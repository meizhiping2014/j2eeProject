package com.cberp.control.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import com.cberp.control.entity.Resource;

@Transactional
public interface ResourceMapper {

	/**
	 * @描述：
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @param userId
	 *            用户ID
	 * @param parentId
	 *            父资源ID -->值为"null"表示查询该系统下该用户所有的资源；值为""表示查询该系统下该用户所有的模块资源
	 * @param resourceType
	 *            资源类型
	 * @return
	 */
	public List<Resource> findResourceBy(String userId, String parentId, int resourceType);

	/**
	 * @描述：按条件查询资源条数
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @param userId
	 *            用户ID
	 * @param parentId
	 *            父资源ID -->值为"null"表示查询该系统下该用户所有的资源；值为""表示查询该系统下该用户所有的模块资源
	 * @param resourceType
	 *            资源类型
	 * @return
	 */
	public Long findResourceCountBy(String userId, String parentId, int resourceType);

	/**
	 * @描述：按用户ID查询用户所分配的资源菜单
	 * @作者：李彬
	 * @开发日期：2016-09-22
	 * @return
	 */
	public List<Resource> findResourceByUserId(String userId);

	/**
	 * @描述：按条件查询资源条数
	 * @作者：李彬
	 * @开发日期：2016-09-22
	 * @return
	 */
	public Long resourceCount();

	public Long countByParentId(String id);

	public List<Resource> findAll();

	/**
	 * @描述：查询顶级父资源节点
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @return
	 */
	public Resource findTopParent();

	/**
	 * @描述：查询某个父资源节点的子节点（一级）
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @param id
	 * @return
	 */
	public List<Resource> findByParentId(String id);

	/**
	 * @描述：查询某个父资源节点的子节点（所有子节点，包括本身）
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @param id
	 * @return
	 */
	public List<Resource> findSelfAndAllChild(String parent_id);

	/**
	 * @描述：查询某个父资源节点的子节点（所有子节点，不包括本身）
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @param id
	 * @return
	 */
	public List<Resource> findAllChild(String parent_id);

	/**
	 * @描述： 分页查询资源记录数
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @param params
	 * @return
	 */
	public Long listCountByPage(Map<String, Object> params);

	/**
	 * 
	 * @描述： 资源分页查询
	 * @作者：李彬
	 * @开发日期：2016-09-19
	 * @return
	 */
	public List<Map<String, Object>> listByPage(Map<String, Object> params);

	/**
	 * /**
	 * 
	 * @描述：新增资源
	 * @作者：李彬
	 * @开发日期：2016-09-22
	 * @param resource
	 * @throws Exception
	 */
	public void add(Resource resource) throws Exception;

	public void edit(Resource resource) throws Exception;

	public void deleteById(String id) throws Exception;
	
	public Resource findById(String id);

}
