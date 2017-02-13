package com.haoyu.tpdpor.resource.entity;

import java.io.Serializable;

/*
 * 按照类型查询统计实体
 */
public class ResourceTypeCount implements Serializable{
	
	private static final long serialVersionUID = 4654829138777135997L;

	private String type;

	private int num;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

}
