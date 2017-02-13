package com.haoyu.tpdpor.usercenter.trainresource.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.tpdpor.trainresource.entity.TrainResource;
import com.haoyu.tpdpor.usercenter.trainresource.dao.IUCTrainResourceDao;
import com.haoyu.tpdpor.usercenter.trainresource.service.IUCTrainResourceService;

@Service
public class UCTrainResourceService implements IUCTrainResourceService{

	@Resource
	private IUCTrainResourceDao ucTrainResourceDao;
	
	@Override
	public List<TrainResource> findTrainResource(Map<String, Object> parameters, PageBounds pageBounds) {
		return ucTrainResourceDao.findTrainResource(parameters,pageBounds);
	}

	@Override
	public int getCount(Map<String, Object> params) {
		return ucTrainResourceDao.getCount(params);
	}

}
