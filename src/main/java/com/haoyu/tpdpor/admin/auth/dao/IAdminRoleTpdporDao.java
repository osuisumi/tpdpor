package com.haoyu.tpdpor.admin.auth.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.auth.entity.AuthRole;

public interface IAdminRoleTpdporDao {

	List<AuthRole> findAll(Map<String, Object> parameter, PageBounds pageBounds);
}
