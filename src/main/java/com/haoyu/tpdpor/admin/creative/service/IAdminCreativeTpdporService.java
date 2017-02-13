package com.haoyu.tpdpor.admin.creative.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.core.service.Response;
import com.haoyu.tip.creative.entity.Creative;
import com.haoyu.tpdpor.admin.creative.entity.CreativeTypeParam;

public interface IAdminCreativeTpdporService {

	List<CreativeTypeParam> findCreativeTypeParams(Map<String, Object> param,PageBounds pageBounds);

	Response batchExcellentState(Creative creative);

	Response updateCreativeType(String type, String name);

}
