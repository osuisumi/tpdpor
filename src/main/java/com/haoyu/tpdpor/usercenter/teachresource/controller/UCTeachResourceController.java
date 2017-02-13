package com.haoyu.tpdpor.usercenter.teachresource.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@Controller
@RequestMapping("**/userCenter/teach_resource")
public class UCTeachResourceController extends AbstractBaseController{
	
	protected String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getUserCenterPath("/teachResource/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Model model){
		setParameterToModel(request, model);
		return getViewNamePerfix() + "list_teach_resource";
	}
	

}
