package com.haoyu.tpdpor.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.annotation.Resource;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.core.freemarker.TemplateDirective;
import com.haoyu.sip.core.utils.PropertiesLoader;
import com.haoyu.tpdpor.resource.entity.ResourceTypeCount;
import com.haoyu.tpdpor.resource.service.IResourceBizService;
import com.haoyu.tpdpor.statistics.entity.ResourceStatistics;
import com.haoyu.tpdpor.statistics.service.IResourceStatisticsService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
@TemplateDirective(directiveName="tpoporStatisticsDirective")
public class TpoporStatisticsDirective extends AbstractTemplateDirectiveModel{

	@Resource
	private IResourceBizService resourceBizService;
	@Resource
	private IResourceStatisticsService resourceStatisticsService;
	@Resource
	private RedisTemplate redisTemplate;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		PageBounds pageBounds = getPageBounds(params);
		
		String key = PropertiesLoader.get("redis.app.key") + ":statisticsResourceForType:tpdpor";
		String key1 = PropertiesLoader.get("redis.app.key") + ":statisticsResourceForRegion:tpdpor";
		ValueOperations<String,Map<String, ResourceTypeCount>> valueOper = redisTemplate.opsForValue();
		ValueOperations<String,List<ResourceStatistics>> va = redisTemplate.opsForValue();
		
		if(redisTemplate.hasKey(key)){
			Map<String, ResourceTypeCount> resourceTypeMap = valueOper.get(key);
			env.setVariable("resourceTypeMap", new DefaultObjectWrapper().wrap(resourceTypeMap));			
		}else {
			Map<String, Object> param = Maps.newHashMap();
			param.put("relationTypes",Lists.newArrayList("course","teach","train_resource","creative"));
			Map<String,ResourceTypeCount> resourceTypeMap = resourceBizService.resourceCountMap(param);
			env.setVariable("resourceTypeMap", new DefaultObjectWrapper().wrap(resourceTypeMap));	
			valueOper.set(key, resourceTypeMap);
			redisTemplate.expire(key, 10, TimeUnit.MINUTES);
		}
		
		if(redisTemplate.hasKey(key1)){
			List<ResourceStatistics> resourceStatistics = va.get(key1);
			env.setVariable("resourceStatistics", new DefaultObjectWrapper().wrap(resourceStatistics));
		}else {			
			Map<String, Object> param = Maps.newHashMap();
			List<ResourceStatistics> resourceStatistics = resourceStatisticsService.findStatistics(param, pageBounds);
			env.setVariable("resourceStatistics", new DefaultObjectWrapper().wrap(resourceStatistics));
			va.set(key1, resourceStatistics);
			redisTemplate.expire(key1, 10, TimeUnit.MINUTES);
			
		}
		
		body.render(env.getOut());
	}

}
