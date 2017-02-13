package com.haoyu.tpdpor.admin.auth.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haoyu.sip.auth.controller.AuthUserController;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@Controller
@RequestMapping("**/admin/auth_users")
public class AuthUserBizController extends AuthUserController{
	
	protected String getLogicalViewNamePrefix(){
		
		return TpdporViewNamePerfixUtil.getAdminPath("/auth/user");
	}

}
