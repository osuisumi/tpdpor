package com.haoyu.tpdpor.admin.auth.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haoyu.sip.auth.controller.AuthPermissionController;
import com.haoyu.sip.auth.service.IAuthPermissionService;
import com.haoyu.sip.auth.service.IAuthResourceService;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@Controller
@RequestMapping("**/admin/auth_permissions")
public class AuthPermissionBizController extends AuthPermissionController {

	@Resource
	private IAuthResourceService authResourceService;
	@Resource
	private IAuthPermissionService permissionService;

	protected String getLogicalViewNamePrefix() {
		return TpdporViewNamePerfixUtil.getAdminPath("/auth/permission/");
	}

	
}
