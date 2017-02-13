package com.haoyu.tpdpor.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@Controller
@RequestMapping("def")
public class DefferdController extends AbstractBaseController{
	
	
	@RequestMapping(value="test")
	public String test(){
		return TpdporViewNamePerfixUtil.getPath("/def/") + "index";
	}
	
	@RequestMapping
	@ResponseBody
	public Object doPost(){
		try {
			System.out.println("sleep");
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new User("666");
	}

}
