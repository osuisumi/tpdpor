package com.haoyu.tpdpor.admin.auth.dao;

import java.util.List;

import com.haoyu.sip.auth.entity.AuthRole;

public interface IAdminUserRoleTpdporDao {
	
	int insertRoleUser(AuthRole authRole,List<String> userIds,String relationId);
}
