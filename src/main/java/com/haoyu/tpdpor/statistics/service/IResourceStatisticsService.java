package com.haoyu.tpdpor.statistics.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.tpdpor.statistics.entity.ResourceStatistics;

public interface IResourceStatisticsService {

	List<ResourceStatistics> findStatistics(Map<String, Object> parameter,PageBounds pageBounds);
}
