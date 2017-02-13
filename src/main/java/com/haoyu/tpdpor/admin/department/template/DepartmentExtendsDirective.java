package com.haoyu.tpdpor.admin.department.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.tpdpor.admin.department.entity.DepartmentExtend;
import com.haoyu.tpdpor.admin.department.service.IAdminDepartmentTpdporService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class DepartmentExtendsDirective extends AbstractTemplateDirectiveModel{
	@Resource
	private IAdminDepartmentTpdporService adminDepartmentTpdporService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> parameter = getSelectParam(params);
		PageBounds pageBounds = getPageBounds(params);

		List<DepartmentExtend> departmentExtends = adminDepartmentTpdporService.findByParameter(parameter, pageBounds);

		env.setVariable("departmentExtends", new DefaultObjectWrapper().wrap(departmentExtends));

		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList) departmentExtends;
			env.setVariable("paginator", new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}

		body.render(env.getOut());
		
	}

}
