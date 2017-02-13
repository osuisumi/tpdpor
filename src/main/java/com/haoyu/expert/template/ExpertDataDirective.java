package com.haoyu.expert.template;

import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import com.haoyu.expert.entity.Expert;
import com.haoyu.expert.service.IExpertService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.core.freemarker.TemplateDirective;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
@TemplateDirective(directiveName="expertData")
public class ExpertDataDirective extends AbstractTemplateDirectiveModel{

	@Resource
	private IExpertService expertService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String,Object> parameters = getSelectParam(params);
		
		if (parameters.containsKey("id") && StringUtils.isNotEmpty(parameters.get("id").toString().trim())) {
			Expert expert = expertService.findExpertById(parameters.get("id").toString().trim());			
			env.setVariable("expertModel", new DefaultObjectWrapper().wrap(expert));
		}
		
		body.render(env.getOut());
	}

}
