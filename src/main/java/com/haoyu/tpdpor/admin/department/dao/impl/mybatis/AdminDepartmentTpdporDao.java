package com.haoyu.tpdpor.admin.department.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.tpdpor.admin.department.dao.IAdminDepartmentTpdporDao;
import com.haoyu.tpdpor.admin.department.entity.DepartmentExtend;

@Repository
public class AdminDepartmentTpdporDao extends MybatisDao implements IAdminDepartmentTpdporDao{

	@Override
	public DepartmentExtend selectDepartmentById(String id) {
		return super.selectByPrimaryKey(id);
	}

	@Override
	public List<DepartmentExtend> selectByParameter(Map<String, Object> parameter, PageBounds pageBounds) {
		return super.selectList("selectByParameter", parameter, pageBounds);
	}

	@Override
	public int updateDeparment(DepartmentExtend department) {
		return super.update(department);
	}

	@Override
	public int insertDepartment(DepartmentExtend department) {
		return super.insert(department);
	}

}
