package com.cberp.commons.utils.enCrypt;

import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;

/**
 * @描述：加密算法工具类
 * @作者：李彬
 * @开发日期：2011-9-21
 * @版权：
 * @版本：1.0
 */
public class EnCryptUtil {

	/**
	 * @描述：公用KEY(尽量复杂化)
	 * @作者：李彬
	 * @开发日期：2011-9-21
	 * @return
	 */
	public static String getCommKey() {
		return "com.megaaa·#￥%（*）+=";
	}

	/**
	 * @描述：散列KEY
	 * @作者：李彬
	 * @开发日期：2011-9-21
	 * @return
	 * @throws Exception
	 */
	public static String getHmacSHA1Key() throws Exception {
		KeyGenerator keyGen = KeyGenerator.getInstance("HmacSHA1");
		SecretKey key = keyGen.generateKey();
		return key.toString();
	}
	
	public static void main(String[] args) {
		 System.out.println(BASE64Encoder.encode(HMACSHA1.getHmacSHA1(EnCryptUtil.getCommKey(), "admin123")));
	}
}
