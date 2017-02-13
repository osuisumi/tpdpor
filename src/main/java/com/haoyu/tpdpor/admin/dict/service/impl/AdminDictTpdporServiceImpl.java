package com.haoyu.tpdpor.admin.dict.service.impl;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.haoyu.dict.dao.IDictEntryDao;
import com.haoyu.dict.entity.DictEntry;
import com.haoyu.dict.utils.DictionaryUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.utils.Identities;
import com.haoyu.tpdpor.admin.dict.dao.IAdminDictTpdporDao;
import com.haoyu.tpdpor.admin.dict.service.IAdminDictTpdporService;

@Service
public class AdminDictTpdporServiceImpl implements IAdminDictTpdporService{

	@Resource
	private IDictEntryDao dictEntryDao;
	@Resource
	private IAdminDictTpdporDao adminDictTpdporDao;
	
	@Override
	public Response create(DictEntry dictEntry) {
		Response response = Response.failInstance();
		if (dictEntry == null) {
			return Response.failInstance();
		}
		if (StringUtils.isEmpty(dictEntry.getId())) {
			dictEntry.setId(Identities.uuid2());
		}
		if (StringUtils.isEmpty(dictEntry.getDictValue())) {
			dictEntry.setDictValue(Identities.uuid2());
		}
		dictEntry.setDefaultValue();
		int count = dictEntryDao.create(dictEntry);
		if(count > 0 ){
			DictionaryUtils.init(dictEntry.getDictTypeCode());
			return Response.successInstance().responseData(dictEntry);
		}
		return response;
	}

	@Override
	public Response delete(DictEntry dictEntry) {
		String[] array = dictEntry.getId().split(",");
		List<String> ids = Arrays.asList(array);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("ids", ids);
		List<String> dictTypeCodes = dictEntryDao.getDictTypeCodesByIds(map);
		int count = dictEntryDao.deleteByIdsPhysics(map);
		if(count > 0 ){
			DictionaryUtils.init(dictTypeCodes);
			return Response.successInstance();
		}
		return  Response.failInstance();
	}

	@Override
	public DictEntry get(Map<String, Object> param) {
		return adminDictTpdporDao.get(param);
	}

}
