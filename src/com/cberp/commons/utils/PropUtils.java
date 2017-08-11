package com.cberp.commons.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import cn.egssoft.common.client.CommonClient;
import cn.egssoft.common.service.ServiceRequest;
import cn.egssoft.common.service.ServiceResponse;

public class PropUtils {
	private static Logger logger = Logger.getLogger(PropUtils.class);
	private static Properties properties = new Properties();
	static {
		try {
			InputStream portalIn = PropUtils.class.getResourceAsStream("/portal.properties");
			properties.load(portalIn);
		} catch (IOException e) {
			logger.error(e);
		}
	}

	public static String read(String key) {
		String value="";
		String firstPropSource=readFromProp("first_prop_source");
		if(StringUtils.equals("cache", firstPropSource)){
			value=readCacheFirst(key);
		}else{
			value=readPropFirst(key);
		}
		if(StringUtils.isBlank(value)){
			logger.error("从缓存和配置文件中都未找到该配置，配置key为："+key);
		}
		return value;
	}

	private static String readFromCache(String key) {
		try {
			ServiceRequest req = new ServiceRequest();
			req.setServiceId("config.configCacheService");
			req.setBodyValue("configKey", key);
			req.setBodyValue("systemName", "portal");
			ServiceResponse resp = CommonClient.call(req);
			Object result = resp.getBodyValue("result");
			if (result.equals("200")) {
				return (String) resp.getBodyValue("configValue");
			} else if(result.equals("102")){
				return "";
			}else{
				logger.error(resp.getBodyValue("msg"));
				return "";
			}
		} catch (Exception e) {
			logger.error("从缓存中获取配置信息出错",e);
			return "";
		}

	}

	private static String readFromProp(String key) {
		if (null != properties.get(key)) {
			return properties.get(key).toString();
		} else {
			return "";
		}
	}

	private static String readPropFirst(String key) {
		String value=readFromProp(key);
		if(StringUtils.isNotBlank(value)){
			return value;
		}else{
			logger.warn("从配置文件中未找到该配置，key="+key);
			return readFromCache(key);
		}
	}

	private static String readCacheFirst(String key) {
		String value=readFromCache(key);
		if(StringUtils.isNotBlank(value)){
			return value;
		}else{
			logger.warn("从缓存中未找到该配置，key="+key);
			return readFromProp(key);
		}
	}
}
