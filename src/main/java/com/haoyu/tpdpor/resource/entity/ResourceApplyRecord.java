package com.haoyu.tpdpor.resource.entity;

import com.haoyu.sip.core.entity.BaseEntity;
import com.haoyu.sip.core.entity.Relation;
import com.haoyu.sip.user.entity.UserInfo;
import com.haoyu.tip.resource.entity.Resources;

import org.apache.commons.codec.digest.DigestUtils;

//资源申请记录
public class ResourceApplyRecord extends BaseEntity {

	private static final long serialVersionUID = 1L;

	private String id;
	private Resources resource;
	private String applyState;
	private UserInfo userInfo;
	private Relation relation;

	public Resources getResource() {
		return resource;
	}

	public void setResource(Resources resource) {
		this.resource = resource;
	}


	public UserInfo getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(UserInfo userInfo) {
		this.userInfo = userInfo;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getApplyState() {
		return applyState;
	}

	public void setApplyState(String applyState) {
		this.applyState = applyState;
	}

	public Relation getRelation() {
		return relation;
	}

	public void setRelation(Relation relation) {
		this.relation = relation;
	}

	public static String getId(String userId, String resourceId) {
		return DigestUtils.md5Hex(userId + resourceId);
	}

}
