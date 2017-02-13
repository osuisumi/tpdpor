package com.haoyu.tpdpor.admin.project.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tip.project.entity.Project;
import com.haoyu.tip.project.service.IProjectService;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@Controller
@RequestMapping("**/tpdpor/admin/project")
public class AdminProjectTpdporController extends AbstractBaseController{

	@Resource
	private IProjectService projectService;
	
	protected String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getAdminPath("/project/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Project project,Model model){
		setParameterToModel(request, model);
		model.addAttribute("project",project);
		model.addAttribute("pageBounds", getPageBounds(10, true));
		return getViewNamePerfix() + "list_project";
	}
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	public String create(Project project, Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("project", project);
		return getViewNamePerfix() + "edit_project";
	}
	
	@RequestMapping(value="{id}/edit", method=RequestMethod.GET)
	public String edit(Project project,Model model){	
		model.addAttribute("project",projectService.findProjectById(project.getId()));
		return getViewNamePerfix() + "edit_project";
	}
}
