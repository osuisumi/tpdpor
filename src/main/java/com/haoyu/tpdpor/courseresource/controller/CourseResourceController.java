package com.haoyu.tpdpor.courseresource.controller;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.point.service.IPointRecordService;
import com.haoyu.sip.textbook.utils.TextBookParam;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tip.resource.service.IResourceService;
import com.haoyu.tpdpor.courseresource.service.impl.CourseResourceService;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;
import com.haoyu.tpdpor.resource.service.IResourceBizService;
import com.haoyu.tpdpor.utils.ResourceType;

@RequestMapping("**/course_resource")
@Controller
public class CourseResourceController extends AbstractBaseController{
	@Resource
	private IResourceService resourceService;
	@Resource
	private IResourceBizService resourceBizService;
	@Resource
	private IPointRecordService pointRecordService;
	@Resource
	private CourseResourceService courseResourceService;
	
	protected String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getPath("/courseResource/");
	}
	
	@RequestMapping(value="index",method=RequestMethod.GET)
	public String index(Model model,TextBookParam textBookParam){
		setParameterToModel(request, model,textBookParam);
		model.addAttribute("creatorNum",resourceBizService.countCreatorByType(ResourceType.COURSE));
		model.addAttribute("resourceNum", resourceBizService.countResourceByType(ResourceType.COURSE));
		return getViewNamePerfix() + "course_resource_index";
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Model model){
		setParameterToModel(request, model);
		return getViewNamePerfix() + "list_course_resource";
	}
	
	@RequestMapping(value="view/{id}",method=RequestMethod.GET)
	public String view(Resources resource,Model model){
		setParameterToModel(request, model);
		model.addAttribute("creatorNum",resourceBizService.countCreatorByType(ResourceType.COURSE));
		model.addAttribute("resourceNum", resourceBizService.countResourceByType(ResourceType.COURSE));
		Resources r = resourceService.viewResource(resource);
		model.addAttribute("resource",r);
		model.addAttribute("intrestsResources", courseResourceService.intrestList(r));
		return getViewNamePerfix() + "view_course_resource";
	}
	
	@RequestMapping(value="create",method=RequestMethod.GET)
	public String create(Model model){
		setParameterToModel(request, model);
		return getViewNamePerfix() + "edit_course_resource";
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
	
	@RequestMapping(value="delete/{id}",method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(Resources resource){
		return resourceService.delete(resource.getId());
	}
	
	@RequestMapping(value="create_muti",method=RequestMethod.GET)
	public String createMuti(Model model){
		setParameterToModel(request, model);
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
	
	@RequestMapping(value="pay/{resourceId}",method=RequestMethod.POST)
	@ResponseBody
	public Response pay(@PathVariable String resourceId,Model model){
		setParameterToModel(request, model);
		return courseResourceService.createPayRecord(resourceId);
	}
	
	
	
	protected void setParameterToModel(HttpServletRequest request, Model model,TextBookParam textBookParam) {
		super.setParameterToModel(request, model);
		textBookParam = textBookParam == null ? new TextBookParam():textBookParam;
		TextBookParam subjectTextBookParam = new TextBookParam();subjectTextBookParam.setTextBookTypeCode("SUBJECT");
		TextBookParam gradeTextBookParam = new TextBookParam();gradeTextBookParam.setTextBookTypeCode("GRADE");
		TextBookParam versionTextBookParam = new TextBookParam();versionTextBookParam.setTextBookTypeCode("VERSION");
		TextBookParam sectionTextBookParam = new TextBookParam();sectionTextBookParam.setTextBookTypeCode("SECTION");
		if(!StringUtils.isEmpty(textBookParam.getStage())){
			subjectTextBookParam.setStage(textBookParam.getStage());
			gradeTextBookParam.setStage(textBookParam.getStage());
			versionTextBookParam.setStage(textBookParam.getStage());
			sectionTextBookParam.setStage(textBookParam.getStage());
		}
		if(!StringUtils.isEmpty(textBookParam.getSubject())){
			gradeTextBookParam.setSubject(textBookParam.getSubject());
			versionTextBookParam.setSubject(textBookParam.getSubject());
			sectionTextBookParam.setSubject(textBookParam.getSubject());
		}
		if(!StringUtils.isEmpty(textBookParam.getGrade())){
			versionTextBookParam.setGrade(textBookParam.getGrade());
			sectionTextBookParam.setGrade(textBookParam.getGrade());
		}
		if(!StringUtils.isEmpty(textBookParam.getVersion())){
			sectionTextBookParam.setVersion(textBookParam.getVersion());
		}
		model.addAttribute("subjectTextBookParam", subjectTextBookParam);
		model.addAttribute("gradeTextBookParam", gradeTextBookParam);
		model.addAttribute("versionTextBookParam", versionTextBookParam);
		if(valiateSectionTextBookParam(sectionTextBookParam)){
			model.addAttribute("sectionTextBookParam",sectionTextBookParam);
		}
	}
	
	private boolean valiateSectionTextBookParam(TextBookParam textBookParam){
		if(StringUtils.isAnyEmpty(textBookParam.getStage(),textBookParam.getSubject(),textBookParam.getGrade(),textBookParam.getVersion())){
			return false;
		}else{
			return true;
		}
		
	}

}
