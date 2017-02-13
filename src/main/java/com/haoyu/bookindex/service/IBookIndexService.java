package com.haoyu.bookindex.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.bookindex.entity.BookIndex;
import com.haoyu.sip.core.service.Response;

public interface IBookIndexService {
	
	Response createBookIndex(BookIndex BookIndex);
	
	Response updateBookIndex(BookIndex BookIndex);
	
	Response deleteBookIndex(BookIndex BookIndex);
	
	Response deleteBookIndexAndAllChildren(BookIndex bookIndex);
	
	BookIndex findBookIndexByBIndex(String bIndex);
	
	BookIndex findBookIndexById(String id);
	
	List<BookIndex> findBookIndexs(Map<String,Object> parameter,PageBounds pageBounds,boolean getTree);
	
}
