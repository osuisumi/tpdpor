package com.haoyu.tpdpor.trainresource.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.sip.attitude.entity.AttitudeStat;
import com.haoyu.sip.attitude.service.IAttitudeService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.core.freemarker.TemplateDirective;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.tpdpor.resource.entity.ResourceApplyRecord;
import com.haoyu.tpdpor.resource.service.IResourceApplyRecordService;
import com.haoyu.tpdpor.trainresource.entity.TrainResource;
import com.haoyu.tpdpor.trainresource.service.ITrainResourceService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
@TemplateDirective(directiveName="trainResourceViewData")
public class TrainResourceViewDataDirective extends AbstractTemplateDirectiveModel{

	@Resource
	private ITrainResourceService trainResourceService;
	@Resource
	private IResourceApplyRecordService resourceApplyRecordService;
	@Resource
	private IAttitudeService attitudeService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body)
			throws TemplateException, IOException {
		Map<String,Object> parameters = getSelectParam(params);
		
		if(parameters.containsKey("id") && StringUtils.isNotEmpty(parameters.get("id").toString().trim()) ){
			TrainResource trainResource = trainResourceService.findById(parameters.get("id").toString(),true);
			env.setVariable("trainRsourceModel", new DefaultObjectWrapper().wrap(trainResource));
			
			if(parameters.containsKey("getAttitudeStatForSupport")){
				boolean getAttitudeStatForSupport = (boolean) parameters.get("getAttitudeStatForSupport");
				if (getAttitudeStatForSupport) {					
					Map<String,Object> param = Maps.newHashMap();
					param.put("relationIds",Lists.newArrayList(parameters.get("id").toString()));
					param.put("attitude","support");
					Map<String,AttitudeStat> attitudeStatMapForSupport = attitudeService.getAttitudeStatByParam(param);
					env.setVariable("attitudeStatMapForSupport", new DefaultObjectWrapper().wrap(attitudeStatMapForSupport));
				}
			}
			
			if(parameters.containsKey("getApplyRecord")){
				boolean getApplyRecord = (boolean) parameters.get("getApplyRecord");
				if (getApplyRecord) {
					if (ThreadContext.getUser() != null) {
						Map<String, Object> param = Maps.newHashMap();
						param.put("resourceIds", Lists.newArrayList(trainResource.getResource().getId()));
						param.put("userId", ThreadContext.getUser().getId());
						List<ResourceApplyRecord> applyRecords = resourceApplyRecordService.findResourceApplyRecords(param, null);
						Map<String, ResourceApplyRecord> applyRecordMap = Collections3.extractToMap(applyRecords,"resource.id",null);
						env.setVariable("applyRecordMap", new DefaultObjectWrapper().wrap(applyRecordMap));					
					}
				}
			}
		}
		
		body.render(env.getOut());
	}

}
