package com.haoyu.tpdpor.usercenter.trainresource.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.google.common.collect.Maps;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.core.freemarker.TemplateDirective;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.follow.entity.Follow;
import com.haoyu.sip.follow.service.IFollowService;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.tpdpor.resource.entity.ResourceApplyRecord;
import com.haoyu.tpdpor.resource.service.IResourceApplyRecordService;
import com.haoyu.tpdpor.trainresource.entity.TrainResource;
import com.haoyu.tpdpor.usercenter.trainresource.service.IUCTrainResourceService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
@TemplateDirective(directiveName="ucTrainResourcesData")
public class UCTrainResourcesDataDirective extends AbstractTemplateDirectiveModel{

	@Resource
	private IUCTrainResourceService ucTrainResourceService;
	@Resource
	private IFollowService followService;
	@Resource
	private IResourceApplyRecordService resourceApplyRecordService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) 
			throws TemplateException, IOException {
		PageBounds pageBounds = getPageBounds(params);
		Map<String,Object> parameters = getSelectParam(params);
		
		String queryType = "all";
		
		if (parameters.containsKey("queryType") && StringUtils.isNotEmpty(parameters.get("queryType").toString().trim())) {
			queryType = parameters.get("queryType").toString().trim();
		}
		
		if ("all".equals(queryType)) {
			parameters.put("creatorOrFollowCreatorOrAyylyUserId",ThreadContext.getUser().getId());
		}else if ("follow".equals(queryType)) {
			parameters.put("followCreator",ThreadContext.getUser().getId());
		}else if ("myUpload".equals(queryType)) {
			parameters.put("creator",ThreadContext.getUser().getId());
		}else if ("apply".equals(queryType)) {
			parameters.put("ayylyUserId", ThreadContext.getUser().getId());
		}
		
		List<TrainResource> trainResources = ucTrainResourceService.findTrainResource(parameters, pageBounds);
		env.setVariable("trainResources", new DefaultObjectWrapper().wrap(trainResources));
		
		if (Collections3.isNotEmpty(trainResources)) {
			Map<String, Object> param = Maps.newHashMap();
			param.put("resourceIds",Collections3.extractToList(trainResources, "resource.id"));
			param.put("userId",ThreadContext.getUser().getId());
			List<ResourceApplyRecord> resourceApplyRecords = resourceApplyRecordService.findResourceApplyRecords(param, null);
			Map<String, ResourceApplyRecord> resourceApplyRecordMap = Collections3.extractToMap(resourceApplyRecords, "resource.id", null);
			env.setVariable("resourceApplyRecordMap", new DefaultObjectWrapper().wrap(resourceApplyRecordMap));
		}
		
		if (Collections3.isNotEmpty(trainResources)){
			if(parameters.containsKey("getFollow")){
				boolean getFollow = (boolean) parameters.get("getFollow");
				if (getFollow) {
					Map<String, Object> param = Maps.newHashMap();
					param.put("followedIds", Collections3.extractToList(trainResources, "resource.id"));
					param.put("userId", ThreadContext.getUser().getId());
					List<Follow> follows = followService.listFollow(param, null);
					Map<String, Follow> followMap = Collections3.extractToMap(follows,"followEntity.id",null);
					env.setVariable("followMap", new DefaultObjectWrapper().wrap(followMap));
				}
			}
		}
		
		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList)trainResources;
			env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		
		body.render(env.getOut());
	}

}
