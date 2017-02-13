package com.haoyu.tpdpor.admin.trainresource.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;
import com.haoyu.tpdpor.trainresource.entity.TrainResourceUser;
import com.haoyu.tpdpor.trainresource.service.ITrainResourceUserService;

@RequestMapping("**/tpdpor/admin/train_resource/user")
@Controller
public class AdminTrainResourceUserTpdporController extends AbstractBaseController{

	@Resource
	private ITrainResourceUserService trainResourceUserService;
	
	protected String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getAdminPath("/trainResource/user/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(TrainResourceUser trainResourceUser,Model model){
		setParameterToModel(request, model);
		getPageBounds(10, true);
		model.addAttribute("trainResourceUser", trainResourceUser);
		return getViewNamePerfix() + "list_train_resource_user";
	}
	
	@RequestMapping(value="{id}/view", method=RequestMethod.GET)
	public String view(TrainResourceUser trainResourceUser, Model model){
		setParameterToModel(request, model);
		model.addAttribute("trainResourceUser", trainResourceUser);
		return getViewNamePerfix() + "view_train_resource_user";
	}

}
