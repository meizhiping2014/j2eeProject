package com.cberp.commons.security;

import java.security.Key;
import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESedeKeySpec;
import javax.crypto.spec.IvParameterSpec;

import org.joda.time.DateTime;

import com.alibaba.fastjson.JSONObject;

/**
 * 3DES加密工具类，简单加密，用来加密/解密加密后请求流中的参数
 * 
 * @author jinshajiang
 * 
 */
public class DES3Cypher {

	// 加解密统一使用的编码方式
	private final static String encoding = "utf-8";

	/**
	 * 3DES加密
	 * 
	 * @param content
	 *            普通文本
	 * @param private_key
	 *            加密私钥
	 * @param iv
	 *            加密向量
	 * @return
	 * @throws Exception
	 */
	public static String encode(String content, String private_key, String iv) throws Exception {
		Key deskey = null;
		DESedeKeySpec spec = new DESedeKeySpec(private_key.getBytes());
		SecretKeyFactory keyfactory = SecretKeyFactory.getInstance("desede");
		deskey = keyfactory.generateSecret(spec);

		Cipher cipher = Cipher.getInstance("desede/CBC/PKCS5Padding");
		IvParameterSpec ips = new IvParameterSpec(iv.getBytes());
		cipher.init(Cipher.ENCRYPT_MODE, deskey, ips);
		byte[] encryptData = cipher.doFinal(content.getBytes(encoding));
		return Base64.encode(encryptData);
	}

	/**
	 * 3DES解密
	 * 
	 * @param content
	 *            加密文本
	 * @param private_key
	 *            加密私钥
	 * @param iv
	 *            加密向量
	 * @return
	 * @throws Exception
	 */
	public static String decode(String content, String private_key, String iv) throws Exception {
		Key deskey = null;
		DESedeKeySpec spec = new DESedeKeySpec(private_key.getBytes());
		SecretKeyFactory keyfactory = SecretKeyFactory.getInstance("desede");
		deskey = keyfactory.generateSecret(spec);
		Cipher cipher = Cipher.getInstance("desede/CBC/PKCS5Padding");
		IvParameterSpec ips = new IvParameterSpec(iv.getBytes());
		cipher.init(Cipher.DECRYPT_MODE, deskey, ips);

		byte[] decryptData = cipher.doFinal(Base64.decode(content));

		return new String(decryptData, encoding);
	}

	private static String getETCCard() {
		StringBuffer sb = new StringBuffer("");

		for (int i = 0; i < 15; i++) {
			sb.append(new SecureRandom().nextInt(9) + 1);
		}
		return sb.toString();

	}

	public static void main(String[] args) {
		String enStr = "";
		// \"etcCard\":\"918225227126789\",
		String[] strArr = { "{\"uid\":\"-1\"}", "{\"etcID\":\"752b95be644711e682cfc81f66358acc\",\"payPassword\":\"J7q9/DWEllhs2vB7mn4fSA==\",\"rechargeMoney\":\"1000\"}" };
		// ETC 卡充值
		// auth:{"address":"","app_key":"7986C7543b0427F787dD590d6f39a5A0","app_version":"1.0","area":"华南","channel":"0","channel_sub":"0","city":"深圳市","country":"中国","imei":"DEVbe6db65e41e47d02","ip":"119.139.194.245","isp":"电信","latitude":"","longitude":"","mac":"08:00:27:32:aa:09","mb_brand":"generic","mb_model":"Samsung
		// Galaxy Note 2 - 4.1.1 - API 16 -
		// 720x1280","mb_screen":"null","os":"Android_os","os_version":"4.1.1","region":"广东省","time_stamp":"20160817092344","uid":"44f194c5260746988afc4a11b5ef4169","username":"15866666666"}
		// info:{"etcID":"752b95be644711e682cfc81f66358acc","payPassword":"J7q9/DWEllhs2vB7mn4fSA==","rechargeMoney":"1000"}
		try {
			System.out.println(encode("{\"etcCard\":\"986743612529437\"}", "b9202c25289642b148f9a791a1388110", "01234567"));
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			for (String tmpStr : strArr) {
				System.out.println(tmpStr);
				enStr = encode(tmpStr, "b9202c25289642b148f9a791a1388110", "01234567");
				System.out.println(enStr);

			}
			String str = "{\"address\":\"\",\"app_key\":\"7986C7543b0427F787dD590d6f39a5A0\",\"app_version\":\"1.0\",\"area\":\"华南\",\"channel\":\"0\",\"channel_sub\":\"0\",\"city\":\"深圳市\",\"country\":\"中国\",\"imei\":\"DEVbe6db65e41e47d02\",\"ip\":\"119.139.194.245\",\"isp\":\"电信\",\"latitude\":\"\",\"longitude\":\"\",\"mac\":\"08:00:27:32:aa:09\",\"mb_brand\":\"generic\",\"mb_model\":\"SamsungGalaxy Note 2 - 4.1.1 - API 16 -720x1280\",\"mb_screen\":\"null\",\"os\":\"Android_os\",\"os_version\":\"4.1.1\",\"region\":\"广东省\",\"time_stamp\":\"20160817092344\",\"uid\":\"44f194c5260746988afc4a11b5ef4169\",\"username\":\"15866666666\"}";
			System.out.println("auth：" + encode(str, "b9202c25289642b148f9a791a1388110", "01234567"));
			String etcNo = getETCCard();
			System.out.println("ETC卡号：" + etcNo);
			System.out.println("绑定ETC卡：" + encode("{\"etcCard\":" + etcNo + "}", "b9202c25289642b148f9a791a1388110", "01234567"));
			System.out.println("设置默认ETC卡：" + encode("{\"etcID\":\"1f656adb65f311e682cfc81f66358acc\"}", "b9202c25289642b148f9a791a1388110", "01234567"));
			System.out.println("ETC卡充值：" + encode("{\"etcID\":\"8bb814e96a9911e682cfc81f66358acc\",\"bankID\":\"553d07c061384ea6b59ea5ade75cd98d\",\"payPassword\":\"J7q9/DWEllhs2vB7mn4fSA==\",\"rechargeMoney\":\"1000\"}", "b9202c25289642b148f9a791a1388110", "01234567"));
			System.out.println("ETC卡充值记录：" + encode("{\"pageNo\":\"1\",\"pageNum\":\"10\"}", "b9202c25289642b148f9a791a1388110", "01234567"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String deStr = "";
		try {
			// 123243
			deStr = decode("H07QC4VOKG1AtEuSpPQp8BTVE4BRbpyaDUFPJrhvcWs=", "b9202c25289642b148f9a791a1388110", "01234567");
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(deStr);

		JSONObject object = new JSONObject();
		System.out.println(object.toJSONString());

		System.out.println(new DateTime().toDate());
		
		System.out.println(new DateTime().toString("yyyy-MM-dd HH:mm:ss"));
		
		System.out.println(getPayNumber());

	}
	
	private static String getPayNumber() {
		StringBuffer sb = new StringBuffer("");
		sb.append(new DateTime().toString("yyyyMMddHHmmss"));
		sb.append(new SecureRandom().nextInt(8999) + 1000);

		return sb.toString();
	}
}
