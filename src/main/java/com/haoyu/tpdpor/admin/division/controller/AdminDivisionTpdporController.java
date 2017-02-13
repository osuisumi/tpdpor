package com.haoyu.tpdpor.admin.division.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.division.entity.Division;
import com.haoyu.division.service.IDivisionService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@RequestMapping("**/tpdpor/admin/division")
@Controller
public class AdminDivisionTpdporController extends AbstractBaseController{

	@Resource
	private IDivisionService divisionService;
	
	protected String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getAdminPath("/division/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Division division,Model model){
		setParameterToModel(request, model);
		model.addAttribute("division",division);
		getPageBounds(10, true);
		return getViewNamePerfix() + "list_division";
	}
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	public String create(Division division, Model model){
		setParameterToModel(request, model);
		model.addAttribute("division", division);
		return getViewNamePerfix() + "edit_division";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response createDivision(Division division, Model model){
		return divisionService.createDivision(division);
	}
	
	@RequestMapping(value="{id}/edit",method=RequestMethod.GET)
	public String edit(Division division,Model model){
		model.addAttribute("division",division);
		setParameterToModel(request, model);
		return getViewNamePerfix() + "edit_division";
	}
	
	@RequestMapping(value="{id}",method=RequestMethod.PUT)
	@ResponseBody
	public Response update(Division division){
		return divisionService.updateDivision(division);
	}
	
	@RequestMapping(value="{id}", method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(Division division, Model model){
		return divisionService.deleteDivision(division);
	}
	
}
