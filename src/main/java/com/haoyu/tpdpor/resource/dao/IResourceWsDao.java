package com.haoyu.tpdpor.resource.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.tpdpor.resource.entity.ResourceWs;

public interface IResourceWsDao {
	
	public int count(Map<String,Object> parameter);
	
	public List<ResourceWs> list(Map<String,Object> parameter,PageBounds pageBounds);

}
