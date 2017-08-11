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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.cberp.commons.utils.annotation.SystemControllerLog;
import com.cberp.commons.utils.enCrypt.BASE64Encoder;
import com.cberp.commons.utils.enCrypt.EnCryptUtil;
import com.cberp.commons.utils.enCrypt.HMACSHA1;
import com.cberp.control.entity.Organization;
import com.cberp.control.entity.Role;
import com.cberp.control.entity.RoleUserRelation;
import com.cberp.control.entity.User;
import com.cberp.control.entity.UserResourceRelation;
import com.cberp.control.mapper.OrganizationMapper;
import com.cberp.control.mapper.ResourceMapper;
import com.cberp.control.mapper.RoleMapper;
import com.cberp.control.mapper.RoleUserRelationMapper;
import com.cberp.control.mapper.UserMapper;
import com.cberp.control.mapper.UserResourceRelationMapper;

@Controller
public class UserController {

	@Resource
	private UserMapper userMapper;

	@Resource
	private OrganizationMapper organizationMapper;

	@Resource
	private RoleMapper roleMapper;

	@Resource
	private ResourceMapper resourceMapper;

	@Resource
	private RoleUserRelationMapper roleUserRelationMapper;

	@Resource
	private UserResourceRelationMapper userResourceRelationMapper;

	private Logger logger = LoggerFactory.getLogger(UserController.class);

	@RequestMapping(value = "/control/user/list", method = RequestMethod.GET)
	public String list() {
		return "control/user-list";
	}

	@RequestMapping(value = "/control/user/list", method = RequestMethod.POST)
	@ResponseBody
	public String list(String searchVal, int start, int length, int draw) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("start", start);
		params.put("length", length);
		params.put("searchVal", searchVal);

		// 查询总记录数
		Long totalCount = this.userMapper.listCountByPage(params);
		// 分页查询用户记录
		List<Map<String, Object>> users = this.userMapper.listByPage(params);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("data", users);
		map.put("recordsTotal", totalCount);
		map.put("recordsFiltered", totalCount);
		map.put("draw", draw);

