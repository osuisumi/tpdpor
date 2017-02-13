package com.haoyu.tpdpor.search.listener;

import java.util.Map;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.context.ApplicationListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.search.utils.IndexUtils;
import com.haoyu.tip.creative.entity.Creative;
import com.haoyu.tip.creative.event.CreateCreativeEvent;

@Component
@Async
public class CreateCreativeIndexListener implements ApplicationListener<CreateCreativeEvent>{

	@Override
	public void onApplicationEvent(CreateCreativeEvent event) {
		Creative creative =  (Creative) event.getSource();
		Map<String, Object> map = Maps.newHashMap();
		map.put("id", creative.getId());
		map.put("title", creative.getTitle());
		map.put("createTime", DateFormatUtils.format(creative.getCreateTime(), "yyyy-MM-dd"));
		map.put("type","creative");
		IndexUtils.updateIndex(Lists.newArrayList(map), false);
		
	}

}
