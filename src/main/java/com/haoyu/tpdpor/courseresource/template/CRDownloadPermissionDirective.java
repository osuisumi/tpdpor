package com.haoyu.tpdpor.courseresource.template;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Component;

import com.google.common.collect.Maps;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.excel.utils.StringUtils;
import com.haoyu.sip.point.entity.PointRecord;
import com.haoyu.sip.point.service.IPointRecordService;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tip.resource.service.IResourceService;
import com.haoyu.tpdpor.courseresource.utils.CourseResourceDownloadPermission;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class CRDownloadPermissionDirective extends AbstractTemplateDirectiveModel{
	@Resource
	private IResourceService resourceService;
	@Resource
	private IPointRecordService pointRecordService;
	
	private Map<String,Object> getDownloadPermission(Resources resource){
		Map<String,Object> result = Maps.newHashMap();
		if(resource == null){
			result.put("downloadPermission", CourseResourceDownloadPermission.NO_FILE) ;
		}else if(resource.getCreator()!=null && ThreadContext.getUser().getId().equals(resource.getCreator().getId())){
			result.put("downloadPermission", CourseResourceDownloadPermission.DOWNLOAD) ;
		}else if(resource.getResourceExtend() == null){
			result.put("downloadPermission", CourseResourceDownloadPermission.DOWNLOAD) ;
		}else if(resource.getResourceExtend().getPrice() == null || resource.getResourceExtend().getPrice().equals(new BigDecimal(0))){
			result.put("downloadPermission", CourseResourceDownloadPermission.DOWNLOAD) ;
		}else{
			Map<String,Object> parameter = Maps.newHashMap();
			parameter.put("userId", ThreadContext.getUser().getId());
			parameter.put("entityId", resource.getId());
			List<PointRecord> records = pointRecordService.findPointRecords(parameter, null);
			if(CollectionUtils.isNotEmpty(records)){
				result.put("downloadPermission", CourseResourceDownloadPermission.DOWNLOAD) ;
			}else{
				Float myPoint = pointRecordService.findUserPoint(ThreadContext.getUser().getId(), "tpdpor", "tpdpor");
				result.put("myPoint", myPoint);
				myPoint = myPoint == null?new Float(0):myPoint;
				if(resource.getResourceExtend().getPrice().compareTo(new BigDecimal(myPoint))>0){
					result.put("downloadPermission", CourseResourceDownloadPermission.NEED_MORE_POINT) ;
				}else{
					result.put("downloadPermission", CourseResourceDownloadPermission.PAY_DOWNLOAD) ;
				}
			}
		}
		return result;
	}

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String,Object> parameter = getSelectParam(params);
		String resourceId = (String.valueOf(parameter.get("resourceId")));
		if(ThreadContext.getUser()!=null && StringUtils.isNotEmpty(ThreadContext.getUser().getId())){
			Resources resource = resourceService.get(resourceId);
			env.setVariable("mapResult",new DefaultObjectWrapper().wrap(getDownloadPermission(resource)));
			env.setVariable("resource",new DefaultObjectWrapper().wrap(resource));
		}
		body.render(env.getOut());
	}

}
