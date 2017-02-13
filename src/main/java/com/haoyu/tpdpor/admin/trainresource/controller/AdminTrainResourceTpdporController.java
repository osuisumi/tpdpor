package com.haoyu.tpdpor.admin.trainresource.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;
import com.haoyu.tpdpor.trainresource.entity.TrainResource;
import com.haoyu.tpdpor.trainresource.service.ITrainResourceService;
import com.haoyu.tpdpor.trainresource.service.ITrainResourceUserService;

@RequestMapping("**/tpdpor/admin/train_resource")
@Controller
public class AdminTrainResourceTpdporController extends AbstractBaseController{

	@Resource
	private ITrainResourceService trainResourceService;
	@Resource
	private ITrainResourceUserService trainResourceUserService;
	
	protected String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getAdminPath("/trainResource/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(TrainResource trainResource,Model model){
		setParameterToModel(request, model);
		getPageBounds(10, true);
		model.addAttribute("trainResource", trainResource);
		return getViewNamePerfix() + "list_train_resource";
	}
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	public String create(TrainResource trainResource, Model model){
		setParameterToModel(request, model);
		model.addAttribute("trainResource", trainResource);
		return getViewNamePerfix() + "edit_train_resource";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response createTrainResource(TrainResource trainResource, Model model){
		return trainResourceService.createTrainResource(trainResource);
	}
	
	@RequestMapping(value="{id}/edit", method=RequestMethod.GET)
	public String edit(TrainResource trainResource,Model model){	
		model.addAttribute("trainResource",trainResourceService.findById(trainResource.getId(),true));
		return getViewNamePerfix() + "edit_train_resource";
	}
	
	@RequestMapping(value="{id}", method=RequestMethod.PUT)
	@ResponseBody
	public Response update(TrainResource trainResource, Model model){
		return trainResourceService.updateTrainResource(trainResource);
	}
	
	@RequestMapping(value="batch", method=RequestMethod.DELETE)
	@ResponseBody
	public Response batchDelete(TrainResource trainResource, Model model){
		return trainResourceService.batchDeleteTrainResource(trainResource);
	}
	
}
