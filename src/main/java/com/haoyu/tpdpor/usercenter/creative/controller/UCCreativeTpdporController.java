package com.haoyu.tpdpor.usercenter.creative.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tip.creative.entity.Creative;
import com.haoyu.tip.creative.service.ICreativeService;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@Controller
@RequestMapping("**/userCenter/creative")
public class UCCreativeTpdporController extends AbstractBaseController{

	@Resource
	private ICreativeService creativeService;
	
	private String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getUserCenterPath("/creative/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Creative creative, Model model){
		setParameterToModel(request, model);
		getPageBounds(10, true);
		model.addAttribute("creative", creative);
		return getViewNamePerfix() + "list_creative";
	}
	
	@RequestMapping(value="batch", method=RequestMethod.DELETE)
	@ResponseBody
	public Response batchDelete(Creative creative, Model model){
		return creativeService.batchDeleteCreative(creative);
	}
}
