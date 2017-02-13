package com.haoyu.tpdpor.usercenter.courseresource.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@RequestMapping("**/userCenter/course_resource")
@Controller
public class UCCourseResourceTpdporController extends AbstractBaseController{
	
	private String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getUserCenterPath("/courseResource/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list( Model model){
		setParameterToModel(request, model);
		getPageBounds(10, true);
		return getViewNamePerfix() + "list_course_resource";
	}
}
