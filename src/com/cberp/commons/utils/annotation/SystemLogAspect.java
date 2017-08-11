package com.cberp.commons.utils.annotation;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.cberp.commons.utils.IpUtil;
import com.cberp.commons.utils.constants.SessionConstants;
import com.cberp.control.entity.Log;
import com.cberp.control.entity.Organization;
import com.cberp.control.entity.Role;
import com.cberp.control.entity.RoleResourceRelation;
import com.cberp.control.entity.User;
import com.cberp.control.mapper.LogMapper;
import com.cberp.control.mapper.OrganizationMapper;
import com.cberp.control.mapper.ResourceMapper;
import com.cberp.control.mapper.RoleMapper;
import com.cberp.control.mapper.UserMapper;

/**
 * 切点类
 * 
 * @version 1.0
 */
@Aspect
@Component
public class SystemLogAspect {
	// 注入Service用于把日志保存数据库
	// @Resource
	// private LogService logService;
	// 本地异常日志记录对象
	private static final Logger logger = LoggerFactory.getLogger(SystemLogAspect.class);

	@Resource
	private LogMapper logMapper;

	@Resource
	private UserMapper userMapper;

	@Resource
	private OrganizationMapper organizationMapper;

	@Resource
	private RoleMapper roleMapper;

	@Resource
	private ResourceMapper resourceMapper;
	

	// Service层切点
	@Pointcut("@annotation(com.cberp.commons.utils.annotation.SystemServiceLog)")
	public void serviceAspect() {
	}

	// Controller层切点
	@Pointcut("@annotation(com.cberp.commons.utils.annotation.SystemControllerLog)")
	public void controllerAspect() {
	}

