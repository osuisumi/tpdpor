package com.haoyu.tpdpor.admin.auth.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haoyu.sip.auth.controller.AuthRoleController;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@Controller
@RequestMapping("**/auth_roles")
public class AuthRoleBizController extends AuthRoleController {
	
	
	protected String getLogicalViewNamePrefix(){
		return TpdporViewNamePerfixUtil.getAdminPath("/auth/role/");
	}
	
	
	
}
