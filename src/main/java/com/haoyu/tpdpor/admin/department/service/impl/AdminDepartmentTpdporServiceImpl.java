package com.haoyu.tpdpor.admin.department.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.user.dao.IDeparmentDao;
import com.haoyu.sip.utils.Identities;
import com.haoyu.tpdpor.admin.department.dao.IAdminDepartmentTpdporDao;
import com.haoyu.tpdpor.admin.department.entity.DepartmentExtend;
import com.haoyu.tpdpor.admin.department.service.IAdminDepartmentTpdporService;

@Service
public class AdminDepartmentTpdporServiceImpl implements IAdminDepartmentTpdporService{

	@Resource
	private IDeparmentDao deparmentDao;
	@Resource
	private IAdminDepartmentTpdporDao adminDeparmentTpdporDao;
	
	@Override
	public Response createDepartment(DepartmentExtend department) {
		Response response = Response.failInstance();
		if (department == null) {
			return Response.failInstance();
		}
		if (StringUtils.isEmpty(department.getId())) {
			department.setId(Identities.uuid2());
		}
		department.setDefaultValue();
		int count = adminDeparmentTpdporDao.insertDepartment(department);
		if (count > 0) {
			response = Response.successInstance();
		}
		return response;
	}

	@Override
	public DepartmentExtend findDepartmentById(String id) {
		return adminDeparmentTpdporDao.selectDepartmentById(id);
	}

	@Override
	public Response updateDepartment(DepartmentExtend department) {
		Response response = Response.failInstance();
		if (department == null || StringUtils.isEmpty(department.getId())) {
			return Response.failInstance();
		}
		department.setUpdateValue();
		int count = adminDeparmentTpdporDao.updateDeparment(department);
		if (count > 0) {
			response =Response.successInstance();
		}
		return response;
	}

	@Override
	public List<DepartmentExtend> findByParameter(Map<String, Object> parameter, PageBounds pageBounds) {
		return adminDeparmentTpdporDao.selectByParameter(parameter, pageBounds);
	}

}
