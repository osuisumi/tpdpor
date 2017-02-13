package com.haoyu.division.service.impl;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Maps;
import com.haoyu.division.dao.IDivisionUserDao;
import com.haoyu.division.entity.DivisionUser;
import com.haoyu.division.service.IDivisionUserService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.utils.Identities;

@Service
public class DivisionUserService implements IDivisionUserService{
	
	@Resource
	private IDivisionUserDao divisionUserDao;

	@Override
	public Response createDivisionUser(DivisionUser divisionUser) {
		if(StringUtils.isEmpty(divisionUser.getId())){
			divisionUser.setId(Identities.uuid2());
		}
		divisionUser.setDefaultValue();
		return divisionUserDao.insertDivisionUser(divisionUser)>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public Response updateDivisionUser(DivisionUser divisionUser) {
		divisionUser.setUpdateValue();
		return divisionUserDao.updateDivisionUser(divisionUser)>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public Response deleteDivisionUser(DivisionUser divisionUser) {
		divisionUser.setUpdateValue();
		return divisionUserDao.deleteDivisionUserByLogic(divisionUser)>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public DivisionUser findDivisionUserById(String id) {
		return divisionUserDao.selectDivisionUserById(id);
	}

	@Override
	public List<DivisionUser> findDivisionUsers(DivisionUser divisionUser, PageBounds pageBounds) {
		Map<String,Object> parameter = Maps.newHashMap();
		return divisionUserDao.findAll(parameter, pageBounds);
	}

	@Override
	public List<DivisionUser> findDivisionUsers(Map<String, Object> parameter, PageBounds pageBounds) {
		return divisionUserDao.findAll(parameter, pageBounds);
	}

	@Override
	public Map<String, DivisionUser> getDivisionUser(Map<String, Object> param) {
		return divisionUserDao.selectDivisionUser(param);
	}

	@Override
	public Response deleteDivisionUser(Map<String, Object> parameter) {
		return divisionUserDao.deleteDivisionUserByParameter(parameter)>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public Map<String, List<DivisionUser>> getDivisionUserMap(Map<String, Object> param) {
		return divisionUserDao.selectDivisionUserMap(param);
	}

}
