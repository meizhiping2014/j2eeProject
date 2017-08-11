package com.cberp.commons.utils;

public class LgtConstants {

	// 充值结果
	public static final int RECHARGE_REQUEST = 0;
	public static final int RECHARGE_SUCCESS = 1;
	public static final int RECHARGE_PROCESS = 2;
	public static final int RECHARGE_FAILURE = 3;

	/** 超级系统管理员名称 */
	public static final String SUPER_SYSTEM_ADMIN = "超级系统管理员";

	// EAP服务调用结果
	public static final String SERVICE_CALL_SUCCESS = "1";
	public static final String SERVICE_CALL_FAILURE = "0";

	/** *************************ETC卡充值 start ******************** */

	/** 服务接口调用成功* */
	public static final String ETC_INTERFACE_CALL_SUCCESS = "200";

	/** 服务接口调用失败* */
	public static final String ETC_INTERFACE_CALL_FAILURE = "500";

	/**
	 * 国采-天付宝-验签成功code
	 */
	public static final String TFB_SIGN_VALIDATE_SUCCESS_CODE = "000000";

	/** ETC充值代付状态：发起代付请求 * */
	public static final int ETC_RECHARGE_REQUEST = 0;

	/** ETC充值代付状态：代付成功* */
	public static final int ETC_RECHARGE_SUCCESS = 1;

	/** ETC充值代付状态：处理中* */
	public static final int ETC_RECHARGE_PROCESS = 2;

	/** ETC充值代付状态：处理失败* */
	public static final int ETC_RECHARGE_FAILURE = 3;

	/** ETC充值流程状态-请求发起 * */
	public static final int ETC_RECHARGE_PROCESS_STATUS_REQUEST = 15001;
	/** ETC充值流程状态-国采代付 * */
	public static final int ETC_RECHARGE_PROCESS_STATUS_GC = 15002;
	/** ETC充值流程状态-创建订单 * */
	public static final int ETC_RECHARGE_PROCESS_STATUS_CREATEORDER = 15003;
	/** ETC充值流程状态-检查订单（交易通知） * */
	public static final int ETC_RECHARGE_PROCESS_STATUS_VERIFYORDER = 15004;

	/** 国采代付接口请求URL * */
	public static final String TFB_PAY_SINGLE_URL = PropUtils.read("tfb_pay_single_url");

	/** 国采代付查询接口请求URL * */
	public static final String TFB_PAY_SINGLE_QUERY_URL = PropUtils.read("tfb_pay_single_query_url");

	/** 国采代付分配的商户号* */
	public static final String TFB_SPID_HX = PropUtils.read("tfb_spid_hx");

	/** 赣通宝接口-订单类型-11：路港通 * */
	public static final String ETC_ORDER_TYPE = "11";

	/** 赣通宝接口-查询是否存在已付款待圈存的订单 * */
	public static final String ETC_PAYMENT_CHECK_ORDER_URL = "http://127.0.0.1:8081/lgt/payment/checkExistOrder";

	/** 赣通宝接口-创建订单URL * */
	public static final String ETC_PAYMENT_ORDER_URL = "http://127.0.0.1:8081/lgt/payment/order";

	/** 赣通宝接口-检查交易通知URL * */
	public static final String ETC_PAYMENT_ORDER_CONFIRM_URL = "http://127.0.0.1:8081/lgt/payment/confirmation/{orderNo}";

	/** 通过 * */
	public static final String CODE_SUCCESS = "00";

	/** 不通过 * */
	public static final String CODE_FAIL = "01";

	/** 失败 * */
	public static final String CODE_ERROR = "-1";

	/** 101 单号XX待圈存 * */
	public static final String ETC_ORDER_STATUS_1 = "101";

	/** 102 单号XX圈存失败 * */
	public static final String ETC_ORDER_STATUS_2 = "102";

	/** 103 单号XX已圈存，未返回结果，需修复 * */
	public static final String ETC_ORDER_STATUS_3 = "103";

	/** *************************ETC卡充值 end******************** */
}
