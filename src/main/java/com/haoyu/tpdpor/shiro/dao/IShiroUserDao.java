package com.haoyu.tpdpor.shiro.dao;



import java.util.List;
import java.util.Map;

import com.haoyu.sip.auth.entity.AuthUser;
import com.haoyu.tpdpor.shiro.entity.Loginer;
import com.haoyu.tpdpor.shiro.entity.ShiroUser;

public interface IShiroUserDao {

	ShiroUser selectByUserName(String username);

	List<AuthUser> selectAuthUser(Map<String, Object> param);
	
	Loginer getLoginer(Loginer loginer);

}
