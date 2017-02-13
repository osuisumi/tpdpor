package com.haoyu.tpdpor.creative.controller;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Lists;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tip.creative.entity.Creative;
import com.haoyu.tip.creative.entity.CreativeUser;
import com.haoyu.tip.creative.service.ICreativeService;
import com.haoyu.tip.creative.service.ICreativeUserService;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tip.resource.service.IResourceService;
import com.haoyu.tpdpor.creative.service.ICreativeTpdporService;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@Controller
@RequestMapping("**/creative")
public class CreativeController extends AbstractBaseController{

	@Resource
	private ICreativeService creativeService;
	@Resource
	private ICreativeUserService creativeUserService;
	@Resource
	private IResourceService resourceService;
	@Resource
	private ICreativeTpdporService creativeTpdporService;
	
	private String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getPath("/creative/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Creative creative, Model model){
		getPageBounds(10, true);
		model.addAttribute("creative", creative);
		model.addAllAttributes(request.getParameterMap());
		return getViewNamePerfix() + "list_creative";
	}
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	public String create(Creative creative, Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("creative", creative);
		return getViewNamePerfix() + "edit_creative";
	}
	
	@RequestMapping(value="{id}/edit", method=RequestMethod.GET)
	public String edit(Creative creative,Model model){	
		model.addAttribute("creative",creativeService.findCreativeById(creative.getId()));
		return getViewNamePerfix() + "edit_creative";
	}
	
	@RequestMapping(value="{id}/view", method=RequestMethod.GET)
	public String view(Creative creative, Model model){
		model.addAttribute("creative", creative);
		model.addAllAttributes(request.getParameterMap());
		return getViewNamePerfix() + "view_creative";
	}

	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response createCreative(Creative creative, Model model){
		return creativeService.createCreative(creative);
	}
	
	@RequestMapping(value="{id}", method=RequestMethod.PUT)
	@ResponseBody
	public Response update(Creative creative, Model model){
		return creativeService.updateCreative(creative);
	}
	
	@RequestMapping(value="{id}",method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(Creative creative){		
		return creativeService.deleteCreative(creative);
	}
	
	@RequestMapping(value="demo", method=RequestMethod.GET)
	public String demo(){
		return getViewNamePerfix() + "view_creative_demo";
	}
	
	@RequestMapping(value="index",method=RequestMethod.GET)
	public String index(Model model){
		model.addAllAttributes(request.getParameterMap());
		return "redirect:/creative";
	}
	
	@RequestMapping(value="claim", method=RequestMethod.GET)
	public String claim(Creative creative, Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("creative", creativeService.findCreativeById(creative.getId()));
		return getViewNamePerfix() + "claim_creative";
	}
	
	@RequestMapping(value="{creative.id}/claim", method=RequestMethod.POST)
	@ResponseBody
	public Response createClaim(CreativeUser creativeUser, Model model){
		return creativeUserService.createCreativeUser(creativeUser);
	}
	
	@RequestMapping(value="creativeAdvice", method=RequestMethod.GET)
	public String createAdvice(Creative creative,Model model){
		model.addAttribute("creative", creative);
		model.addAllAttributes(request.getParameterMap());
		return getViewNamePerfix() + "create_advice";
	}
	
	@RequestMapping(value="advice",method=RequestMethod.GET)
	public String listAdvice(Creative creative, Model model){
		getPageBounds(10, true);
		model.addAttribute("creative", creative);
		model.addAllAttributes(request.getParameterMap());
		return getViewNamePerfix() + "list_creative_advice";
	}
	
	@RequestMapping(value="resource", method=RequestMethod.GET)
	public String listResource(Creative creative,Model model){
		model.addAttribute("creative", creative);
		getPageBounds(12, true);
		model.addAllAttributes(request.getParameterMap());
		return getViewNamePerfix() + "list_creative_resource";
	}
	
	@RequestMapping(value="resource/create", method=RequestMethod.GET)
	public String createResource(Creative creative, Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("creative", creativeService.findCreativeById(creative.getId()));
		return getViewNamePerfix() + "edit_creative_resource";
	}
	
	@RequestMapping(value="{id}/resource/{resources[0].id}/edit", method=RequestMethod.GET)
	public String editResource(Creative creative,Model model){	
		Resources resource = resourceService.get(creative.getResources().get(0).getId());
		creative = creativeService.findCreativeById(creative.getId());
		creative.setResources(Lists.newArrayList(resource));
		model.addAttribute("creative",creative);
		return getViewNamePerfix() + "edit_creative_resource";
	}
	
	@RequestMapping(value="{id}/resource",method=RequestMethod.POST)
	@ResponseBody
	public Response createCreativeResource(Creative creative, Model model){
		return resourceService.createResource(creative.getResources().get(0));
	}
	
	@RequestMapping(value="{id}/resource/{resources[0].id}", method=RequestMethod.PUT)
	@ResponseBody
	public Response updateResource(Creative creative, Model model){
		return resourceService.updateResource(creative.getResources().get(0));
	}
	
	@RequestMapping(value="{id}/resource/{resources[0].id}",method=RequestMethod.DELETE)
	@ResponseBody
	public Response deleteResource(Creative creative){		
		return resourceService.deleteByIds(creative.getResources().get(0).getId());
	}
	
	@RequestMapping(value={"{id}/resource/{resources[0].id}/view","resource/{resources[0].id}/view"}, method=RequestMethod.GET)
	public String viewResource(Creative creative, Model model){
		model.addAttribute("creative", creative);
		return getViewNamePerfix() + "view_creative_resource";
	}
	
	@RequestMapping(value="{id}/resource/{resources[0].id}/goPay", method=RequestMethod.GET)
	public String goPay(Creative creative, Model model){
		model.addAttribute("creative", creative);
		model.addAllAttributes(request.getParameterMap());
		setParameterToModel(request,model);
		return getViewNamePerfix() + "pay_creative_resource";
	}
	
	@RequestMapping(value="{id}/resource/{resources[0].id}/pay",method=RequestMethod.GET)
	@ResponseBody
	public Response pay(Creative creative, Model model){		
		return creativeTpdporService.pay(creative);
	}
	
}
