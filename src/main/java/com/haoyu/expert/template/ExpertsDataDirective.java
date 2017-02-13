package com.haoyu.expert.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
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
@TemplateDirective(directiveName="expertsData")
public class ExpertsDataDirective extends AbstractTemplateDirectiveModel{

	@Resource
	private IExpertService expertService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		PageBounds pageBounds = getPageBounds(params);
		Map<String,Object> paramerts = getSelectParam(params);
		
		List<Expert> experts = expertService.findExperts(paramerts, pageBounds);
		env.setVariable("experts", new DefaultObjectWrapper().wrap(experts));
		
		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList)experts;
			env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		
		body.render(env.getOut());	
	}

}
