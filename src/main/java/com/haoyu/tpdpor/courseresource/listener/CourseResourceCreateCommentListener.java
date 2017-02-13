package com.haoyu.tpdpor.courseresource.listener;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.google.common.collect.Maps;
import com.haoyu.sip.comment.entity.Comment;
import com.haoyu.sip.comment.event.CreateCommentEvent;
import com.haoyu.sip.excel.utils.StringUtils;
import com.haoyu.tip.resource.entity.ResourceRelation;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tip.resource.service.IResourceRelationService;
import com.haoyu.tip.resource.service.IResourceService;
import com.haoyu.tpdpor.resource.service.IResourceBizService;

@Component
public class CourseResourceCreateCommentListener implements ApplicationListener<CreateCommentEvent>{
	@Resource
	private IResourceBizService resourceBizService;
	@Resource
	private IResourceRelationService resourceRelationService;
	@Resource
	private IResourceService resourceService;

	@Override
	public void onApplicationEvent(CreateCommentEvent event) {
		Comment comment = (Comment) event.getSource();
		if(comment!=null && comment.getRelation()!=null &&comment.getRelation().getType()!=null && "course_resource".equals(comment.getRelation().getType())){
			if(StringUtils.isNotEmpty(comment.getRelation().getId())){
				String resourceId = comment.getRelation().getId();
				Map<String,Object> parameter = Maps.newHashMap();
				parameter.put("resourceId", resourceId);
				//resourceBizService.updateResourceExtendEvaluateResult(parameter);
				//更新回复数
				Resources resource = resourceService.get(resourceId);
				if(resource !=  null && CollectionUtils.isNotEmpty(resource.getResourceRelations())){
					ResourceRelation resourceRelation = new ResourceRelation();
					resourceRelation.setReplyNum(1);
					resourceRelation.setId(resource.getResourceRelations().get(0).getId());
					resourceRelationService.update(resourceRelation);
				}
			}
		}
		
	}

}
