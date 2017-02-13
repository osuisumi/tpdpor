package com.haoyu.expert.entity;

import com.haoyu.sip.core.entity.BaseEntity;
import com.haoyu.sip.user.entity.Account;
import com.haoyu.sip.user.entity.UserInfo;

public class Expert extends BaseEntity {

	private static final long serialVersionUID = 6304549486885997219L;
	
	private String id;
	
	private UserInfo user;
	
	private Account account;
	//职位
	private String position;
	//专业
	private String specialty;
	//职称
	private String professionalTitle;
	//研究主题与成果
	private String researchResult;
	//培训项目经验
	private String trainExperience;
	//贡献资源
	private String contributeResource;
	
	public Expert() {
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getSpecialty() {
		return specialty;
	}

	public void setSpecialty(String specialty) {
		this.specialty = specialty;
	}

	public String getProfessionalTitle() {
		return professionalTitle;
	}

	public void setProfessionalTitle(String professionalTitle) {
		this.professionalTitle = professionalTitle;
	}

	public String getResearchResult() {
		return researchResult;
	}

	public void setResearchResult(String researchResult) {
		this.researchResult = researchResult;
	}

	public String getTrainExperience() {
		return trainExperience;
	}

	public void setTrainExperience(String trainExperience) {
		this.trainExperience = trainExperience;
	}

	public String getContributeResource() {
		return contributeResource;
	}

	public void setContributeResource(String contributeResource) {
		this.contributeResource = contributeResource;
	}

	public UserInfo getUser() {
		return user;
	}

	public void setUser(UserInfo user) {
		this.user = user;
	}

	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}

}
