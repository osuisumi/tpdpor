package com.haoyu.tpdpor.resource.dao.impl.mybatis;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Maps;
import com.haoyu.tpdpor.resource.dao.IResourceApplyRecordDao;
import com.haoyu.tpdpor.resource.entity.ResourceApplyRecord;
import com.haoyu.tpdpor.resource.entity.ResourceApplyRecordStateCount;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class ResourceApplyRecordDao extends MybatisDao implements IResourceApplyRecordDao {

	@Override
	public ResourceApplyRecord selectResourceApplyRecordById(String id) {
		return super.selectByPrimaryKey(id);
	}

	@Override
	public int insertResourceApplyRecord(ResourceApplyRecord ResourceApplyRecord) {
		ResourceApplyRecord.setDefaultValue();
		return super.insert(ResourceApplyRecord);
	}

	@Override
	public int updateResourceApplyRecord(ResourceApplyRecord resourceReadRecord) {
		if(StringUtils.isEmpty(resourceReadRecord.getId())){
			return 0;
		}
		resourceReadRecord.setUpdateValue();
		Map<String,Object> parameter = Maps.newHashMap();
		parameter.put("entity", resourceReadRecord);
		parameter.put("ids", Arrays.asList(resourceReadRecord.getId().split(",")));
		return super.update(parameter);
	}

	@Override
	public int deleteResourceApplyRecordByPhysics(String id) {
		return super.delete("deleteByPhysics",id);
	}

	@Override
	public List<ResourceApplyRecord> findAll(Map<String, Object> parameter, PageBounds pageBounds) {
		return super.selectList("selectByParameter", parameter, pageBounds);
	}

	@Override
	public Map<String, ResourceApplyRecordStateCount> stateCount(Map<String, Object> parameter) {
		return super.selectMap("selectStateCount", parameter, "applyState");
	}

	
}
