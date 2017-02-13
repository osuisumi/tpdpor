package com.haoyu.tpdpor.resource.service.impl;


import java.util.HashMap;
import java.util.List;

import javax.jws.WebService;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.github.miemiedev.mybatis.paginator.domain.Paginator;
import com.haoyu.tpdpor.resource.dao.impl.mybatis.ResourceWsDao;
import com.haoyu.tpdpor.resource.entity.ResourceWs;
import com.haoyu.tpdpor.resource.entity.ResourcesWapper;
import com.haoyu.tpdpor.resource.service.IResourceWsService;
import com.haoyu.tpdpor.resource.utils.ApplicationContextUtil;

@WebService(serviceName = "ResourceWsService"
, portName = "ResourceWsServiceServicePort"
, endpointInterface = "com.haoyu.tpdpor.resource.service.IResourceWsService"
, targetNamespace = com.haoyu.tpdpor.resource.utils.WebServiceConstants.NAMESPACE)
public class ResourceWsService  implements IResourceWsService{
	@Override
	public ResourcesWapper list(int page,int limit) {
		ResourceWsDao resourceWsDao = (ResourceWsDao) ApplicationContextUtil.getAc().getBean("resourceWsDao");
		PageBounds pageBounds = null;
		if(page>0&&limit>0){
			pageBounds = new PageBounds(page,limit);
		}
		List<ResourceWs> resources = resourceWsDao.list(new HashMap(), pageBounds);
		ResourcesWapper result = new ResourcesWapper();
		result.setResources(resources);
		if(resources instanceof PageList){
			PageList pageList = (PageList) resources;
			Paginator paginator = pageList.getPaginator(); 
			result.setTotalCount(paginator.getTotalCount());
			result.setPage(paginator.getPage());
			result.setLimit(paginator.getLimit());
			result.setTotalPages(paginator.getTotalPages());
		}
		return result;
	}


}
