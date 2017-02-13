package com.haoyu.bookindex.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Maps;
import com.haoyu.bookindex.dao.IBookIndexDao;
import com.haoyu.bookindex.entity.BookIndex;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class BookIndexDao extends MybatisDao implements IBookIndexDao {

	@Override
	public BookIndex selectBookIndexById(String id) {
		return super.selectByPrimaryKey(id);
	}

	@Override
	public int insertBookIndex(BookIndex BookIndex) {
		BookIndex.setDefaultValue();
		return super.insert(BookIndex);
	}

	@Override
	public int updateBookIndex(BookIndex BookIndex) {
		BookIndex.setUpdateValue();
		return super.update(BookIndex);
	}

	@Override
	public int deleteBookIndexByLogic(BookIndex BookIndex) {
		BookIndex.setUpdateValue();
		return super.deleteByLogic(BookIndex);
	}

	@Override
	public int deleteBookIndexByPhysics(String id) {
		return super.deleteByPhysics(id);
	}

	@Override
	public List<BookIndex> findAll(Map<String, Object> parameter, PageBounds pageBounds) {
		return super.selectList("selectByParameter", parameter, pageBounds);
	}

	@Override
	public int updateIndexByParent(List<String> ids,String parentIndex) {
		if(CollectionUtils.isNotEmpty(ids)&&StringUtils.isNotEmpty(parentIndex)){
			Map<String,Object> parameter = Maps.newHashMap();
			parameter.put("ids", ids);
			parameter.put("parentIndex",parentIndex);
			return super.update("updateIndexByParent",parameter);
		}else{
			return 0;
		}
		
	}

	@Override
	public int deleteLogicByIds(List<String> ids) {
		if(CollectionUtils.isNotEmpty(ids)){
			return super.delete("deleteLogicByIds", ids);
		}else{
			return 0;
		}
		
	}

	
}
