package com.haoyu.tpdpor.controller;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.sip.auth.entity.AuthMenu;
import com.haoyu.sip.auth.realm.CacheCleaner;
import com.haoyu.sip.auth.service.IAuthMenuService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;
import com.haoyu.tpdpor.shiro.entity.Loginer;
import com.haoyu.tpdpor.shiro.service.IShiroUserService;

@Controller
@RequestMapping("tpdpor")
public class TpdporController extends AbstractBaseController{
	@Resource
	private IShiroUserService shiroUserService;
	@Resource
	private CacheCleaner authRealm;
	@Resource
	private IAuthMenuService authMenuService;
	
	private String getLogicViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getPath("");
	}
	
	@RequestMapping(value="index",method=RequestMethod.GET)
	public String index(){
		return getLogicViewNamePerfix() + "index";
	}
	
	@RequestMapping(value="login",method=RequestMethod.GET)
	public String loginUI(Model model){
		setParameterToModel(request, model);
		return getLogicViewNamePerfix() + "login";
	}
	
	@RequestMapping(value="login",method=RequestMethod.POST)
	@ResponseBody
	public Response login(Loginer loginer){
		try {
			String password = loginer.getPassword();
			Subject currentUser = SecurityUtils.getSubject();
			if (!currentUser.isAuthenticated()) {
				currentUser.logout();
			}
			UsernamePasswordToken upt = new UsernamePasswordToken(loginer.getUserName(), loginer.getPassword());
			upt.setRememberMe(false);
			currentUser.login(upt);
			loginer = shiroUserService.getLoginer(loginer);
			if (loginer != null) {
				String userName  = (String) currentUser.getPrincipal();
				loginer.setUserName(userName);
				loginer.setPassword(password);
				request.getSession().setAttribute("loginer", loginer);
				Map<String,Object> parameter = Maps.newHashMap();
				parameter.put("userId", loginer.getId());
				List<AuthMenu> authMenus =authMenuService.findMenu(parameter, true);
				if(CollectionUtils.isNotEmpty(authMenus)){
					SecurityUtils.getSubject().getSession().setAttribute("hasMenu",true);
				}
				authRealm.clearUserCacheByIds(Lists.newArrayList(loginer.getId()));
				return Response.successInstance();
			}else{
				return Response.failInstance().responseMsg("用户名或密码错误");
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return Response.failInstance().responseMsg("用户名或密码错误");
		}
	}

}
