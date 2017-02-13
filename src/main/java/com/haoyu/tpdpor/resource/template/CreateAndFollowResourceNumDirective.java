package com.haoyu.tpdpor.resource.template;

import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.google.common.collect.Maps;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.tpdpor.resource.service.IResourceBizService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class CreateAndFollowResourceNumDirective extends AbstractTemplateDirectiveModel{
	@Resource
	private IResourceBizService resourceBizService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String,Object> parameter =getSelectParam(params);
		if(parameter.containsKey("getCreateNum")){
			Map<String,Object> creatorParam = Maps.newHashMap();
			creatorParam.putAll(parameter);
			creatorParam.put("creator", ThreadContext.getUser().getId());
			env.setVariable("createNum", new DefaultObjectWrapper().wrap(resourceBizService.countResourceByParameter(creatorParam)));
		}
		if(parameter.containsKey("getFollowNum")){
			Map<String,Object> followParam = Maps.newHashMap();
			followParam.putAll(parameter);
			followParam.put("followCreator", ThreadContext.getUser().getId());
			env.setVariable("followNum", new DefaultObjectWrapper().wrap(resourceBizService.countResourceByParameter(followParam)));
		}
		if(parameter.containsKey("getApplyNum")){
			Map<String,Object> applyParam = Maps.newHashMap();
			applyParam.putAll(parameter);
			applyParam.put("applyUser",ThreadContext.getUser().getId());
			env.setVariable("applyNum", new DefaultObjectWrapper().wrap(resourceBizService.countResourceByParameter(applyParam)));
		}
		if(parameter.containsKey("applyAndFollowNum")){
			Map<String,Object> applyFollowNum = Maps.newHashMap();
			applyFollowNum.putAll(parameter);
			applyFollowNum.put("applyUserOrFollowCreator",ThreadContext.getUser().getId());
			env.setVariable("applyAndFollowNum", new DefaultObjectWrapper().wrap(resourceBizService.countResourceByParameter(applyFollowNum)));
		}
		body.render(env.getOut());
	}

}
