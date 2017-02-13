package com.haoyu.tpdpor.admin.courseresource.controller;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tip.resource.service.IResourceService;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@RequestMapping("**/admin/course_resource")
@Controller
public class AdminCourseResourceController extends AbstractBaseController{
	
	@Resource
	private IResourceService resourceService;
	
	protected String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getAdminPath("/courseResource/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Model model){
		setParameterToModel(request, model);
		return getViewNamePerfix() + "list_course_resource";
	}
	
	@RequestMapping(value="delete",method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(Resources resource){
		return resourceService.deleteByIds(resource.getId());
	}
	
	@RequestMapping(value="create",method=RequestMethod.GET)
	public String create(Model model){
		return getViewNamePerfix() + "edit_course_resource";
	}
	
	@RequestMapping(value="create_muti",method=RequestMethod.GET)
	public String createMuti(Model model){
		return getViewNamePerfix() + "edit_course_muti_resource";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response save(Resources resources){
		if (StringUtils.isEmpty(resources.getId())) {
			return resourceService.createResource(resources);
		}else{
			return resourceService.updateResource(resources);
		}
	}
	
	@RequestMapping(value="edit/{id}",method=RequestMethod.GET)
	public String edit(Resources resource,Model model){
		setParameterToModel(request, model);
		Resources edit = resourceService.viewResource(resource);
		model.addAttribute("resource",edit );
		if(edit!=null && edit.getResourceExtend()!=null && "package".equals(edit.getResourceExtend().getType())){
			return getViewNamePerfix() + "edit_course_muti_resource";
		}else{
			return getViewNamePerfix() + "edit_course_resource";
		}
	}
	

}
