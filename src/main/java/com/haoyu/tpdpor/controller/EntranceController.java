package com.haoyu.tpdpor.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("entrance")
public class EntranceController extends AbstractBaseController{
	
	@RequestMapping(method=RequestMethod.GET)
	public String entrance(){
		return "redirect:/tpdpor/index";
	}

}
