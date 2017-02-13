package com.haoyu.tpdpor.admin.creative.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.tpdpor.admin.creative.entity.CreativeTypeParam;

public interface IAdminCreativeTpdporDao {

	List<CreativeTypeParam> selectCreativeTypeParams(Map<String, Object> param, PageBounds pageBounds);

}
