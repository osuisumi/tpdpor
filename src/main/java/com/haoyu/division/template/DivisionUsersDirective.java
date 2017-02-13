package com.haoyu.division.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.haoyu.division.entity.DivisionUser;
import com.haoyu.division.service.IDivisionUserService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.core.freemarker.TemplateDirective;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
@TemplateDirective(directiveName="divisionUsersDirective")
public class DivisionUsersDirective extends AbstractTemplateDirectiveModel{

	@Resource
	private IDivisionUserService divisionUserService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		PageBounds pageBounds = getPageBounds(params);
		Map<String,Object> paramerts = getSelectParam(params);
		
		List<DivisionUser> divisionUsers = divisionUserService.findDivisionUsers(paramerts, pageBounds);
		env.setVariable("divisionUsers", new DefaultObjectWrapper().wrap(divisionUsers));
		
		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList)divisionUsers;
			env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		
		body.render(env.getOut());
	}

}
