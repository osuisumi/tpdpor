package com.haoyu.tpdpor.courseresource.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.point.entity.PointRecord;
import com.haoyu.sip.point.entity.PointStrategy;
import com.haoyu.sip.point.service.IPointRecordService;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tip.resource.service.IResourceService;
import com.haoyu.tip.resource.utils.ResourceType;
import com.haoyu.tpdpor.courseresource.utils.CourseResourcePointStrategyType;

@Service
public class CourseResourceService {
	@Resource
	private IResourceService resourceService;
	@Resource
	private IPointRecordService pointRecordService;
	
	public Response createPayRecord(String resourceId){
		Resources resource = resourceService.get(resourceId);
		Map<String,Object> parameter = Maps.newHashMap();
		parameter.put("userId", ThreadContext.getUser().getId());
		parameter.put("entityId", resource.getId());
		List<PointRecord> records = pointRecordService.findPointRecords(parameter, null);
		if(CollectionUtils.isEmpty(records)){
			//下载者扣除积分
			PointRecord payRecord = new PointRecord();
			payRecord.setPointStrategy(new PointStrategy(PointStrategy.getId(CourseResourcePointStrategyType.payType(resource.getResourceExtend().getPrice()), "tpdpor")));
			payRecord.setUserId(ThreadContext.getUser().getId());
			payRecord.setRelationId("tpdpor");
			payRecord.setEntityId(resource.getId());
			Response response = pointRecordService.createPointRecord(payRecord);

			//资源创建者获得积分
			if(response.isSuccess()){
				PointRecord acceptRecord = new PointRecord();
				acceptRecord.setPointStrategy(new PointStrategy(PointStrategy.getId(CourseResourcePointStrategyType.acceptType(resource.getResourceExtend().getPrice()), "tpdpor")));
				acceptRecord.setUserId(resource.getCreator().getId());
				acceptRecord.setRelationId("tpdpor");
				acceptRecord.setEntityId(resource.getId());
				response = pointRecordService.createPointRecord(acceptRecord);
			}
			return response;
		}else{
			return Response.successInstance();
		}
	}
	
	
	public List<Resources> intrestList(Resources refer){
		//匹配次序：年级学科》类型》创建者
		Map<String,Object> parameter = Maps.newHashMap();
		parameter.put("type", com.haoyu.tpdpor.utils.ResourceType.COURSE);
		List<Resources> intrests = Lists.newArrayList();
		if(refer.getResourceExtend()!=null){
			if(StringUtils.isNotEmpty(refer.getResourceExtend().getStage())||StringUtils.isNotEmpty(refer.getResourceExtend().getSubject())){
				if(StringUtils.isNotEmpty(refer.getResourceExtend().getStage())){
					parameter.put("stage", refer.getResourceExtend().getStage());
				}
				if(StringUtils.isNotEmpty(refer.getResourceExtend().getSubject())){
					parameter.put("subject", refer.getResourceExtend().getSubject());
				}
			}else if(StringUtils.isNotEmpty(refer.getResourceExtend().getType())){
				parameter.put("extendType", refer.getResourceExtend().getType());
			}else{
				parameter.put("creator",refer.getCreator().getId());
			}
		}
		intrests = resourceService.list(parameter,new PageBounds(1, 5));
		if(CollectionUtils.isEmpty(intrests)){
			parameter.clear();
			parameter.put("type",com.haoyu.tpdpor.utils.ResourceType.COURSE );
			intrests = resourceService.list(Maps.newHashMap(),new PageBounds(1,5));
		}
		return intrests;
	}

}
