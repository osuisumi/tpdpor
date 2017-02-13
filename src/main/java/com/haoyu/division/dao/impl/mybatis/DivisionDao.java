package com.haoyu.division.dao.impl.mybatis;

import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.division.dao.IDivisionDao;
import com.haoyu.division.entity.Division;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class DivisionDao extends MybatisDao implements IDivisionDao {

	@Override
	public Division selectDivisionById(String id) {
		return super.selectByPrimaryKey(id);
	}

	@Override
	public int insertDivision(Division division) {
		division.setDefaultValue();
		return super.insert(division);
	}

	@Override
	public int updateDivision(Division division) {
		division.setUpdateValue();
		return super.update(division);
	}

	@Override
	public int deleteDivisionByLogic(Division division) {
		division.setUpdateValue();
		return super.deleteByLogic(division);
	}

	@Override
	public int deleteDivisionByPhysics(String id) {
		return super.deleteByPhysics(id);
	}

	@Override
	public List<Division> findAll(Map<String, Object> parameter) {
		return super.selectList("selectByParameter", parameter);
	}

	@Override
	public List<Division> findAll(Map<String, Object> parameter, PageBounds pageBounds) {
		return super.selectList("selectByParameter", parameter, pageBounds);
	}

	
}
