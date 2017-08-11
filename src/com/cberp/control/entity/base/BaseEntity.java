package com.cberp.control.entity.base;

import java.io.Serializable;

/**
 * @描述：统一定义id的entity基类. 基类统一定义id的属性名称、数据类型、列名映射及生成策略.
 *                      子类可重载getId()函数重定义id的列名映射和生成策略.
 * @作者：李彬
 * @开发日期：2016-09-19
 * @版权：
 * @版本：1.0
 */
public abstract class BaseEntity implements Serializable {
	private static final long serialVersionUID = 5717799104713253868L;

	protected String id;

	/** 如需改变主键的生成策略，可在子类中重写该方法 */
	public abstract String getId();

	public void setId(String id) {
		this.id = id;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (getClass() != obj.getClass()) {
			return false;
		}
		BaseEntity other = (BaseEntity) obj;
		if (id == null) {
			if (other.id != null) {
				return false;
			}
		} else if (!id.equals(other.id)) {
			return false;
		}
		return true;
	}

}
