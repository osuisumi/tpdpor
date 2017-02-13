package com.haoyu.expert.service.impl;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.expert.dao.IExpertDao;
import com.haoyu.expert.entity.Expert;
import com.haoyu.expert.service.IExpertService;
import com.haoyu.sip.auth.entity.AuthRole;
import com.haoyu.sip.auth.service.IAuthRoleService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.user.service.IAccountService;
import com.haoyu.sip.user.service.IUserDepartmentService;
import com.haoyu.sip.user.service.IUserInfoService;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.sip.utils.Identities;
import com.haoyu.tpdpor.admin.auth.service.IAdminRoleTpdporService;
import com.haoyu.tpdpor.utils.RoleCode;

@Service
public class ExpertService implements IExpertService{
	
	@Resource
	private IExpertDao expertDao;
	@Resource
	private IAdminRoleTpdporService adminRoleTpdporService;
	@Resource
	private IAuthRoleService authRoleService;
	@Resource
	private IUserInfoService userInfoService;
	@Resource
	private IUserDepartmentService userDepartmentService;
	@Resource
	private IAccountService accountService;
	
	@Override
	public Response createExpert(Expert expert) {		
		if (expert.getUser() == null || expert.getAccount() == null) {
			return Response.failInstance();
		}
		
		Response response = Response.failInstance();

		expert.getAccount().setUser(expert.getUser());
		response = accountService.createAccount(expert.getAccount());
		
		if ("01".equals(response.getResponseCode())) {
			return Response.failInstance();
		}
		
		if(StringUtils.isEmpty(expert.getId())){
			expert.setId(Identities.uuid2());
		}
		expert.setDefaultValue();
		
		int count = expertDao.insertExpert(expert);
		if (count > 0) {
			Map<String, Object> param = Maps.newHashMap();
			param.put("code",RoleCode.EXPERT);
			List<AuthRole> authRoles = adminRoleTpdporService.findAuthRoles(param, null);
			if (Collections3.isNotEmpty(authRoles)) {
				authRoleService.addUsersToRole(authRoles.get(0), Lists.newArrayList(expert.getUser().getId()), "tpdpor");				
			}
			return Response.successInstance();
		}
		return Response.failInstance();
	}

	@Override
	public Response updateExpert(Expert expert) {
		expert.setUpdateValue();
		int count = expertDao.updateExpert(expert);
		if (expert.getAccount() != null) {
			if (expert.getUser() != null ) {
				expert.getAccount().setUser(expert.getUser());
			}
			if (count > 0) {				
				accountService.updateAccount(expert.getAccount());
			}
		}
		return count>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public Response deleteExpert(Expert expert) {
		if (expert == null || StringUtils.isEmpty(expert.getId())) {
			return Response.failInstance();
		}
		if (expert != null && StringUtils.isNotEmpty(expert.getId())) {
			expert = this.findExpertById(expert.getId());
		}
		
		expert.setUpdateValue();
		int count = expertDao.deleteExpertByLogic(expert);
		if (count > 0) {
			Map<String, Object> param = Maps.newHashMap();
			param.put("code",RoleCode.EXPERT);
			List<AuthRole> authRoles = adminRoleTpdporService.findAuthRoles(param, null);
			if (Collections3.isNotEmpty(authRoles)) {
				Response response = authRoleService.removeUsersFromRole(authRoles.get(0), Lists.newArrayList(expert.getUser().getId()), "tpdpor");		
				return response;
			}
		}
		return Response.failInstance();
	}

	@Override
	public Expert findExpertById(String id) {
		return expertDao.selectExpertById(id);
	}

	@Override
	public List<Expert> findExperts(Expert expert, PageBounds pageBounds) {
		Map<String,Object> param = Maps.newHashMap();
		if (expert.getUser() != null && StringUtils.isNotEmpty(expert.getUser().getId())) {
			param.put("userId",expert.getUser().getId());
		}
		return expertDao.findAll(param, pageBounds);
	}

	@Override
	public List<Expert> findExperts(Map<String, Object> parameter, PageBounds pageBounds) {
		return expertDao.findAll(parameter, pageBounds);
	}

}
