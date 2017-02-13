package com.haoyu.division.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.division.entity.DivisionUser;
import com.haoyu.sip.core.service.Response;

public interface IDivisionUserService {
	
	Response createDivisionUser(DivisionUser divisionUser);
	
	Response updateDivisionUser(DivisionUser divisionUser);
	
	Response deleteDivisionUser(DivisionUser divisionUser);
	
	DivisionUser findDivisionUserById(String id);
		
	List<DivisionUser> findDivisionUsers(DivisionUser divisionUser,PageBounds pageBounds);
	
	List<DivisionUser> findDivisionUsers(Map<String,Object> parameter,PageBounds pageBounds);

	Map<String, DivisionUser> getDivisionUser(Map<String, Object> param);
	
	Response deleteDivisionUser(Map<String,Object> parameter);

	Map<String, List<DivisionUser>> getDivisionUserMap(Map<String, Object> param);

}
