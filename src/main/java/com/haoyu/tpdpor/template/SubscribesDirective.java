package com.haoyu.tpdpor.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Component;

import com.google.common.collect.Maps;
import com.haoyu.division.entity.Division;
import com.haoyu.division.service.IDivisionService;
import com.haoyu.expert.entity.Expert;
import com.haoyu.expert.service.IExpertService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.follow.entity.Follow;
import com.haoyu.sip.follow.service.IFollowService;
import com.haoyu.sip.user.entity.UserInfo;
import com.haoyu.sip.user.service.IUserInfoService;
import com.haoyu.sip.utils.Collections3;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class SubscribesDirective extends AbstractTemplateDirectiveModel{
	@Resource
	private IFollowService followService;
	@Resource
	private IExpertService expertService;
	@Resource
	private IDivisionService divisionService;
	@Resource
	private IUserInfoService userInfoService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		List<Follow> followExperts = followService.findFollowByUserAndFolloweds(ThreadContext.getUser().getId(), null, "expert", null);
		List<Follow> followDivisions = followService.findFollowByUserAndFolloweds(ThreadContext.getUser().getId(), null,"division",null);
		
		if(CollectionUtils.isNotEmpty(followExperts)){
			List<String> userIds = Collections3.extractToList(followExperts, "followEntity.id");
			Map<String,Object> sp = Maps.newHashMap();
			sp.put("ids",userIds );
			List<UserInfo> experts = userInfoService.listUser(sp, null);
			env.setVariable("experts", new DefaultObjectWrapper().wrap(experts));
		}
		
		if(CollectionUtils.isNotEmpty(followDivisions)){
			List<String> divisionIds = Collections3.extractToList(followDivisions, "followEntity.id");
			Map<String,Object> sp = Maps.newHashMap();
			sp.put("ids",divisionIds );
			List<Division> divisisons = divisionService.findDivisions(sp, null);
			env.setVariable("divisions", new DefaultObjectWrapper().wrap(divisisons));
		}

		body.render(env.getOut());
		
	}

}
