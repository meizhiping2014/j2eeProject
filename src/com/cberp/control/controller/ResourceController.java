package com.cberp.control.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
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

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.cberp.commons.utils.LgtConstants;
import com.cberp.commons.utils.annotation.SystemControllerLog;
import com.cberp.commons.utils.constants.ControlConstant;
import com.cberp.control.entity.RoleResourceRelation;
import com.cberp.control.entity.User;
import com.cberp.control.mapper.ResourceMapper;
import com.cberp.control.mapper.RoleMapper;
import com.cberp.control.mapper.RoleResourceRelationMapper;
import com.cberp.control.mapper.UserResourceRelationMapper;

@Controller
public class ResourceController {

	@Resource
	private ResourceMapper resourceMapper;

	@Resource
	private RoleMapper roleMapper;

	@Resource
	private RoleResourceRelationMapper roleResourceRelationMapper;

	@Resource
	private UserResourceRelationMapper userResourceRelationMapper;

	private Logger logger = LoggerFactory.getLogger(ResourceController.class);

	/**
	 * @描述：根据条件获取资源树
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/control/resource/getResourceTree")
	@ResponseBody
	public String getResourceTree(HttpServletRequest request, HttpSession session) throws Exception {

		User user = (User) session.getAttribute("user");
		List<com.cberp.control.entity.Resource> resources = this.resourceMapper.findResourceBy(user.getId(), ControlConstant.RESOURCE_ROOT, 2);

		StringBuffer jsonObj = new StringBuffer();
		jsonObj.append("{rNodes:[");
		jsonObj.append(buildEditTreeJson(resources, user, request.getContextPath()));
		jsonObj.append("]}");

		return JSONObject.parseObject(jsonObj.toString()).toJSONString();
	}

	/**
	 * @描述：组装资源树json
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @param resources
	 *            资源集合
	 * @param user
	 *            当前登录的用户
	 * @param roleOrUserResourceList
	 *            角色或用户拥有的资源
	 * @return
	 * @throws Exception
	 */
	private StringBuffer buildEditTreeJson(List<com.cberp.control.entity.Resource> resources, User user, String contextPath) throws Exception {

		StringBuffer jsonObj = new StringBuffer();
		for (com.cberp.control.entity.Resource resource : resources) {

			Long count = this.resourceMapper.findResourceCountBy(user.getId(), resource.getId(), 2);

			jsonObj.append("{text:");
			jsonObj.append("'");
			if (count == 0) {
				// jsonObj.append("<span data-url=\"" + resource.getPath() + "\"
				// >");
				// jsonObj.append("<img src=\"" + contextPath +
				// "/images/application_form.png\" />&nbsp;");
			}
			jsonObj.append(resource.getName());
			if (count == 0) {
				// jsonObj.append("</span>");
			}
			jsonObj.append("'");
			jsonObj.append(",id:");
			jsonObj.append("'").append(resource.getId()).append("'");
			jsonObj.append(",path:").append("'").append(resource.getPath()).append("'");

			if (count > 0) {
				List<com.cberp.control.entity.Resource> childResources = this.resourceMapper.findResourceBy(user.getId(), resource.getId(), 2);
				jsonObj.append(",nodes:[").append(buildEditTreeJson(childResources, user, contextPath)).append("]");
			}

			jsonObj.append("},");
		}
		jsonObj = jsonObj.deleteCharAt(jsonObj.length() - 1);
		return jsonObj;
	}

	/**
	 * 资源树
	 * 
	 * @return
	 */
	@RequestMapping("/control/resource/list")
	public String list(Model model) {

		Long count = this.resourceMapper.resourceCount();
		model.addAttribute("count", count);

		return "control/resource-tree";
	}

	@RequestMapping("/control/resource/list/{id}")
	@ResponseBody
	public String list(String searchVal, @PathVariable
	String id, int start, int length, int draw) {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("start", start);
		params.put("length", length);
		params.put("searchVal", searchVal.trim());
		params.put("id", id);

		// 查询总记录数
		Long totalCount = this.resourceMapper.listCountByPage(params);
		// 分页查询用户记录
		List<Map<String, Object>> users = this.resourceMapper.listByPage(params);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("data", users);
		map.put("recordsTotal", totalCount);
		map.put("recordsFiltered", totalCount);
		map.put("draw", draw);

		return JSONObject.toJSONString(map);
	}

