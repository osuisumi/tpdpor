package com.haoyu.tpdpor.usercenter.trainresource.template;

import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.google.common.collect.Maps;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.core.freemarker.TemplateDirective;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.tpdpor.usercenter.trainresource.service.IUCTrainResourceService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
@TemplateDirective(directiveName="ucTrainResourceNumData")
public class UCTrainResourceNumDataDirective extends AbstractTemplateDirectiveModel{

	@Resource
	private IUCTrainResourceService ucTrainResourceService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String,Object> parameter = getSelectParam(params);
		
		if (parameter.containsKey("getMyUpload")) {	
			boolean getMyUpload = (boolean) parameter.get("getMyUpload");
			if (getMyUpload) {						
				Map<String, Object> param = Maps.newHashMap();
				param.put("creator",ThreadContext.getUser().getId());
				int myUploadNum = ucTrainResourceService.getCount(param);
				env.setVariable("myUploadNum", new DefaultObjectWrapper().wrap(myUploadNum));
			}
		}
		
		Map<String, Object> param = Maps.newHashMap();
		param.put("creatorOrFollowCreatorOrAyylyUserId",ThreadContext.getUser().getId());
		int allNum = ucTrainResourceService.getCount(param);
		env.setVariable("allNum", new DefaultObjectWrapper().wrap(allNum));
		
		param = Maps.newHashMap();
		param.put("followCreator",ThreadContext.getUser().getId());
		int followNum = ucTrainResourceService.getCount(param);
		env.setVariable("followNum", new DefaultObjectWrapper().wrap(followNum));
		
		param = Maps.newHashMap();
		param.put("ayylyUserId",ThreadContext.getUser().getId());
		int applyNum = ucTrainResourceService.getCount(param);
		env.setVariable("applyNum", new DefaultObjectWrapper().wrap(applyNum));
		
		body.render(env.getOut());
	}

}
