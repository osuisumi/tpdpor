package com.haoyu.tpdpor.admin.dict.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.haoyu.dict.entity.DictEntry;
import com.haoyu.dict.service.IDictEntryService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.core.web.SearchParam;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class AdminDictsDirective extends AbstractTemplateDirectiveModel{

	@Resource
	private IDictEntryService dictEntryService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> parameter = getSelectParam(params);
		PageBounds pageBounds = getPageBounds(params);
		
		SearchParam searchParam = new SearchParam();
		searchParam.setParamMap(parameter);
		
		List<DictEntry> dictEntries = dictEntryService.list(searchParam, pageBounds);

		env.setVariable("dictEntries", new DefaultObjectWrapper().wrap(dictEntries));

		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList) dictEntries;
			env.setVariable("paginator", new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}

		body.render(env.getOut());
	}

}
