package com.haoyu.tpdpor.resource.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tpdpor.resource.entity.ResourceApplyRecord;
import com.haoyu.tpdpor.resource.service.IResourceApplyRecordService;

@Controller
@RequestMapping("**/resource_apply_record")
public class ResourceApplyRecordController extends AbstractBaseController{
	@Resource
	private IResourceApplyRecordService resourceApplyRecordService;
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response save(ResourceApplyRecord resourceReadRecord){
		return resourceApplyRecordService.createResourceApplyRecord(resourceReadRecord);
	}
	
	@RequestMapping(value="entity",method=RequestMethod.GET)
	@ResponseBody
	public ResourceApplyRecord entity(String userId,String resourceId){
		return resourceApplyRecordService.findResourceApplyRecordById(ResourceApplyRecord.getId(userId, resourceId));
	}
	
}
