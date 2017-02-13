package com.haoyu.tpdpor.trainresource.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.tpdpor.trainresource.dao.ITrainResourceDao;
import com.haoyu.tpdpor.trainresource.entity.TrainResource;

@Repository
public class TrainResourceDao extends MybatisDao implements ITrainResourceDao{

	@Override
	public List<TrainResource> findAll(Map<String, Object> parameter, PageBounds pageBounds) {
		return super.selectList("selectByParameter", parameter, pageBounds);
	}

	@Override
	public TrainResource selectByPrimaryKey(String id) {
		return super.selectByPrimaryKey(id);
	}

	@Override
	public int batchDeleteTrainResource(Map<String, Object> param) {
		return super.update("batchDelete",param);
	}

	@Override
	public int getApplyNum(Map<String, Object> param) {
		return super.selectOne("applyNumByParameter",param);
	}

}
