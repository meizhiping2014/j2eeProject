package com.cberp.commons.utils;

import java.nio.charset.Charset;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import javax.net.ssl.SSLContext;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContextBuilder;
import org.apache.http.conn.ssl.TrustStrategy;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSON;

public class HttpRequestUtils {
	
	private static Logger logger = LoggerFactory.getLogger(HttpRequestUtils.class);
	private static final HttpClientBuilder httpClientBuilder = HttpClientBuilder.create();
	public static final HttpClient httpClient = httpClientBuilder.build();

	/**
	 * @param client
	 * @param url
	 * @param headers
	 * @param postContent
	 * @param defaultCharset
	 * @return
	 */
	public static String httpPost(HttpClient client, String url, Map<String, String> headers, String postContent, String defaultCharset) {
		HttpPost httpPost = null;
		String returnContent = "";
		long before = System.currentTimeMillis();
		try {
			httpPost = new HttpPost(url);
			
			if (headers != null && headers.size() > 0) {
				Header[] params = new Header[headers.size()];
				Set<String> set = headers.keySet();
				Iterator<String> it = set.iterator();
				int i = 0;
				while (it.hasNext()) {
					String key = it.next();
					String value = String.valueOf(headers.get(key));
					params[i] = new BasicHeader(key, value);
					i++;
				}
				httpPost.setHeaders(params);
			}
			
			HttpEntity entity = new StringEntity(postContent, defaultCharset);
			httpPost.setEntity(entity);
			
			HttpResponse response = client.execute(httpPost);
			returnContent = EntityUtils.toString(response.getEntity(), defaultCharset);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (httpPost != null) {
				httpPost.abort();
			}
		}
		logger.info("Http请求用时 " + (System.currentTimeMillis() - before) + "ms. 返回内容:" + returnContent);
		return returnContent;
	}

	/**
	 *
	 * @param url
	 * @param headers
	 * @param postContent
	 * @return
	 */
	public static String httpPost(String url, Map<String, String> headers, String postContent) {
		return httpPost(httpClient, url, headers, postContent, Charset.forName("UTF-8").displayName());
	}

	/**
	 *
	 * @param url
	 * @param headers
	 * @param params
	 * @return
	 */
	public static String httpPost(String url, Map<String, String> headers, Map<String, String> params) {
		return httpPost(httpClient, url, headers, JSON.toJSONString(params), Charset.forName("UTF-8").displayName());
	}

	/**
	 *
	 * @param url
	 * @param map
	 * @param charset
	 * @return
	 */
	public static String doPost(String url, Map<String, String> map, String charset) {
		HttpClient httpClient = null;
		HttpPost httpPost = null;
		String result = null;
		try {
			// httpClient = new SSLClient();
			httpClient = HttpRequestUtils.createSSLClientDefault();
			httpPost = new HttpPost(url);
			// 设置参数
			List<NameValuePair> list = new ArrayList<NameValuePair>();
			Iterator<Entry<String, String>> iterator = map.entrySet().iterator();
			while (iterator.hasNext()) {
				Entry<String, String> entry = iterator.next();
				list.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
			}
			if (list.size() > 0) {
				UrlEncodedFormEntity entity = new UrlEncodedFormEntity(list, charset);
				httpPost.setEntity(entity);
			}
			HttpResponse response = httpClient.execute(httpPost);
			if (response != null) {
				HttpEntity resEntity = response.getEntity();
				if (resEntity != null) {
					result = EntityUtils.toString(resEntity, charset);
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (null != httpPost) {
				httpPost.abort();
			}
		}
		return result;
	}

	public static CloseableHttpClient createSSLClientDefault() {
		try {
			SSLContext sslContext = new SSLContextBuilder().loadTrustMaterial(null, new TrustStrategy() {
				// 信任所有
				@Override
				public boolean isTrusted(java.security.cert.X509Certificate[] chain, String authType)
						throws java.security.cert.CertificateException {
					return true;
				}
			}).build();
			SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(sslContext);
			return HttpClients.custom().setSSLSocketFactory(sslsf).build();
		} catch (KeyManagementException e) {
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (KeyStoreException e) {
			e.printStackTrace();
		}
		return HttpClients.createDefault();
	}

}
