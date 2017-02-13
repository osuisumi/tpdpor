package com.haoyu.bookindex.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.bookindex.entity.BookIndex;

public interface IBookIndexDao {

	BookIndex selectBookIndexById(String id);

	int insertBookIndex(BookIndex BookIndex);

	int updateBookIndex(BookIndex BookIndex);

	int deleteBookIndexByLogic(BookIndex BookIndex);

	int deleteBookIndexByPhysics(String id);
	
	int deleteLogicByIds(List<String> ids);

	List<BookIndex> findAll(Map<String, Object> parameter, PageBounds pageBounds);
	
	int updateIndexByParent(List<String> ids,String parentIndex);

}