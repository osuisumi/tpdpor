package com.haoyu.tpdpor.admin.account.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.user.entity.Account;
import com.haoyu.sip.user.service.IAccountService;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@RequestMapping("**/admin/account")
@Controller
public class AdminAccountTpdporController extends AbstractBaseController{
	@Resource
	private IAccountService accountService;

	protected String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getAdminPath("/account/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Account account,Model model){
		setParameterToModel(request, model);
		getPageBounds(10, true);
		return getViewNamePerfix() + "list_account";
	}
	
	@RequestMapping(value="create",method=RequestMethod.GET)
	public String create(Account account, Model model){
		model.addAttribute("account",account);
		model.addAllAttributes(request.getParameterMap());
		return getViewNamePerfix() + "edit_account";
	}
	
	@RequestMapping(value="{id}/edit",method=RequestMethod.GET)
	public String edit(Account account,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("account",this.accountService.findAccountById(account.getId()));
		return getViewNamePerfix() + "edit_account";
	}
	
	@RequestMapping(value="{id}/editPassword",method=RequestMethod.GET)
	public String editPassword(Account account,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("account",this.accountService.findAccountById(account.getId()));
		return getViewNamePerfix() + "edit_password";
	}
	
	
	
}
