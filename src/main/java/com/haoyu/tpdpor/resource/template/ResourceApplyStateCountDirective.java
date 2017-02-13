package com.haoyu.tpdpor.resource.template;

import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.google.common.collect.Maps;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.tpdpor.resource.entity.ResourceApplyRecordStateCount;
import com.haoyu.tpdpor.resource.service.IResourceApplyRecordService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class ResourceApplyStateCountDirective extends AbstractTemplateDirectiveModel{
	@Resource
	private IResourceApplyRecordService resourceApplyRecordService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String,Object> parameter = getSelectParam(params);
		Map<String,ResourceApplyRecordStateCount> stateCountMap = resourceApplyRecordService.selectStateCount(parameter);
		Map<String,Integer> result = Maps.newHashMap();
		if(!stateCountMap.isEmpty()){
			int total = 0;
			for(ResourceApplyRecordStateCount rrs:stateCountMap.values()){
				result.put(rrs.getApplyState(), rrs.getNum());
				total = total + rrs.getNum();
			}
			result.put("total", total);
		}
		env.setVariable("resourceApplyRecordStateCount", new DefaultObjectWrapper().wrap(result));
		body.render(env.getOut());
	}

}
