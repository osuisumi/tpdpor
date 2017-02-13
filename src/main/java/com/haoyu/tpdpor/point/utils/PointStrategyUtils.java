package com.haoyu.tpdpor.point.utils;

import java.math.BigDecimal;

import com.haoyu.tpdpor.courseresource.utils.CourseResourcePointStrategyType;

public class PointStrategyUtils {
	
	public static String getId(String type,BigDecimal price){
		return CourseResourcePointStrategyType.acceptType(price);
	}

}
