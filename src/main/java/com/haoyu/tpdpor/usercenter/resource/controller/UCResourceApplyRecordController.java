package com.haoyu.tpdpor.usercenter.resource.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;
import com.haoyu.tpdpor.resource.service.IResourceApplyRecordService;

@Controller
@RequestMapping("**/userCenter/resource_apply_record")
public class UCResourceApplyRecordController extends AbstractBaseController{
	@Resource
	private IResourceApplyRecordService resourceApplyRecordService;
	
	protected String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getUserCenterPath("/resource/applyrecord/");
	}
	
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Model model){
		setParameterToModel(request, model);
		return getViewNamePerfix() + "list_resource_apply_record";
	}
	
	@RequestMapping(value="edit_evaluate",method=RequestMethod.GET)
	public String editReadRecord(Model model){
		setParameterToModel(request, model);
		return getViewNamePerfix() + "edit_evaluate";
	}
	
}
