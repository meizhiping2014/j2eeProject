package com.cberp.control.entity;

import java.util.Date;

import com.cberp.control.entity.base.BaseEntity;

/**
 * @描述：操作日志表
 * @作者：李彬
 * @开发日期：2016-11-30
 * @版权：
 * @Table:t_dcs_log
 * @版本：1.0
 */
public class Log extends BaseEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 主键ID
	 */
	private String pid;

	/**
	 * 日志类型
	 */
	private String log_type;

	/**
	 * 日志类型名称
	 */
	private String log_type_val;

	/**
	 * 日志内容
	 */
	private String log_content;

	/**
	 * 日志创建人
	 */
	private String log_creator;

	/**
	 * 日志时间
	 */
	private Date log_date;

	/**
	 * 日志IP地址
	 */
	private String log_ip;

	/**
	 * 日志状态
	 */
	private int log_record_status;

	/**
	 * 预留字段
	 */
	private String log_filed1;

	private String log_filed2;

	private String log_filed3;

	public Log() {
	}

	public Log(String log_type, String log_type_val, String log_content, String log_creator, String log_ip) {
		this.log_type = log_type;
		this.log_type_val = log_type_val;
		this.log_content = log_content;
		this.log_creator = log_creator;
		this.log_ip = log_ip;

	}

	@Override
	public String getId() {
		return this.id;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getLog_content() {
		return log_content;
	}

	public void setLog_content(String log_content) {
		this.log_content = log_content;
	}

	public String getLog_creator() {
		return log_creator;
	}

	public void setLog_creator(String log_creator) {
		this.log_creator = log_creator;
	}

	public Date getLog_date() {
		return log_date;
	}

	public void setLog_date(Date log_date) {
		this.log_date = log_date;
	}

	public String getLog_ip() {
		return log_ip;
	}

	public void setLog_ip(String log_ip) {
		this.log_ip = log_ip;
	}

	public String getLog_filed1() {
		return log_filed1;
	}

	public void setLog_filed1(String log_filed1) {
		this.log_filed1 = log_filed1;
	}

	public String getLog_filed2() {
		return log_filed2;
	}

	public void setLog_filed2(String log_filed2) {
		this.log_filed2 = log_filed2;
	}

	public String getLog_filed3() {
		return log_filed3;
	}

	public void setLog_filed3(String log_filed3) {
		this.log_filed3 = log_filed3;
	}

	public String getLog_type() {
		return log_type;
	}

	public void setLog_type(String log_type) {
		this.log_type = log_type;
	}

	public int getLog_record_status() {
		return log_record_status;
	}

	public void setLog_record_status(int log_record_status) {
		this.log_record_status = log_record_status;
	}

	public String getLog_type_val() {
		return log_type_val;
	}

	public void setLog_type_val(String log_type_val) {
		this.log_type_val = log_type_val;
	}

}
