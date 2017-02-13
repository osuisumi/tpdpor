package com.haoyu.tpdpor.admin.teacher.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tip.project.entity.Project;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@Controller
@RequestMapping("**/tpdpor/admin/teacher")
public class AdminTeacherTpdporController extends AbstractBaseController{

	protected String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getAdminPath("/teacher/");
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
}
