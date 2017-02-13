package com.haoyu.tpdpor.tempimport.dao;

import com.haoyu.tpdpor.tempimport.entity.TempImport;

public interface ITempImportDao {
	
	int createTempImport(TempImport TempImport);

	int deleteTempImportByPid(String pid);

}
