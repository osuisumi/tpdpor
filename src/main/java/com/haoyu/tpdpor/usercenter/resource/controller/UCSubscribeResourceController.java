package com.haoyu.tpdpor.usercenter.resource.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@Controller
@RequestMapping("**/userCenter/subscribe_resource")
public class UCSubscribeResourceController extends AbstractBaseController{
	
	protected String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getUserCenterPath("/subscribe/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Model model){
		setParameterToModel(request, model);
		return getViewNamePerfix() + "list_subscribe_resource";
	}
	

}
