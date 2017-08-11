package com.cberp.commons.utils.constants;

/**
 * @描叙：验证码常量
 * @版本：1.0
 */
public final class VerifyImageConstants {

	public static final Integer imageWidth = 55;

	public static final Integer imageHight = 23;

	public static final Integer minWordsLength = 4;

	public static final Integer maxWordsLength = 4;

	public static final Integer minFontSize = 14;

	public static final Integer maxFontSize = 14;

	public static final String randomWords = "ABCDEFGHJKLMNPQRSTUVWXY123456789";

	public static final Integer minGuarantedStorageDelayInSeconds = 180;

	public static final Integer maxCaptchaStoreSize = 100000;

	public static final Integer captchaStoreLoadBeforeGarbageCollection = 75000;

}
