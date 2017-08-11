package com.cberp.commons.utils;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Md5Utils {

   /**
    * 
    * @param plainText 明文
    * @return 32位密文
 * @throws UnsupportedEncodingException 
    */
   public static String encryption(String plainText) throws UnsupportedEncodingException {
       String re_md5 = new String();
       try {
           MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(plainText.getBytes("utf-8"));
           byte b[] = md.digest();

           int i;

           StringBuffer buf = new StringBuffer("");
           for (int offset = 0; offset < b.length; offset++) {
               i = b[offset];
               if (i < 0)
                   i += 256;
               if (i < 16)
                   buf.append("0");
               buf.append(Integer.toHexString(i));
           }

           re_md5 = buf.toString();

       } catch (NoSuchAlgorithmException e) {
           e.printStackTrace();
       }
       return re_md5;
   }
   
   public static String encryption(String str,String charset) {  
       MessageDigest messageDigest = null;  
 
       try {  
           messageDigest = MessageDigest.getInstance("MD5");  
           messageDigest.reset();  
 
           messageDigest.update(str.getBytes(charset));  
       } catch (NoSuchAlgorithmException e) {  
           System.out.println("NoSuchAlgorithmException caught!");  
           System.exit(-1);  
       } catch (UnsupportedEncodingException e) {  
           e.printStackTrace();  
       }  
 
       byte[] byteArray = messageDigest.digest();  
 
       StringBuffer md5StrBuff = new StringBuffer();
       for (int i = 0; i < byteArray.length; i++) {              
           if (Integer.toHexString(0xFF & byteArray[i]).length() == 1)  
               md5StrBuff.append("0").append(Integer.toHexString(0xFF & byteArray[i]));  
           else  
               md5StrBuff.append(Integer.toHexString(0xFF & byteArray[i]));  
       }  
 
       return md5StrBuff.toString();  
   }  
   
   public static void main(String[] args) throws UnsupportedEncodingException {
	  String s = encryption("1325|0|1422683857807|18664317540|13250001|陈超,50元");
	   System.out.println(s);
	   s = encryption("1325|0|1422683857807|18664317540|13250001|陈超,50元","GBK");
	   System.out.println(s);
	   
	   System.out.println(encryption("12345678"));
	   
	   
   }
}
