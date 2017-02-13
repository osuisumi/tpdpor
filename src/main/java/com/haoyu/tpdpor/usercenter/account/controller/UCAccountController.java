package com.haoyu.tpdpor.usercenter.account.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.user.service.IAccountService;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;
@Controller
@RequestMapping("**/userCenter/account")
public class UCAccountController extends AbstractBaseController{
	@Resource
	private IAccountService accountService;
	
	protected String viewNamePerfix(){
		return TpdporViewNamePerfixUtil.getUserCenterPath("/account/");
	}
	
	@RequestMapping(value="change_password",method=RequestMethod.GET)
	public String editMyAccount(Model model){
		setParameterToModel(request, model);
		return viewNamePerfix() + "change_password";
	}
	
	@RequestMapping(value="change_password",method=RequestMethod.PUT)
	@ResponseBody
	public Response updateAccount(String oldPassword,String newPassword){
		return accountService.updatePassword(oldPassword, newPassword, ThreadContext.getUser().getId());
	}

}
