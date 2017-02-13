package com.haoyu.tpdpor.shiro.handler;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.sip.auth.realm.IAuthRealmHandler;
import com.haoyu.sip.point.entity.PointRecord;
import com.haoyu.sip.point.service.IPointRecordService;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.tip.creative.entity.CreativeUser;
import com.haoyu.tip.creative.service.ICreativeUserService;
import com.haoyu.tip.creative.utils.CreativeType;
import com.haoyu.tip.creative.utils.CreativeUserRole;
import com.haoyu.tpdpor.point.utils.PointType;
import com.haoyu.tpdpor.utils.RoleCodeConstant;

public class CreativeHandler implements IAuthRealmHandler{

	@Resource
	private IPointRecordService pointRecordService;
	@Resource
	private ICreativeUserService creativeUserService;
	
	@Override
	public void addAuthorize(SimpleAuthorizationInfo info, PrincipalCollection principals) {
		Subject subject = SecurityUtils.getSubject();
		List<Object> listPrincipals = subject.getPrincipals().asList();
		Map<String, String> attributes = (Map<String, String>) listPrincipals.get(1);
		String userId = attributes.get("id");
		
		Map<String, Object> param = Maps.newHashMap();
		param.put("userId",userId);
		
		//创客角色授权
		List<CreativeUser> creativeUsers = creativeUserService.findCreativeUsers(param, null);
		if (Collections3.isNotEmpty(creativeUsers)) {
			for (CreativeUser cu : creativeUsers) {
				if (CreativeType.INNOVATE.equals(cu.getCreative().getId()) || CreativeType.STUDY.equals(cu.getCreative().getId()) || CreativeType.TEACH.equals(cu.getCreative().getId())) {
					if (CreativeUserRole.MANAGER.equals(cu.getRole())) {						
						info.addRole(RoleCodeConstant.CREATIVE_TYPE_MANAGER + "_" + cu.getCreative().getId());
					}
					if (CreativeUserRole.EXPERT.equals(cu.getRole())) {
						info.addRole(RoleCodeConstant.CREATIVE_TYPE_EXPERT + "_" + cu.getCreative().getId());
					}
				}else {					
					info.addRole(RoleCodeConstant.CREATIVE_MANAGER + "_" + cu.getCreative().getId());
				}
			}
		}
		
		//为已支付积分的创客资源授权
		param = Maps.newHashMap();
		param.put("userId",userId);
		param.put("pointStrategyRelationId", "tpdpor");
		param.put("pointStrategyTypes",Lists.newArrayList(PointType.DOWNLOAD_CREATIVE_RESOURCE_10,PointType.DOWNLOAD_CREATIVE_RESOURCE_20));
    	
    	List<PointRecord> pointRecords= pointRecordService.findPointRecords(param, null);
		
    	if (Collections3.isNotEmpty(pointRecords)) {
			for (PointRecord pointRecord : pointRecords) {
				info.addRole("creative_resource_" + pointRecord.getEntityId());
			}
		}
	}

}
