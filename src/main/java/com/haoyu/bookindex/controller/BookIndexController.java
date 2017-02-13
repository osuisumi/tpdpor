package com.haoyu.bookindex.controller;

import java.util.Comparator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.bookindex.entity.BookIndex;
import com.haoyu.bookindex.service.IBookIndexService;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;

@Controller
@RequestMapping("**/book_index")
public class BookIndexController extends AbstractBaseController {
	
	@Resource
	private IBookIndexService bookIndexService;
	
	@RequestMapping(value="entities",method=RequestMethod.GET)
	@ResponseBody
	public List<BookIndex> entities(SearchParam searchParam){
		PageBounds pageBounds = new PageBounds(1,Integer.MAX_VALUE);
		pageBounds.setOrders(Order.formString("SORT_NO.ASC"));
		List<BookIndex> result = bookIndexService.findBookIndexs(searchParam.getParamMap(), pageBounds,false);
		return result;
	}

}
