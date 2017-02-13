package com.haoyu.tpdpor.admin.auth.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.auth.entity.AuthRole;
import com.haoyu.sip.core.service.Response;
import com.haoyu.tpdpor.admin.auth.dao.IAdminRoleTpdporDao;
import com.haoyu.tpdpor.admin.auth.dao.IAdminUserRoleTpdporDao;
import com.haoyu.tpdpor.admin.auth.service.IAdminRoleTpdporService;

@Service
public class AdminRoleTpdporServiceImpl implements IAdminRoleTpdporService{

	@Resource
	private IAdminRoleTpdporDao adminRoleTpdporDao;
	@Resource
	private IAdminUserRoleTpdporDao adminUserRoleTpdporDao;
	
	@Override
	public List<AuthRole> findAuthRoles(Map<String, Object> parameter, PageBounds pageBounds) {
		return adminRoleTpdporDao.findAll(parameter, pageBounds);
	}

	@Override
	public Response addUsersToRole(AuthRole role, List<String> userIds, String relationId) {
		if (role == null || StringUtils.isEmpty(role.getId()) || userIds == null || userIds.isEmpty())
			return Response.failInstance().responseMsg("addUsersToRole fail!role or role's id or userIds is null");
		int count = adminUserRoleTpdporDao.insertRoleUser(role, userIds, relationId);
		return count > 0 ? Response.successInstance().responseData(userIds) : Response.failInstance();
	}

}
