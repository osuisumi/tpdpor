package com.haoyu.tpdpor.trainresource.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.tpdpor.trainresource.entity.TrainResourceUser;

public interface ITrainResourceUserService {
	
	List<TrainResourceUser> findTrainResourceUsers(Map<String,Object> parameter,PageBounds pageBounds);

	TrainResourceUser findTrainResourceUserById(String id);

}
