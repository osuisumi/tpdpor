package com.haoyu.tpdpor.admin.resource.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;
import com.haoyu.tpdpor.resource.entity.ResourceApplyRecord;
import com.haoyu.tpdpor.resource.service.IResourceApplyRecordService;

@Controller
@RequestMapping("**/admin/resource_apply_record")
public class AdminResourceApplyRecordController extends AbstractBaseController{
	@Resource
	private IResourceApplyRecordService resourceApplyRecordService;
	
	protected String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getAdminPath("/resource/applyrecord/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Model model){
		setParameterToModel(request, model);
		return getViewNamePerfix() + "list_resource_apply_record";
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	@ResponseBody
	public Response update(ResourceApplyRecord resourceReadRecord){
		return resourceApplyRecordService.updateResourceApplyRecord(resourceReadRecord);
	}

}
