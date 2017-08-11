package com.cberp.control.entity;

import java.util.Date;

import com.cberp.control.entity.base.BaseEntity;

/**
 * @描述：用户实体
 * @作者：李彬
 * @开发日期：2016-09-19
 * @版权：
 * @版本：1.0
 */
public class User extends BaseEntity {

	/** 版本序列号 */
	private static final long serialVersionUID = 1L;

	/** 账户名称 */
	private String account;

	/** 账户密码 */
	private String password;

	/** 用户名称 */
	private String name;

	/** 用户职务 */
	private String position;

	/** 用户性别 */
	private int sex;

	/** 用户年龄 */
	private Long age;

	/** 用户邮件 */
	private String email;

	/** 办公电话 */
	private String office_phone;

	/** 移动电话 */
	private String mobil_phone;

	/** 是否启用 * */
	private Boolean visible = true;

	/** 创建者 */
	private String creator;

	/** 创建时间 */
	private Date created_date = new Date();

	/** 所属部门 */
	private String organization_id;

	public User() {
	}

	public User(String id) {
		this.id = id;
	}

	public User(String account, String password) {
		this.account = account;
		this.password = password;
	}

	@Override
	public String getId() {
		return this.id;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public int getSex() {
		return sex;
	}

	public void setSex(int sex) {
		this.sex = sex;
	}

	public Long getAge() {
		return age;
	}

	public void setAge(Long age) {
		this.age = age;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Boolean getVisible() {
		return visible;
	}

	public void setVisible(Boolean visible) {
		this.visible = visible;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getOrganization_id() {
		return organization_id;
	}

	public void setOrganization_id(String organization_id) {
		this.organization_id = organization_id;
	}

	public String getOffice_phone() {
		return office_phone;
	}

	public void setOffice_phone(String office_phone) {
		this.office_phone = office_phone;
	}

	public String getMobil_phone() {
		return mobil_phone;
	}

	public void setMobil_phone(String mobil_phone) {
		this.mobil_phone = mobil_phone;
	}

	public Date getCreated_date() {
		return created_date;
	}

	public void setCreated_date(Date created_date) {
		this.created_date = created_date;
	}

}
