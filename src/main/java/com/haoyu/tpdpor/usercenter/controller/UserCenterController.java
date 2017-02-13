package com.haoyu.tpdpor.usercenter.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@Controller
@RequestMapping("**/userCenter")
public class UserCenterController extends AbstractBaseController{

	private String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getUserCenterPath("");
	}
	
	@RequestMapping
	private String index(Model model){
		model.addAllAttributes(request.getParameterMap());
		return getViewNamePerfix() + "index";
	}
}
