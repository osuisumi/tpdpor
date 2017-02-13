package com.haoyu.tpdpor.trainresource.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.tpdpor.trainresource.dao.ITrainResourceUserDao;
import com.haoyu.tpdpor.trainresource.entity.TrainResourceUser;

@Repository
public class TrainResourceUserDao extends MybatisDao implements ITrainResourceUserDao{

	@Override
	public List<TrainResourceUser> findAll(Map<String, Object> parameter, PageBounds pageBounds) {
		return super.selectList("selectByParameter", parameter,pageBounds);
	}

	@Override
	public TrainResourceUser selectByPrimaryKey(String id) {
		return super.selectByPrimaryKey(id);
	}

}
