package com.haoyu.tpdpor.utils;

import org.apache.commons.codec.digest.DigestUtils;

public class DictEntrySqlFactory {
	public static String [] teachResourceType = {"图书","期刊","报纸","附书光盘","非书资料"};
	
	public static String [] courseResourceType = {"优秀课例包","网络课程","微课","课堂实录","教学设计","教学课件","教学素材","论文","其他"};
	
	public static String [] trainResourceType = {"课程","案例","素材","其他"};
	
	public static String [] trainResourceChannel = {"基础课程","民族与区域","特色专题"};
	
	public static String [] accountRoleCode = {"普通用户","直属校教师","直属校学生","教师认证会员"};
	
	
	
	
	public static void main(String[] args) {
		printSql("ACCOUNT_ROLE_CODE", accountRoleCode);
	}
	
	
	
	public static void printSql(String dictTypeCode,String [] dictNames){
		int index = 1;
		System.out.println("delete from ipanther_dict_entry where dict_type_code = '"+dictTypeCode+"';");
		for(String name:dictNames){
			System.out.println("insert into ipanther_dict_entry values ('"+getId(dictTypeCode,index)+"', '"+dictTypeCode+"', '"+getDictValue(index)+"', '"+name+"', null, null, null, '"+index+"', null, null, null, '"+index+"', 'N', null);");
			index++;
		}
		System.out.println("select * from ipanther_dict_entry where DICT_TYPE_CODE = '"+dictTypeCode+"';");
	}
	
	public static void printdeptSql(){
		
	}
	
	private static String getDictValue(int index){
		if(index<10){
			return "0" + index;
		}else{
			return index+"";
		}
	}
	
	private static String getId(String typeCode,int index){
		return DigestUtils.md5Hex(typeCode + index);
	}
	

}
