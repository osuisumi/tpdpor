package com.haoyu.tpdpor.trainresource.event;

import org.springframework.context.ApplicationEvent;

public class BatchDeleteTrainResourceEvent extends ApplicationEvent{
	private static final long serialVersionUID = 4975160439569715172L;
	
	public BatchDeleteTrainResourceEvent(Object source) {
		super(source);
	}
}
