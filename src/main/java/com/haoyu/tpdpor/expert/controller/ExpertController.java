package com.haoyu.tpdpor.expert.controller;

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
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@Controller
@RequestMapping("**/expert")
public class ExpertController extends AbstractBaseController{

	@Resource
	private IExpertService expertService;
	
	private String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getPath("/expert/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Expert expert, Model model){
		setParameterToModel(request, model);
		getPageBounds(10, true);
		model.addAttribute("expert", expert);
		return getViewNamePerfix() + "list_expert";
	}
	
	@RequestMapping(value="{id}/view", method=RequestMethod.GET)
	public String view(Expert expert, Model model){
		setParameterToModel(request, model);
		model.addAttribute("expert", expert);
		return getViewNamePerfix() + "view_expert";
	}
	
	@RequestMapping(value="{id}/edit", method=RequestMethod.GET)
	public String edit(Expert expert,Model model){	
		model.addAttribute("expert",expertService.findExpertById(expert.getId()));
		return getViewNamePerfix() + "edit_expert";
	}
	
	@RequestMapping(value="{id}", method=RequestMethod.PUT)
	@ResponseBody
	public Response update(Expert expert, Model model){
		return expertService.updateExpert(expert);
	}
}
