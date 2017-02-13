package com.haoyu.tpdpor.statistics.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.tpdpor.statistics.dao.IResourceStatisticsDao;
import com.haoyu.tpdpor.statistics.entity.ResourceStatistics;

@Repository
public class ResourceStatisticsDao extends MybatisDao implements IResourceStatisticsDao{

	@Override
	public List<ResourceStatistics> findAll(Map<String, Object> param, PageBounds pageBounds) {
		return super.selectList("selectByParameter", param, pageBounds);
	}

}
