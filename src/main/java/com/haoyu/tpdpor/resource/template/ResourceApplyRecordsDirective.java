package com.haoyu.tpdpor.resource.template;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.utils.TimeUtils;
import com.haoyu.tpdpor.resource.entity.ResourceApplyRecord;
import com.haoyu.tpdpor.resource.service.IResourceApplyRecordService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class ResourceApplyRecordsDirective extends AbstractTemplateDirectiveModel{
	@Resource
	private IResourceApplyRecordService resourceApplyRecordService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> parameter = getSelectParam(params);
		if(parameter.containsKey("applyYear")){
			try{
				String year = String.valueOf(parameter.get("applyYear"));
				int y = Integer.parseInt(year);
				Date start = TimeUtils.getFirstDayOfYear(y);
				Date end = TimeUtils.getLastDayOfYear(y);
				parameter.put("createTimeGT", start.getTime());
				parameter.put("createTimeLT", end.getTime());
			}catch(NumberFormatException e){
				parameter.put("createTimeLT", 0);
			}
		}
		PageBounds pageBounds = getPageBounds(params);
		List<ResourceApplyRecord> resourceApplyRecords = resourceApplyRecordService.findResourceApplyRecords(parameter, pageBounds);
		env.setVariable("resourceApplyRecords", new DefaultObjectWrapper().wrap(resourceApplyRecords));
		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList) resourceApplyRecords;
			env.setVariable("paginator", new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		body.render(env.getOut());

	}

}
