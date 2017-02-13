package com.haoyu.tpdpor.resource.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.tpdpor.resource.dao.IResourceWsDao;
import com.haoyu.tpdpor.resource.entity.ResourceWs;

@Repository
public class ResourceWsDao extends MybatisDao implements IResourceWsDao{

	@Override
	public int count(Map<String,Object> parameter) {
		return super.selectOne("count", parameter);
	}

	@Override
	public List<ResourceWs> list(Map<String, Object> parameter, PageBounds pageBounds) {
		return super.selectList("select", parameter, pageBounds);
	}
	

}
