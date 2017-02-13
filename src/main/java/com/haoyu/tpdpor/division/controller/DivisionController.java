package com.haoyu.tpdpor.division.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.division.entity.Division;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@Controller
@RequestMapping("**/division")
public class DivisionController extends AbstractBaseController{

	private String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getPath("/division/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Division division, Model model){
		setParameterToModel(request, model);
		model.addAttribute("division",division);
		getPageBounds(10, true);
		return getViewNamePerfix() + "list_division";
	}
	
	@RequestMapping(value="{id}/view", method=RequestMethod.GET)
	public String view(Division division, Model model){
		setParameterToModel(request, model);
		model.addAttribute("division",division);
		return getViewNamePerfix() + "view_division";
	}
}
