package com.haoyu.tpdpor.courseresource.utils;

import java.math.BigDecimal;

public class CourseResourcePointStrategyType {
	
	public static String payType(BigDecimal price){
		return "course_resource_pay" + price;
	}
	
	public static String acceptType(BigDecimal price){
		return "course_resource_accept" + price;
	}

}
