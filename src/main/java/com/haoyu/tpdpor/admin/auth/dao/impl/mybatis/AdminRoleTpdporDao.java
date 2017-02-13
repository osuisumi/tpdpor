package com.haoyu.tpdpor.admin.auth.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.auth.entity.AuthRole;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.tpdpor.admin.auth.dao.IAdminRoleTpdporDao;

@Repository
public class AdminRoleTpdporDao extends MybatisDao implements IAdminRoleTpdporDao{

	@Override
	public List<AuthRole> findAll(Map<String, Object> parameter, PageBounds pageBounds) {
		return super.selectList("selectByParameter", parameter, pageBounds);
	}
	
	
	
}
