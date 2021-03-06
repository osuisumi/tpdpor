package com.haoyu.tpdpor.creative.listener;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.sip.attitude.entity.AttitudeUser;
import com.haoyu.sip.attitude.service.IAttitudeService;
import com.haoyu.sip.comment.entity.Comment;
import com.haoyu.sip.comment.service.ICommentService;
import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.message.entity.Message;
import com.haoyu.sip.message.service.IMessageService;
import com.haoyu.sip.message.utils.MessageType;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.tip.creative.entity.Creative;
import com.haoyu.tip.creative.service.ICreativeService;
import com.haoyu.tip.creative.service.impl.CreativeService;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tip.resource.event.CreateResourceEvent;

@Component
public class CreateCreativeResourceListener implements ApplicationListener<CreateResourceEvent>{

	@Resource
	private IMessageService messageService;
	@Resource
	private IAttitudeService attitudeService;
	@Resource
	private ICommentService commentService;
	@Resource
	private ICreativeService creativeService;
	
	
	@Override
	public void onApplicationEvent(CreateResourceEvent event) {
		Resources resource = (Resources) event.getSource();
		if (resource != null && Collections3.isNotEmpty(resource.getResourceRelations()) 
				&& resource.getResourceRelations().get(0) != null && resource.getResourceRelations().get(0).getRelation() != null
				&& StringUtils.isNotEmpty(resource.getResourceRelations().get(0).getRelation().getId())) {
			
			String creativeId = resource.getResourceRelations().get(0).getRelation().getId();
			
			Creative creative = creativeService.findCreativeById(creativeId);
			
			//获取参与人（点赞和评论）
			List<String> receiverIds = Lists.newArrayList();
			
			Map<String, Object> param = Maps.newHashMap();
			param.put("attitude","support");
			param.put("relationType","creative");
			param.put("relationIds",Lists.newArrayList(creativeId));
			
			List<AttitudeUser> attitudeUsers = attitudeService.findAttitudeUserByParameter(param, null);
			
			if (Collections3.isNotEmpty(attitudeUsers)) {
				receiverIds = Collections3.extractToList(attitudeUsers, "creator.id");
			}
			
			param = Maps.newHashMap();
			param.put("relationId",creativeId);
			param.put("relationType","creative_advice");
			
			List<Comment> advices = commentService.list(param, null);
			
			if (Collections3.isNotEmpty(advices)) {
				List<String> adviceUserId = Collections3.extractToList(advices, "creator.id");
				
				receiverIds = Collections3.intersection(receiverIds, adviceUserId);
			}
			
			if (Collections3.isNotEmpty(receiverIds)) {
				Message message = new Message();
				message.setSender(new User(this.getClass().getName()));
				message.setType(MessageType.SYSTEM_MESSAGE);
				message.setContent("前去参与创客吧--><a target='_blank' href='creative/"+creative.getId()+"/view'>"+creative.getTitle()+"</a>");
				message.setTitle("您所参与的创客("+creative.getTitle()+")有资源更新啦!");
				messageService.sendMessageToUsers(message, receiverIds);
			}
			
		}
	}

}
