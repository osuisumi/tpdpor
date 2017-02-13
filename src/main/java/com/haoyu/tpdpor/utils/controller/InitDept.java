//package com.haoyu.tpdpor.utils.controller;
//
//import javax.annotation.Resource;
//
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//import com.haoyu.sip.core.service.Response;
//import com.haoyu.sip.core.web.AbstractBaseController;
//import com.haoyu.sip.user.entity.Department;
//import com.haoyu.sip.user.service.IDepartmentService;
//
//@Controller
//public class InitDept extends AbstractBaseController{
//	@Resource
//	private IDepartmentService departmentService;
//	public static String [] dept = {"教育学院","美术学院","远程教育中心","政法系","计算机科学系","中文系","音乐系","数学系","教育发展力研修学院","外语系","成人教育学院","物理与信息工程系","化学系","国际教育学院","生物与食品工程学院	","体育学院","思想政治理论课教学部","教育科学研究所","德育研究中心","邓小平理论与教育研究中心","心理研究与指导中心","应用数学研究所","中华民族凝聚力研究中心","民办教育研究中心","海外华文文学研究所","教师信息技术研究中心","应用生态学实验室","基础教育研究中心","学校管理研究中心","科学教育研究所","番禺附属中学","龙湖附属中学","番禺附属初中","番禺附属小学","广州南站附属学校","广东省中小学校长培训中心","广东省中小学德育研究与指导中心","广东省中小学教师教育技术能力建设项目办公室","广东省中小学校本培训项目管理办公室	","广东省高中教师培训协作组等"};
//	
//	@RequestMapping(value="dept/init")
//	public Response init(){
//		for(int i=0;i<dept.length;i++){
//			Department d = new Department();
//			d.setDeptName(dept[i]);
//			departmentService.createDepartment(d);
//		}
//		return Response.successInstance();
//	}
//
//}
