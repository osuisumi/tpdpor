package com.haoyu.tpdpor.search.listener;

import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.context.ApplicationListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.search.utils.IndexUtils;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tip.resource.event.CreateResourceEvent;
import com.haoyu.tpdpor.utils.ResourceType;

@Component
@Async
public class CreateResourceIndexListener implements ApplicationListener<CreateResourceEvent>{

	@Override
	public void onApplicationEvent(CreateResourceEvent event) {
		Resources resource = (Resources) event.getSource();
		Map<String, Object> map = Maps.newHashMap();
		map.put("id", resource.getId());
		map.put("title", resource.getTitle());
		map.put("createTime", DateFormatUtils.format(resource.getCreateTime(), "yyyy-MM-dd"));
		if(StringUtils.isNotEmpty(resource.getType())){
			if(CollectionUtils.isNotEmpty(resource.getResourceRelations())&&resource.getResourceRelations().get(0).getRelation()!=null && StringUtils.isNotEmpty(resource.getResourceRelations().get(0).getRelation().getType())){
				map.put("type", resource.getResourceRelations().get(0).getRelation().getType());	
			}else{
				map.put("type", resource.getType());
			}
			if(resource.getResourceExtend()!=null){
				if (StringUtils.isNotEmpty(resource.getResourceExtend().getStage())) {
					map.put("stage", resource.getResourceExtend().getStage());
				}
				if (StringUtils.isNotEmpty(resource.getResourceExtend().getSubject())) {
					map.put("subject", resource.getResourceExtend().getSubject());
				}
				if (StringUtils.isNotEmpty(resource.getResourceExtend().getGrade())) {
					map.put("grade", resource.getResourceExtend().getGrade());
				}
			}
		}
		IndexUtils.updateIndex(Lists.newArrayList(map), false);
		
	}

}
