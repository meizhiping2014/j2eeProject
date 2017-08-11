package com.cberp.control.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.cberp.commons.utils.annotation.SystemControllerLog;
import com.cberp.control.entity.Role;
import com.cberp.control.entity.RoleResourceRelation;
import com.cberp.control.entity.User;
import com.cberp.control.mapper.ResourceMapper;
import com.cberp.control.mapper.RoleMapper;
import com.cberp.control.mapper.RoleResourceRelationMapper;

@Controller
public class RoleController {

	@Resource
	private RoleMapper roleMapper;

	@Resource
	private ResourceMapper resourceMapper;

	@Resource
	private RoleResourceRelationMapper roleResourceRelationMapper;

	private Logger logger = LoggerFactory.getLogger(RoleController.class);

	@RequestMapping(value = "/control/role/list", method = RequestMethod.GET)
	public String list() {

		return "control/role-list";

	}

	/**
	 * 查询所有角色
	 * 
	 * @return
	 */
	@RequestMapping(value = "/control/role/list", method = RequestMethod.POST)
	@ResponseBody
	public String list(String searchVal, int start, int length, int draw) {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("start", start);
		params.put("length", length);
		params.put("searchVal", searchVal);

		// 查询总记录数
		Long totalCount = this.roleMapper.listCountByPage(params);
		// 分页查询角色记录
		List<Map<String, Object>> roles = this.roleMapper.listByPage(params);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("data", roles);
		map.put("recordsTotal", totalCount);
		map.put("recordsFiltered", totalCount);
		map.put("draw", draw);

		return JSONObject.toJSONString(map);

	}

	/**
	 * 添加角色
	 * 
	 * @return
	 */
	@RequestMapping(value = "/control/role/add", method = RequestMethod.GET)
	public String toAdd(Model model) {

		com.cberp.control.entity.Resource topParent = this.resourceMapper.findTopParent();
		List<com.cberp.control.entity.Resource> resources = this.resourceMapper.findByParentId(topParent.getId());
		model.addAttribute("resources", resources);

		Map<String, Object> map = new HashMap<String, Object>();
		for (com.cberp.control.entity.Resource resource : resources) {
			map.put(resource.getId(), this.resourceMapper.findAllChild(resource.getId()));
		}

		model.addAttribute("map", map);

		return "control/role-input";
	}

	@RequestMapping(value = "/control/role/add", method = RequestMethod.POST)
	@ResponseBody
	@SystemControllerLog(description = "{'log_type':'12009','log_type_val':'新增角色'}")
	public String add(Role role, RoleResourceRelation roleResourceRelation, HttpSession session) {

		JSONObject jsonObj = JSONObject.parseObject("{}");

		try {
			User currUser = (User) session.getAttribute("user");
			role.setCreator(currUser.getName());
			this.roleMapper.add(role);

			String resource_ids = roleResourceRelation.getResource_id();
			if (StringUtils.isNotEmpty(resource_ids)) {
				String[] ids = resource_ids.split("\\,");
				for (String id : ids) {
					roleResourceRelation.setRole_id(role.getId());
					roleResourceRelation.setAuthorize_type(0);
					roleResourceRelation.setResource_id(id);
					this.roleResourceRelationMapper.save(roleResourceRelation);

				}
			}
			jsonObj.put("code", "0");
		} catch (Exception e) {
			logger.error("保存角色出错", e);
			jsonObj.put("code", "-1");
		}

		return jsonObj.toJSONString();
	}

	@RequestMapping(value = "/control/role/edit/{roleid}", method = RequestMethod.GET)
	public String toEdit(@PathVariable
	String roleid, Model model) {

		com.cberp.control.entity.Resource topParent = this.resourceMapper.findTopParent();
		List<com.cberp.control.entity.Resource> resources = this.resourceMapper.findByParentId(topParent.getId());
		model.addAttribute("resources", resources);
		Map<String, Object> map = new HashMap<String, Object>();
		for (com.cberp.control.entity.Resource resource : resources) {
			map.put(resource.getId(), this.resourceMapper.findAllChild(resource.getId()));
		}

		// 查询角色绑定的资源
		Role role = this.roleMapper.findById(roleid);
		List<RoleResourceRelation> roleResources = this.roleResourceRelationMapper.findByRoleId(roleid);
		model.addAttribute("map", map).addAttribute("role", role).addAttribute("roleResources", roleResources);

		return "control/role-edit";
	}

	@RequestMapping(value = "/control/role/edit", method = RequestMethod.POST)
	@ResponseBody
	@SystemControllerLog(description = "{'log_type':'12010','log_type_val':'修改角色'}")
	public String edit(Role role, RoleResourceRelation roleResourceRelationVo) {

		JSONObject jsonObject = JSONObject.parseObject("{}");

		try {
			this.roleMapper.edit(role);

			String resource_ids = roleResourceRelationVo.getResource_id();
			if (StringUtils.isNotEmpty(resource_ids)) {

				// 删除现有角色资源
				this.roleResourceRelationMapper.deleteByRoleId(role.getId());

				String[] ids = resource_ids.split("\\,");
				RoleResourceRelation roleResourceRelation = null;

				for (String id : ids) {
					// 保存角色资源
					roleResourceRelation = new RoleResourceRelation();
					roleResourceRelation.setRole_id(role.getId());
					roleResourceRelation.setAuthorize_type(0);
					roleResourceRelation.setResource_id(id);
					this.roleResourceRelationMapper.save(roleResourceRelation);

				}
			}

			jsonObject.put("code", "0");
		} catch (Exception e) {
			logger.error("编辑角色出错", e);
			jsonObject.put("code", "-1");
		}

		return jsonObject.toJSONString();
	}

	@RequestMapping(value = "/control/role/delete")
	@ResponseBody
	@SystemControllerLog(description = "{'log_type':'12011','log_type_val':'删除角色'}")
	public String delete(String roleids) {

		JSONObject jsonObject = JSONObject.parseObject("{}");

		if (StringUtils.isNotEmpty(roleids)) {

			try {

				String roleArr[] = roleids.split("\\,");
				for (String roleid : roleArr) {

					// 删除资源与角色关系
					this.roleResourceRelationMapper.deleteByRoleId(roleid);
					// 删除角色
					this.roleMapper.deleteById(roleid);
				}
				jsonObject.put("code", "0");
			} catch (Exception e) {
				logger.error("删除角色出错", e);
				jsonObject.put("code", "-1");
			}
		}

		return jsonObject.toJSONString();
	}
}
