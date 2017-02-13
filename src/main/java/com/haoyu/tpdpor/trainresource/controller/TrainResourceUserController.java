package com.haoyu.tpdpor.trainresource.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tpdpor.trainresource.entity.TrainResourceUser;
import com.haoyu.tpdpor.trainresource.service.ITrainResourceUserService;

@Controller
@RequestMapping("**/train_resource/user")
public class TrainResourceUserController extends AbstractBaseController{

	@Resource
	private ITrainResourceUserService trainResourceUserService;
	
/*	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response create(TrainResourceUser trainResourceUser, Model model){
		return trainResourceUserService.createTrainResourceUser(trainResourceUser);
	}*/
}
