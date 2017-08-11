package com.cberp.control.entity;

import java.util.Date;

import com.cberp.control.entity.base.BaseEntity;

/**
 * @描述：资源实体
 * @作者：李彬
 * @开发日期：2016-09-19
 * @版权：
 * @版本：1.0
 */
public class Resource extends BaseEntity {

	/** 版本序列号 */
	private static final long serialVersionUID = 1L;

	/** 资源名称 */
	private String name;

	/** 资源路径 */
	private String path;

	/** 资源描述 */
	private String description;

	/** 资源类型 */
	private int resource_type;

	/** 排列顺序 */
	private Long order_num;

	/** 创建者 */
	private String creator;

	/** 创建时间 */
	private Date created_date = new Date();

	/** 所属的父资源 */
	private String parent_id;

	public Resource() {
	}

	public Resource(String id) {
		this.id = id;
	}

	/**
	 * 
	 * @param name
	 *            资源名称
	 * @param path
	 *            资源路径
	 * @param resourceType
	 *            资源类型
	 * @param orderNum
	 *            排列顺序
	 * @param parentResource
	 *            所属的父资源
	 */
	public Resource(String name, String path, Long orderNum, int resourceType, String parentResource) {
		this.name = name;
		this.path = path;
		this.resource_type = resourceType;
		this.order_num = orderNum;
		this.parent_id = parentResource;
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

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public int getResource_type() {
		return resource_type;
	}

	public void setResource_type(int resource_type) {
		this.resource_type = resource_type;
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

	public String getParent_id() {
		return parent_id;
	}

	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}

}
