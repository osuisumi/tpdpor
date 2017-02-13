package com.haoyu.tpdpor.point.listener;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.haoyu.sip.point.entity.PointRecord;
import com.haoyu.sip.point.entity.PointStrategy;
import com.haoyu.sip.point.service.IPointRecordService;
import com.haoyu.tip.creative.entity.Creative;
import com.haoyu.tip.creative.event.UpdateCreativeEvent;
import com.haoyu.tip.creative.utils.CreativeState;
import com.haoyu.tpdpor.point.utils.PointType;

@Component
public class UpdateCreativeStateForPointListener implements ApplicationListener<UpdateCreativeEvent>{

	@Resource
	private IPointRecordService pointRecordService;
	
	@Override
	public void onApplicationEvent(UpdateCreativeEvent event) {
		Creative creative = (Creative) event.getSource();
		
		if (CreativeState.EXCELLENT.equals(creative.getState())) {			
			PointRecord pointRecord = new PointRecord();
			pointRecord.setPointStrategy(PointStrategy.getMd5IdInstance(PointType.SET_CREATIVE_EXCELLENT, "tpdpor"));
			pointRecord.setUserId(creative.getCreator().getId());
			pointRecord.setRelationId("tpdpor");
			pointRecord.setEntityId(creative.getId());
			pointRecordService.createPointRecord(pointRecord, false);
		}
	}

}
