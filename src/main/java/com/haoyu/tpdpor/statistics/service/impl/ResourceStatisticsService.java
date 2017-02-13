package com.haoyu.tpdpor.statistics.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.tpdpor.statistics.dao.IResourceStatisticsDao;
import com.haoyu.tpdpor.statistics.entity.ResourceStatistics;
import com.haoyu.tpdpor.statistics.service.IResourceStatisticsService;

@Service
public class ResourceStatisticsService implements IResourceStatisticsService{

	@Resource
	private IResourceStatisticsDao resourceStatisticsDao;
	
	public List<ResourceStatistics> findStatistics(Map<String,Object> param, PageBounds pageBounds) {
		return resourceStatisticsDao.findAll(param,pageBounds);
	}
}
