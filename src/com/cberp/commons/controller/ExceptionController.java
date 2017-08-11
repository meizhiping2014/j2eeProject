package com.cberp.commons.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.cberp.commons.vo.ReturnVo;

/**
 * 异常处理类,包括404
 * 
 * @author libin
 * 
 */
@Controller
public class ExceptionController extends BaseController implements HandlerExceptionResolver {

	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
		try {
			outResponse(response, new ReturnVo("0", "请求不存在或异常"));
			ex.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	@RequestMapping(value = "/error_404", produces = "application/json; charset=utf-8")
	public void error_404() throws Exception {
		outResponse(response, new ReturnVo("0", "请求有误，检查请求后重试"));
		return;
	}
}
