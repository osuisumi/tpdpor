package com.haoyu.division.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.google.common.collect.Maps;
import com.haoyu.division.entity.Division;
import com.haoyu.division.entity.DivisionUser;
import com.haoyu.division.service.IDivisionService;
import com.haoyu.division.service.IDivisionUserService;
import com.haoyu.division.utils.DivisionUserRole;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.core.freemarker.TemplateDirective;
import com.haoyu.sip.utils.Collections3;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
@TemplateDirective(directiveName="divisionsDirective")
public class DivisionsDirective extends AbstractTemplateDirectiveModel{

	@Resource
	private IDivisionService divisionService; 
	@Resource
	private IDivisionUserService divisionUserService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		PageBounds pageBounds = getPageBounds(params);
		Map<String,Object> paramerts = getSelectParam(params);
		
		List<Division> divisions = divisionService.findDivisions(paramerts, pageBounds);
		env.setVariable("divisions", new DefaultObjectWrapper().wrap(divisions));
		
		if (Collections3.isNotEmpty(divisions)) {
			if (paramerts.containsKey("getManager")) {
				boolean getManager = (boolean) paramerts.get("getManager");
				if (getManager) {
					Map<String, Object> param = Maps.newHashMap();
					param.put("role",DivisionUserRole.MANAGER);
					param.put("divisionIds",Collections3.extractToList(divisions, "id"));
					Map<String, List<DivisionUser>> divisionManagerMap = divisionUserService.getDivisionUserMap(param);
					env.setVariable("divisionManagerMap", new DefaultObjectWrapper().wrap(divisionManagerMap));
				}
			}
			
			if (paramerts.containsKey("getEditor")) {
				boolean getEditor = (boolean) paramerts.get("getEditor");
				if (getEditor) {
					Map<String, Object> param = Maps.newHashMap();
					param.put("role",DivisionUserRole.EDITOR);
					param.put("divisionIds",Collections3.extractToList(divisions, "id"));
					Map<String, List<DivisionUser>> divisionEditorMap = divisionUserService.getDivisionUserMap(param);
					env.setVariable("divisionEditorMap", new DefaultObjectWrapper().wrap(divisionEditorMap));
				}
			}
		}
		
		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList)divisions;
			env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		
		body.render(env.getOut());	
	}

}
