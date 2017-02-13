package com.haoyu.tpdpor.admin.department.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.core.service.Response;
import com.haoyu.tpdpor.admin.department.entity.DepartmentExtend;

public interface IAdminDepartmentTpdporService {

	Response createDepartment(DepartmentExtend department);

	DepartmentExtend findDepartmentById(String id);

	Response updateDepartment(DepartmentExtend department);
	
	List<DepartmentExtend> findByParameter(Map<String,Object> parameter,PageBounds pageBounds);

}
