package com.haoyu.tpdpor.tempimport.service;


import java.util.List;

import com.haoyu.sip.core.service.Response;
import com.haoyu.tpdpor.tempimport.entity.TempImport;

public interface ITempImportService {
	
	Response createList(List<TempImport> tempImports);
	
	Response deleteByPid(String pid);

}
