package com.haoyu.tpdpor.admin.dict.dao.impl.mybatis;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.haoyu.dict.entity.DictEntry;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.tpdpor.admin.dict.dao.IAdminDictTpdporDao;

@Repository
public class AdminDictTpdporDao extends MybatisDao implements IAdminDictTpdporDao{

	@Override
	public DictEntry get(Map<String, Object> param) {
		return super.selectOne("selectOneByParameter", param);
	}

}
