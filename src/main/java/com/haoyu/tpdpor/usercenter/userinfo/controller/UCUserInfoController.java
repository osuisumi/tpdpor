package com.haoyu.tpdpor.usercenter.userinfo.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.user.entity.UserInfo;
import com.haoyu.sip.user.service.IUserInfoService;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;
import com.haoyu.tpdpor.shiro.entity.Loginer;
import com.haoyu.tpdpor.shiro.service.IShiroUserService;

@Controller
@RequestMapping("**/userCenter/user_info")
public class UCUserInfoController extends AbstractBaseController{
	@Resource
	private IUserInfoService userInfoService;
	@Resource
	private IShiroUserService shiroUserService;
	
	protected String viewNamePerfix(){
		return TpdporViewNamePerfixUtil.getUserCenterPath("/userinfo/");
	}
	
	@RequestMapping(value="edit_my_user_info",method=RequestMethod.GET)
	public String editUserInfo(Model model){
		setParameterToModel(request, model);
		model.addAttribute("userInfo", userInfoService.selectUserInfoById(ThreadContext.getUser().getId()));
		return viewNamePerfix() + "edit_user_info";
	}
	
	@RequestMapping(value="update",method=RequestMethod.PUT)
	@ResponseBody
	public Response update(UserInfo userInfo){
		Response response = userInfoService.updateUser(userInfo);
		if(response.isSuccess()){
			Loginer old = (Loginer) request.getSession().getAttribute("loginer");
			Loginer loginer = shiroUserService.getLoginer(old);
			request.getSession().setAttribute("loginer", loginer);
		}
		return response;
	}

}
