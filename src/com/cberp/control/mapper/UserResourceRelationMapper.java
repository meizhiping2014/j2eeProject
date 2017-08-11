package com.cberp.control.mapper;

import java.util.List;

import com.cberp.control.entity.UserResourceRelation;

public interface UserResourceRelationMapper {

	public List<UserResourceRelation> findById(String userid);

	public void save(UserResourceRelation userResourceRelation) throws Exception;

	public void deleteByUserId(String userid) throws Exception;

	public void deleteByResourceId(String resourceId) throws Exception;
}
