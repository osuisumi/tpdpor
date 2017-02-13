package com.haoyu.tpdpor.search.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.tpdpor.search.entity.PageAndResults;
import com.haoyu.tpdpor.search.entity.SearchResult;
import com.haoyu.tpdpor.search.service.ISearchService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class SearchDirective extends AbstractTemplateDirectiveModel{
	
	@Resource
	private ISearchService searchService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> parameter = getSelectParam(params);
		PageBounds pageBounds = getPageBounds(params);
		if(parameter.containsKey("keywords")){
			PageAndResults pageAndResults = searchService.list(parameter, pageBounds);
			List<SearchResult> searchResults = pageAndResults.getSearchResults();
			env.setVariable("searchResults", new DefaultObjectWrapper().wrap(searchResults));
			env.setVariable("paginator", new DefaultObjectWrapper().wrap(pageAndResults.getPaginator()));
		}
		body.render(env.getOut());
	}

}
