package com.haoyu.tpdpor.trainresource.service.impl;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.sip.core.entity.Relation;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.file.service.IFileService;
import com.haoyu.sip.utils.Identities;
import com.haoyu.tip.resource.entity.ResourceRelation;
import com.haoyu.tip.resource.service.IResourceService;
import com.haoyu.tip.train.service.ITrainService;
import com.haoyu.tpdpor.trainresource.dao.ITrainResourceDao;
import com.haoyu.tpdpor.trainresource.entity.TrainResource;
import com.haoyu.tpdpor.trainresource.event.BatchDeleteTrainResourceEvent;
import com.haoyu.tpdpor.trainresource.service.ITrainResourceService;

@Service
public class TrainResourceService implements ITrainResourceService{

	@Resource
	private ITrainResourceDao trainResourceDao;
	@Resource
	private IFileService fileService;
	@Resource
	private ITrainService trainService;
	@Resource
	private IResourceService resourceService;
	@Resource
	private ApplicationContext applicationContext;
	
	@Override
	public List<TrainResource> findTrainResources(Map<String, Object> parameter, PageBounds pageBounds) {
		return trainResourceDao.findAll(parameter, pageBounds);
	}

	@Override
	public TrainResource findById(String id,boolean getFile) {
		TrainResource trainResource = trainResourceDao.selectByPrimaryKey(id);
		if (getFile) {
			if (trainResource.getResource() != null) {
				trainResource.getResource().setFileInfos(fileService.listFileInfoByRelation(new Relation(trainResource.getResource().getId(), "resources")));
			}
		}
		return trainResource;
	}

	@Override
	public Response batchDeleteTrainResource(TrainResource trainResource) {
		Response response = Response.failInstance();
		if (trainResource == null && trainResource.getResource() == null || StringUtils.isEmpty(trainResource.getResource().getId())) {
			return Response.failInstance();
		}
		Map<String, Object> param = Maps.newHashMap();
		if (trainResource.getResource() != null && StringUtils.isNotEmpty(trainResource.getResource().getId())) {
			param.put("ids",Arrays.asList(trainResource.getResource().getId().split(",")));
		}
		param.put("updateTime",System.currentTimeMillis());
		param.put("updatedbyId", ThreadContext.getUser().getId());
		int count = trainResourceDao.batchDeleteTrainResource(param);
		return count > 0 ? response.successInstance() : response.failInstance();
	}

	@Override
	public Response createTrainResource(TrainResource trainResource) {
		Response response = Response.failInstance();
		
		if (trainResource.getTrain() != null) {
			if(StringUtils.isEmpty(trainResource.getTrain().getId())){
				trainResource.getTrain().setId(Identities.uuid2());
			}
			trainResource.getTrain().setDefaultValue();
			response = trainService.createTrain(trainResource.getTrain());
			
			if ("00".equals(response.getResponseCode())) {
				if (trainResource.getResource() != null) {
					ResourceRelation resourceRelation = new ResourceRelation();
					Relation relation = new Relation(trainResource.getTrain().getId(),"train_resource");
					resourceRelation.setRelation(relation);
					trainResource.getResource().setResourceRelations(Lists.newArrayList(resourceRelation));
					
					resourceService.createResource(trainResource.getResource());
				}
			}
		}
		return response;
	}

	@Override
	public Response updateTrainResource(TrainResource trainResource) {
		Response response = Response.failInstance();
		if (trainResource.getTrain() != null && StringUtils.isNotEmpty(trainResource.getTrain().getId())) {
			response = trainService.updateTrain(trainResource.getTrain());
		}	
		if (response.isSuccess() && trainResource.getResource() != null && StringUtils.isNotEmpty(trainResource.getResource().getId())) {
			if (trainResource.getResource().getResourceExtend() != null) {
				trainResource.getResource().getResourceExtend().setResourceId(trainResource.getResource().getId());
			}
			response = resourceService.updateResource(trainResource.getResource());	
		}	
		return response;
	}

	@Override
	public int getApplyNum(Map<String, Object> param) {
		return trainResourceDao.getApplyNum(param);
	}

}
