package com.cberp.control.mapper;

import java.util.List;
import java.util.Map;

import com.cberp.control.entity.User;

public interface UserMapper {


	/**
	 * 
	 * @描述：根据账户名和密码获取用户
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @param account
	 *            账户名
	 * @param password
	 *            密码
	 * @return
	 */
	public User checkUser(String account, String password);

	/**
	 * @描述：根据账户名获取用户
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @param account
	 *            账户名
	 * @return
	 */
	public User findUserByAccount(String account);

	/**
	 * @描述：根据用户名获取用户
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @param name
	 *            登录用户
	 * @return
	 * @throws Exception
	 */
	public User findByName(String name);

	/**
	 * @描述：根据用户ID获取用户
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @param name
	 *            登录用户
	 * @return
	 * @throws Exception
	 */
	public User findById(String id);

	/**
	 * @描述： 查询用户记录数
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @param params
	 * @return
	 */
	public Long listCountByPage(Map<String, Object> params);

	/**
	 * 
	 * @描述： 用户分页查询
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @return
	 */
	public List<Map<String, Object>> listByPage(Map<String, Object> params);

	public List<User> findByOrgId(String orgId);

	/**
	 * @描述： 新增用户
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @param user
	 */
	public void addUser(User user) throws Exception;

	/**
	 * @描述： 通过id删除用户
	 * @作者：李彬
	 * @开发日期：2016-09-22
	 * @param orgid
	 */
	public void delById(String id) throws Exception;

	public void editUser(User user) throws Exception;

	public void disableUser(String id) throws Exception;

	public void enableUser(String id) throws Exception;
}
