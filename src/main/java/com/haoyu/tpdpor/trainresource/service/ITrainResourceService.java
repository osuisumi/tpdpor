package com.haoyu.tpdpor.trainresource.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.core.service.Response;
import com.haoyu.tpdpor.trainresource.entity.TrainResource;

public interface ITrainResourceService {

	List<TrainResource> findTrainResources(Map<String,Object> parameter,PageBounds pageBounds);

	TrainResource findById(String id,boolean getFile);

	Response batchDeleteTrainResource(TrainResource trainResource);
	
	Response createTrainResource(TrainResource trainResource);

	Response updateTrainResource(TrainResource trainResource);

	int getApplyNum(Map<String, Object> param);

}
