package com.haoyu.tpdpor.admin.dict.dao;

import java.util.Map;

import com.haoyu.dict.entity.DictEntry;

public interface IAdminDictTpdporDao {

	DictEntry get(Map<String, Object> param);
}
