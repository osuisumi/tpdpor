package com.haoyu.tpdpor.courseresource.listener;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.haoyu.sip.attitude.entity.AttitudeUser;
import com.haoyu.sip.attitude.event.CreateAttitudeUserEvent;
import com.haoyu.tip.resource.entity.ResourceRelation;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tip.resource.service.IResourceRelationService;
import com.haoyu.tip.resource.service.IResourceService;

@Component
public class CourseResourceSupportListener implements ApplicationListener<CreateAttitudeUserEvent>{
	@Resource
	private IResourceService resourceService;
	@Resource
	private IResourceRelationService resourceRelationService;
	
	@Override
	public void onApplicationEvent(CreateAttitudeUserEvent event) {
		AttitudeUser attitudeUser = (AttitudeUser) event.getSource();
		if(attitudeUser.getRelation()!=null && StringUtils.isNotEmpty(attitudeUser.getRelation().getType()) && "course_resource".equals(attitudeUser.getRelation().getType())){
			String resourceId = attitudeUser.getRelation().getId();
			if(StringUtils.isNotEmpty(resourceId)){
				Resources resource = resourceService.get(resourceId);
				if(resource!=null && CollectionUtils.isNotEmpty(resource.getResourceRelations())){
					ResourceRelation resourceRelation = new ResourceRelation();
					resourceRelation.setId(resource.getResourceRelations().get(0).getId());
					resourceRelation.setSupportNum(1);
					resourceRelationService.update(resourceRelation);
				}
			}
		}
	}

}
