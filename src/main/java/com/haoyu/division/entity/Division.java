package com.haoyu.division.entity;

import java.util.List;

import com.google.common.collect.Lists;
import com.haoyu.sip.core.entity.BaseEntity;
import com.haoyu.sip.file.entity.FileInfo;

public class Division extends BaseEntity {

	private static final long serialVersionUID = -5031170414521167151L;
	
	private String id;
	private String name;
	private String summary;
	private String imageUrl;
	private FileInfo imageFileInfo;
	private String phone;
	private List<DivisionUser> managers = Lists.newArrayList();
	private List<DivisionUser> editors = Lists.newArrayList();
	private String email;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public FileInfo getImageFileInfo() {
		return imageFileInfo;
	}

	public void setImageFileInfo(FileInfo imageFileInfo) {
		this.imageFileInfo = imageFileInfo;
	}

	public List<DivisionUser> getManagers() {
		return managers;
	}

	public void setManagers(List<DivisionUser> managers) {
		this.managers = managers;
	}

	public List<DivisionUser> getEditors() {
		return editors;
	}

	public void setEditors(List<DivisionUser> editors) {
		this.editors = editors;
	}
	
}
