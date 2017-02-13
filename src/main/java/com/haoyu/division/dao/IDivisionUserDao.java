package com.haoyu.division.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.division.entity.DivisionUser;

public interface IDivisionUserDao {

	DivisionUser selectDivisionUserById(String id);

	int insertDivisionUser(DivisionUser divisionUser);

	int updateDivisionUser(DivisionUser divisionUser);

	int deleteDivisionUserByLogic(DivisionUser divisionUser);

	int deleteDivisionUserByPhysics(String id);

	List<DivisionUser> findAll(Map<String, Object> parameter);

	List<DivisionUser> findAll(Map<String, Object> parameter, PageBounds pageBounds);

	Map<String, DivisionUser> selectDivisionUser(Map<String, Object> param);

	int deleteDivisionUserByParameter(Map<String, Object> parameter);

	Map<String, List<DivisionUser>> selectDivisionUserMap(Map<String, Object> param);

}