package com.haoyu.tpdpor.admin.teachresource.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tip.resource.service.IResourceService;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;
import com.haoyu.tpdpor.teachresource.service.ITeachResourceService;

@RequestMapping("**/admin/teach_resource")
@Controller
public class AdminTeachResourceController extends AbstractBaseController{
	@Resource
	private IResourceService resourceService;
	@Resource
	private ITeachResourceService teachResourceService;
	
	protected String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getAdminPath("/teachResource/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Model model){
		setParameterToModel(request, model);
		return getViewNamePerfix() + "list_teach_resource";
	}
	
	@RequestMapping(value="create",method=RequestMethod.GET)
	public String create(Model model){
		setParameterToModel(request, model);
		return getViewNamePerfix() + "edit_teach_resource";
	}
	
	@RequestMapping(value="edit/{id}",method=RequestMethod.GET)
	public String edit(@PathVariable String id,Model model){
		Resources resource = resourceService.get(id);
		model.addAttribute("resource",resource);
		return getViewNamePerfix() + "edit_teach_resource";
	}
	
	@RequestMapping(value="delete",method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(Resources resource){
		return resourceService.deleteByIds(resource.getId());
	}
	
	@RequestMapping(value="save", method=RequestMethod.POST)
	@ResponseBody
	public Response save(Resources resource, Model model,String year){
		if(StringUtils.isNotEmpty(year)){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
			try {
				Date d = sdf.parse(year);
				if(resource.getResourceExtend()!=null){
					resource.getResourceExtend().setIssueDate(d);
				}
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		if (StringUtils.isEmpty(resource.getId())) {
			return resourceService.createResource(resource);
		}else{
			return resourceService.updateResource(resource);
		}
	}
	
	@RequestMapping(value="go_import_preview_url",method=RequestMethod.GET)
	public String goImportPreviewUrl(Model model){
		setParameterToModel(request, model);
		return getViewNamePerfix() + "import_preview_url";
	}
	
	@RequestMapping(value="import_preview_url",method=RequestMethod.POST)
	public String importPreviewUrl(String url,Model model){
		model.addAttribute("resultMap",teachResourceService.importPreviewUrl(url));
		model.addAllAttributes(request.getParameterMap());
		return getViewNamePerfix() + "import_result";
	}
}
