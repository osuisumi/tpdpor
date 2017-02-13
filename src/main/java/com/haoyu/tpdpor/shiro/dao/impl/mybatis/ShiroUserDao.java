package com.haoyu.tpdpor.shiro.dao.impl.mybatis;



import java.util.List;
import java.util.Map;

import com.haoyu.sip.auth.entity.AuthUser;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.tpdpor.shiro.dao.IShiroUserDao;
import com.haoyu.tpdpor.shiro.entity.Loginer;
import com.haoyu.tpdpor.shiro.entity.ShiroUser;

public class ShiroUserDao extends MybatisDao implements IShiroUserDao{

	@Override
	public ShiroUser selectByUserName(String username) {
		return this.selectOne("selectByUserName",username);
	}

	@Override
	public List<AuthUser> selectAuthUser(Map<String, Object> param) {
		return this.selectList("selectAuthUser", param);
	}

	@Override
	public Loginer getLoginer(Loginer loginer) {
		return (Loginer)selectOne("getLoginer", loginer);
	}

}
