package com.haoyu.tpdpor.statistics.entity;

import java.io.Serializable;

import com.haoyu.common.regions.entity.Regions;

public class ResourceStatistics implements Serializable{

	private static final long serialVersionUID = 3614476453688756566L;

	private Regions region;
	
	private int resourceNum;
	
	private int downloadNum;
	
	private int userNum;

	public ResourceStatistics() {
	}

	public int getResourceNum() {
		return resourceNum;
	}

	public void setResourceNum(int resourceNum) {
		this.resourceNum = resourceNum;
	}

	public int getDownloadNum() {
		return downloadNum;
	}

	public void setDownloadNum(int downloadNum) {
		this.downloadNum = downloadNum;
	}

	public int getUserNum() {
		return userNum;
	}

	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}

	public Regions getRegion() {
		return region;
	}

	public void setRegion(Regions region) {
		this.region = region;
	}

}