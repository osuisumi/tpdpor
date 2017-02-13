package com.haoyu.bookindex.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.haoyu.bookindex.entity.BookIndex;
import com.haoyu.bookindex.service.IBookIndexService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateBooleanModel;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class BookIndexsDirective extends AbstractTemplateDirectiveModel{
	@Resource
	private IBookIndexService bookIndexService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String,Object> parameter = getSelectParam(params);
		PageBounds pageBounds = getPageBounds(params);
		
		boolean getTree = false;
		if(params.containsKey("getTree")){
			if(params.get("getTree") instanceof TemplateBooleanModel){
				TemplateBooleanModel flg = (TemplateBooleanModel) params.get("getTree");
				getTree = flg.getAsBoolean();
			}
		}
		List<BookIndex> bookIndexs = bookIndexService.findBookIndexs(parameter, pageBounds, getTree);

		env.setVariable("bookIndexs", new DefaultObjectWrapper().wrap(bookIndexs));

		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList) bookIndexs;
			env.setVariable("paginator", new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}

		body.render(env.getOut());
		
	}

}
