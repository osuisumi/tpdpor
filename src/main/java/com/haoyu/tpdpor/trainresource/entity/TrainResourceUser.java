package com.haoyu.tpdpor.trainresource.entity;

import com.haoyu.sip.core.entity.BaseEntity;
import com.haoyu.sip.user.entity.UserInfo;

public class TrainResourceUser extends BaseEntity{

	private static final long serialVersionUID = -1711772583235971385L;

	private String id;
	
	private UserInfo user;
	
	private TrainResource trainResource;
	
	private String state;

	public TrainResourceUser() {
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public TrainResource getTrainResource() {
		return trainResource;
	}

	public void setTrainResource(TrainResource trainResource) {
		this.trainResource = trainResource;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public UserInfo getUser() {
		return user;
	}

	public void setUser(UserInfo user) {
		this.user = user;
	}
	
}
