package com.haoyu.tpdpor.admin.dict.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.dict.entity.DictEntry;
import com.haoyu.dict.service.IDictEntryService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tpdpor.admin.dict.service.IAdminDictTpdporService;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@Controller
@RequestMapping("**/tpdpor/admin/dict")
public class AdminDictTpdporController extends AbstractBaseController{

	@Resource
	private IAdminDictTpdporService adminDictTpdporService;
	@Resource
	private IDictEntryService dictEntryService;
	
	protected String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getAdminPath("/dict/");
	}
	
	@RequestMapping(value="post_topic",method = RequestMethod.GET)
	public String getPostTopic(Model model){
		setParameterToModel(request, model);
		return getViewNamePerfix() + "post_topic";
	}
	
	@RequestMapping(value="post_topic/{postValue}",method = RequestMethod.GET)
	public String getPostTopic(@PathVariable String postValue,Model model){
		setParameterToModel(request, model);
		model.addAttribute("postValue", postValue);
		return getViewNamePerfix() + "post_topic";
	}
	
	@RequestMapping(value="create",method=RequestMethod.GET)
	public String create(Model model){
		setParameterToModel(request, model);
		return getViewNamePerfix() + "edit_dict";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response save(DictEntry dictEntry){
		return adminDictTpdporService.create(dictEntry);
	}
	
	@RequestMapping(value="{id}/edit",method=RequestMethod.GET)
	public String edit(DictEntry dictEntry,Model model){
		setParameterToModel(request, model);
		model.addAttribute("dictEntry",dictEntryService.get(dictEntry.getId()));
		return getViewNamePerfix() + "edit_dict";
	}
	
	@RequestMapping(value="{id}",method=RequestMethod.PUT)
	@ResponseBody
	public Response update(DictEntry dictEntry){
		return dictEntryService.update(dictEntry);
	}
	
	@RequestMapping(value="{id}",method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(DictEntry dictEntry, Model model){
		return adminDictTpdporService.delete(dictEntry);
	}
}
