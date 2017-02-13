package com.haoyu.tpdpor.admin.creative.entity;

import java.io.Serializable;

import com.haoyu.sip.core.entity.User;

public class CreativeTypeParam implements Serializable{

	private static final long serialVersionUID = 7765981524284376721L;

	private String type;
	
	private User manager;
	
	private User expert;
	
	private int creativeNum;
	
	private int resorceNum;

	public CreativeTypeParam() {
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public User getManager() {
		return manager;
	}

	public void setManager(User manager) {
		this.manager = manager;
	}

	public int getCreativeNum() {
		return creativeNum;
	}

	public void setCreativeNum(int creativeNum) {
		this.creativeNum = creativeNum;
	}

	public int getResorceNum() {
		return resorceNum;
	}

	public void setResorceNum(int resorceNum) {
		this.resorceNum = resorceNum;
	}

	public User getExpert() {
		return expert;
	}

	public void setExpert(User expert) {
		this.expert = expert;
	}
	
}
