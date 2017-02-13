package com.haoyu.tpdpor.trainresource.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.tpdpor.trainresource.dao.ITrainResourceUserDao;
import com.haoyu.tpdpor.trainresource.entity.TrainResourceUser;
import com.haoyu.tpdpor.trainresource.service.ITrainResourceUserService;

@Service
public class TrainResourceUserService implements ITrainResourceUserService{

	@Resource
	private ITrainResourceUserDao trainResourceUserDao;

	@Override
	public List<TrainResourceUser> findTrainResourceUsers(Map<String, Object> parameter, PageBounds pageBounds) {
		return trainResourceUserDao.findAll(parameter,pageBounds);
	}

	@Override
	public TrainResourceUser findTrainResourceUserById(String id) {
		return trainResourceUserDao.selectByPrimaryKey(id);
	}
	
}
