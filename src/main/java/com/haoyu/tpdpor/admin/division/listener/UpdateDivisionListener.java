package com.haoyu.tpdpor.admin.division.listener;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.division.dao.IDivisionDao;
import com.haoyu.division.entity.Division;
import com.haoyu.division.entity.DivisionUser;
import com.haoyu.division.event.UpdateDivisionEvent;
import com.haoyu.division.service.IDivisionUserService;
import com.haoyu.division.utils.DivisionUserRole;
import com.haoyu.sip.auth.entity.AuthRole;
import com.haoyu.sip.auth.service.IAuthRoleService;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.tpdpor.admin.auth.service.IAdminRoleTpdporService;
import com.haoyu.tpdpor.utils.RoleCode;

@Component
public class UpdateDivisionListener implements ApplicationListener<UpdateDivisionEvent>{

	@Resource
	private IDivisionDao divisionDao;
	@Resource
	private IDivisionUserService divisionUserService;
	@Resource
	private IAuthRoleService authRoleService;
	@Resource
	private IAdminRoleTpdporService adminRoleTpdporService;
	
	@Override
	public void onApplicationEvent(UpdateDivisionEvent event) {
		Division division = (Division) event.getSource();
		
		if(division != null && StringUtils.isNotEmpty(division.getId())){
			//部门管理员
			if (Collections3.isNotEmpty(division.getManagers())) {
				List<String> existUserIds = Lists.newArrayList();
				List<String> newInsertUserIds = Lists.newArrayList();
				
				Map<String, Object> param = Maps.newHashMap();
				param.put("code",RoleCode.DIVISION_MANAGER);
				List<AuthRole> authRoles = adminRoleTpdporService.findAuthRoles(param, null);
				
				param = Maps.newHashMap();
				param.put("divisionId",division.getId());
				param.put("role",DivisionUserRole.MANAGER);
				Map<String, DivisionUser> managerMap = divisionUserService.getDivisionUser(param);
				
				for (DivisionUser du : division.getManagers()) {
					if (du.getUser() != null && StringUtils.isNotEmpty(du.getUser().getId())) {
						if (managerMap.get(du.getUser().getId()) != null) {
							
						}else{
							Division d = new Division();
							d.setId(division.getId());
							du.setDivision(d);
							du.setRole(DivisionUserRole.MANAGER);
							divisionUserService.createDivisionUser(du);
							
							newInsertUserIds.add(du.getUser().getId());
						}
						existUserIds.add(du.getUser().getId());
					}
				}
				
				//增量的userId添加部门管理员的角色
				if (Collections3.isNotEmpty(newInsertUserIds) && Collections3.isNotEmpty(authRoles)) {					
					authRoleService.addUsersToRole(authRoles.get(0),newInsertUserIds, division.getId());
				}
				
				List<String> oldAllUserIds = Lists.newArrayList();
				for (String key : managerMap.keySet()) {
					if (managerMap.get(key) != null && managerMap.get(key).getUser() != null && StringUtils.isNotEmpty(managerMap.get(key).getUser().getId())) {
						oldAllUserIds.add(managerMap.get(key).getUser().getId());
					}
				}
				
				//删除无交集的userId部门管理员和角色
				List<String> deleteUserIds = Collections3.subtract(oldAllUserIds,existUserIds);
				if (Collections3.isNotEmpty(deleteUserIds)) {
					param = Maps.newHashMap();
					param.put("role",DivisionUserRole.MANAGER);
					param.put("divisionId",division.getId());
					param.put("userIds", deleteUserIds);
					divisionUserService.deleteDivisionUser(param);		
					
					if (Collections3.isNotEmpty(authRoles)) {						
						authRoleService.removeUsersFromRole(authRoles.get(0), deleteUserIds, division.getId());
					}
				}
			}else{
				Map<String, Object> param = Maps.newHashMap();
				param.put("code",RoleCode.DIVISION_MANAGER);
				List<AuthRole> authRoles = adminRoleTpdporService.findAuthRoles(param, null);
				
				param = Maps.newHashMap();
				param.put("role",DivisionUserRole.MANAGER);
				param.put("divisionId",division.getId());
				
				List<DivisionUser> divisionUsers = divisionUserService.findDivisionUsers(param, null);
				if (Collections3.isNotEmpty(divisionUsers)) {
					List<String> userIds = Collections3.extractToList(divisionUsers, "user.id");
					if (Collections3.isNotEmpty(authRoles)) {						
						authRoleService.removeUsersFromRole(authRoles.get(0), userIds, division.getId());
					}
				}
				
				divisionUserService.deleteDivisionUser(param);
				
			}
			
			//部门编辑
			if (Collections3.isNotEmpty(division.getEditors())) {
				List<String> existUserIds = Lists.newArrayList();
				List<String> newInsertUserIds = Lists.newArrayList();
				
				Map<String, Object> param = Maps.newHashMap();
				param.put("code",RoleCode.DIVISION_EDITOR);
				List<AuthRole> authRoles = adminRoleTpdporService.findAuthRoles(param, null);
				
				param = Maps.newHashMap();
				param.put("divisionId",division.getId());
				param.put("role",DivisionUserRole.EDITOR);
				Map<String, DivisionUser> editorMap = divisionUserService.getDivisionUser(param);
				
				for (DivisionUser du : division.getEditors()) {
					if (du.getUser() != null && StringUtils.isNotEmpty(du.getUser().getId())) {
						if (editorMap.get(du.getUser().getId()) != null) {
							
						}else{
							Division d = new Division();
							d.setId(division.getId());
							du.setDivision(d);
							du.setRole(DivisionUserRole.EDITOR);
							divisionUserService.createDivisionUser(du);
							
							newInsertUserIds.add(du.getUser().getId());
						}
						existUserIds.add(du.getUser().getId());
					}
				}
				
				//增量的userId添加部门编辑的角色
				if (Collections3.isNotEmpty(newInsertUserIds) && Collections3.isNotEmpty(authRoles)) {					
					authRoleService.addUsersToRole(authRoles.get(0),newInsertUserIds, division.getId());
				}
				
				List<String> oldAllUserIds = Lists.newArrayList();
				for (String key : editorMap.keySet()) {
					if (editorMap.get(key) != null && editorMap.get(key).getUser() != null && StringUtils.isNotEmpty(editorMap.get(key).getUser().getId())) {
						oldAllUserIds.add(editorMap.get(key).getUser().getId());
					}
				}
				
				//删除无交集的userId部门管理员和角色
				List<String> deleteUserIds = Collections3.subtract(oldAllUserIds,existUserIds);
				if (Collections3.isNotEmpty(deleteUserIds)) {
					param = Maps.newHashMap();
					param.put("role",DivisionUserRole.EDITOR);
					param.put("divisionId",division.getId());
					param.put("userIds", deleteUserIds);
					divisionUserService.deleteDivisionUser(param);		
					
					if (Collections3.isNotEmpty(authRoles)) {						
						authRoleService.removeUsersFromRole(authRoles.get(0), deleteUserIds, division.getId());
					}
				}
			}else{
				Map<String, Object> param = Maps.newHashMap();
				param.put("code",RoleCode.DIVISION_EDITOR);
				List<AuthRole> authRoles = adminRoleTpdporService.findAuthRoles(param, null);
				
				param = Maps.newHashMap();
				param.put("role",DivisionUserRole.EDITOR);
				param.put("divisionId",division.getId());
				
				List<DivisionUser> divisionUsers = divisionUserService.findDivisionUsers(param, null);
				if (Collections3.isNotEmpty(divisionUsers)) {
					List<String> userIds = Collections3.extractToList(divisionUsers, "user.id");
					if (Collections3.isNotEmpty(authRoles)) {						
						authRoleService.removeUsersFromRole(authRoles.get(0), userIds, division.getId());
					}
				}
				
				divisionUserService.deleteDivisionUser(param);
			}
		}
	}
}
