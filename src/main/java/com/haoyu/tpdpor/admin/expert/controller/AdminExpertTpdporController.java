package com.haoyu.tpdpor.admin.expert.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.expert.entity.Expert;
import com.haoyu.expert.service.IExpertService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@RequestMapping("**/tpdpor/admin/expert")
@Controller
public class AdminExpertTpdporController extends AbstractBaseController{

	@Resource
	private IExpertService expertService; 
	
	protected String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getAdminPath("/expert/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Expert expert,Model model){
		setParameterToModel(request, model);
		model.addAttribute("expert",expert);
		getPageBounds(10, true);
		return getViewNamePerfix() + "list_expert";
	}
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	public String create(Expert expert, Model model){
		setParameterToModel(request, model);
		model.addAttribute("expert", expert);
		return getViewNamePerfix() + "edit_expert";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response createCreative(Expert expert, Model model){
		return expertService.createExpert(expert);
	}
	
	@RequestMapping(value="{id}/edit",method=RequestMethod.GET)
	public String edit(Expert expert,Model model){
		model.addAttribute("expert",expertService.findExpertById(expert.getId()));
		setParameterToModel(request, model);
		return getViewNamePerfix() + "edit_expert";
	}
	
	@RequestMapping(value="{id}",method=RequestMethod.PUT)
	@ResponseBody
	public Response update(Expert expert){
		return expertService.updateExpert(expert);
	}
	
	@RequestMapping(value="{id}", method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(Expert expert, Model model){
		return expertService.deleteExpert(expert);
	}
	
	@RequestMapping("entities")
	@ResponseBody
	public List<Expert> entities(SearchParam searchParam){
		return expertService.findExperts(searchParam.getParamMap(), getPageBounds(10, true));
	}
}
