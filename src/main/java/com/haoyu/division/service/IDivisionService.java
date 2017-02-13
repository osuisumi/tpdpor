package com.haoyu.division.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.division.entity.Division;
import com.haoyu.sip.core.service.Response;

public interface IDivisionService {
	
	Response createDivision(Division division);
	
	Response updateDivision(Division division);
	
	Response deleteDivision(Division division);
	
	Division findDivisionById(String id);
	
	List<Division> findDivisions(Division division,PageBounds pageBounds);
	
	List<Division> findDivisions(Map<String,Object> parameter,PageBounds pageBounds);
}