	/**
	 * 前置通知 用于拦截Controller层记录用户的操作
	 * 
	 * @param joinPoint
	 *            切点
	 */
	@Before("controllerAspect()")
	public void doBefore(JoinPoint joinPoint) {

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		// 读取session中的用户
		User user = (User) session.getAttribute(SessionConstants.CURRENT_USER);
		String ip = IpUtil.getClientIp(request);
		Object[] args = joinPoint.getArgs();

		// 用户为空，则为登录
		if (null == user) {
			if (null != args && args.length > 0) {
				if (null != args[0]){
					String username = args[0].toString();
					user = userMapper.findUserByAccount(username);
				}
			}
		}

		try {
			logger.info("=====前置通知开始=====");
			logger.info("请求方法:" + (joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName() + "()"));
			logger.info("方法描述:" + getControllerMethodDescription(joinPoint));
			logger.info("请求IP:" + ip);

			JSONObject content = new JSONObject();
			String desc = getControllerMethodDescription(joinPoint);

			JSONObject desc_json = JSONObject.parseObject(desc);
			String log_type = desc_json.getString("log_type");
			String log_type_val = desc_json.getString("log_type_val");
			
			JSONObject rs_obj = new JSONObject();
			JSONArray rs_arr = new JSONArray();

			if (null != args && args.length > 0) {
				// 登录
				if ("0".equals(log_type)) {
					if(null != user){
						rs_obj.put(user.getName(), log_type_val);
						content.put("操作内容", rs_obj);
					}
				}else if ("12003".equals(log_type)) {
					// 删除机构

					String id = (String) args[0];
					Organization o = organizationMapper.findById(id);
					content.put("操作内容", o);

				} else if ("12004".equals(log_type)) {
					// 授权用户权限

					String userid = (String) args[0];
					String roleids = (String) args[1];
					String resource_id = (String) args[2];

					
					User u = this.userMapper.findById(userid);

					if (StringUtils.isNotEmpty(roleids)) {
						String[] roleIdArr = roleids.split("\\,");

						for (String roleid : roleIdArr) {
							Role role = this.roleMapper.findById(roleid);
							rs_arr.add(role);
						}

					}

					if (StringUtils.isNotEmpty(resource_id)) {
						String[] rids = resource_id.split("\\,");
						for (String rid : rids) {
							com.cberp.control.entity.Resource r = this.resourceMapper.findById(rid);
							rs_arr.add(r);
						}
					}

					rs_obj.put(u.getName(), rs_arr);
					content.put("操作内容", rs_obj);

				} else if ("12007".equals(log_type) || "12008".equals(log_type)) {
					// 停用用户、启用用户

					String ids = (String) args[0];
					String[] idArr = ids.split("\\,");
					for (String id : idArr) {
						rs_arr.add(this.userMapper.findById(id));
					}
					content.put("操作内容", rs_arr);

				} else if ("12009".equals(log_type) || "12010".equals(log_type)) {
					// 记录新增角色、编辑角色日志
					Role role = (Role) args[0];
					RoleResourceRelation roleResourceRelation = (RoleResourceRelation) args[1];

					String resource_ids = roleResourceRelation.getResource_id();
					if (StringUtils.isNotEmpty(resource_ids)) {
						String[] ids = resource_ids.split("\\,");
						for (String id : ids) {
							rs_arr.add(this.resourceMapper.findById(id));
						}
					}

					rs_obj.put(role.getName(), rs_arr);
					content.put("操作内容", rs_obj);

				} else if ("12011".equals(log_type)) {
					// 记录删除角色日志
					String roleids = (String) args[0];

					if (StringUtils.isNotEmpty(roleids)) {
						String[] ids = roleids.split("\\,");
						for (String roleid : ids) {
							rs_arr.add(this.roleMapper.findById(roleid));
						}
					}

					content.put("操作内容", rs_arr);

				} else if ("12014".equals(log_type)) {
					// 记录删除资源日志
					String id = (String) args[0];
					content.put("操作内容", this.resourceMapper.findById(id));
				} else if ("12015".equals(log_type)) {
					// 记录用户重置密码日志
					User u = (User) args[0];
					u = this.userMapper.findById(u.getId());
					content.put("操作内容", u);
				}/* else if("12017".equals(log_type)){
					//新增/修改供应商
					//CompanyInfo companyInfo = (CompanyInfo) args[0];
					//content.put("操作内容", companyInfo);
				}else if("12018".equals(log_type)){
					//禁用供应商
					String ids = (String) args[0];
					List<CompanyInfo> list = new ArrayList<CompanyInfo>();
					if (StringUtils.isNotEmpty(ids)) {
						String[] idArr = ids.split("\\,");
						for (String pid : idArr) {
							CompanyInfo companyInfo = this.companyInfoMapper.findCompanyInfoByPid(pid);
							list.add(companyInfo);
						}
					}
					content.put("操作内容", list);
				}else if("12019".equals(log_type)){
					//启用供应商
					String ids = (String) args[0];
					List<CompanyInfo> list = new ArrayList<CompanyInfo>();
					if (StringUtils.isNotEmpty(ids)) {
						String[] idArr = ids.split("\\,");
						for (String pid : idArr) {
							CompanyInfo companyInfo = this.companyInfoMapper.findCompanyInfoByPid(pid);
							list.add(companyInfo);
						}
					}
					content.put("操作内容", list);
				} else if("12020".equals(log_type)){
					//新增/修改前台产品
					HttpServletRequest req =  (HttpServletRequest)args[0];
					Integer firstRechargeDay = Integer.parseInt(req.getParameter("firstRechargeDay"));//首充日
					String arrivalType = req.getParameter("arrivalType");//到账类型
					String pid = req.getParameter("pid");//前台产品编号
					String fkTCompanyInfoId = req.getParameter("fkTCompanyInfoId");//供应商编号
					String productId = req.getParameter("productName");//供应商产品编号
					
					PortalProductInfo portalProductInfo = new PortalProductInfo();
					portalProductInfo.setPid(pid);
					portalProductInfo.setFirstRechargeDay(firstRechargeDay);//首充日
					portalProductInfo.setArrivalType(arrivalType);//到账类型 分期
					portalProductInfo.setFkTCompanyInfo(fkTCompanyInfoId);//供应商主键
					portalProductInfo.setFkTCompanyProductInfo(productId);//供应商产品主键
					portalProductInfo.setApprStatus("32001");//审核状态     32001 待审核  32002审核通过   32003审核不通过
					
					content.put("操作内容", portalProductInfo);
				} else if("12021".equals(log_type)){
					//删除前台产品收益规则
					String pid =  (String)args[0];
					Map<String, Object> params = new HashMap<String, Object>();
					params.put("pid", pid);
					params.put("recordStatus", 0);
					
					content.put("操作内容", params);
				} */else {
					// 新增用户、修改用户、新增资源、修改资源、新增机构、修改机构
					content.put("操作内容", args[0]);
				}

				// // 新增用户
				// if ("12006".equals(log_type)) {
				// content.put("操作内容", args[0]);
				// }
				//
				// // 修改用户
				// if ("12005".equals(log_type)) {
				// content.put("操作内容", args[0]);
				// }
				//
				// // 记录新增资源日志
				// if ("12012".equals(log_type)) {
				// content.put("操作内容", args[0]);
				// }
				//
				// // 记录修改资源日志
				// if ("12013".equals(log_type)) {
				// content.put("操作内容", args[0]);
				// }

			}

			if (null != user)
				logMapper.addLog(new Log(log_type, log_type_val, content.toJSONString(), user.getName(), ip));

			logger.info("=====前置通知结束=====");
		} catch (Exception e) {
			// 记录本地异常日志
			logger.error("==前置通知异常==");
			logger.error("异常信息:{}", e.getMessage());
		}
	}
	
