package com.haoyu.tpdpor.admin.auth.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haoyu.sip.auth.controller.AuthMenuController;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@Controller
@RequestMapping("**/admin/auth_menus")
public class AuthMenuBizController extends AuthMenuController {

	protected String getLogicalViewNamePrefix(){
		return TpdporViewNamePerfixUtil.getAdminPath("/auth/menu/");
	}
	
	
}
