package com.cberp.control.entity;

import java.util.Date;

import com.cberp.control.entity.base.BaseEntity;

/**
 * @描述：角色实体
 * @作者：李彬
 * @开发日期：2016-09-19
 * @版权：
 * @版本：1.0
 */
public class Role extends BaseEntity {

	/** 版本序列号 */
	private static final long serialVersionUID = 1L;

	/** 角色名称 */
	private String name;

	/** 角色描述 */
	private String description;

	/** 父角色 */
	private Long parent_id;

	/** 排列顺序 */
	private Long order_num;

	/** 创建者 */
	private String creator;

	/** 创建时间 */
	private Date created_date = new Date();

	public Role() {
	}

	public Role(String id) {
		this.id = id;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public Long getParent_id() {
		return parent_id;
	}

	public void setParent_id(Long parent_id) {
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
