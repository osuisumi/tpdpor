package com.haoyu.tpdpor.admin.creative.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.tpdpor.admin.creative.dao.IAdminCreativeTpdporDao;
import com.haoyu.tpdpor.admin.creative.entity.CreativeTypeParam;

@Repository
public class AdminCreativeTpdporDao extends MybatisDao implements IAdminCreativeTpdporDao{

	@Override
	public List<CreativeTypeParam> selectCreativeTypeParams(Map<String, Object> param, PageBounds pageBounds) {
		return super.selectList("selectCreativeTypeParamsByParameter", param, pageBounds);
	}

}
