package com.haoyu.tpdpor.file.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.file.service.IFileInfoService;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@Controller
@RequestMapping("**/tpdpor/file")
public class FileTpdporController extends AbstractBaseController{

	@Resource
	private IFileInfoService fileInfoService;
	
	private String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getPath("/common/include/");
	}
	
	@RequestMapping("previewFile")
	public String previewFile(String fileId, Model model){
		setParameterToModel(request, model);
		model.addAttribute("fileInfo", fileInfoService.get(fileId));
		return getViewNamePerfix() + "preview_file";
	}
}
