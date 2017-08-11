package com.cberp.commons.utils;

import com.alibaba.fastjson.JSONObject;

public class ClassCastUtils {
	
	public static JSONObject getJsonObject(Object target){
		if(target == null){
			return null;
		}else if(target instanceof String ){
			return JSONObject.parseObject((String)target);
		}else{
			return (JSONObject)target;
		}
	}
	
}
