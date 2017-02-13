package com.haoyu.tpdpor.admin.department.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.tpdpor.admin.department.entity.DepartmentExtend;

public interface IAdminDepartmentTpdporDao {

	DepartmentExtend selectDepartmentById(String id);
	
	List<DepartmentExtend> selectByParameter(Map<String,Object> parameter,PageBounds pageBounds);

	int updateDeparment(DepartmentExtend department);

	int insertDepartment(DepartmentExtend department);

}