		return JSONObject.toJSONString(map);
	}

	@RequestMapping(value = "/control/user/add", method = RequestMethod.GET)
	public String add(Model model) {

		List<Organization> organizationVOs = this.organizationMapper.findAllParentOrg();
		model.addAttribute("organizationVOs", organizationVOs);

		Map<String, Object> map = new HashMap<String, Object>();
		for (Organization o : organizationVOs) {
			map.put(o.getId(), this.organizationMapper.findSelfAndChild(o.getId()));
		}

		model.addAttribute("map", map);

		return "control/user-input";
	}

	/**
	 * 
	 * @param uid
	 * @return
	 */
	@RequestMapping(value = "/control/user/validate")
	@ResponseBody
	public String validateUser(String uid) {

		JSONObject jsonObj = JSONObject.parseObject("{}");

		User u = this.userMapper.findUserByAccount(uid);
		jsonObj.put("flag", (null == u) ? true : false);

		return jsonObj.toJSONString();
	}

	@RequestMapping(value = "/control/user/add", method = RequestMethod.POST)
	@SystemControllerLog(description = "{'log_type':'12006','log_type_val':'新增用户'}")
	public String add(User userVo, HttpSession session) {

		User currUser = (User) session.getAttribute("user");
		userVo.setCreator(currUser.getName());
		userVo.setPassword(BASE64Encoder.encode(HMACSHA1.getHmacSHA1(EnCryptUtil.getCommKey(), userVo.getPassword())));

		try {
			this.userMapper.addUser(userVo);
		} catch (Exception e) {
			this.logger.error("添加用户出错", e);
		}

		return "redirect:/control/user/list";
	}

	@RequestMapping(value = "/control/user/edit/{id}", method = RequestMethod.GET)
	public String toEdit(@PathVariable
	String id, Model model) {

		// 查询机构
		List<Organization> organizationVOs = this.organizationMapper.findAllParentOrg();
		model.addAttribute("organizationVOs", organizationVOs);

		Map<String, Object> map = new HashMap<String, Object>();
		for (Organization o : organizationVOs) {
			map.put(o.getId(), this.organizationMapper.findSelfAndChild(o.getId()));
		}

		model.addAttribute("map", map);

		User user = this.userMapper.findById(id);
		model.addAttribute("user", user);
		return "control/user-edit";
	}

	@RequestMapping(value = "/control/user/edit", method = RequestMethod.POST)
	@SystemControllerLog(description = "{'log_type':'12005','log_type_val':'修改用户'}")
	public String edit(User user, Model model) {

		try {
			if (StringUtils.isNotEmpty(user.getPassword())) {
				user.setPassword(BASE64Encoder.encode(HMACSHA1.getHmacSHA1(EnCryptUtil.getCommKey(), user.getPassword())));
			}
			this.userMapper.editUser(user);
		} catch (Exception e) {
			this.logger.error("修改用户出错", e);
		}

		return "redirect:/control/user/list";
	}

	@RequestMapping(value = "/control/user/auth", method = RequestMethod.GET)
	public String toAuth(@RequestParam("userid")
	String userid, @RequestParam("name")
	String name, Model model) {
		try {
			//处理中文乱码
			model.addAttribute("userid", userid).addAttribute("name", new String(name.getBytes("iso-8859-1"),"utf-8"));
		} catch (Exception e) {
		}
		// 查询角色
		List<Role> roles = this.roleMapper.allRole();
		// 查询用户已有角色
		List<Role> userRoles = this.roleMapper.findRoleByUserId(userid);
		model.addAttribute("roles", roles).addAttribute("userRoles", userRoles);

		// 查询资源列表
		com.cberp.control.entity.Resource topParent = this.resourceMapper.findTopParent();
		List<com.cberp.control.entity.Resource> resources = this.resourceMapper.findByParentId(topParent.getId());
		model.addAttribute("resources", resources);

		Map<String, Object> map = new HashMap<String, Object>();
		for (com.cberp.control.entity.Resource resource : resources) {
			map.put(resource.getId(), this.resourceMapper.findAllChild(resource.getId()));
		}

		// 查询用户已有资源
		List<UserResourceRelation> userResources = this.userResourceRelationMapper.findById(userid);
		model.addAttribute("map", map).addAttribute("userResources", userResources);

		return "control/user-auth";
	}

	@RequestMapping(value = "/control/user/auth", method = RequestMethod.POST)
	@ResponseBody
	@SystemControllerLog(description = "{'log_type':'12004','log_type_val':'授权用户'}")
	public String auth(String userid, String roleIds, String resource_id) {

		JSONObject jsonObj = JSONObject.parseObject("{}");

		// 保存用户角色
		if (StringUtils.isNotEmpty(roleIds)) {

			try {

				this.roleUserRelationMapper.deleteById(userid);

				String[] roleIdArr = roleIds.split("\\,");
				RoleUserRelation roleUserRelation = null;
				for (String roleId : roleIdArr) {
					roleUserRelation = new RoleUserRelation();
					roleUserRelation.setAuthorize_type(0);
					roleUserRelation.setRole_id(roleId);
					roleUserRelation.setUser_id(userid);
					this.roleUserRelationMapper.save(roleUserRelation);
				}

				jsonObj.put("code", "0");
			} catch (Exception e1) {
				this.logger.error("用户授权｛用户角色｝出错", e1);
				jsonObj.put("code", "-1");
			}

		}

		// 保存用户资源
		if (StringUtils.isNotEmpty(resource_id)) {

			try {

				this.userResourceRelationMapper.deleteByUserId(userid);

				String[] rids = resource_id.split("\\,");
				UserResourceRelation userResourceRelation = null;
				for (String rid : rids) {
					userResourceRelation = new UserResourceRelation();
					userResourceRelation.setAuthorize_type(0);
					userResourceRelation.setResource_id(rid);
					userResourceRelation.setUser_id(userid);
					this.userResourceRelationMapper.save(userResourceRelation);
				}

				jsonObj.put("code", "0");
			} catch (Exception e) {
				this.logger.error("用户授权｛用户资源｝出错", e);
				jsonObj.put("code", "-1");
			}

		}

		return jsonObj.toJSONString();
	}

	@RequestMapping(value = "/control/user/disable")
	@ResponseBody
	@SystemControllerLog(description = "{'log_type':'12007','log_type_val':'停用用户'}")
	public String disable(String ids) {

		JSONObject jsonObj = JSONObject.parseObject("{}");
		try {

			if (StringUtils.isNotEmpty(ids)) {
				String[] idArr = ids.split("\\,");
				for (String id : idArr) {
					this.userMapper.disableUser(id);
				}
			}

			jsonObj.put("code", "0");
		} catch (Exception e) {
			this.logger.error("停用用户出错", e);
			jsonObj.put("code", "-1");
		}
		return jsonObj.toJSONString();
	}

	@RequestMapping(value = "/control/user/enable")
	@ResponseBody
	@SystemControllerLog(description = "{'log_type':'12008','log_type_val':'启用用户'}")
	public String enable(String ids) {

		JSONObject jsonObj = JSONObject.parseObject("{}");
		try {

			if (StringUtils.isNotEmpty(ids)) {
				String[] idArr = ids.split("\\,");
				for (String id : idArr) {
					this.userMapper.enableUser(id);
				}
			}

			jsonObj.put("code", "0");
		} catch (Exception e) {
			this.logger.error("启用用户出错", e);
			jsonObj.put("code", "-1");
		}
		return jsonObj.toJSONString();
	}

	/**
	 * 当前用户重置密码页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/control/user/resetpass/{id}")
	public String toResetPassword(@PathVariable
	String id, Model model) {
		User user = this.userMapper.findById(id);
		Organization o = organizationMapper.findById(user.getOrganization_id());
		model.addAttribute("user", user).addAttribute("o", o);
		return "control/user-reset-password";
	}

	/**
	 * 校验用户输入的原始密码是否正确
	 * 
	 * @return
	 */
	@RequestMapping(value = "/control/user/validatepass")
	@ResponseBody
	public String validatePassword(String userid, String password) {

		JSONObject jsonObj = JSONObject.parseObject("{}");
		User user = this.userMapper.checkUser(userid, BASE64Encoder.encode(HMACSHA1.getHmacSHA1(EnCryptUtil.getCommKey(), password)));
		jsonObj.put("flag", (null != user) ? true : false);
		return jsonObj.toJSONString();
	}

	/**
	 * 当前用户重置密码操作
	 * 
	 * @param userId
	 * @return
	 */
	@RequestMapping(value = "/control/user/resetpass")
	@ResponseBody
	@SystemControllerLog(description = "{'log_type':'12015','log_type_val':'用户重置密码'}")
	public String resetPassword(User user, String newpassword) {

		JSONObject jsonObj = JSONObject.parseObject("{}");

		try {
			user.setPassword(BASE64Encoder.encode(HMACSHA1.getHmacSHA1(EnCryptUtil.getCommKey(), newpassword)));
			this.userMapper.editUser(user);
			jsonObj.put("code", "0");
		} catch (Exception e) {
			this.logger.error("用户重置密码出错", e);
			jsonObj.put("code", "-1");
		}

		return jsonObj.toJSONString();
	}

	/**
	 * 重置某个用户密码
	 * 
	 * @param userId
	 * @return
	 */
	public String toResetUserPassword(String userId) {

		return "control/user-reset-password";
	}

	/**
	 * 重置某个用户密码操作
	 * 
	 * @param userId
	 * @return
	 */
	public String resetUserPassword(String userId) {

		JSONObject jsonObj = JSONObject.parseObject("{}");
		return jsonObj.toJSONString();
	}

	@RequestMapping(value = "/control/user/view/{id}")
	public String view(@PathVariable
	String id, Model model) {

		User user = this.userMapper.findById(id);
		Organization o = organizationMapper.findById(user.getOrganization_id());
		model.addAttribute("user", user).addAttribute("o", o);

		return "control/user-view";
	}

}
