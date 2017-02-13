package com.haoyu.tpdpor.creative.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Component;

import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.core.freemarker.TemplateDirective;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.tip.creative.entity.Creative;
import com.haoyu.tip.creative.service.ICreativeService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
@TemplateDirective(directiveName="creativeIdKeyMapDirective")
public class CreativeIdKeyMapDirective extends AbstractTemplateDirectiveModel{

	@Resource
	private ICreativeService creativeService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> parameter = getSelectParam(params);
		
		if(parameter.containsKey("ids")){
			List<Creative> creatives = creativeService.findCreatives(parameter, null);
			if(CollectionUtils.isNotEmpty(creatives)){
				Map<String,Creative> result = Collections3.extractToMap(creatives, "id", null);
				env.setVariable("creativeIdKeyMap", new DefaultObjectWrapper().wrap(result));
			}
		}
		body.render(env.getOut());
		
	}

}
