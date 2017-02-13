package com.haoyu.tpdpor.search.listener;

import java.util.List;

import org.springframework.context.ApplicationListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import com.haoyu.search.utils.IndexUtils;
import com.haoyu.tpdpor.trainresource.event.BatchDeleteTrainResourceEvent;

@Component
@Async
public class BatchDeleteTrainResourceIndexListener implements ApplicationListener<BatchDeleteTrainResourceEvent>{

	@Override
	public void onApplicationEvent(BatchDeleteTrainResourceEvent event) {
		List<String> ids = (List<String>) event.getSource();
		IndexUtils.deleteDocuments(ids);
	}

}
