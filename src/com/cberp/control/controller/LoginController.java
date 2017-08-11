package com.cberp.control.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.cberp.commons.utils.VerifyImageUtils;
import com.cberp.commons.utils.annotation.SystemControllerLog;
import com.cberp.commons.utils.enCrypt.BASE64Encoder;
import com.cberp.commons.utils.enCrypt.EnCryptUtil;
import com.cberp.commons.utils.enCrypt.HMACSHA1;
import com.cberp.control.entity.User;
import com.cberp.control.mapper.UserMapper;

/**
 * 路港通-后台用户登录Controller
 * 
 * @author libin
 * 
 */
@Controller
@SessionAttributes("user")
public class LoginController {

	@Resource
	private UserMapper userMapper;

	/**
	 * 登录验证用户名、密码
	 * 
	 * @param username
	 * @param password
	 * @param model
	 * @param ra
	 * @return
	 */
	@RequestMapping(value = "/control/login/auth")
	@SystemControllerLog(description = "{'log_type':'0','log_type_val':'登录'}")
	public String auth(String username, String password, String code, Model model, HttpServletRequest req, HttpServletResponse rs) {

		if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
			model.addAttribute("username", username);
			model.addAttribute("msg", "请输入用户名或密码");
			return "control/login-input-new";
		}

		if (StringUtils.isEmpty(code)) {
			model.addAttribute("username", username);
			model.addAttribute("msg", "请输入验证码");
			return "control/login-input-new";
		}

		try {
			if (!VerifyImageUtils.verifyCodeCheck(code, req, rs)) {
				model.addAttribute("username", username);
				model.addAttribute("msg", "您输入的验证码有误");
				return "control/login-input-new";
			}
		} catch (Exception e) {
			model.addAttribute("username", username);
			model.addAttribute("msg", "验证码已过期");
			return "control/login-input-new";
		}

		User user = this.userMapper.checkUser(username, BASE64Encoder.encode(HMACSHA1.getHmacSHA1(EnCryptUtil.getCommKey(), password)));

		if (null == user) {
			model.addAttribute("username", username);
			model.addAttribute("msg", "用户名或密码错误");
			return "control/login-input-new";
		}

		if (!user.getVisible()) {
			model.addAttribute("username", username);
			model.addAttribute("msg", "用户状态异常，请联系管理员");
			return "control/login-input-new";
		}

		model.addAttribute("user", user);
		return "redirect:/control/main";
	}

	/**
	 * 登录页面
	 * 
	 * @return
	 */
	@RequestMapping("/control/login")
	public String loginUI(HttpServletRequest request, HttpServletResponse rs, HttpSession session) {

		VerifyImageUtils.visitorCheck(request, rs);

		User u = (User) session.getAttribute("user");
		if (null != u) {
			return "redirect:/control/main";
		}

		return "control/login-input-new";
	}

	/**
	 * 注销
	 * 
	 * @param request
	 * @param status
	 * @return
	 */
	@RequestMapping("/control/logout")
	public String loginOut(HttpServletRequest request, SessionStatus status) {
		status.setComplete();
		request.getSession().removeAttribute("user");
		request.getSession().invalidate();
		return InternalResourceViewResolver.REDIRECT_URL_PREFIX + "/login.jsp";
	}
}
