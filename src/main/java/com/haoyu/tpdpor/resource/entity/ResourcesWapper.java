package com.haoyu.tpdpor.resource.entity;

import java.io.Serializable;
import java.util.List;


public class ResourcesWapper implements Serializable{

	private static final long serialVersionUID = 2079724606903449538L;
	
	private List<ResourceWs> resources;
	
	private int limit;

	private int page;

	private int totalCount; 
	
	private int totalPages;

	public List<ResourceWs> getResources() {
		return resources;
	}

	public void setResources(List<ResourceWs> resources) {
		this.resources = resources;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}
	
	


	
	

}
