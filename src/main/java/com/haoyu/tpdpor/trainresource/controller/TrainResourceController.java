package com.haoyu.tpdpor.trainresource.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;
import com.haoyu.tpdpor.trainresource.entity.TrainResource;

@Controller
@RequestMapping("**/train_resource")
public class TrainResourceController extends AbstractBaseController {
	
	private String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getPath("/trainResource/");
	}
	
	@RequestMapping(value="index",method=RequestMethod.GET)
	public String index(Model model){
		return getViewNamePerfix() + "train_resource_index";
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(TrainResource trainResource, Model model){
		setParameterToModel(request, model);
		model.addAttribute("trainResource",trainResource);
		getPageBounds(10, true);
		return getViewNamePerfix() + "list_train_resource";
	}
	
	@RequestMapping(value="{id}/view", method=RequestMethod.GET)
	public String view(TrainResource trainResource, Model model){
		setParameterToModel(request, model);
		model.addAttribute("trainResource",trainResource);
		return getViewNamePerfix() + "view_train_resource";
	}
	
	@RequestMapping(value="{id}/viewFile", method=RequestMethod.GET)
	public String viewResourceFile(TrainResource trainResource, Model model){
		setParameterToModel(request, model);
		model.addAttribute("trainResource",trainResource);
		return getViewNamePerfix() + "view_train_resource_file";
	}
	
	@RequestMapping(value="applyStudy",method=RequestMethod.GET)
	public String applyStudy(TrainResource trainResource, Model model){
		setParameterToModel(request, model);
		model.addAttribute("trainResource",trainResource);
		return getViewNamePerfix() + "realNameAuthentication";
	}
	
	@RequestMapping(value="recommendResource",method=RequestMethod.GET)
	public String listRecommendResourc(TrainResource trainResource, Model model){
		setParameterToModel(request, model);
		model.addAttribute("trainResource",trainResource);
		getPageBounds(3, true);
		return getViewNamePerfix() + "list_resource_recommend";
	}
	
	@RequestMapping(value="queryParam",method=RequestMethod.GET)
	public String listQueryParam(Model model){
		setParameterToModel(request, model);
		return getViewNamePerfix() + "list_query_param";
	}
}
