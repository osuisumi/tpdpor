package com.haoyu.tpdpor.statistics.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.tpdpor.statistics.entity.ResourceStatistics;

public interface IResourceStatisticsDao {

	List<ResourceStatistics> findAll(Map<String, Object> param, PageBounds pageBounds);

}
