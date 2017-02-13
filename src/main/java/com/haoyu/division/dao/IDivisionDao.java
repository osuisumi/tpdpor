package com.haoyu.division.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.division.entity.Division;

public interface IDivisionDao {

	Division selectDivisionById(String id);

	int insertDivision(Division division);

	int updateDivision(Division division);

	int deleteDivisionByLogic(Division division);

	int deleteDivisionByPhysics(String id);

	List<Division> findAll(Map<String, Object> parameter);

	List<Division> findAll(Map<String, Object> parameter, PageBounds pageBounds);

}