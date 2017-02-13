package com.haoyu.tpdpor.trainresource.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.tpdpor.trainresource.entity.TrainResourceUser;

public interface ITrainResourceUserDao {
	
	List<TrainResourceUser> findAll(Map<String, Object> parameter, PageBounds pageBounds);

	TrainResourceUser selectByPrimaryKey(String id);

}
