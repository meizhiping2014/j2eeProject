package com.cberp.control.mapper;

import java.util.List;
import java.util.Map;

import com.cberp.control.entity.Organization;

public interface OrganizationMapper {

	/**
	 * @描述：查询所有机构
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @return
	 */
	public List<Organization> findAll();

	/**
	 * *
	 * 
	 * @描述：添加机构
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @param organization
	 * @throws Exception
	 */
	public void addOrg(Organization organization) throws Exception;

	/**
	 * @描述：添加机构
	 * @作者：李彬
	 * @开发日期：2016-09-22
	 * @throws Exception
	 */
	public void editOrg(Organization organization) throws Exception;

	/**
	 * @描述：通过主键ID删除机构
	 * @作者：李彬
	 * @开发日期：2016-09-22
	 * @param id
	 * @throws Exception
	 */
	public void delOrgById(String id) throws Exception;

	/**
	 * @描述：通过父ID删除机构
	 * @作者：李彬
	 * @开发日期：2016-09-22
	 * @param id
	 * @throws Exception
	 */
	public void delOrgByParentId(String id) throws Exception;

	/**
	 * @描述：查询机构count数
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @return
	 */
	public Long countAll();

	public Long countByParentId(String id);

	/**
	 * @描述： 分页查询用户记录数
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

	/**
	 * @描述：查询所有父机构
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @return
	 */
	public List<Organization> findAllParentOrg();

	/**
	 * @描述：查询某个机构下的一级子机构
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @return
	 */
	public List<Organization> findByParentId(String id);

	/**
	 * @描述：根据id查询机构
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @return
	 */
	public Organization findById(String id);

	/**
	 * @描述：查询某个父机构的子节点（所有子节点，包括本身）
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @param id
	 * @return
	 */
	public List<Organization> findSelfAndChild(String parent_id);

	/**
	 * @描述：查询某个父机构的子节点（所有子节点，不包括本身）
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @param id
	 * @return
	 */
	public List<Organization> findAllChild(String parent_id);

	/**
	 * @描述：查询sequence
	 * @作者：李彬
	 * @开发日期：2016-10-11
	 * @return
	 */
	public Long findSeqNumber();
}