	/**
	 * 前置通知 用于拦截Controller层记录用户的操作
	 * 
	 * @param joinPoint
	 *            切点
	 */
	@After("controllerAspect()")
	public void doAfter(JoinPoint joinPoint) {
//		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
//		HttpSession session = request.getSession();
//		// 读取session中的用户
//		User user = (User) session.getAttribute(SessionConstants.CURRENT_USER);
//		String ip = IpUtil.getClientIp(request);
//		Object[] args = joinPoint.getArgs();
	}

	/**
	 * 异常通知 用于拦截service层记录异常日志
	 * 
	 * @param joinPoint
	 * @param e
	 */
	@AfterThrowing(pointcut = "serviceAspect()", throwing = "e")
	public void doAfterThrowing(JoinPoint joinPoint, Throwable e) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		// 读取session中的用户
		User user = (User) session.getAttribute(SessionConstants.CURRENT_USER);
		// 获取请求ip
		String ip = request.getRemoteAddr();
		// 获取用户请求方法的参数并序列化为JSON格式字符串
		String params = "";
		if (joinPoint.getArgs() != null && joinPoint.getArgs().length > 0) {
			for (int i = 0; i < joinPoint.getArgs().length; i++) {
				params += JSONObject.toJSONString(joinPoint.getArgs()[i]) + ";";
			}
		}
		try {
			/* ========控制台输出========= */
			logger.error("=====异常通知开始=====");
			logger.error("异常代码:" + e.getClass().getName());
			logger.error("异常信息:" + e.getMessage());
			logger.error("异常方法:" + (joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName() + "()"));
			logger.error("方法描述:" + getServiceMthodDescription(joinPoint));
			logger.error("请求人:" + user.getName());
			logger.error("请求IP:" + ip);
			logger.error("请求参数:" + params);
			logger.error("=====异常通知结束=====");
		} catch (Exception ex) {
			// 记录本地异常日志
			logger.error("==异常通知异常==");
			logger.error("异常信息:{}", ex.getMessage());
		}
		/* ==========记录本地异常日志========== */
		// logger.error("异常方法:{}异常代码:{}异常信息:{}参数:{}",
		// joinPoint.getTarget().getClass().getName() +
		// joinPoint.getSignature().getName(), e.getClass().getName(),
		// e.getMessage(), params);
	}

	/**
	 * 获取注解中对方法的描述信息 用于service层注解
	 * 
	 * @param joinPoint
	 *            切点
	 * @return 方法描述
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static String getServiceMthodDescription(JoinPoint joinPoint) throws Exception {
		String targetName = joinPoint.getTarget().getClass().getName();
		String methodName = joinPoint.getSignature().getName();
		Object[] arguments = joinPoint.getArgs();
		Class targetClass = Class.forName(targetName);
		Method[] methods = targetClass.getMethods();
		String description = "";
		for (Method method : methods) {
			if (method.getName().equals(methodName)) {
				Class[] clazzs = method.getParameterTypes();
				if (clazzs.length == arguments.length) {
					description = method.getAnnotation(SystemServiceLog.class).description();
					break;
				}
			}
		}
		return description;
	}

	/**
	 * 获取注解中对方法的描述信息 用于Controller层注解
	 * 
	 * @param joinPoint
	 *            切点
	 * @return 方法描述
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static String getControllerMethodDescription(JoinPoint joinPoint) throws Exception {
		String targetName = joinPoint.getTarget().getClass().getName();
		String methodName = joinPoint.getSignature().getName();
		Object[] arguments = joinPoint.getArgs();
		Class targetClass = Class.forName(targetName);
		Method[] methods = targetClass.getMethods();
		String description = "";
		for (Method method : methods) {
			if (method.getName().equals(methodName)) {
				Class[] clazzs = method.getParameterTypes();
				if (clazzs.length == arguments.length) {
					description = method.getAnnotation(SystemControllerLog.class).description();
					break;
				}
			}
		}
		return description;
	}
}
