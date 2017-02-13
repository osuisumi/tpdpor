package com.haoyu.tpdpor.admin.auth.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.auth.entity.AuthRole;
import com.haoyu.sip.core.service.Response;

public interface IAdminRoleTpdporService {

	List<AuthRole> findAuthRoles(Map<String,Object> parameter,PageBounds pageBounds);
	
	Response addUsersToRole(AuthRole role,List<String> userIds,String relationId);

}
