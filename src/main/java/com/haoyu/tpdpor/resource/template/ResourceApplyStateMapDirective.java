package com.haoyu.tpdpor.resource.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Component;

import com.google.common.collect.Maps;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.excel.utils.StringUtils;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tpdpor.resource.entity.ResourceApplyRecord;
import com.haoyu.tpdpor.resource.service.IResourceApplyRecordService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.SimpleSequence;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class ResourceApplyStateMapDirective extends AbstractTemplateDirectiveModel{
	@Resource
	private IResourceApplyRecordService resourceApplyRecordService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String,Object> parameter = getSelectParam(params);
		if(params.containsKey("resources") && parameter.containsKey("userId")){
			if(parameter.get("resources") instanceof List){
				String userId = parameter.get("userId").toString();
				SimpleSequence ss = (SimpleSequence) params.get("resources");
				List<Resources> resources = ss.toList();
				if(CollectionUtils.isNotEmpty(resources)&&resources.size()<1000){
					List<String> resourceIds = Collections3.extractToList(resources, "id");
					Map<String,Object> p = Maps.newHashMap();
					p.put("resourceIds", resourceIds);
					p.put("userId", userId);
					List<ResourceApplyRecord> resourceApplyRecords = resourceApplyRecordService.findResourceApplyRecords(p, null);
					if(CollectionUtils.isNotEmpty(resourceApplyRecords)){
						env.setVariable("applyRecordMap", new DefaultObjectWrapper().wrap(Collections3.extractToMap(resourceApplyRecords, "resource.id",null)));
					}
				}
			}
		}
		body.render(env.getOut());
		
	}

}
