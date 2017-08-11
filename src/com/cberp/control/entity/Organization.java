package com.cberp.control.entity;

import java.util.Date;

import com.cberp.control.entity.base.BaseEntity;

/**
 * @描述：组织机构实体
 * @作者：李彬
 * @开发日期：2016-09-19
 * @版权：
 * @版本：1.0
 */
public class Organization extends BaseEntity {

	/** 版本序列号 */
	private static final long serialVersionUID = 1L;

	/** 机构名称 */
	private String name;

	/** 机构代码 */
	private String code;

	/** 父机构ID */
	private String parent_id;

	/** 机构排列顺序 */
	private Long order_num;

	/** 机构地址 */
	private String address;

	/** 创建者 */
	private String creator;

	/** 创建时间 */
	private Date created_date = new Date();

	public Organization() {
	}

	public Organization(String id) {
		this.id = id;
	}

	public Organization(String name, Long orderNum, String parent_id) {
		this.order_num = orderNum;
		this.name = name;
		this.parent_id = parent_id;
	}

	public String getId() {
		return this.id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getParent_id() {
		return parent_id;
	}

	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}

	public Long getOrder_num() {
		return order_num;
	}

	public void setOrder_num(Long order_num) {
		this.order_num = order_num;
	}

	public Date getCreated_date() {
		return created_date;
	}

	public void setCreated_date(Date created_date) {
		this.created_date = created_date;
	}

}
