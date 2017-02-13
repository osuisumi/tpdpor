package com.haoyu.tpdpor.admin.creative.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tip.creative.entity.Creative;
import com.haoyu.tip.creative.service.ICreativeService;
import com.haoyu.tpdpor.admin.creative.service.IAdminCreativeTpdporService;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@RequestMapping("**/tpdpor/admin/creative")
@Controller
public class AdminCreativeTpdporController extends AbstractBaseController{

	@Resource
	private ICreativeService creativeService;
	@Resource
	private IAdminCreativeTpdporService adminCreativeTpdporService;
	
	protected String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getAdminPath("/creative/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Creative creative,Model model){
		setParameterToModel(request, model);
		model.addAttribute("creative",creative);
		getPageBounds(10, true);
		return getViewNamePerfix() + "list_creative";
	}
	
	@RequestMapping(value="batch", method=RequestMethod.PUT)
	@ResponseBody
	public Response batchUpdate(Creative creative, Model model){
		return creativeService.batchUpdateCreative(creative);
	}
	
	@RequestMapping(value="batch", method=RequestMethod.DELETE)
	@ResponseBody
	public Response batchDelete(Creative creative, Model model){
		return creativeService.batchDeleteCreative(creative);
	}
	
	@RequestMapping(value="typeManage",method=RequestMethod.GET)
	public String typeManage(Model model){
		setParameterToModel(request, model);
		return getViewNamePerfix() + "list_creative_type";
	}
	
	@RequestMapping(value="typeManage/edit",method=RequestMethod.GET)
	public String edit(Model model){
		setParameterToModel(request, model);
		return getViewNamePerfix() + "edit_creative_type";
	}
	
	@RequestMapping(value="typeManage", method=RequestMethod.PUT)
	@ResponseBody
	public Response updateCreativeType(String type,String name, Model model){
		return adminCreativeTpdporService.updateCreativeType(type,name);
	}
	
	@RequestMapping(value="batch/excellentState", method=RequestMethod.PUT)
	@ResponseBody
	public Response batchUpdateExcellentState(Creative creative, Model model){
		return adminCreativeTpdporService.batchExcellentState(creative);
	}
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	public String create(Creative creative, Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("creative", creative);
		return getViewNamePerfix() + "edit_creative";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response createCreative(Creative creative, Model model){
		return creativeService.createCreative(creative);
	}
	
	@RequestMapping(value="agreement",method=RequestMethod.GET)
	public String listCreativeAgreement(Creative creative,Model model){
		setParameterToModel(request, model);
		model.addAttribute("creative",creative);
		getPageBounds(10, true);
		return getViewNamePerfix() + "list_creative_agreement";
	}
	
	@RequestMapping(value="agreement", method=RequestMethod.PUT)
	@ResponseBody
	public Response update(Creative creative, Model model){
		return creativeService.updateCreativeAgreement(creative);
	}
}
