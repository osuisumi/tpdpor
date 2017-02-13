package com.haoyu.tpdpor.usercenter.trainresource.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.tpdpor.trainresource.entity.TrainResource;
import com.haoyu.tpdpor.usercenter.trainresource.dao.IUCTrainResourceDao;

@Repository
public class UCTrainResourceDao extends MybatisDao implements IUCTrainResourceDao{

	@Override
	public List<TrainResource> findTrainResource(Map<String, Object> parameters, PageBounds pageBounds) {
		return super.selectList("selectByParameter", parameters, pageBounds);
	}

	@Override
	public int getCount(Map<String, Object> params) {
		return selectOne("getCount", params);
	}

}
