package com.haoyu.division.dao.impl.mybatis;

import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.division.dao.IDivisionUserDao;
import com.haoyu.division.entity.DivisionUser;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class DivisionUserDao extends MybatisDao implements IDivisionUserDao {

	@Override
	public DivisionUser selectDivisionUserById(String id) {
		return super.selectByPrimaryKey(id);
	}

	@Override
	public int insertDivisionUser(DivisionUser divisionUser) {
		divisionUser.setDefaultValue();
		return super.insert(divisionUser);
	}

	@Override
	public int updateDivisionUser(DivisionUser divisionUser) {
		divisionUser.setUpdateValue();
		return super.update(divisionUser);
	}

	@Override
	public int deleteDivisionUserByLogic(DivisionUser divisionUser) {
		divisionUser.setUpdateValue();
		return super.deleteByLogic(divisionUser);
	}

	@Override
	public int deleteDivisionUserByPhysics(String id) {
		return super.deleteByPhysics(id);
	}

	@Override
	public List<DivisionUser> findAll(Map<String, Object> parameter) {
		return super.selectList("selectByParameter", parameter);
	}

	@Override
	public List<DivisionUser> findAll(Map<String, Object> parameter, PageBounds pageBounds) {
		return super.selectList("selectByParameter", parameter, pageBounds);
	}

	@Override
	public Map<String, DivisionUser> selectDivisionUser(Map<String, Object> param) {
		return super.selectMap("selectByParameter", param,"user.id");
	}

	@Override
	public int deleteDivisionUserByParameter(Map<String, Object> parameter) {
		return super.delete("batchDeleteByParameter", parameter);
	}

	@Override
	public Map<String, List<DivisionUser>> selectDivisionUserMap(Map<String, Object> param) {
		return super.selectMap("selectByParameter", param,"division.id");
	}

	
}
