package com.haoyu.tpdpor.point.utils;

import com.haoyu.sip.excel.utils.StringUtils;

public class PointEntityType {

	public static String getEntityType(String pointStrategyType) {
		String result = "";
		if (StringUtils.isNotEmpty(pointStrategyType)) {
			if (pointStrategyType.equals(PointType.SET_CREATIVE_EXCELLENT)) {
				result = "creative";
			} else if (pointStrategyType.indexOf("creative_resource") >= 0) {
				result = "creative_resource";
			} else if(pointStrategyType.indexOf("course_resource") >= 0){
				result = "course_resource";
			}
		}
		return result;
	}

}
