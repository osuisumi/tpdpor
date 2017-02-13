package com.haoyu.tpdpor.freemaker.util;

public class TpdporViewNamePerfixUtil {
	
	public static String getPath(String path){
//		return "/tpdpor/"+ThreadContext.getDomain()+"/" + path +"/";
		return "/tpdpor/"+ path +"/";
	}
	
	public static String getAdminPath(String path){
		return "/admin/" + path + "/";
	}
	
	public static String getUserCenterPath(String path){
		return "/userCenter/" + path + "/";
	}
}
