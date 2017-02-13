package com.haoyu.division.service.impl;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.division.dao.IDivisionDao;
import com.haoyu.division.entity.Division;
import com.haoyu.division.entity.DivisionUser;
import com.haoyu.division.event.UpdateDivisionEvent;
import com.haoyu.division.service.IDivisionService;
import com.haoyu.division.service.IDivisionUserService;
import com.haoyu.division.utils.DivisionUserRole;
import com.haoyu.sip.auth.entity.AuthRole;
import com.haoyu.sip.auth.service.IAuthUserService;
import com.haoyu.sip.core.entity.Relation;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.file.entity.FileInfo;
import com.haoyu.sip.file.service.IFileService;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.sip.utils.Identities;
import com.haoyu.tpdpor.admin.auth.service.IAdminRoleTpdporService;
import com.haoyu.tpdpor.utils.RoleCode;

@Service
public class DivisionService implements IDivisionService{
	
	@Resource
	private IDivisionDao divisionDao;
	@Resource
	private IFileService fileService;
	@Resource
	private IDivisionUserService divisionUserService;
	@Resource  
	private ApplicationContext applicationContext;  
	@Resource
	private IAdminRoleTpdporService adminRoleTpdporService;
	@Resource
	private IAuthUserService authUserService;

	@Override
	public Response createDivision(Division division) {
		if(StringUtils.isEmpty(division.getId())){
			division.setId(Identities.uuid2());
		}
		division.setDefaultValue();
		if (division.getImageFileInfo() != null ) {
			Response r = fileService.createFile(division.getImageFileInfo(),division.getId(), "division");
			if(r.isSuccess()){
				FileInfo fileInfo = division.getImageFileInfo();
				division.setImageUrl(fileInfo.getUrl());
			}
		}
		if (Collections3.isNotEmpty(division.getManagers()) ) {
			Map<String, Object> param = Maps.newHashMap();
			param.put("code",RoleCode.DIVISION_MANAGER);
			List<AuthRole> authRoles = adminRoleTpdporService.findAuthRoles(param, null);
			
			for (DivisionUser du : division.getManagers()) {
				if (du != null && du.getUser() != null && StringUtils.isNotEmpty(du.getUser().getId())) {
					Division d = new Division();
					d.setId(division.getId());
					du.setDivision(d);
					du.setRole(DivisionUserRole.MANAGER);
					Response response = divisionUserService.createDivisionUser(du);
					if (response.isSuccess() && Collections3.isNotEmpty(authRoles)) {
						adminRoleTpdporService.addUsersToRole(authRoles.get(0), Lists.newArrayList(du.getUser().getId()), division.getId());
					}
				}
			}
		}
		if (Collections3.isNotEmpty(division.getEditors()) ) {
			Map<String, Object> param = Maps.newHashMap();
			param.put("code",RoleCode.DIVISION_EDITOR);
			List<AuthRole> authRoles = adminRoleTpdporService.findAuthRoles(param, null);
			
			for (DivisionUser du : division.getEditors()) {
				if (du != null && du.getUser() != null && StringUtils.isNotEmpty(du.getUser().getId())) {
					Division d = new Division();
					d.setId(division.getId());
					du.setDivision(d);
					du.setRole(DivisionUserRole.EDITOR);
					Response response = divisionUserService.createDivisionUser(du);
					if (response.isSuccess() && Collections3.isNotEmpty(authRoles) ) {
						
						
					}
				}
			}
		}
		return divisionDao.insertDivision(division)>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public Response updateDivision(Division division) {
		Response response = Response.failInstance();
		division.setUpdateValue();
		if(division.getImageFileInfo() != null){
			List<FileInfo> oldCoverFileInfo = fileService.listFileInfoByRelation(new Relation(division.getId(),"division"));
			fileService.updateFileList(Lists.newArrayList(division.getImageFileInfo()), oldCoverFileInfo, division.getId(), "division");
			FileInfo fi = division.getImageFileInfo();
			division.setImageUrl(fi.getUrl());
		}
		int count = divisionDao.updateDivision(division);
		
		if (count > 0) {
			response = Response.successInstance().responseData(division);
			applicationContext.publishEvent(new UpdateDivisionEvent(division));
		}
		return response;
	}

	@Override
	public Response deleteDivision(Division division) {
		division.setUpdateValue();
		return divisionDao.deleteDivisionByLogic(division)>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public Division findDivisionById(String id) {
		return divisionDao.selectDivisionById(id);
	}

	@Override
	public List<Division> findDivisions(Division division, PageBounds pageBounds) {
		Map<String,Object> parameter = Maps.newHashMap();
		return divisionDao.findAll(parameter, pageBounds);
	}

	@Override
	public List<Division> findDivisions(Map<String, Object> parameter, PageBounds pageBounds) {
		return divisionDao.findAll(parameter, pageBounds);
	}

}
