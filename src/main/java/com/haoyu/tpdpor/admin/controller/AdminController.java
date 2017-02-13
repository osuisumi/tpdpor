package com.haoyu.tpdpor.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@Controller
@RequestMapping("admin")
public class AdminController extends AbstractBaseController{
	
	private String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getAdminPath("");
	}
	
	@RequestMapping
	private String index(Model model){
		model.addAllAttributes(request.getParameterMap());
		return getViewNamePerfix() + "index";
	}
	
	

}
