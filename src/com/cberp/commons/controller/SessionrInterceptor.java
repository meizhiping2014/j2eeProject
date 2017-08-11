package com.cberp.commons.controller;

import java.net.URLEncoder;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import com.alibaba.fastjson.JSONObject;
import com.cberp.commons.utils.IpUtil;
import com.cberp.control.entity.Resource;
import com.cberp.control.entity.User;
import com.cberp.control.mapper.ResourceMapper;

/**
 * 拦截所有请求，处理请求验证用户是否存在及用户权限是否拥有访问此权限
 * 
 * @author libin
 * 
 */
public class SessionrInterceptor extends HandlerInterceptorAdapter {

	private Logger logger = Logger.getLogger(SessionrInterceptor.class);

	private List<String> allowUrls;

	@SuppressWarnings("unchecked")
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		try {

			logger.info(IpUtil.getClientIp(request));
			String requestUrl = request.getRequestURI();
			logger.info("请求url：" + requestUrl);
			for (String urlStr : allowUrls) {
				if (requestUrl.contains(urlStr)) {
					return true;
				}
			}

			User user = (User) request.getSession().getAttribute("user");

			String reqType = request.getHeader("X-Requested-With");
			String contextPath = request.getContextPath();
			if (null == user) {
				// ajax session超时
				if (StringUtils.isNotEmpty(reqType) && reqType.equalsIgnoreCase("XMLHttpRequest")) {
					response.setHeader("sessionstatus", "timeout");
					return false;
				}
				response.sendRedirect(contextPath + "/login.jsp");
				return false;
			}

			if (null != user) {

				// 查询用户已有资源权限
				Boolean ifExist = false;
				List<Resource> resources = WebApplicationContextUtils.getRequiredWebApplicationContext(request.getSession().getServletContext()).getBean(ResourceMapper.class).findResourceByUserId(user.getId());

				// 判断用户请求操作是否拥有此权限
				for (Resource resource : resources) {
					String path = contextPath + (StringUtils.isNotEmpty(resource.getPath()) ? resource.getPath() : "-1");
					if (path.indexOf("?") != -1) {
						path = path.substring(0, path.indexOf("?"));
					}

					if (requestUrl.contains(path)) {
						ifExist = true;
						break;
					}
				}

				if (ifExist) {
					// 用户拥有此权限
					return true;
				} else {
					// 用户请求操作不拥有此权限
					if ("XMLHttpRequest".equals(reqType)) {
						response.setCharacterEncoding("UTF-8");
						response.setContentType("application/json; charset=utf-8");
						response.getWriter().write(JSONObject.parseObject("{'error':'-1','msg':'您没有权限。请与管理员联系!'}").toJSONString());
						return false;
					} else {
						response.setCharacterEncoding("UTF-8");
						response.setContentType("text/html; charset=utf-8");
						response.sendRedirect(contextPath + "/no-privilege.jsp?message=" + URLEncoder.encode("您没有权限。请与管理员联系!", "UTF-8"));
						return false;
					}
				}
			}

		} catch (Exception e) {
			logger.error(e);
			return false;
		}

		return super.preHandle(request, response, handler);
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		super.afterCompletion(request, response, handler, ex);
	}

	public List<String> getAllowUrls() {
		return allowUrls;
	}

	public void setAllowUrls(List<String> allowUrls) {
		this.allowUrls = allowUrls;
	}
}