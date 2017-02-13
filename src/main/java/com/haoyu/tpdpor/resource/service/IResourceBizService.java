package com.haoyu.tpdpor.resource.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.core.service.Response;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tpdpor.resource.entity.ResourceTypeCount;

public interface IResourceBizService {
	
	int countResourceByType(String type);
	
	int countCreatorByType(String type);
	
	int countResourceByParameter(Map<String,Object> parameter);
	
	Map<String,ResourceTypeCount> resourceCountMap(Map<String,Object> parameter);
	
	Response updateResourceExtendEvaluateResult(Map<String,Object> parameter);
	
	//比tip中多了  查询我申请的资源
	List<Resources> findResources(Map<String,Object> parameter,PageBounds pageBounds,boolean getFile);
	
	

}
