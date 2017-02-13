package com.haoyu.tpdpor.resource.template;

import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.tpdpor.resource.entity.ResourceApplyRecord;
import com.haoyu.tpdpor.resource.service.IResourceApplyRecordService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class ResourceApplyRecordDirective extends AbstractTemplateDirectiveModel {
	@Resource
	private IResourceApplyRecordService resourceApplyRecordService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		String id = getId(params);
		if (StringUtils.isEmpty(id)) {
			Map<String, Object> parameter = getSelectParam(params);
			if (parameter.containsKey("userId") && parameter.containsKey("resourceId")) {
				id = ResourceApplyRecord.getId(String.valueOf(parameter.get("userId")), String.valueOf(parameter.get("resourceId")));
			}
		}
		if (StringUtils.isNotEmpty(id)) {
			env.setVariable("resourceApplyRecordModel", new DefaultObjectWrapper().wrap(resourceApplyRecordService.findResourceApplyRecordById(id)));
		}

		body.render(env.getOut());

	}

}
