package com.cberp.control.entity;

import com.cberp.control.entity.base.BaseEntity;

/**
 * @描述：用户资源关联实体
 * @作者：李彬
 * @开发日期：2016-09-19
 * @版权：
 * @版本：1.0
 */
public class UserResourceRelation extends BaseEntity {

	/** 版本序列号 */
	private static final long serialVersionUID = 1L;

	/** 授权类型,默认为正常'AuthorizeType.NORMAL' */
	private int authorize_type;

	/** 所属的用户 */
	private String user_id;

	/** 所属的资源 */
	private String resource_id;

	/** 所属的临时用户资源 */
	private String user_resource_temp_id;

	public UserResourceRelation() {
	}

	public UserResourceRelation(String user, String resource) {
		this.user_id = user;
		this.resource_id = resource;
	}

	@Override
	public String getId() {
		return this.id;
	}

	public int getAuthorize_type() {
		return authorize_type;
	}

	public void setAuthorize_type(int authorize_type) {
		this.authorize_type = authorize_type;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getResource_id() {
		return resource_id;
	}

	public void setResource_id(String resource_id) {
		this.resource_id = resource_id;
	}

	public String getUser_resource_temp_id() {
		return user_resource_temp_id;
	}

	public void setUser_resource_temp_id(String user_resource_temp_id) {
		this.user_resource_temp_id = user_resource_temp_id;
	}

}
