package com.cberp.commons.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.ModelAttribute;

import com.alibaba.fastjson.JSONObject;
import com.cberp.commons.security.DES3Cypher;
import com.cberp.commons.utils.PropUtils;


/**
 * Controller基类，用于获取request，response，session，每个请求都会调用这个方法
 *
 * @author 朱国军
 * @version 2015年7月22日
 */
public class BaseController {
	protected HttpServletRequest request;
	protected HttpServletResponse response;
	protected HttpSession session;
	
	/** true:PC,false:H5 */
	protected Boolean isPc;
	
	protected  String errorMessage;

	/** 错误页面 */
	protected final static String ERROR_PAGE = "500";

	/** 支付请求 */
	protected final static String PAY_REQUESR = "redirect:/accountcenter/go_gopayPayment.do?showType=1";

	/** 登录页面 */
	protected final static String LOGIN_PAGE = "ucenter/new_login";

	@ModelAttribute
	public void setReqAndRes(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
		this.session = request.getSession();
		this.isPc=getIsPc();
	}

	/**
	 * 获取实际访问地址前缀
	 *
	 * @return
	 */
	public String getPath() {
		String path = request.getContextPath();
		int port = request.getServerPort();
		String basePath = "";
		if (port == 80) {
			basePath = request.getScheme() + "://" + request.getServerName() + path;
		}else{
			basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
		}
		return basePath;
	}
	
	/**
	 * 获取PC和H5的标识
	 *
	 * @return true:PC,false:H5
	 */
	private Boolean getIsPc(){
		Object isPcObj=session.getAttribute("isPc");
		if (isPcObj!=null&&(Integer)isPcObj==1) {
			return false;
		}
		return true;
	}
	
	protected void print(HttpServletResponse response, String msg) {
		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.print(msg);
		} catch (Exception e) {

		} finally {
			if (out != null) {
				out.close();
			}
		}
	}
	
	
	/**
	 * 获取请求参数，封装在请求流中
	 * @param request
	 * @return
	 * @throws Exception
	 */
	protected JSONObject getRquestObjectFromStream(HttpServletRequest request) throws Exception{
		StringBuilder builder = new StringBuilder(256);
		request.setCharacterEncoding("UTF-8");
		String _temp = null;
		InputStream input = null;
		InputStreamReader reader = null;
		BufferedReader breader = null;
		try {
			input = request.getInputStream();
			reader = new InputStreamReader((input),"UTF-8");
			breader = new BufferedReader(reader);
			while((_temp = breader.readLine()) != null){
				builder.append(_temp);
			}
//			log.info("request params are: " + builder.toString());
			
			if(builder.toString().equals("")){
				throw new Exception("请求中包含的JSON内容为空字符串；转换失败；抛出异常");
			}else{
				//解密
				JSONObject json=JSONObject.parseObject(builder.toString());
				String authDes=(String)json.get("auth");
				String infoDes=(String)json.get("info");
				String auth=DES3Cypher.decode(authDes, PropUtils.read("private_key"),PropUtils.read("private_iv"));
				String info=DES3Cypher.decode(infoDes, PropUtils.read("private_key"),PropUtils.read("private_iv"));
				json.put("auth", auth);
				json.put("info", info);
				
//				log.info("DES3Cypher request json: "+json.toString());
				return json;
			}
		} catch (IOException e) {
			throw new Exception("在请求流中无法获取请求JSON字符串",e);
		} finally{
			if(input != null){
				input.close();
			}
			if(reader != null){
				reader.close();
			}
			if(breader != null){
				breader.close();
			}
		}
	}
	
	/**
	 * 请求响应流
	 * @param response
	 * @param object
	 * @throws Exception
	 */
	protected void outResponse(HttpServletResponse response,Object object) throws Exception{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=utf-8");
		OutputStream responseout = null;
		try {
			responseout = response.getOutputStream();
			String result = JSONObject.toJSONString(object);
			System.out.println(result);
//			log.info("response is: " + result);
			responseout.write(result.getBytes("UTF-8"));
		} catch (IOException e) {
			throw new Exception("系统繁忙",e);
		}finally{
			if (responseout != null) {
				try {
					responseout.flush();
					responseout.close();
				} catch (IOException e) {
//					log.error("关闭流失败");
				}
			}
		}
	}
	
	protected String getRemoteIP(HttpServletRequest request) {
		if (request.getHeader("x-forwarded-for") == null) {
			return request.getRemoteAddr();
		}
		return request.getHeader("x-forwarded-for");
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
	
}
