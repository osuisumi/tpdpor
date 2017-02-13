package com.haoyu.expert.dao.impl.mybatis;

import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.expert.dao.IExpertDao;
import com.haoyu.expert.entity.Expert;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class ExpertDao extends MybatisDao implements IExpertDao {

	@Override
	public Expert selectExpertById(String id) {
		return super.selectByPrimaryKey(id);
	}

	@Override
	public int insertExpert(Expert expert) {
		expert.setDefaultValue();
		return super.insert(expert);
	}

	@Override
	public int updateExpert(Expert expert) {
		expert.setUpdateValue();
		return super.update(expert);
	}

	@Override
	public int deleteExpertByLogic(Expert expert) {
		expert.setUpdateValue();
		return super.deleteByLogic(expert);
	}

	@Override
	public int deleteExpertByPhysics(String id) {
		return super.deleteByPhysics(id);
	}

	@Override
	public List<Expert> findAll(Map<String, Object> parameter) {
		return super.selectList("selectByParameter", parameter);
	}

	@Override
	public List<Expert> findAll(Map<String, Object> parameter, PageBounds pageBounds) {
		return super.selectList("selectByParameter", parameter, pageBounds);
	}

	
}
