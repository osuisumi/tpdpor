package com.haoyu.tpdpor.admin.creative.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.google.common.collect.Maps;
import com.haoyu.sip.auth.realm.CacheCleaner;
import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.sip.utils.Identities;
import com.haoyu.tip.creative.entity.Creative;
import com.haoyu.tip.creative.entity.CreativeUser;
import com.haoyu.tip.creative.service.ICreativeUserService;
import com.haoyu.tip.creative.utils.CreativeUserRole;
import com.haoyu.tpdpor.admin.creative.service.IAdminCreativeUserTpdporService;

@Service
public class AdminCreativeUserTpdporServiceImpl implements IAdminCreativeUserTpdporService{

	@Resource
	private ICreativeUserService creativeUserService ;
	@Resource
	private CacheCleaner authRealm;
	
	@Override
	public Response updateTypeManagerAndExpert(String type,String typeManagerUserId,String expertUserId) {
		if (StringUtils.isNotEmpty(type)) {
			if (StringUtils.isNotEmpty(typeManagerUserId)) {				
				CreativeUser typeManager = new CreativeUser();
				Map<String, Object> param = Maps.newHashMap();
				param.put("creativeId", type);
				param.put("role", CreativeUserRole.MANAGER);
				List<CreativeUser> typeManagers = creativeUserService.findCreativeUsers(param, null);
				if (Collections3.isNotEmpty(typeManagers) && typeManagers.get(0) != null ) {
					typeManager = typeManagers.get(0);
					if (type.equals(typeManager.getCreative().getId()) && typeManagerUserId.equals(typeManager.getUser().getId())) {
						
					}else{
						creativeUserService.deleteCreativeUser(typeManagers.get(0));
						typeManager.setId(Identities.uuid2());
						typeManager.setCreative(new Creative(type));
						typeManager.setUser(new User(typeManagerUserId));
						typeManager.setRole(CreativeUserRole.MANAGER);
						creativeUserService.createCreativeUser(typeManager);
					}
				}else{
					typeManager.setId(Identities.uuid2());
					typeManager.setCreative(new Creative(type));
					typeManager.setUser(new User(typeManagerUserId));
					typeManager.setRole(CreativeUserRole.MANAGER);
					creativeUserService.createCreativeUser(typeManager);
				}
			}
			if (StringUtils.isNotEmpty(expertUserId)) {
				CreativeUser expert = new CreativeUser();
				Map<String, Object> param = Maps.newHashMap();
				param.put("creativeId", type);
				param.put("role", CreativeUserRole.EXPERT);
				List<CreativeUser> experts = creativeUserService.findCreativeUsers(param, null);
				if (Collections3.isNotEmpty(experts) && experts.get(0) != null ) {
					expert = experts.get(0);
					if (type.equals(expert.getCreative().getId()) && expertUserId.equals(expert.getUser().getId())) {
						
					}else {
						creativeUserService.deleteCreativeUser(experts.get(0));
						expert.setId(Identities.uuid2());
						expert.setCreative(new Creative(type));
						expert.setUser(new User(expertUserId));
						expert.setRole(CreativeUserRole.EXPERT);
						creativeUserService.createCreativeUser(expert);
					}
				}else {				
					expert.setId(Identities.uuid2());
					expert.setCreative(new Creative(type));
					expert.setUser(new User(expertUserId));
					expert.setRole(CreativeUserRole.EXPERT);
					creativeUserService.createCreativeUser(expert);
				}
			}
		}
		authRealm.clearUserCacheById(ThreadContext.getUser().getId());
		
		return Response.successInstance();
	}

}
