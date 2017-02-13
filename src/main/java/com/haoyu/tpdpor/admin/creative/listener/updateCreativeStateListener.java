package com.haoyu.tpdpor.admin.creative.listener;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.google.common.collect.Maps;
import com.haoyu.sip.point.entity.PointRecord;
import com.haoyu.sip.point.entity.PointStrategy;
import com.haoyu.sip.point.service.IPointRecordService;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.tip.creative.entity.Creative;
import com.haoyu.tip.creative.entity.CreativeUser;
import com.haoyu.tip.creative.event.UpdateCreativeEvent;
import com.haoyu.tip.creative.service.ICreativeUserService;
import com.haoyu.tip.creative.utils.CreativeState;
import com.haoyu.tip.creative.utils.CreativeUserRole;
import com.haoyu.tpdpor.point.utils.PointType;

@Component
public class updateCreativeStateListener implements ApplicationListener<UpdateCreativeEvent>{

	@Resource
	private IPointRecordService pointRecordService;
	@Resource
	private ICreativeUserService creativeUserService;
	
	@Override
	public void onApplicationEvent(UpdateCreativeEvent event) {
		Creative creative = (Creative) event.getSource();
		if (StringUtils.isNotEmpty(creative.getId())) {
			List<String> creativeIds = Arrays.asList(creative.getId().split(","));
			if (Collections3.isNotEmpty(creativeIds)) {
				Map<String, Object> param = Maps.newHashMap();
				param.put("creativeIds",creativeIds);
				param.put("role",CreativeUserRole.MANAGER);
				
				List<CreativeUser> managers = creativeUserService.findCreativeUsers(param, null);
				
				if (Collections3.isEmpty(managers)) {
					return ;
				}
				if (StringUtils.isEmpty(creative.getState())) {
					return ;
				}else {
					if (CreativeState.EXCELLENT.equals(creative.getState())) {
						for (CreativeUser m : managers) {
							PointRecord pointRecord = new PointRecord();
							pointRecord.setPointStrategy(PointStrategy.getMd5IdInstance(PointType.SET_CREATIVE_EXCELLENT,"tpdpor"));
							pointRecord.setUserId(m.getUser().getId());
							pointRecord.setRelationId("tpdpor");
							pointRecord.setEntityId(m.getCreative().getId());
							pointRecordService.createPointRecord(pointRecord, false);
						}						
					}
					if (CreativeState.NO_EXCELLENT.equals(creative.getState())) {
						for (CreativeUser m : managers) {
							pointRecordService.deletePointRecord(PointStrategy.getId(PointType.SET_CREATIVE_EXCELLENT,"tpdpor"), m.getUser().getId(), "tpdpor", m.getCreative().getId());
						}
					}
				}
			}
		}
	}
}
