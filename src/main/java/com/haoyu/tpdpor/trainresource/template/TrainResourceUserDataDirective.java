package com.haoyu.tpdpor.trainresource.template;

import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.core.freemarker.TemplateDirective;
import com.haoyu.tpdpor.trainresource.entity.TrainResourceUser;
import com.haoyu.tpdpor.trainresource.service.ITrainResourceUserService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
@TemplateDirective(directiveName="trainResourceUserData")
public class TrainResourceUserDataDirective extends AbstractTemplateDirectiveModel{

	@Resource
	private ITrainResourceUserService trainResourceUserService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String,Object> parameters = getSelectParam(params);
		
		if(parameters.containsKey("id") && StringUtils.isNotEmpty(parameters.get("id").toString().trim()) ){
			TrainResourceUser trainResourceUser = trainResourceUserService.findTrainResourceUserById(parameters.get("id").toString().trim());
			env.setVariable("trainResourceUserModel", new DefaultObjectWrapper().wrap(trainResourceUser));
		}
		
		body.render(env.getOut());
		
	}

}
