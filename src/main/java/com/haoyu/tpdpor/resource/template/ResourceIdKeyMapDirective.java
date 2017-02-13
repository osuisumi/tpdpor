package com.haoyu.tpdpor.resource.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Component;

import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tip.resource.service.IResourceService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class ResourceIdKeyMapDirective extends AbstractTemplateDirectiveModel{
	@Resource
	private IResourceService resourceService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> parameter = getSelectParam(params);
		
		if(parameter.containsKey("ids")){
			List<Resources> resources = resourceService.list(parameter, null);
			if(CollectionUtils.isNotEmpty(resources)){
				Map<String,Resources> result = Collections3.extractToMap(resources, "id", null);
				env.setVariable("resourceIdKeyMap", new DefaultObjectWrapper().wrap(result));
			}
		}
		body.render(env.getOut());
		
	}

}
