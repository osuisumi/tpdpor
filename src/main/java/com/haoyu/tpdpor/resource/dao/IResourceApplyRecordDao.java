package com.haoyu.tpdpor.resource.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.tpdpor.resource.entity.ResourceApplyRecord;
import com.haoyu.tpdpor.resource.entity.ResourceApplyRecordStateCount;

public interface IResourceApplyRecordDao {

	ResourceApplyRecord selectResourceApplyRecordById(String id);

	int insertResourceApplyRecord(ResourceApplyRecord resourceApplyRecord);

	int updateResourceApplyRecord(ResourceApplyRecord resourceApplyRecord);

	int deleteResourceApplyRecordByPhysics(String id);

	List<ResourceApplyRecord> findAll(Map<String, Object> parameter, PageBounds pageBounds);
	
	Map<String,ResourceApplyRecordStateCount> stateCount(Map<String,Object> parameter);

}