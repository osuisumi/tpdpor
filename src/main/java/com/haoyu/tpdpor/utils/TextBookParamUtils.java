package com.haoyu.tpdpor.utils;

import com.haoyu.sip.excel.utils.StringUtils;
import com.haoyu.sip.textbook.utils.TextBookParam;
import com.haoyu.tip.resource.entity.Resources;

public class TextBookParamUtils {

	public static TextBookParam buildTextBookParam(String typeCode, Object obj) {
		TextBookParam textBookParam = new TextBookParam();
		textBookParam.setTextBookTypeCode(typeCode);
		if (obj instanceof Resources) {
			Resources resource = (Resources) obj;
			if (resource != null && resource.getResourceExtend() != null) {
				if (StringUtils.isNotEmpty(resource.getResourceExtend().getStage())) {
					textBookParam.setStage(resource.getResourceExtend().getStage());
				}
				if (StringUtils.isNotEmpty(resource.getResourceExtend().getSubject())) {
					textBookParam.setSubject(resource.getResourceExtend().getSubject());
				}
				if (StringUtils.isNotEmpty(resource.getResourceExtend().getGrade())) {
					textBookParam.setGrade(resource.getResourceExtend().getGrade());
				}
				if (StringUtils.isNotEmpty(resource.getResourceExtend().getTbVersion())) {
					textBookParam.setVersion(resource.getResourceExtend().getTbVersion());
				}
				if (StringUtils.isNotEmpty(resource.getResourceExtend().getChapter())) {
					textBookParam.setSection(resource.getResourceExtend().getChapter());
				}
			}
		}

		TextBookParam result = new TextBookParam();
		result.setTextBookTypeCode(typeCode);
		if (typeCode.equals("SUBJECT")) {
			result.setStage(textBookParam.getStage());
		} else if (typeCode.equals("GRADE")) {
			result.setStage(textBookParam.getStage());
			result.setSubject(textBookParam.getSubject());
		} else if (typeCode.equals("VERSION")) {
			result.setStage(textBookParam.getStage());
			result.setSubject(textBookParam.getSubject());
			result.setGrade(textBookParam.getGrade());
		} else if (typeCode.equals("SECTION")) {
			result.setStage(textBookParam.getStage());
			result.setSubject(textBookParam.getSubject());
			result.setGrade(textBookParam.getGrade());
			result.setVersion(textBookParam.getVersion());
		}
		return result;
	}

}
