package com.haoyu.tpdpor.creative.template;

import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.google.common.collect.Maps;
import com.haoyu.sip.comment.service.ICommentService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.core.freemarker.TemplateDirective;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.point.service.IPointRecordService;
import com.haoyu.sip.sign.entity.SignStat;
import com.haoyu.sip.sign.service.ISignStatService;
import com.haoyu.tip.creative.service.ICreativeService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
@TemplateDirective(directiveName="creativeSignStatDirective")
public class CreativeSignStatDirective extends AbstractTemplateDirectiveModel{

	@Resource
	private ICreativeService creativeService;
	@Resource
	private ISignStatService signStatService;
	@Resource
	private IPointRecordService pointRecordService;
	@Resource
	private ICommentService commentService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body)
			throws TemplateException, IOException {
		Map<String,Object> parameters = getSelectParam(params);
		
		int creativeNum = creativeService.getCount(parameters);

		env.setVariable("creativeNum", new DefaultObjectWrapper().wrap(creativeNum));
		
		if(parameters.containsKey("relationId") && parameters.containsKey("creator")){
			String relationId = parameters.get("relationId").toString();
			String userId = parameters.get("creator").toString();
			
			SignStat signStat = signStatService.getSignStat(SignStat.getId(relationId,userId));
			env.setVariable("signStatModel", new DefaultObjectWrapper().wrap(signStat));
			
			float score = pointRecordService.findUserPoint(userId,"tpdpor","tpdpor");
			env.setVariable("score", new DefaultObjectWrapper().wrap(score));
		}
		
		Map<String,Object> param = Maps.newHashMap();
		param.put("creator", ThreadContext.getUser().getId());
		param.put("relationType","creative_advice");
		int creativeAdviceNum =  commentService.getCount(param);
		env.setVariable("creativeAdviceNum", new DefaultObjectWrapper().wrap(creativeAdviceNum));
		
		body.render(env.getOut());			
	}

}
