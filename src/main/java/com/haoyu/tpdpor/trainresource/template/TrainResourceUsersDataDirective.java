package com.haoyu.tpdpor.trainresource.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
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
@TemplateDirective(directiveName="trainResourceUsersData")
public class TrainResourceUsersDataDirective extends AbstractTemplateDirectiveModel{

	@Resource
	private ITrainResourceUserService trainResourceUserService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		PageBounds pageBounds = getPageBounds(params);
		Map<String,Object> parameters = getSelectParam(params);
		
		List<TrainResourceUser> trainResourceUsers = trainResourceUserService.findTrainResourceUsers(parameters, pageBounds);
		env.setVariable("trainResourceUsers", new DefaultObjectWrapper().wrap(trainResourceUsers));
		
		
		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList)trainResourceUsers;
			env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		
		body.render(env.getOut());	
	}

}
