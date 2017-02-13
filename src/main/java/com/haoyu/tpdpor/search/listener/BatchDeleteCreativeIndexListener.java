package com.haoyu.tpdpor.search.listener;

import java.util.List;

import org.springframework.context.ApplicationListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import com.haoyu.search.utils.IndexUtils;
import com.haoyu.tip.creative.event.BatchDeleteCreativeEvent;

@Component
@Async
public class BatchDeleteCreativeIndexListener implements ApplicationListener<BatchDeleteCreativeEvent>{

	@Override
	public void onApplicationEvent(BatchDeleteCreativeEvent event) {
		List<String> ids = (List<String>) event.getSource();
		IndexUtils.deleteDocuments(ids);
	}

}
