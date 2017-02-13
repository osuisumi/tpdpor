package com.haoyu.tpdpor.trainresource.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.google.common.collect.Maps;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.core.freemarker.TemplateDirective;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.tpdpor.resource.entity.ResourceApplyRecord;
import com.haoyu.tpdpor.resource.service.IResourceApplyRecordService;
import com.haoyu.tpdpor.resource.utils.ResourceReadApplyState;
import com.haoyu.tpdpor.trainresource.entity.TrainResource;
import com.haoyu.tpdpor.trainresource.service.ITrainResourceService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
@TemplateDirective(directiveName="trainResourcesData")
public class TrainResourcesDataDirective extends AbstractTemplateDirectiveModel{

	@Resource
	private ITrainResourceService trainResourceService;
	@Resource
	private IResourceApplyRecordService resourceApplyRecordService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body)
			throws TemplateException, IOException {
		PageBounds pageBounds = getPageBounds(params);
		Map<String,Object> parameters = getSelectParam(params);
		
		List<TrainResource> trainResources = trainResourceService.findTrainResources(parameters, pageBounds);
		
		env.setVariable("trainResources", new DefaultObjectWrapper().wrap(trainResources));
		
		if (Collections3.isNotEmpty(trainResources)) {
			if(parameters.containsKey("getApplyRecord")){
				boolean getApplyRecord = (boolean) parameters.get("getApplyRecord");
				if (getApplyRecord) {
					Map<String, Object> param = Maps.newHashMap();
					param.put("resourceIds", Collections3.extractToList(trainResources, "resource.id"));
					param.put("userId", ThreadContext.getUser().getId());
					List<ResourceApplyRecord> applyRecords = resourceApplyRecordService.findResourceApplyRecords(param, null);
					Map<String, ResourceApplyRecord> applyRecordMap = Collections3.extractToMap(applyRecords,"resource.id",null);
					env.setVariable("applyRecordMap", new DefaultObjectWrapper().wrap(applyRecordMap));
				}
			}
		}
		
		if(parameters.containsKey("getApplyNum")){
			boolean getApplyNum = (boolean) parameters.get("getApplyNum");
			if (getApplyNum) {
				Map<String, Object> param = Maps.newHashMap();
				if (parameters.containsKey("belongs")) {
					List<String> belongs = (List<String>) parameters.get("belongs");
					param.put("belongs",belongs);
				}
				param.put("userId",ThreadContext.getUser().getId());
				param.put("applyState",ResourceReadApplyState.APPLY);
				int applyNum = trainResourceService.getApplyNum(param);
				env.setVariable("applyNum", new DefaultObjectWrapper().wrap(applyNum));
			}
		}
		
		
		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList)trainResources;
			env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		
		body.render(env.getOut());	
	}

}
