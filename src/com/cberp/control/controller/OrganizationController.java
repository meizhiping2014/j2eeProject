package com.cberp.control.controller;

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
import com.cberp.commons.utils.DataUtils;
import com.cberp.commons.utils.annotation.SystemControllerLog;
import com.cberp.control.entity.Organization;
import com.cberp.control.entity.User;
import com.cberp.control.mapper.OrganizationMapper;
import com.cberp.control.mapper.RoleUserRelationMapper;
import com.cberp.control.mapper.UserMapper;
import com.cberp.control.mapper.UserResourceRelationMapper;

@Controller
public class OrganizationController {

	@Resource
	private OrganizationMapper organizationMapper;

	@Resource
	private UserMapper userMapper;

	@Resource
	private RoleUserRelationMapper roleUserRelationMapper;

	@Resource
	private UserResourceRelationMapper userResourceRelationMapper;

	private Logger logger = LoggerFactory.getLogger(OrganizationController.class);

	@RequestMapping(value = "/control/org/list", method = RequestMethod.GET)
	public String list(Model model) {
		Long count = this.organizationMapper.countAll();
		model.addAttribute("count", count);
		return "control/org-tree";
	}

	@RequestMapping(value = "/control/org/list/{id}", method = RequestMethod.POST)
	@ResponseBody
	public String list(String searchVal, @PathVariable
	String id, int start, int length, int draw) {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("start", start);
		params.put("length", length);
		params.put("searchVal", searchVal.trim());
		params.put("id", id);

		// 查询总记录数
		Long totalCount = this.organizationMapper.listCountByPage(params);
		// 分页查询用户记录
		List<Map<String, Object>> users = this.organizationMapper.listByPage(params);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("data", users);
		map.put("recordsTotal", totalCount);
		map.put("recordsFiltered", totalCount);
		map.put("draw", draw);

		return JSONObject.toJSONString(map);
	}

	@RequestMapping(value = "/control/org/query", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String query(String id) {

		List<Organization> orgs = null;
		if (StringUtils.isNotEmpty(id)) {
			if ("-1".equals(id)) {
				orgs = this.organizationMapper.findAllParentOrg();
			} else {
				orgs = this.organizationMapper.findByParentId(id);
			}
		}

		JSONArray array = new JSONArray();

		for (Organization o : orgs) {
			JSONObject jsonObj = (JSONObject) JSONObject.toJSON(o);
			Long count = this.organizationMapper.countByParentId(o.getId());

			if (count > 0) {
				jsonObj.put("isParent", true);
			}
			array.add(jsonObj);
		}
		return array.toJSONString();
	}

	@RequestMapping(value = "/control/org/query/{id}")
	public String query(@PathVariable
	String id, Model model) {
		model.addAttribute("id", id);
		return "control/org-list";
	}

	@RequestMapping(value = "/control/org/add", method = RequestMethod.GET)
	public String add(Model model) {

		List<Organization> organizationVOs = this.organizationMapper.findAllParentOrg();
		model.addAttribute("organizationVOs", organizationVOs);

		Map<String, Object> map = new HashMap<String, Object>();
		for (Organization o : organizationVOs) {
			map.put(o.getId(), this.organizationMapper.findSelfAndChild(o.getId()));
		}

		model.addAttribute("map", map);

		return "control/org-input";
	}

	@RequestMapping(value = "/control/org/add", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	@SystemControllerLog(description = "{'log_type':'12001','log_type_val':'新增机构'}")
	public String add(Organization org, HttpServletRequest req, HttpSession session) {

		User currUser = (User) session.getAttribute("user");
		JSONObject jsonObj = JSONObject.parseObject("{}");
		try {
			if (StringUtils.isEmpty(org.getParent_id())) {
				org.setParent_id(null);
			}

			Long seqNum = this.organizationMapper.findSeqNumber();
			String org_code = ("C" + DataUtils.getNumber(seqNum));
			org.setCode(org_code);
			org.setCreator(currUser.getName());
			this.organizationMapper.addOrg(org);

			jsonObj.put("code", "0");
		} catch (Exception e) {
			jsonObj.put("code", "-1");
			logger.error("添加机构失败", e);
		}

		return jsonObj.toJSONString();
	}

	/**
	 * 
	 * @return
	 */
	@RequestMapping(value = "/control/org/edit/{id}", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	@SystemControllerLog(description = "{'log_type':'12002','log_type_val':'修改机构'}")
	public String edit(Organization org, @PathVariable
	String id, HttpServletRequest req, HttpSession session) {

		JSONObject jsonObj = JSONObject.parseObject("{}");
		try {
			this.organizationMapper.editOrg(org);
			jsonObj.put("code", "0");

		} catch (Exception e) {
			jsonObj.put("code", "-1");
			logger.error("编辑机构失败", e);
		}
		return jsonObj.toJSONString();
	}

	/**
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/control/org/delete/{id}", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	@SystemControllerLog(description = "{'log_type':'12003','log_type_val':'删除机构'}")
	public String delete(@PathVariable
	String id, HttpServletRequest req, HttpSession session) {

		JSONObject jsonObj = JSONObject.parseObject("{}");
		try {

			// 查询当前机构下的所有子机构
			List<Organization> orgs = this.organizationMapper.findSelfAndChild(id);
			for (Organization o : orgs) {

				// 查询机构下的用户
				List<User> users = this.userMapper.findByOrgId(o.getId());
				for (User u : users) {
					// 删除用户角色
					this.roleUserRelationMapper.deleteById(u.getId());
					// 删除用户资源
					this.userResourceRelationMapper.deleteByUserId(u.getId());
					// 删除用户
					this.userMapper.delById(u.getId());
				}

				// 删除机构
				this.organizationMapper.delOrgById(o.getId());
			}

			jsonObj.put("code", "0");
		} catch (Exception e) {
			jsonObj.put("code", "-1");
			logger.error("删除机构失败", e);
		}
		return jsonObj.toJSONString();
	}

}
