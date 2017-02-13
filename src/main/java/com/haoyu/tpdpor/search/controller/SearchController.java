package com.haoyu.tpdpor.search.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;
import com.haoyu.tpdpor.search.service.ISearchService;

@Controller
@RequestMapping("**/search")
public class SearchController extends AbstractBaseController {
	
	@Resource
	private ISearchService searchService;
	
	
	protected String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getPath("/search/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Model model){
		setParameterToModel(request, model);
		return getViewNamePerfix() + "list_search";
	}
	
	@RequestMapping("initSearchIndex")
	@ResponseBody
	public Response initSearchIndex(){
		return searchService.initSearchIndex();
	}

}
