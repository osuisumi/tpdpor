package com.haoyu.tpdpor.search.listener;

import org.springframework.context.ApplicationListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.haoyu.search.utils.IndexUtils;
import com.haoyu.tip.creative.entity.Creative;
import com.haoyu.tip.creative.event.DeleteCreativeEvent;

@Component
@Async
public class DeleteCreativeIndexListener implements ApplicationListener<DeleteCreativeEvent>{

	@Override
	public void onApplicationEvent(DeleteCreativeEvent event) {
		Creative c = (Creative) event.getSource();
		if(c!=null){
			IndexUtils.deleteDocuments(Lists.newArrayList(c.getId()));
		}
	}

}
