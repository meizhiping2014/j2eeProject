/**
 * 
 */
package com.cberp.commons.utils;

import org.apache.commons.lang3.StringUtils;

/**
 * FIXME 类注释信息(此标记自动生成,注释填写完成后请删除)
 *
 * @author 朱国军
 * @version 2015年8月21日
 */
public class ConfigurationsUtils {
	 private static  String protocal = PropUtils.read("protocal");

	 private static  String domain = PropUtils.read("domain");
	 
	 private static  String projectName = PropUtils.read("project.name");
	 
	 public static String getPrefix(){
		 replaceUrl();
		 if(StringUtils.isNotBlank(projectName)){
			 return protocal + "://" + domain + "/" + projectName;
		 }else{
			 return protocal + "://" + domain;
		 }
		
	 }
	 
	 public static String getHttpPrefix(){
		 replaceUrl();
		 if(StringUtils.isNotBlank(projectName)){
			 return "http://" + domain + "/" + projectName;
		 }else{
			 return "http://" + domain;
		 }
	 }
	 
	 private  static void replaceUrl(){
		 if(StringUtils.isNotBlank(projectName)){
			 if(StringUtils.endsWith(projectName, "/")){
				 projectName=StringUtils.removeEnd(projectName, "/");
			 }
		 }
		 if(StringUtils.isNotBlank(domain)){
			 if(StringUtils.endsWith(domain, "/")){
				 domain=StringUtils.removeEnd(domain, "/");
			 }
		 }
	 }
}
