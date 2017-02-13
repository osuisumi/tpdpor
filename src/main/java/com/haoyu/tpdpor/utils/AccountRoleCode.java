package com.haoyu.tpdpor.utils;

import org.apache.commons.lang3.StringUtils;

public class AccountRoleCode {
	
	public static final String DEFAULT = "1"; //默认值
	
	public static final String ZSXJS = "2"; //直属校教师
	
	public static final String ZSXXS = "3"; //直属校学生
	
	public static final String JSRZHY = "4"; //教师认证会员

	public static String getDEFAULT() {
		return DEFAULT;
	}

	public static String getZSXJS() {
		return ZSXJS;
	}

	public static String getZSXXS() {
		return ZSXXS;
	}

	public static String getJSRZHY() {
		return JSRZHY;
	}
	
	public static String viewName(String code){
		String result = "";
		if(StringUtils.isNotEmpty(code)){
			switch (code) {
			case DEFAULT:
				result = "普通用户";
				break;
			case ZSXJS:
				result = "直属校教师";
				break;
			case ZSXXS:
				result = "直属校学生";
				break;
			case JSRZHY:
				result = "教师认证会员";
				break;
			default:
				break;
			}
		}
		return result;
	}
	
	//public static String ZCHY = "5";	//注册会员
	

}
