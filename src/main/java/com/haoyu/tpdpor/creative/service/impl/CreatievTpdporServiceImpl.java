package com.haoyu.tpdpor.creative.service.impl;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Service;

import com.haoyu.sip.auth.realm.CacheCleaner;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.point.entity.PointRecord;
import com.haoyu.sip.point.entity.PointStrategy;
import com.haoyu.sip.point.service.IPointRecordService;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.tip.creative.dao.ICreativeDao;
import com.haoyu.tip.creative.entity.Creative;
import com.haoyu.tip.creative.utils.CreativeState;
import com.haoyu.tpdpor.creative.service.ICreativeTpdporService;
import com.haoyu.tpdpor.point.utils.PointType;

@Service
public class CreatievTpdporServiceImpl implements ICreativeTpdporService{

	@Resource
	private ICreativeDao creativeDao;
	@Resource
	private IPointRecordService pointRecordService;
	@Resource
	private CacheCleaner authRealm;
	
	@Override
	public Response pay(Creative creative) {
		if (StringUtils.isEmpty(creative.getId()) || Collections3.isEmpty(creative.getResources()) || StringUtils.isEmpty(creative.getResources().get(0).getId())) {
			return Response.failInstance();
		}
		
		String resourceId = creative.getResources().get(0).getId();
		
		Subject currentUser = SecurityUtils.getSubject();
		if (currentUser.hasRole("creative_resource_" + resourceId)) {
			return Response.successInstance();
		}
		
		creative = creativeDao.selectCreativeById(creative.getId());
		
		float score = pointRecordService.findUserPoint(ThreadContext.getUser().getId(),"tpdpor","tpdpor");
		float payScore = 0f;
		
		PointRecord pointRecord = new PointRecord();
		String pointType = null;
		if (CreativeState.EXCELLENT.equals(creative.getState())) {
			pointType = PointType.DOWNLOAD_CREATIVE_RESOURCE_20;
			payScore = 20f;
		}else {
			pointType = PointType.DOWNLOAD_CREATIVE_RESOURCE_10;
			payScore = 10f;
		}
		if (score < payScore) {
			return Response.failInstance();
		}
		pointRecord.setPointStrategy(PointStrategy.getMd5IdInstance(pointType, "tpdpor"));
		pointRecord.setUserId(ThreadContext.getUser().getId());
		pointRecord.setRelationId("tpdpor");
		pointRecord.setEntityId(resourceId);
		
		Response response = pointRecordService.createPointRecord(pointRecord, false);
		
		if ("00".equals(response.getResponseCode())) {
			authRealm.clearUserCacheById(ThreadContext.getUser().getId());
		}
		
		return response;
	}

	
}
