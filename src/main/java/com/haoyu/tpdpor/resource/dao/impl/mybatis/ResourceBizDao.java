package com.haoyu.tpdpor.resource.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tpdpor.resource.dao.IResourceBizDao;
import com.haoyu.tpdpor.resource.entity.ResourceTypeCount;

@Repository
public class ResourceBizDao extends MybatisDao implements IResourceBizDao{

	@Override
	public int countResourceByType(String type) {
		return super.selectOne("countByType",type);
	}

	@Override
	public int countCreatorByType(String type) {
		return super.selectOne("countCreatorByType",type);
	}

	@Override
	public Map<String, ResourceTypeCount> resourceCountMap(Map<String,Object> parameter) {
		return super.selectMap("countMap",parameter,"type");
	}

	@Override
	public int updateResourceExtendEvaluateResult(Map<String, Object> parameter) {
		return super.update("updateResourceExtendEvaluateResult", parameter);
	}

	@Override
	public int countResourceByParameter(Map<String, Object> parameter) {
		return super.selectOne("countByParameter", parameter);
	}

	@Override
	public List<Resources> findResource(Map<String, Object> parameter, PageBounds pageBounds) {
		return super.selectList("selectResources", parameter, pageBounds);
	}

}
