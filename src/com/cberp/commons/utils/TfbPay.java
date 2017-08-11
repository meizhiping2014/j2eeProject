package com.cberp.commons.utils;

import java.io.StringReader;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

/**
 * 国采天付宝-代付
 * 
 * @author libin
 * 
 */
public class TfbPay {

	public static Map<String, String> callPayService(String serUrl, Map<String, String> reqMap) throws Exception {

		// 返回结果字符串
		String result = null;

		// 排序后的返回结果（定义）
		Map<String, String> rMap = new TreeMap<String, String>(new Comparator<String>() {
			public int compare(String obj1, String obj2) {
				// 升序排序
				return obj1.compareTo(obj2);
			}
		});

		// 商户Key
		String spkey = PropUtils.read("tfb_spkey_hx");

		// 请求参数（定义）
		List<NameValuePair> lValuePairs = new ArrayList<NameValuePair>();

		// 排序后的请求参数（定义）
		Map<String, String> map2 = new TreeMap<String, String>(new Comparator<String>() {
			public int compare(String obj1, String obj2) {
				// 升序排序
				return obj1.compareTo(obj2);
			}
		});

		// 数据对象填值
		for (Map.Entry<String, String> entry : reqMap.entrySet()) {
			map2.put(entry.getKey(), entry.getValue());
		}

		// 加密前所有请求参数字符串
		String paramStr = "";

		for (Map.Entry<String, String> entry : map2.entrySet()) {
			if (!"".equals(entry.getValue())) {
				paramStr = paramStr + "&" + entry.getKey() + "=" + entry.getValue();
			}
		}

		// 加密前的签名串
		String signStr = paramStr.substring(1) + "&key=" + spkey;
		// 生成商户签名
		String md5_sign = Md5Utils.encryption(signStr).toLowerCase();
		paramStr = paramStr + "&sign=" + md5_sign;
		// RSA加密
		String cipherData = encrypt(paramStr.toString());

		lValuePairs.add(new BasicNameValuePair("cipher_data", cipherData));

		// 请求参数返回
		// rMap.put("apl_data", JSON.toJSONString(lValuePairs));

		try {
			/** 发起Post请求 * */
			HttpClient client = HttpClientBuilder.create().build();

			HttpPost hPost = new HttpPost(serUrl);
			hPost.setEntity(new UrlEncodedFormEntity(lValuePairs, Charset.forName("UTF-8").displayName()));
			HttpResponse httpResponse = client.execute(hPost);
			HttpEntity entity = httpResponse.getEntity();

			// 返回结果字符串
			result = EntityUtils.toString(entity, "UTF-8");
			rMap.put("tfb_result", result);

		} catch (Exception e) {
			rMap.put("excep_dsc", "调用代付接口异常====" + e.toString());
		}

		/** 解析xml格式的返回结果 * */
		try {
			if (StringUtils.isNotEmpty(result)) {
				DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
				DocumentBuilder builder = factory.newDocumentBuilder();
				Document doc = builder.parse(new InputSource(new StringReader(result)));

				Element root = doc.getDocumentElement();
				NodeList books = root.getChildNodes();

				if (books != null) {
					for (int i = 0; i < books.getLength(); i++) {
						Node book = books.item(i);
						if (book != null && book.getFirstChild() != null) {
							rMap.put(book.getNodeName(), book.getFirstChild().getNodeValue());
						}
					}
				}
			}

		} catch (Exception e) {
			rMap.put("excep_dsc", "代付请求结果解析异常====" + e.toString());
		}

		// 校验天付宝签名
		if ("00".equals(rMap.get("retcode"))) {
			try {
				// 结果加密串
				String rCipherData = rMap.get("cipher_data");

				// 结果明文串
				rCipherData = decryptResponseData(rCipherData);
				rMap.put("proclaim_data", rCipherData);

				// 天付宝签名
				String sign = rCipherData.substring(rCipherData.indexOf("sign=") + 5, rCipherData.length());
				rMap.put("sign", sign);

				// 返回参数串
				String source = rCipherData.substring(0, rCipherData.lastIndexOf("&sign"));

				// 返回参数串分隔
				String[] paramStrings = source.split("&");

				// 返回参数Map封装
				for (String paramString : paramStrings) {
					String paramKey = paramString.substring(0, paramString.lastIndexOf("="));
					String paramValue = paramString.substring(paramString.lastIndexOf("=") + 1);
					rMap.put(paramKey, paramValue);
				}
				// 测试代码，不管天付宝返回结果如何，都默认成功
				// rMap.put("result", "1");
				// rMap.put("retcode", "000000");
				// 验签
				if (verify(source, sign)) {
					rMap.put("retcode", "000000");
				} else {
					rMap.put("retcode", "100001");
					rMap.put("retmsg", "天付宝签名校验失败");
				}

			} catch (Exception e) {
				rMap.put("excep_dsc", "校验天付宝代付签名异常====" + e.toString());
				rMap.put("retcode", "100001");
				rMap.put("retmsg", "天付宝签名校验失败");
			}
		}

		return rMap;

	}

	/**
	 * 验签
	 * 
	 * @param source
	 *            签名内容
	 * @param sign
	 *            签名值
	 * @return
	 */
	private static boolean verify(String source, String sign) throws Exception {
		// 商户Key
		String spkey = PropUtils.read("tfb_spkey_hx");
		// 生成天付宝签名
		String md5_sign2 = Md5Utils.encryption(source + "&key=" + spkey).toLowerCase();

		// 验签
		return sign.equals(md5_sign2);
	}

	/**
	 * 加密得到cipherData
	 * 
	 * @param paramstr
	 * @return
	 */
	private static String encrypt(String paramStr) throws Exception {

		String publickey = RSAUtils.loadPublicKey(PropUtils.read("tfb_rsa_public_file_hx"));
		
		System.out.println(paramStr.getBytes("UTF-8").length);
		System.out.println(paramStr.getBytes().length);
		String cipherData = RSAUtils.encryptByPublicKey(paramStr.getBytes("UTF-8"), publickey);

		return cipherData;
	}

	/**
	 * rsa解密
	 * 
	 * @param cipherData
	 *            the data to be decrypt
	 * @return
	 */
	private static String decryptResponseData(String cipherData) throws Exception {

		String privatekey = RSAUtils.loadPrivateKey(PropUtils.read("tfb_rsa_private_file_hx"));
		String result = RSAUtils.decryptByPrivateKey(Base64Utils.decode(cipherData), privatekey);

		result = new String(result.getBytes("ISO-8859-1"), "UTF-8");
		return result;
	}

}
