package com.haoyu.tpdpor.teachresource.service.impl;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.dict.entity.DictEntry;
import com.haoyu.dict.utils.DictionaryUtils;
import com.haoyu.sip.core.entity.Relation;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.PropertiesLoader;
import com.haoyu.sip.excel.ExcelImport;
import com.haoyu.sip.textbook.entity.TextBookEntry;
import com.haoyu.sip.textbook.utils.TextBookUtils;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.sip.utils.TimeUtils;
import com.haoyu.tip.resource.entity.ResourceExtend;
import com.haoyu.tip.resource.entity.ResourceRelation;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tip.resource.service.IResourceService;
import com.haoyu.tpdpor.teachresource.excel.TeachResourceExport;
import com.haoyu.tpdpor.teachresource.excel.TeachResourceModel;
import com.haoyu.tpdpor.teachresource.service.ITeachResourceService;
import com.haoyu.tpdpor.tempimport.entity.TempImport;
import com.haoyu.tpdpor.tempimport.service.ITempImportService;
import com.haoyu.tpdpor.utils.AccountRoleCode;
import com.haoyu.tpdpor.utils.ResourceType;

import ch.qos.logback.core.util.TimeUtil;
import freemarker.template.SimpleDate;

@Service
public class TeachResourceService implements ITeachResourceService{
	@Resource
	private PropertiesLoader propertiesLoader;
	@Resource
	private ITempImportService tempImportService;
	@Resource
	private IResourceService resourceService;

	@Override
	public Map<String,Object> importPreviewUrl(String url) {
		String tempFileDir = propertiesLoader.getProperty("file.temp.dir");
		File file = new File(tempFileDir + url);
		Map<String, Object> resultMap = Maps.newHashMap();
		int successNum = 0;
		List<TeachResourceExport> successList = Lists.newArrayList();
		List<String> failList = Lists.newArrayList();
		ExcelImport<TeachResourceModel> ei = new ExcelImport<TeachResourceModel>(TeachResourceModel.class);
		Collection<TeachResourceModel> list = ei.importExcel(file, 0, 1);
		for (String str : ei.getErrorMsg()) {
			failList.add(str);
		}
		if(CollectionUtils.isNotEmpty(list)){
			//获取所有学科学段年级
			List<TextBookEntry> stageList = TextBookUtils.getEntryList("STAGE");
			List<TextBookEntry> subjectList = TextBookUtils.getEntryList("SUBJECT");
			List<TextBookEntry> gradeList = TextBookUtils.getEntryList("GRADE");
			
			Map<String,String> stageNameMap = Collections3.extractToMap(stageList, "textBookName", "textBookValue");
			Map<String,String> subjectNameMap = Collections3.extractToMap(subjectList, "textBookName", "textBookValue");
			Map<String,String> gradeNameMap = Collections3.extractToMap(gradeList, "textBookName", "textBookValue");
			
			//获取teachresource类型
			List<DictEntry> extendTypeList = DictionaryUtils.getEntryList("TEACH_RESOURCE_TYPE");
			Map<String,String> extendTypeNameMap = Collections3.extractToMap(extendTypeList, "dictName", "dictValue");
			
			//获取已存在的链接
			//Map<String,Object> parameter = Maps.newHashMap();
			//parameter.put("type",ResourceType.TEACH);
			//parameter.put("isOriginal", "N");
			//List<Resources> existPreviewUrlResources = resourceService.list(parameter, null) ;
			
			//List<String> existPreviewUrls =CollectionUtils.isEmpty(existPreviewUrlResources)?Lists.newArrayList():Collections3.extractToList(existPreviewUrlResources, "resourceExtend.previewUrl");
			
			for(TeachResourceModel trm:list){
				//if(existPreviewUrls.contains(trm.getPreviewUrl().trim())){
					Resources resource = new Resources();
					resource.setType(com.haoyu.tpdpor.utils.ResourceType.TEACH);
					ResourceExtend resourceExtend = new ResourceExtend();
					ResourceRelation resourceRelation = new ResourceRelation();
					resourceRelation.setRelation(new Relation(com.haoyu.tpdpor.utils.ResourceType.TEACH, com.haoyu.tpdpor.utils.ResourceType.TEACH));
					resource.setResourceExtend(resourceExtend);
					resource.getResourceRelations().add(resourceRelation);
					
					resourceExtend.setIsOriginal("N");
					resourceExtend.setPreviewUrl(trm.getPreviewUrl().trim());
					if(StringUtils.isNotEmpty(trm.getStage())){
						resourceExtend.setStage(stageNameMap.get(trm.getStage().trim()));
					}
					if(StringUtils.isNotEmpty(trm.getSubject())){
						resourceExtend.setSubject(subjectNameMap.get(trm.getSubject().trim()));
					}
					if(StringUtils.isNotEmpty(trm.getGrade())){
						resourceExtend.setGrade(gradeNameMap.get(trm.getGrade().trim()));
					}
					
					resource.setTitle(trm.getTitle().trim());
					
					if(StringUtils.isNotEmpty(trm.getBIndex())){
						resourceExtend.setbIndex(trm.getBIndex().trim());
					}
					if(StringUtils.isNotEmpty(trm.getAuthor())){
						resourceExtend.setAuthor(trm.getAuthor().trim());
					}
					if(StringUtils.isNotEmpty(trm.getSource())){
						resourceExtend.setSource(trm.getSource().trim());
					}
					if(StringUtils.isNotEmpty(trm.getIssueDate())){
						try{
							SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
							Date year = sdf.parse(trm.getIssueDate().trim());
							resourceExtend.setIssueDate(year);
						}catch(ParseException e){
							
						}
					}
					if(StringUtils.isNotEmpty(trm.getType())){
						resourceExtend.setType(extendTypeNameMap.get(trm.getType().trim()));
					}
					if(StringUtils.isNotEmpty(trm.getSummary())){
						resource.setSummary(trm.getSummary());
					}
					//开放对象
					if(StringUtils.isNotEmpty(trm.getBelong())){
						if(trm.getBelong().contains("直属校教师")){
							if(StringUtils.isEmpty(resource.getBelong())){
								resource.setBelong(AccountRoleCode.ZSXJS);
							}else{
								resource.setBelong(resource.getBelong()+","+AccountRoleCode.ZSXJS);
							}
						}
						if(trm.getBelong().contains("直属校学生")){
							if(StringUtils.isEmpty(resource.getBelong())){
								resource.setBelong(AccountRoleCode.ZSXXS);
							}else{
								resource.setBelong(resource.getBelong()+"," + AccountRoleCode.ZSXXS);
							}
						}
						if(trm.getBelong().contains("教师认证会员")){
							if(StringUtils.isEmpty(resource.getBelong())){
								resource.setBelong(AccountRoleCode.JSRZHY);
							}else{
								resource.setBelong(resource.getBelong()+","+AccountRoleCode.JSRZHY);
							}
						}
					}
					Response response = resourceService.createResource(resource);
					if(response.isSuccess()){
						successNum = successNum +1 ;
					}else{
						failList.add("第" + trm.getLineNumber() + "行导入失败");
					}
			//	}
				
			}

		}
		resultMap.put("successNum",successNum);
		resultMap.put("failList", failList);
		return resultMap;
	}
	

}
