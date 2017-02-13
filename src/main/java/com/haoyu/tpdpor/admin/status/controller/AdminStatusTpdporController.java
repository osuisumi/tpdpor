package com.haoyu.tpdpor.admin.status.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.status.entity.Status;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@Controller
@RequestMapping("**/tpdpor/admin/status")
public class AdminStatusTpdporController extends AbstractBaseController{
	
	private String getLogicalViewNamePrefix(){
		return TpdporViewNamePerfixUtil.getAdminPath("/common/include/");
	}

	@RequestMapping(value="goUpdateStatus", method=RequestMethod.GET)
	public String goUpdateStatus(Status status, Model model){
		model.addAttribute("status", status);
		setParameterToModel(request, model);
		return getLogicalViewNamePrefix() + "update_status";
	}
}
