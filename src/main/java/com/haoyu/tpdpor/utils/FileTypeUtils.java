package com.haoyu.tpdpor.utils;

import org.apache.commons.lang3.StringUtils;

public class FileTypeUtils {

	private static String TYPE_SUFFIX = "suffix";

	private static String TPDPOR = "tpdpor";

	public static String getFileTypeClass(String fileName, String type) {
		String subfix = StringUtils.substringAfterLast(fileName, ".");
		if ("doc".equals(subfix) || "docx".equals(subfix)) {
			return "word";
		} else if ("xls".equals(subfix) || "xlsx".equals(subfix)) {
			return "excel";
		} else if ("ppt".equals(subfix) || "pptx".equals(subfix)) {
			return "ppt";
		} else if ("pdf".equals(subfix)) {
			return "pdf";
		} else if ("txt".equals(subfix)) {
			return "txt";
		} else if ("zip".equals(subfix) || "rar".equals(subfix)) {
			return "zip";
		} else if ("jpg".equals(subfix) || "jpeg".equals(subfix) || "png".equals(subfix) || "gif".equals(subfix)) {
			return "img";
		} else if ("mp4".equals(subfix) || "avi".equals(subfix) || "rmvb".equals(subfix) || "rm".equals(subfix) || "asf".equals(subfix) || "divx".equals(subfix) || "mpg".equals(subfix) || "mpeg".equals(subfix) || "mpe".equals(subfix) || "wmv".equals(subfix) || "mkv".equals(subfix) || "vob".equals(subfix) || "3gp".equals(subfix)) {
			if (TYPE_SUFFIX.equals(type)) {
				return "video";
			}else if(TPDPOR.equals(type)){
				return "mv";
			}
		} else {
			if (TYPE_SUFFIX.equals(type)) {
				return "other";
			}else if(TPDPOR.equals(type)){
				return "zip";
			}
		}
		return "";
	}

}
