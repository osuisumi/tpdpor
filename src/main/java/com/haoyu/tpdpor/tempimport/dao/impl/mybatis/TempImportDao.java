package com.haoyu.tpdpor.tempimport.dao.impl.mybatis;


import org.springframework.stereotype.Repository;

import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.tpdpor.tempimport.dao.ITempImportDao;
import com.haoyu.tpdpor.tempimport.entity.TempImport;

@Repository
public class TempImportDao extends MybatisDao implements ITempImportDao{

	@Override
	public int createTempImport(TempImport tempImport) {
		return super.insert(tempImport);
	}

	@Override
	public int deleteTempImportByPid(String pid) {
		return super.delete("deleteByPid",pid);
	}


}
