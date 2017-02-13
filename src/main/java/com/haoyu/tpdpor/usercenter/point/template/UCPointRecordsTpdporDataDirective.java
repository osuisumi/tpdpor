package com.haoyu.tpdpor.usercenter.point.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.google.common.collect.Maps;
import com.haoyu.sip.attitude.entity.AttitudeStat;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.core.freemarker.TemplateDirective;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.point.entity.PointRecord;
import com.haoyu.sip.point.service.IPointRecordService;
import com.haoyu.sip.utils.Collections3;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
@TemplateDirective(directiveName="ucPointRecordsTpdporDataDirective")
public class UCPointRecordsTpdporDataDirective extends AbstractTemplateDirectiveModel{

	@Resource
	private IPointRecordService pointRecordService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		PageBounds pageBounds = getPageBounds(params);
		Map<String,Object> parameter = getSelectParam(params);
		
		List<PointRecord> pointRecords =  pointRecordService.findPointRecords(parameter, pageBounds);
		env.setVariable("pointRecords", new DefaultObjectWrapper().wrap(pointRecords));
		
		if (parameter.containsKey("getScore")) {
			boolean getScore = (boolean) parameter.get("getScore");
			if(getScore){						
				float score = pointRecordService.findUserPoint(ThreadContext.getUser().getId(),"tpdpor","tpdpor");
				env.setVariable("score", new DefaultObjectWrapper().wrap(score));
			}
		}
		
		if (parameter.containsKey("getExpendScore")) {
			boolean getExpendScore = (boolean) parameter.get("getExpendScore");
			if(getExpendScore){						
				Map<String,Object> param = Maps.newHashMap();
				param.put("userId",ThreadContext.getUser().getId());
				param.put("relationId","tpdpor");
				param.put("pointStrategyRelationId","tpdpor");
				Map<String,Float> userExpendMap = pointRecordService.findUserExpendPoint(param);
				float expendScore = 0f;
				if (userExpendMap.get(ThreadContext.getUser().getId()) != null) {
					expendScore = userExpendMap.get(ThreadContext.getUser().getId());
				}
				env.setVariable("expendScore", new DefaultObjectWrapper().wrap(expendScore));
			}
		}
		
		if(pageBounds!=null && pageBounds.isContainsTotalCount()){
			PageList pageList = (PageList) pointRecords;
			env.setVariable("paginator", new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		
		body.render(env.getOut());
	}

}
