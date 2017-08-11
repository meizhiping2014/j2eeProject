package com.cberp.commons.security;

import java.security.NoSuchAlgorithmException;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

/**
 * AES 128bit 加密，解密
 * @author yeyu
 *
 */
public final class Cypher {
	
	/**
	 * @description 加密
	 * @param content 待加密内容
	 * @param private_key
	 * @return
	 * @throws Exception
	 */
	public static String encrypt(final String content,final String private_key) throws Exception {
		byte[] enCodeFormat = HexUtils.hexStringToBytes(private_key);
		SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");   
        Cipher cipher = Cipher.getInstance("AES");// 创建密码器   
        byte[] byteContent = content.getBytes("UTF-8");
        cipher.init(Cipher.ENCRYPT_MODE, key);// 初始化   
        byte[] result = cipher.doFinal(byteContent);   
        return HexUtils.bytesToHexString(result); 
	}
	
	/**
	 * @description 解密
	 * @param content 加密后内容
	 * @param private_key
	 * @return
	 * @throws Exception
	 */
	public static String decrypt(final String content,final String private_key) throws Exception{
		byte[] enCodeFormat = HexUtils.hexStringToBytes(private_key);
		SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");
        Cipher cipher = Cipher.getInstance("AES");// 创建密码器   
        byte[] byteContent = HexUtils.hexStringToBytes(content); 
        cipher.init(Cipher.DECRYPT_MODE, key);// 初始化   
        byte[] result = cipher.doFinal(byteContent);
        return new String(result);
	}
	
	public static void main(String args[]) throws NoSuchAlgorithmException{
		try {
			System.out.println(Cypher.encrypt("叶宇", "b9202c25289642b148f9a791a1388110"));
			System.out.println(Cypher.decrypt("3019b3c2ed9bcd681001c6b32548cecb", "b9202c25289642b148f9a791a1388110"));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
