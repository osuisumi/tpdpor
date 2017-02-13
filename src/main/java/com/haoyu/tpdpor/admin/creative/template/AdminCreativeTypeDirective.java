package com.haoyu.tpdpor.admin.creative.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.core.freemarker.TemplateDirective;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.tip.creative.entity.CreativeUser;
import com.haoyu.tip.creative.service.ICreativeService;
import com.haoyu.tip.creative.service.ICreativeUserService;
import com.haoyu.tip.creative.utils.CreativeUserRole;
import com.haoyu.tpdpor.admin.creative.entity.CreativeTypeParam;
import com.haoyu.tpdpor.admin.creative.service.IAdminCreativeTpdporService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
@TemplateDirective(directiveName="adminCreativeTypeDirective")
public class AdminCreativeTypeDirective extends AbstractTemplateDirectiveModel{

	@Resource
	private ICreativeService creativeService;
	@Resource
	private IAdminCreativeTpdporService creativeTpdporService;
	@Resource
	private ICreativeUserService creativeUserService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body)
			throws TemplateException, IOException {
		PageBounds pageBounds = getPageBounds(params);
		Map<String,Object> paramerts = getSelectParam(params);
		
		List<String> types = Lists.newArrayList("teach","study","innovate");
		
		Map<String,Object> param = Maps.newHashMap();
		param.put("creativeIds", types);
		param.put("role",CreativeUserRole.MANAGER);
		List<CreativeUser> typeManagers = creativeUserService.findCreativeUsers(param, null);
		Map<String, CreativeUser> typeManagerMap = Collections3.extractToMap(typeManagers, "creative.id", null);
		
		param.put("role", CreativeUserRole.EXPERT);
		List<CreativeUser> experts = creativeUserService.findCreativeUsers(param, null);
		Map<String, CreativeUser> expertMap = Collections3.extractToMap(experts, "creative.id", null);
		
		List<CreativeTypeParam> creativeTypeParams = creativeTpdporService.findCreativeTypeParams(paramerts, null);
		Map<String, CreativeTypeParam> creativeTypeParamMap = Collections3.extractToMap(creativeTypeParams, "type", null);
		
		for (String t : types) {
			if (creativeTypeParamMap.containsKey(t)) {
				if (typeManagerMap.get(t) != null && typeManagerMap.get(t).getUser() != null) {					
					creativeTypeParamMap.get(t).setManager(typeManagerMap.get(t).getUser());
				}
				if (expertMap.get(t) != null && expertMap.get(t).getUser() != null) {					
					creativeTypeParamMap.get(t).setExpert(expertMap.get(t).getUser());
				}
			}else {
				CreativeTypeParam creativeTypeParam = new CreativeTypeParam();
				if (typeManagerMap.get(t) != null && typeManagerMap.get(t).getUser() != null) {					
					creativeTypeParam.setManager(typeManagerMap.get(t).getUser());
				}
				if (expertMap.get(t) != null && expertMap.get(t).getUser() != null) {					
					creativeTypeParam.setExpert(expertMap.get(t).getUser());
				}
				creativeTypeParamMap.put(t, creativeTypeParam);
			}
		}
		
		env.setVariable("creativeTypeParamMap", new DefaultObjectWrapper().wrap(creativeTypeParamMap));
		
		body.render(env.getOut());
	}

}
