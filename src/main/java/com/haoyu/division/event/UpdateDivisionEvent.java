package com.haoyu.division.event;

import org.springframework.context.ApplicationEvent;

public class UpdateDivisionEvent extends ApplicationEvent{

	private static final long serialVersionUID = -297907798906984216L;

	public UpdateDivisionEvent(Object source) {
		super(source);
	}

}
