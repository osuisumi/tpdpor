package com.haoyu.tpdpor.shiro.service;



import java.util.List;

import com.haoyu.sip.auth.entity.AuthUser;
import com.haoyu.tpdpor.shiro.entity.Loginer;
import com.haoyu.tpdpor.shiro.entity.ShiroUser;

public interface IShiroUserService {

	ShiroUser queryShiroUserByUserName(String userName);

	AuthUser findAuthUserByUsername(String username);

	AuthUser findAuthUserById(String id);

	List<AuthUser> findAuthUserByIds(List<String> ids);
	
	Loginer getLoginer(Loginer loginer);

}
