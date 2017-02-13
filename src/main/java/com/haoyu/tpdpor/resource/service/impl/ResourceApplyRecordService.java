package com.haoyu.tpdpor.resource.service.impl;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.core.service.Response;
import com.haoyu.tpdpor.resource.dao.IResourceApplyRecordDao;
import com.haoyu.tpdpor.resource.entity.ResourceApplyRecord;
import com.haoyu.tpdpor.resource.entity.ResourceApplyRecordStateCount;
import com.haoyu.tpdpor.resource.service.IResourceApplyRecordService;

@Service
public class ResourceApplyRecordService implements IResourceApplyRecordService{
	@Resource
	private IResourceApplyRecordDao resourceApplyRecordDao;

	@Override
	public Response createResourceApplyRecord(ResourceApplyRecord resourceReadRecord) {
		if(StringUtils.isEmpty(resourceReadRecord.getId())){
			resourceReadRecord.setId(ResourceApplyRecord.getId(resourceReadRecord.getUserInfo().getId(),resourceReadRecord.getResource().getId()));
		}
		resourceReadRecord.setDefaultValue();
		return resourceApplyRecordDao.insertResourceApplyRecord(resourceReadRecord)>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public Response updateResourceApplyRecord(ResourceApplyRecord resourceReadRecord) {
		resourceReadRecord.setUpdateValue();
		return resourceApplyRecordDao.updateResourceApplyRecord(resourceReadRecord)>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public Response deleteResourceApplyRecord(ResourceApplyRecord resourceReadRecord) {
		resourceReadRecord.setUpdateValue();
		return resourceApplyRecordDao.deleteResourceApplyRecordByPhysics(resourceReadRecord.getId())>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public ResourceApplyRecord findResourceApplyRecordById(String id) {
		return resourceApplyRecordDao.selectResourceApplyRecordById(id);
	}

	@Override
	public List<ResourceApplyRecord> findResourceApplyRecords(Map<String, Object> parameter, PageBounds pageBounds) {
		return resourceApplyRecordDao.findAll(parameter, pageBounds);
	}

	@Override
	public Map<String, ResourceApplyRecordStateCount> selectStateCount(Map<String, Object> parameter) {
		return resourceApplyRecordDao.stateCount(parameter);
	}

}
