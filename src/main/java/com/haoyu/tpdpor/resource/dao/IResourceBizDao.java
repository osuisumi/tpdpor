package com.haoyu.tpdpor.resource.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tpdpor.resource.entity.ResourceTypeCount;

public interface IResourceBizDao {
	//根据类型统计resource数量
	int countResourceByType(String type);
	//根据类型统计resource创建者数量
	int countCreatorByType(String type);
	
	int countResourceByParameter(Map<String,Object> parameter);
	
	Map<String,ResourceTypeCount> resourceCountMap(Map<String,Object> parameter);
	
	int updateResourceExtendEvaluateResult(Map<String,Object> parameter);
	
	List<Resources> findResource(Map<String,Object> parameter,PageBounds pageBounds);
	
	
	

}
