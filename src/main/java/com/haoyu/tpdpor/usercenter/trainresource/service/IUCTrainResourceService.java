package com.haoyu.tpdpor.usercenter.trainresource.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.tpdpor.trainresource.entity.TrainResource;

public interface IUCTrainResourceService {

	List<TrainResource> findTrainResource(Map<String, Object> parameters, PageBounds pageBounds);

	int getCount(Map<String, Object> params);

}
