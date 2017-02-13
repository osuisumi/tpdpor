package com.haoyu.tpdpor.usercenter.point.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@Controller
@RequestMapping("**/userCenter/pointRecord")
public class UCPointRecordTpdporController extends AbstractBaseController{

	private String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getUserCenterPath("/point/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Model model){
		setParameterToModel(request, model);
		getPageBounds(10, true);
		return getViewNamePerfix() + "list_point_record";
	}
}
