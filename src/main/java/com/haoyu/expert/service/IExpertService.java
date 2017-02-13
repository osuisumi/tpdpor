package com.haoyu.expert.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.expert.entity.Expert;
import com.haoyu.sip.core.service.Response;

public interface IExpertService {
	
	Response createExpert(Expert expert);
	
	Response updateExpert(Expert expert);
	
	Response deleteExpert(Expert expert);
	
	Expert findExpertById(String id);
	
	List<Expert> findExperts(Expert expert,PageBounds pageBounds);
	
	List<Expert> findExperts(Map<String,Object> parameter,PageBounds pageBounds);
}
