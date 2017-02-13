package com.haoyu.tpdpor.resource.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.tpdpor.resource.entity.ResourceApplyRecord;
import com.haoyu.tpdpor.resource.entity.ResourceApplyRecordStateCount;
import com.haoyu.sip.core.service.Response;

public interface IResourceApplyRecordService {
	
	Response createResourceApplyRecord(ResourceApplyRecord ResourceApplyRecord);
	
	Response updateResourceApplyRecord(ResourceApplyRecord ResourceApplyRecord);
	
	Response deleteResourceApplyRecord(ResourceApplyRecord ResourceApplyRecord);
	
	ResourceApplyRecord findResourceApplyRecordById(String id);
	
	List<ResourceApplyRecord> findResourceApplyRecords(Map<String,Object> parameter,PageBounds pageBounds);
	
	Map<String,ResourceApplyRecordStateCount> selectStateCount(Map<String,Object> parameter);
	
	
}
