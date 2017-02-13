package com.haoyu.tpdpor.admin.department.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.user.entity.Department;
import com.haoyu.sip.user.service.IDepartmentService;
import com.haoyu.tpdpor.admin.department.entity.DepartmentExtend;
import com.haoyu.tpdpor.admin.department.service.IAdminDepartmentTpdporService;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@RequestMapping("**/tpdpor/admin/department")
@Controller
public class AdminDepartmentTpdporController extends AbstractBaseController{

	@Resource
	private IDepartmentService departmentService;
	@Resource
	private IAdminDepartmentTpdporService adminDepartmentTpdporService;
	
	protected String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getAdminPath("/department/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Department department,Model model){
		setParameterToModel(request, model);
		getPageBounds(10, true);
		model.addAttribute("department", department);
		return getViewNamePerfix() + "list_department";
	}
	
	@RequestMapping(value="create",method=RequestMethod.GET)
	public String create(Department department, Model model){
		model.addAttribute("department",department);
		setParameterToModel(request, model);
		return getViewNamePerfix() + "edit_department";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response save(DepartmentExtend department){
		return adminDepartmentTpdporService.createDepartment(department);
	}
	
	@RequestMapping(value="{id}/edit",method=RequestMethod.GET)
	public String edit(DepartmentExtend department,Model model){
		setParameterToModel(request, model);
		model.addAttribute("department",adminDepartmentTpdporService.findDepartmentById(department.getId()));
		return getViewNamePerfix() + "edit_department";
	}
	
	@RequestMapping(value="{id}",method=RequestMethod.PUT)
	@ResponseBody
	public Response update(DepartmentExtend department){
		return this.adminDepartmentTpdporService.updateDepartment(department);
	}
	
	@RequestMapping(value="{id}",method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(DepartmentExtend department){
		return this.departmentService.batchDeleteByIds(department.getId());
	}
	
	@RequestMapping(value="countForValidDeptNameIsExist",method = RequestMethod.GET)
	@ResponseBody
	public int validDeptNameIsExist(Department department){
		return this.departmentService.validDeptNameIsExist(department);
	}
	
	@RequestMapping(value="ValidDeptCodeIsExist",method = RequestMethod.GET)
	@ResponseBody
	public int validDeptCodeIsExist(Department department){
		return this.departmentService.validDeptCodeIsExist(department);
	}
	
	@RequestMapping("entities")
	@ResponseBody
	public List<Department> entities(SearchParam searchParam){
		return departmentService.list(searchParam.getParamMap(), getPageBounds(10, true));
	}
}
