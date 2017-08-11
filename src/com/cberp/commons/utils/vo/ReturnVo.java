package com.cberp.commons.utils.vo;

public class ReturnVo {
	
	private String error;
	
	private String msg;
	
	private Object data;

	public ReturnVo() {
		
	}
	
	public ReturnVo(String error) {
		this.error = error;
	}
	
	public ReturnVo(String error, String msg) {
		this.error = error;
		this.msg = msg;
	}
	
	public ReturnVo(String error, String msg, Object data) {
		this.error = error;
		this.msg = msg;
		this.data = data;
	}
	
	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}
}