	@RequestMapping(value = "/control/resource/query", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String query(String id) {

		List<com.cberp.control.entity.Resource> resources = new ArrayList<com.cberp.control.entity.Resource>();
		if (StringUtils.isNotEmpty(id)) {
			if ("-1".equals(id)) {
				resources.add(this.resourceMapper.findTopParent());
			} else {
				resources = this.resourceMapper.findByParentId(id);
			}
		}

		JSONArray array = new JSONArray();

		for (com.cberp.control.entity.Resource o : resources) {
			JSONObject jsonObj = (JSONObject) JSONObject.toJSON(o);
			Long count = this.resourceMapper.countByParentId(o.getId());

			if (count > 0) {
				jsonObj.put("isParent", true);
			}
			array.add(jsonObj);
		}

		return array.toJSONString();
	}

	@RequestMapping(value = "/control/resource/query/{id}")
	public String query(@PathVariable
	String id, Model model) {

		model.addAttribute("id", id);

		return "control/resource-list";
	}

	@RequestMapping(value = "/control/resource/add", method = RequestMethod.GET)
	public String toAdd(Model model) {

		com.cberp.control.entity.Resource topParent = this.resourceMapper.findTopParent();
		List<com.cberp.control.entity.Resource> resources = this.resourceMapper.findByParentId(topParent.getId());
		model.addAttribute("resources", resources);

		Map<String, Object> map = new HashMap<String, Object>();
		for (com.cberp.control.entity.Resource resource : resources) {
			map.put(resource.getId(), this.resourceMapper.findSelfAndAllChild(resource.getId()));
		}

		model.addAttribute("map", map);

		return "control/resource-input";
	}

	@RequestMapping(value = "/control/resource/add", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	@SystemControllerLog(description = "{'log_type':'12012','log_type_val':'新增资源'}")
	public String add(com.cberp.control.entity.Resource resource, HttpSession session) {

		User currUser = (User) session.getAttribute("user");
		JSONObject jsonObj = JSONObject.parseObject("{}");
		try {
			resource.setCreator(currUser.getName());
			// resource.setResource_type(2);
			this.resourceMapper.add(resource);

			// 将资源与超级系统管理员关联
			RoleResourceRelation roleResourceRelation = new RoleResourceRelation();
			roleResourceRelation.setAuthorize_type(0);
			roleResourceRelation.setRole_id(this.roleMapper.findByName(LgtConstants.SUPER_SYSTEM_ADMIN).getId());
			roleResourceRelation.setResource_id(resource.getId());
			this.roleResourceRelationMapper.save(roleResourceRelation);

			jsonObj.put("code", "0");
		} catch (Exception e) {
			jsonObj.put("code", "-1");
			logger.error("添加资源失败", e);
		}

		return jsonObj.toJSONString();
	}

	/**
	 * 
	 * @return
	 */
	@RequestMapping(value = "/control/resource/edit/{id}", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	@SystemControllerLog(description = "{'log_type':'12013','log_type_val':'修改资源'}")
	public String edit(com.cberp.control.entity.Resource resource, @PathVariable
	String id) {

		JSONObject jsonObj = JSONObject.parseObject("{}");
		try {
			resource.setId(id);
			this.resourceMapper.edit(resource);
			jsonObj.put("code", "0");
		} catch (Exception e) {
			jsonObj.put("code", "-1");
			logger.error("修改资源失败", e);
		}
		return jsonObj.toJSONString();
	}

	@RequestMapping(value = "/control/resource/delete/{id}")
	@ResponseBody
	@SystemControllerLog(description = "{'log_type':'12014','log_type_val':'删除资源'}")
	public String delete(@PathVariable
	String id) {
		JSONObject jsonObj = JSONObject.parseObject("{}");

		try {

			List<com.cberp.control.entity.Resource> resources = this.resourceMapper.findSelfAndAllChild(id);
			for (com.cberp.control.entity.Resource r : resources) {

				this.roleResourceRelationMapper.deleteByResourceId(r.getId());
				this.userResourceRelationMapper.deleteByResourceId(r.getId());

				this.resourceMapper.deleteById(r.getId());
			}

			jsonObj.put("code", "0");
		} catch (Exception e) {
			jsonObj.put("code", "-1");
			logger.error("删除资源失败", e);
		}

		return jsonObj.toJSONString();

	}
}
