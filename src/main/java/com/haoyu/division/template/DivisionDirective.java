package com.haoyu.division.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.google.common.collect.Maps;
import com.haoyu.division.entity.Division;
import com.haoyu.division.entity.DivisionUser;
import com.haoyu.division.service.IDivisionService;
import com.haoyu.division.service.IDivisionUserService;
import com.haoyu.division.utils.DivisionUserRole;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.core.freemarker.TemplateDirective;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
@TemplateDirective(directiveName="divisionDirective")
public class DivisionDirective extends AbstractTemplateDirectiveModel{

	@Resource
	private IDivisionService divisionService; 
	@Resource
	private IDivisionUserService divisionUserService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String,Object> parameters = getSelectParam(params);
		
		Division division = divisionService.findDivisionById(parameters.get("id").toString().trim());
		
		if (parameters.containsKey("getManager")) {
			boolean getManager = (boolean) parameters.get("getManager");
			if (getManager) {
				Map<String, Object> param = Maps.newHashMap();
				param.put("role",DivisionUserRole.MANAGER);
				param.put("divisionId",division.getId());
				List<DivisionUser> divisionManagers = divisionUserService.findDivisionUsers(param, null);
				env.setVariable("divisionManagers", new DefaultObjectWrapper().wrap(divisionManagers));
			}
		}
		
		if (parameters.containsKey("getEditor")) {
			boolean getEditor = (boolean) parameters.get("getEditor");
			if (getEditor) {
				Map<String, Object> param = Maps.newHashMap();
				param.put("role",DivisionUserRole.EDITOR);
				param.put("divisionId",division.getId());
				List<DivisionUser> divisionEditors = divisionUserService.findDivisionUsers(param, null);
				env.setVariable("divisionEditors", new DefaultObjectWrapper().wrap(divisionEditors));
			}
		}
		env.setVariable("divisionModel", new DefaultObjectWrapper().wrap(division));
		body.render(env.getOut());
	}

}
