package com.cberp.control.mapper;

import java.util.List;
import java.util.Map;

import com.cberp.control.entity.Role;

public interface RoleMapper {

	public Role findById(String roleid);

	public Role findByName(String name);

	public void add(Role role) throws Exception;

	public void edit(Role role) throws Exception;

	public void deleteById(String id) throws Exception;

	/**
	 * @描述： 查询角色记录数
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @param params
	 * @return
	 */
	public Long listCountByPage(Map<String, Object> params);

	/**
	 * 
	 * @描述：角色分页查询
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @return
	 */
	public List<Map<String, Object>> listByPage(Map<String, Object> params);

	/**
	 * 
	 * @描述：查询所有角色
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @return
	 */
	public List<Role> allRole();

	public List<Role> findRoleByUserId(String userId);
}
