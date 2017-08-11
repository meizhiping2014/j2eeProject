package com.cberp.control.mapper;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.cberp.control.entity.RoleResourceRelation;

@Transactional
public interface RoleResourceRelationMapper {

	public void save(RoleResourceRelation roleResourceRelation);
	
	public List<RoleResourceRelation> findByRoleId(String roleid);
	
	public void deleteByRoleId(String roleId)throws Exception;
	
	public void deleteByResourceId(String resourceId) throws Exception;
}
