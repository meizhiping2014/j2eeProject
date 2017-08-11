package com.cberp.control.entity;

import java.util.Date;

import com.cberp.control.entity.base.BaseEntity;

/**
 * @描述：临时角色用户实体
 * @作者：李彬
 * @开发日期：2016-09-19
 * @版权：
 * @版本：1.0
 */
public class RoleUserTemp extends BaseEntity {

	/** 版本序列号 */
	private static final long serialVersionUID = 1L;

	/** 生效时间 */
	private Date effective_date;

	/** 失效时间 */
	private Date invalidation_date;

	/** 状态 */
	private int state;

	public RoleUserTemp() {
	}

	public RoleUserTemp(Date effectiveDate, Date invalidationDate) {
		this.effective_date = effectiveDate;
		this.invalidation_date = invalidationDate;
	}

	@Override
	public String getId() {
		return this.id;
	}

	public Date getEffective_date() {
		return effective_date;
	}

	public void setEffective_date(Date effective_date) {
		this.effective_date = effective_date;
	}

	public Date getInvalidation_date() {
		return invalidation_date;
	}

	public void setInvalidation_date(Date invalidation_date) {
		this.invalidation_date = invalidation_date;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

}
