package com.haoyu.tpdpor.trainresource.entity;

import com.haoyu.division.entity.Division;
import com.haoyu.sip.core.entity.BaseEntity;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tip.train.entity.Train;

public class TrainResource extends BaseEntity{

	private static final long serialVersionUID = -8851679651445646998L;

	private String id;
		
	private Train train;
	
	private Resources resource;
		
	private TrainResourceUser trainResourceUser;
	
	private Integer participateNum;
	
	private Division division;
	
	public TrainResource() {
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public TrainResourceUser getTrainResourceUser() {
		return trainResourceUser;
	}

	public void setTrainResourceUser(TrainResourceUser trainResourceUser) {
		this.trainResourceUser = trainResourceUser;
	}

	public Train getTrain() {
		return train;
	}

	public void setTrain(Train train) {
		this.train = train;
	}

	public Integer getParticipateNum() {
		return participateNum;
	}

	public void setParticipateNum(Integer participateNum) {
		this.participateNum = participateNum;
	}

	public Resources getResource() {
		return resource;
	}

	public void setResource(Resources resource) {
		this.resource = resource;
	}

	public Division getDivision() {
		return division;
	}

	public void setDivision(Division division) {
		this.division = division;
	}
	
}