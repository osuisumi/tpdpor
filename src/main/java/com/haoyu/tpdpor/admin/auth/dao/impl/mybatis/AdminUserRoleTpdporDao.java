package com.haoyu.tpdpor.admin.auth.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.google.common.collect.Maps;
import com.haoyu.sip.auth.entity.AuthRole;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.tpdpor.admin.auth.dao.IAdminUserRoleTpdporDao;

@Repository
public class AdminUserRoleTpdporDao extends MybatisDao implements IAdminUserRoleTpdporDao{

	@Override
	public int insertRoleUser(AuthRole authRole, List<String> userIds, String relationId) {
		Map<String,Object> param = Maps.newHashMap();
		if(authRole != null && authRole.getId() !=null && userIds !=null && !userIds.isEmpty()){
			param.put("role", authRole);
			param.put("userIds",userIds);
			param.put("relationId",relationId);
			return super.insert("insertByRoleUsers", param);
		}
		return 0;
	}

}
