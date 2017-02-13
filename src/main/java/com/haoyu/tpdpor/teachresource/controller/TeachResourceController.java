package com.haoyu.tpdpor.teachresource.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.textbook.utils.TextBookParam;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tip.resource.service.IResourceService;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;
import com.haoyu.tpdpor.resource.service.IResourceBizService;

@Controller
@RequestMapping("**/teach_resource")
public class TeachResourceController extends AbstractBaseController{
	@Resource
	private IResourceService resourceService;
	@Resource
	private IResourceBizService resourceBizService;
	
	private String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getPath("/teachResource/");
	}
	
	@RequestMapping(value="index",method=RequestMethod.GET)
	public String index(Model model,TextBookParam textBookParam){
		setParameterToModel(request, model,textBookParam);
		return getViewNamePerfix() + "teach_resource_index";
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Model model){
		setParameterToModel(request, model);
		return getViewNamePerfix() + "list_teach_resource";
	}
	
	@RequestMapping(value="view/{id}",method=RequestMethod.GET)
	public String view(Resources resource,Model model){
		setParameterToModel(request, model);
		model.addAttribute("resource",resourceService.viewResource(resource));
		return getViewNamePerfix() + "view_teach_resource";
	}
	

	protected void setParameterToModel(HttpServletRequest request, Model model,TextBookParam textBookParam) {
		super.setParameterToModel(request, model);
		textBookParam = textBookParam == null ? new TextBookParam():textBookParam;
		TextBookParam subjectTextBookParam = new TextBookParam();subjectTextBookParam.setTextBookTypeCode("SUBJECT");
		if(!StringUtils.isEmpty(textBookParam.getStage())){
			subjectTextBookParam.setStage(textBookParam.getStage());
		}
		model.addAttribute("subjectTextBookParam", subjectTextBookParam);
	}
	
	

}
