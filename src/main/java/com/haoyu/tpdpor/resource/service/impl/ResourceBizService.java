package com.haoyu.tpdpor.resource.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.core.entity.Relation;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.file.service.IFileService;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tpdpor.resource.dao.IResourceBizDao;
import com.haoyu.tpdpor.resource.entity.ResourceTypeCount;
import com.haoyu.tpdpor.resource.service.IResourceBizService;
@Service
public class ResourceBizService implements IResourceBizService{
	@Resource
	private IResourceBizDao resourceBizDao;
	@Resource
	private IFileService fileService;

	@Override
	public int countResourceByType(String type) {
		return resourceBizDao.countResourceByType(type);
	}

	@Override
	public int countCreatorByType(String type) {
		return resourceBizDao.countCreatorByType(type);
	}

	@Override
	public Map<String, ResourceTypeCount> resourceCountMap(Map<String, Object> parameter) {
		return resourceBizDao.resourceCountMap(parameter);
	}

	@Override
	public Response updateResourceExtendEvaluateResult(Map<String, Object> parameter) {
		return resourceBizDao.updateResourceExtendEvaluateResult(parameter)>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public int countResourceByParameter(Map<String, Object> parameter) {
		return resourceBizDao.countResourceByParameter(parameter);
	}

	@Override
	public List<Resources> findResources(Map<String, Object> parameter, PageBounds pageBounds,boolean getFile) {
		List<Resources> resources = resourceBizDao.findResource(parameter, pageBounds);
		if (getFile) {
			for (Resources resource : resources) {
				resource.setFileInfos(fileService.listFileInfoByRelation(new Relation(resource.getId(),"resources")));
			}
		}
		return resources;
	}

}
