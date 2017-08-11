package com.cberp.control.entity;

import com.cberp.control.entity.base.BaseEntity;

/**
 * @描述：角色资源关联实体
 * @作者：李彬
 * @开发日期：2016-09-19
 * @版权：
 * @版本：1.0
 */
public class RoleResourceRelation extends BaseEntity {

	/** 版本序列号 */
	private static final long serialVersionUID = 1L;

	/** 授权类型,默认为正常'0' */
	private int authorize_type;

	/** 所属的资源 */
	private String resource_id;

	/** 所属的角色 */
	private String role_id;

	/** 所属的临时角色资源 */
	private String role_resource_temp_id;

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

	public String getResource_id() {
		return resource_id;
	}

	public void setResource_id(String resource_id) {
		this.resource_id = resource_id;
	}

	public String getRole_id() {
		return role_id;
	}

	public void setRole_id(String role_id) {
		this.role_id = role_id;
	}

	public String getRole_resource_temp_id() {
		return role_resource_temp_id;
	}

	public void setRole_resource_temp_id(String role_resource_temp_id) {
		this.role_resource_temp_id = role_resource_temp_id;
	}

}
