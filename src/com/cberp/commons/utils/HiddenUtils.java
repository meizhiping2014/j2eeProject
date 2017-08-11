package com.cberp.commons.utils;

import org.apache.commons.lang3.StringUtils;



/**
 * 隐藏utils方法
 *
 * @author 朱国军
 * @version 2016年5月9日
 */
public class HiddenUtils {
	
	/**
	 * 车辆信息隐藏
	 *
	 * @param carInfo
	 * @return
	 */
	public static String carInfoHandler(String carInfo) {
		if (carInfo.length() <= 8) {
			return carInfo;
		} else {
			String front = carInfo.substring(0, carInfo.length() - 6) + "****" + carInfo.substring(carInfo.length() - 2, carInfo.length());
			return front;
		}
	}

	/**
	 * 处理身份证号码信息，保留前3位和后4位明文，中间使用4位*字符代替
	 *
	 * @param idcard
	 * @return
	 */
	public static String idcardHandler(String idcard) {
		if (StringUtils.isBlank(idcard) || idcard.length() < 7) {
			return idcard;
		}
		String front = idcard.substring(0, 3);
		String rear = idcard.substring(idcard.length() - 4, idcard.length());
		String hiddenInfo = front + "****" + rear;
		return hiddenInfo;
	}

	/**
	 * 只显示身份证后四位
	 * 
	 * @param idcard
	 * @return
	 */
	public static String idcardHandlerExt(String idcard) {
		String rear = idcard.substring(idcard.length() - 4, idcard.length());
		return "**" + rear;
	}

	/**
	 * 只显示名字第一位
	 * 
	 * @param name
	 * @return
	 */
	public static String nameHandler(String name) {
		if (StringUtils.isNotBlank(name)) {
			String rear = name.substring(0, 1);
			return rear + "**";
		} else {
			return "";
		}
	}

	/**
	 * 只显示名字第一位(由于 数据格式为 ["123"] 类型 故从第二位开始取)
	 * 
	 * @param name
	 * @return
	 */
	public static String nameHandlerExt(String name) {
		String rear = name.substring(2, 3);
		return rear + "**";
	}

	/**
	 * 只显示名字最后一位
	 * 
	 * @param name
	 * @return
	 */
	public static String lastNameHandler(String name) {
		if (StringUtils.isNotBlank(name)) {
			String rear = name.substring(name.length()-1, name.length());
			
			String hiden="";
			for(int i=0;i<name.length()-1;i++){
				hiden+="*";
			}
			
			return hiden+rear;
		} else {
			return "";
		}
	}
	
	/**
	 * 处理手机号码信息，保留前3位和后4位明文，中间使用4位*字符代替
	 *
	 * @param phoneNum
	 * @return
	 */
	public static String phoneNumberHandler(String phoneNum) {
		if (StringUtils.isNotBlank(phoneNum)) {
			// 处理身份证号码信息，保留前3位和后4位明文，中间使用4位*字符代替
			String front = phoneNum.substring(0, 3);
			String rear = phoneNum.substring(phoneNum.length() - 4, phoneNum.length());
			String hiddenInfo = front + "****" + rear;
			return hiddenInfo;
		}
		return "";
	}
	/**
	 * 处理邮箱，前两个字符及@后面字符不隐藏
	 * 
	 * @param email
	 * @return
	 */
	public static String emailHander(String email) {
		String[] emails = email.split("@");
		String head = emails[0].substring(0, 2) + "***";
		return head + "@" + emails[1];
	}
}
