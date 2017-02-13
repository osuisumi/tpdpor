package com.haoyu.tpdpor.creative.listener;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.tip.creative.entity.Creative;
import com.haoyu.tip.creative.entity.CreativeUser;
import com.haoyu.tip.creative.event.CreateCreativeEvent;
import com.haoyu.tip.creative.service.ICreativeUserService;
import com.haoyu.tip.creative.utils.CreativeClaimType;
import com.haoyu.tip.creative.utils.CreativeUserRole;

@Component
public class CreateCreativeListener implements ApplicationListener<CreateCreativeEvent>{

	@Resource
	private	ICreativeUserService creativeUserService; 
	
	@Override
	public void onApplicationEvent(CreateCreativeEvent event) {
		Creative creative = (Creative) event.getSource();
		if (StringUtils.isNotEmpty(creative.getId())) {
			if (!CreativeClaimType.CLAIM.equals(creative.getClaimType())) {
				CreativeUser creativeUser = new CreativeUser();
				creativeUser.setCreative(new Creative(creative.getId()));
				creativeUser.setRole(CreativeUserRole.MANAGER);
				creativeUser.setUser(ThreadContext.getUser());
				creativeUserService.createCreativeUser(creativeUser);
			}
		}
	}

}
