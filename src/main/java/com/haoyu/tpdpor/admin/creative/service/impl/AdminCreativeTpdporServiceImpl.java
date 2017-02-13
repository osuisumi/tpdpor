package com.haoyu.tpdpor.admin.creative.service.impl;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.dict.entity.DictEntry;
import com.haoyu.dict.service.IDictEntryService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.tip.creative.dao.ICreativeDao;
import com.haoyu.tip.creative.entity.Creative;
import com.haoyu.tip.creative.event.UpdateCreativeEvent;
import com.haoyu.tip.creative.utils.CreativeState;
import com.haoyu.tpdpor.admin.creative.dao.IAdminCreativeTpdporDao;
import com.haoyu.tpdpor.admin.creative.entity.CreativeTypeParam;
import com.haoyu.tpdpor.admin.creative.service.IAdminCreativeTpdporService;
import com.haoyu.tpdpor.admin.dict.service.IAdminDictTpdporService;

@Service
public class AdminCreativeTpdporServiceImpl implements IAdminCreativeTpdporService{

	@Resource
	private IAdminCreativeTpdporDao creativeTpdporDao;
	@Resource
	private ICreativeDao creativeDao;
	@Resource  
	private ApplicationContext applicationContext; 
	@Resource
	private IAdminDictTpdporService adminDictTpdporService;
	@Resource
	private IDictEntryService dictEntryService;
	
	@Override
	public List<CreativeTypeParam> findCreativeTypeParams(Map<String, Object> param, PageBounds pageBounds) {
		return creativeTpdporDao.selectCreativeTypeParams(param,pageBounds);
	}

	@Override
	public Response batchExcellentState(Creative creative) {
		Response response = Response.failInstance();
		Map<String, Object> param = Maps.newHashMap();
		
		if (StringUtils.isNotEmpty(creative.getId())) {
			param.put("ids",Arrays.asList(creative.getId().split(",")));
		}else {
			return Response.failInstance();
		}
		if (StringUtils.isEmpty(creative.getState())) {
			return Response.failInstance();
		}
		List<Creative> creatives = creativeDao.findAll(param);
		
		if (Collections3.isEmpty(creatives)) {
			return Response.failInstance();
		}else {
			List<String> hadPassCreativeIds = Lists.newArrayList();
			for (Creative c : creatives) {
				if (CreativeState.PASSED.equals(c.getState()) || CreativeState.NO_EXCELLENT.equals(c.getState()) || CreativeState.EXCELLENT.equals(c.getState())) {
					if (Collections3.isNotEmpty(c.getCreativeRelations()) && c.getCreativeRelations().get(0) != null && c.getCreativeRelations().get(0).getCollectTimePeriod() != null && c.getCreativeRelations().get(0).getCollectTimePeriod().getEndTime() != null) {
						long curTime= new Date().getTime();
						long collectEndTime = c.getCreativeRelations().get(0).getCollectTimePeriod().getEndTime().getTime();
						if (collectEndTime <= curTime) {
							hadPassCreativeIds.add(c.getId());							
						}
					}
				}
			}
			if (Collections3.isNotEmpty(hadPassCreativeIds)) {
				param = Maps.newHashMap();
				param.put("ids",hadPassCreativeIds);
				if (StringUtils.isNotEmpty(creative.getState())) {
					param.put("state",creative.getState());
				}
				
				int count = creativeDao.batchUpdateCreative(param);
				if (count > 0) {
					response = Response.successInstance();
					creative.setId(StringUtils.join(hadPassCreativeIds.toArray(), ","));
					applicationContext.publishEvent(new UpdateCreativeEvent(creative));
				}
				return response;
			}
		}
		
		return Response.successInstance();
	}

	@Override
	public Response updateCreativeType(String type, String name) {
		Map<String, Object> param = Maps.newHashMap();
		param.put("dictValue",type);
		param.put("dictTypeCode","CREATIVE_TYPE");
		DictEntry dictEntry = adminDictTpdporService.get(param);
		if (dictEntry != null) {
			dictEntry.setDictName(name);
			Response response = dictEntryService.update(dictEntry);
			if (response.isSuccess()) {
				return response;
			}
		}
		return Response.failInstance();
	}

}
