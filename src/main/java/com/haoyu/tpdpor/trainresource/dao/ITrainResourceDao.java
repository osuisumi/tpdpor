package com.haoyu.tpdpor.trainresource.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.tpdpor.trainresource.entity.TrainResource;

public interface ITrainResourceDao {

	List<TrainResource> findAll(Map<String, Object> parameter, PageBounds pageBounds);

	TrainResource selectByPrimaryKey(String id);

	int batchDeleteTrainResource(Map<String, Object> parameter);

	int getApplyNum(Map<String, Object> param);

}
