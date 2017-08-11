package com.cberp.control.mapper;

import com.cberp.control.entity.RoleUserRelation;

public interface RoleUserRelationMapper {

	public void save(RoleUserRelation roleUserRelation) throws Exception;

	public void deleteById(String userId) throws Exception;
}
