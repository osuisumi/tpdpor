package com.haoyu.tpdpor.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.haoyu.sip.auth.entity.AuthRole;
import com.haoyu.sip.auth.service.IAuthRoleService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class AuthRolesDirective extends AbstractTemplateDirectiveModel {
	@Resource
	private IAuthRoleService authRoleService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> parameter = getSelectParam(params);
		PageBounds pageBounds = getPageBounds(params);

		List<AuthRole> authRoles = authRoleService.findRoleByNameAndRelation(parameter.containsKey("name") ? String.valueOf(parameter.get("name")) : null, parameter.containsKey("relationId") ? String.valueOf(parameter.get("relationId")) : null, pageBounds);

		env.setVariable("authRoles", new DefaultObjectWrapper().wrap(authRoles));

		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList) authRoles;
			env.setVariable("paginator", new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}

		body.render(env.getOut());

	}

}
