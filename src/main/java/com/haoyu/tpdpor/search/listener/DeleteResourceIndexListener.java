package com.haoyu.tpdpor.search.listener;

import java.util.List;

import org.springframework.context.ApplicationListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import com.haoyu.search.utils.IndexUtils;
import com.haoyu.tip.resource.event.DeleteResourceEvent;

@Component
@Async
public class DeleteResourceIndexListener implements ApplicationListener<DeleteResourceEvent>{

	@Override
	public void onApplicationEvent(DeleteResourceEvent event) {
		List<String> ids = (List<String>) event.getSource();
		IndexUtils.deleteDocuments(ids);
	}

}
