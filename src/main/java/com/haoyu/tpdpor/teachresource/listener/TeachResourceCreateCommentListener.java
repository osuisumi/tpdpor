package com.haoyu.tpdpor.teachresource.listener;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.google.common.collect.Maps;
import com.haoyu.sip.comment.entity.Comment;
import com.haoyu.sip.comment.event.CreateCommentEvent;
import com.haoyu.sip.excel.utils.StringUtils;
import com.haoyu.tpdpor.resource.service.IResourceBizService;

//@Component
public class TeachResourceCreateCommentListener implements ApplicationListener<CreateCommentEvent>{
	@Resource
	private IResourceBizService resourceBizService;

	@Override
	public void onApplicationEvent(CreateCommentEvent event) {
		Comment comment = (Comment) event.getSource();
		if(comment!=null && comment.getRelation()!=null &&comment.getRelation().getType()!=null && "teach_resource_evaluate".equals(comment.getRelation().getType())){
			if(StringUtils.isNotEmpty(comment.getRelation().getId())){
				String resourceId = comment.getRelation().getId();
				Map<String,Object> parameter = Maps.newHashMap();
				parameter.put("resourceId", resourceId);
				resourceBizService.updateResourceExtendEvaluateResult(parameter);
			}
		}
		
	}

}
