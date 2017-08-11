package com.cberp.commons.utils;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.cberp.commons.utils.constants.CookieConstants;
import com.cberp.commons.utils.constants.VerifyImageConstants;
import com.octo.captcha.service.captchastore.FastHashMapCaptchaStore;
import com.octo.captcha.service.image.DefaultManageableImageCaptchaService;

/**
 * @描叙：Verify Code Utils
 * @版本：1.0
 */
public final class VerifyImageUtils {

	private static FastHashMapCaptchaStore fastHashMapStore = new FastHashMapCaptchaStore();

	private static VerifyImageEngine verifyImageEngine = new VerifyImageEngine();

	private static DefaultManageableImageCaptchaService verifyImageService;

	public static final DefaultManageableImageCaptchaService getImageCaptchaService() {
		if (verifyImageService == null || verifyImageEngine == null) {
			verifyImageService = new DefaultManageableImageCaptchaService(fastHashMapStore, verifyImageEngine, VerifyImageConstants.minGuarantedStorageDelayInSeconds, VerifyImageConstants.maxCaptchaStoreSize, VerifyImageConstants.captchaStoreLoadBeforeGarbageCollection);
		}

		return verifyImageService;
	}

	/**
	 * @描述：检查验证
	 * @param inputVerifyCode
	 * @param request
	 * @param response
	 * @return
	 */
	public final static boolean verifyCodeCheck(String inputVerifyCode, HttpServletRequest request, HttpServletResponse response) {
		boolean flag = false;
		if (StringUtils.isNotEmpty(inputVerifyCode) && StringUtils.isNotBlank(inputVerifyCode)) {
			String visitorId = CookieUtils.getCookieValue(request, CookieConstants.KEY_VISITOR_ID);
			flag = VerifyImageUtils.getImageCaptchaService().validateResponseForID(visitorId, inputVerifyCode.toUpperCase());

		}
		if (flag) {
			// logger.info("verifyCodeCheck success.");
		} else {
			// logger.info("verifyCodeCheck failure.");
		}
		return flag;
	}

	/**
	 * @描述：生成用户访问标识
	 * @param request
	 * @param response
	 */
	public final static void visitorCheck(HttpServletRequest request, HttpServletResponse response) {
		String visitorId = CookieUtils.getCookieValue(request, CookieConstants.KEY_VISITOR_ID);
		if (StringUtils.isEmpty(visitorId)) {
			CookieUtils.setCookie(request, response, CookieConstants.KEY_VISITOR_ID, String.valueOf(UUID.randomUUID()).replace("-", ""));
		}
	}

}
