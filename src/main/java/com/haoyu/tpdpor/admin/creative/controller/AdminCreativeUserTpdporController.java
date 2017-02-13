package com.haoyu.tpdpor.admin.creative.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tip.creative.entity.CreativeUser;
import com.haoyu.tpdpor.admin.creative.service.IAdminCreativeUserTpdporService;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@RequestMapping("**/tpdpor/admin/creative/user")
@Controller
public class AdminCreativeUserTpdporController extends AbstractBaseController{

	@Resource
	private IAdminCreativeUserTpdporService creativeUserTpdporService;
	
	protected String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getAdminPath("/creative/user/");
	}
	
	@RequestMapping(value="edit", method=RequestMethod.GET)
	public String edit(CreativeUser creativeUser,Model model){
		setParameterToModel(request, model);
		getPageBounds(10, true);
		model.addAttribute("creativeUser",creativeUser);
		return getViewNamePerfix() + "edit_creative_user";
	}
	
	@RequestMapping(value="typeManagerAndExpert",method=RequestMethod.PUT)
	@ResponseBody
	public Response updateTypeManagerAndExpert(String type,String typeManagerUserId,String expertUserId, Model model){
		return creativeUserTpdporService.updateTypeManagerAndExpert(type,typeManagerUserId,expertUserId);
	}
}
