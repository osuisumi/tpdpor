package com.haoyu.expert.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.expert.entity.Expert;

public interface IExpertDao {

	Expert selectExpertById(String id);

	int insertExpert(Expert expert);

	int updateExpert(Expert expert);

	int deleteExpertByLogic(Expert expert);

	int deleteExpertByPhysics(String id);

	List<Expert> findAll(Map<String, Object> parameter);

	List<Expert> findAll(Map<String, Object> parameter, PageBounds pageBounds);

}