package com.haoyu.tpdpor.resource.service;


import javax.jws.WebParam;
import javax.jws.WebService;

import com.haoyu.tpdpor.resource.entity.ResourcesWapper;

@WebService(name = "ResourceWsService", targetNamespace = com.haoyu.tpdpor.resource.utils.WebServiceConstants.NAMESPACE)
public interface IResourceWsService {
	public ResourcesWapper list(@WebParam(name="page") int page,@WebParam(name="limit") int limit);
}
