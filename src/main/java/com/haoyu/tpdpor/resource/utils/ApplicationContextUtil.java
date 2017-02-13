package com.haoyu.tpdpor.resource.utils;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

@Component
public class ApplicationContextUtil {
	private static ApplicationContext staticAc;
	@Resource
	private ApplicationContext ac;
	
	@PostConstruct
	public void init(){
		staticAc = ac;
	}
	
	public static ApplicationContext getAc(){
		return staticAc;
	}
	

}
