package com.cberp.commons.utils;

/**
 * 定义返全局回码表
 * @author jinshajiang
 *
 */
public enum ReturnCodeUtils {
	/**
	 * 用户名和密码错误
	 */
	USER_NAME_AND_PASSWORD_ERROR("0","用户名或密码错误"),
	/**
	 * 用户成功登陆钱来网
	 */
	USER_LOGIN_SUCCESSFUL("-1","登陆成功"),
	
	USER_LOGIN_ERROR("0","登陆失败"),
	
	USER_NOT_LOGIN("0","用户未登陆"),
	/**
	 * 系统繁忙
	 */
	USER_SYSTEM_BUSY_ERROR("0","系统繁忙"),
	
	/**
	 * 账户查询失败
	 */
	USER_ACCOUNT_ERROR("0","查询失败"),
	
	/**
	 * 账户查询成功
	 */
	USER_ACCOUNT_SUCCESS("-1","查询成功"),
	
	/**
	 * 投资成功
	 */
	BIDDING_SUCCESS("-1","投资成功"),
	
	/**
	 * 投资失败
	 */
	BIDDING_FAILURE("0","投资失败"),
	
	/**
	 * 系统繁忙
	 */
	BIDDING_ERROR("0","系统繁忙，请稍后再试"),
	
	/**
	 * 可投金额不足
	 */
	BIDDING_NOT_ENOUGH("0","剩余可投金额不足"),
	
	/**
	 * 用户剩余可用金额不足
	 */
	BIDDING_AVIVALBLE_NOT_ENOUGH("0","投资金额大于项目剩余金额，请重试"),
	
	/**
	 * 抢光了
	 */
	BIDDING_IS_OVER("0","手慢一步，被别人抢光了"),
	
	/**
	 * 短信
	 */
	SEND_SMS_ERROR("0","发送短信失败"),
	/**
	 * 短信
	 */
	SEND_SMS_SUCCESS("-1","发送短信成功"),
	/**
	 * 短信验证码为空
	 */
	SMS_EMPTY_ERROR("0","短信验证码为空"),
	/**
	 * 短信验证码过期
	 */
	SMS_EXPIRED_ERROR("0","短信验证码过期"),
	/**
	 * 短信验证码校验失败
	 */
	SMS_VALID_ERROR("0","短信验证码错误"),
	
	/**
	 * 用户名已存在
	 */
	USER_PHONE_ISEXIST("0","该用户已存在"),
	/**
	 * 用户名不存在
	 */
	USER_PHONE_ISNOTEXIST("0","该用户不存在"),
	/**
	 * 修改密码成功
	 */
	PASSWORD_SUCCESS("-1","修改成功"),
	/**
	 * 修改密码失败
	 */
	PASSWORD_ERROR("0","修改失败"),
	
	/**
	 * 发送邮件成功
	 */
	BINDDING_ERROR("0","发送邮件失败"),
	
	/**
	 * 发送邮件失败
	 */
	BINDDING_SUCCESS("-1","发送成功"),
	
	/**
	 * 发送邮件失败
	 */
	DEBTTRANSFER_SUCCESS("-1","转让成功"),
	
	/**
	 * 发送邮件失败
	 */
	DEBTTRANSFER_ERROR("0","转让失败"),
	
	/**
	 * 发送邮件失败
	 */
	PAYPASSWORD_ERROR("0","支付密码错误"),
	
	/**
	 * 发送邮件失败
	 */
	CANNOT_CONFIRM_RATE("0","奖励年利率无法确定!"),
	
	/**
	 * 发送邮件失败
	 */
	CANNOT_TRANSFER("0","21:00:00-24:00:00不可转让!"),
	
	/**
	 * 发送邮件失败
	 */
	CANNOT_CONFIRM_ERROR("0","无法确定该债权所在的还款期期间"),
	
	/**
	 * 发送邮件失败
	 */
	CANNOT_TRANSFER_ERROR("0","该笔借款的还款期大于100期，不允许债权转让"),
	
	
	
	/**
	 * 实名认证失败
	 */
	USER_AUTH_ERROR("0","实名认证失败"),
	
	USER_AUTH_SUCCESS("-1","实名认证成功"),
	
	USER_ADD_BANK_ERROR("0","添加银行卡失败"),
	
	USER_ADD_BANK_SUCCESS("-1","添加银行卡成功"),
	
	USER_UPDATE_BANK_ERROR("-1","设置默认银行卡失败"),
	
	USER_UPDATE_BANK_SUCCESS("-1","设置默认银行卡成功"),
	
	/**
	 * 易宝充值
	 */
	YEEPAY_RECHARGE_ERROR("0","提交充值请求失败"),
	YEEPAY_RECHARGE_SUCCESS("-1","提交充值请求成功"),
	YEEPAY_RECHARGE_RESULT_QUERY_ERROR("0","查询充值结果失败"),
	YEEPAY_RECHARGE_RESULT_QUERY_SUCCESS("-1","查询充值结果成功"),
	
	/**
	 * 委托理财计划
	 */
	TRUSTFINANCING_QUERY_ERROR("0","执行失败"),
	TRUSTFINANCING_QUERY_SUCCESS("-1","执行成功"),
	
	/**
	 * 委托理财计划投资
	 */
	TRUSTFINANCING_INVEST_ERROR("0","投资失败"),
	TRUSTFINANCING_INVEST_SYSTEM_BUSY("1","系统繁忙"),
	TRUSTFINANCING_INVEST_OVER("2","手慢一步，被别人抢光了"),
	TRUSTFINANCING_INVEST_NOT_ENOUGH("3","剩余可投金额不足"),
	TRUSTFINANCING_INVEST_OVER_MAXINVESTAMOUNT("4","你已达到本标最高投资额"),
	TRUSTFINANCING_AVIVALBLE_NOT_ENOUGH("5","可用余额不足"),
	TRUSTFINANCING_INVEST_SUCCESS("-1","投资成功"),
	
	/**
	 * 非新手不能投资新手标
	 */
	NOVICE_ERROR("0","本项目只适用于新手首次投资"),
	
	RECEIVE_SUCCESS("-1","领取成功"),
	RECEIVE_ERROR("0","领取失败"),
	
	DELETE_SUCCESS("-1","清空成功"),
	DELETE_ERROR("0","清空失败"),
	VALIDATOR_SUCCESS("-1","验证成功"),
	VALIDATOR_ERROR("0","验证失败"),
	
	PARAMETER_ERROR("0","缺少参数"),
	
	SUBMIT_SUCCESS("-1","提交成功"),
	SUBMIT_ERROR("0","提交失败"),
	/**
	 * 自动投标查询
	 */
	QUERYAUTOMATICBID_SUCCESS("-1","自动投标查询成功"),
	QUERYAUTOMATICBID_ERROR("0","自动投标查询失败"),
	/**
	 * 自动投标修改
	 */
	UPADTEAUTOMATICBID_SUCCESS("-1","自动投标修改成功"),
	UPADTEAUTOMATICBID_ERROR("0","自动投标修改失败"),
	
	QUERY_RESULT_SUCCESS("-1","查询成功"),
	
	QUERY_RESULT_ERROR("0","查询失败");
	
	
	
	private String code;
	
	private String desc;
    
	ReturnCodeUtils(String code,String desc){
		this.code = code;
		this.desc = desc;
    }
   
    public String getReturnCode(){
    	return this.code;
    }
    
    public String getDesc(){
    	return this.desc;
    }
	
}
