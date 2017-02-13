package com.haoyu.bookindex.template;

import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import com.haoyu.bookindex.service.IBookIndexService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class BookIndexDirective extends AbstractTemplateDirectiveModel{

	@Resource
	private IBookIndexService bookIndexService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		String id = getId(params);
		Map<String,Object> parameter = getSelectParam(params);
		String resultName = parameter.containsKey("resultName")?String.valueOf(parameter.get("resultName")):"bookIndex";
		if(StringUtils.isNotEmpty(id)){
			env.setVariable(resultName, new DefaultObjectWrapper().wrap(bookIndexService.findBookIndexById(id)));
		}else{
			if(parameter.containsKey("bIndex")){
				env.setVariable(resultName, new DefaultObjectWrapper().wrap(bookIndexService.findBookIndexByBIndex(String.valueOf(parameter.get("bIndex")))));
			}
		}
		body.render(env.getOut());
	}


}
