package com.haoyu.tpdpor.admin.dict.service;

import java.util.Map;

import com.haoyu.dict.entity.DictEntry;
import com.haoyu.sip.core.service.Response;

public interface IAdminDictTpdporService {

	Response create(DictEntry dictEntry);

	Response delete(DictEntry dictEntry);

	DictEntry get(Map<String, Object> param);
}
