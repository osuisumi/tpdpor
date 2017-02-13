package com.haoyu.tpdpor.admin.auth.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haoyu.sip.auth.controller.AuthResourceController;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@Controller
@RequestMapping("**/admin/auth_resources")
public class AuthResourceBizController extends AuthResourceController {
	protected String getLogicalViewNamePrefix() {
		return TpdporViewNamePerfixUtil.getAdminPath("/auth/resource/");
	}

}
