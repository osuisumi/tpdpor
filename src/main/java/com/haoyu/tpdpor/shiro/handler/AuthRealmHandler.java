package com.haoyu.tpdpor.shiro.handler;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.subject.PrincipalCollection;

import com.haoyu.sip.auth.entity.AuthRole;
import com.haoyu.sip.auth.entity.AuthUser;
import com.haoyu.sip.auth.realm.IAuthRealmHandler;
import com.haoyu.sip.auth.service.IAuthRoleService;
import com.haoyu.sip.utils.Collections3;

public class AuthRealmHandler implements IAuthRealmHandler{

	@Resource
	private IAuthRoleService authRoleService;
	
	@Override
	public void addAuthorize(SimpleAuthorizationInfo info, PrincipalCollection principals) {
		List<Object> listPrincipals = principals.asList();
		Map<String, String> attributes = (Map<String, String>) listPrincipals.get(1);
		String userId = attributes.get("id");
		
		AuthUser authUser = new AuthUser(userId);
		List<AuthRole> authRoles = authRoleService.findRoleByAuthUser(authUser);
		
		if (Collections3.isNotEmpty(authRoles)) {
			for (AuthRole ar : authRoles) {
				info.addRole(ar.getCode());
			}
		}
	}

}
