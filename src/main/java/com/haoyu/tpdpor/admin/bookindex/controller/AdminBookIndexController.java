package com.haoyu.tpdpor.admin.bookindex.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.bookindex.entity.BookIndex;
import com.haoyu.bookindex.service.IBookIndexService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@Controller
@RequestMapping("**/admin/book_index")
public class AdminBookIndexController extends AbstractBaseController{
	@Resource
	private IBookIndexService bookIndexService;
	
	protected String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getAdminPath("/bookindex/");
	}
	
	@RequestMapping(value="tree",method=RequestMethod.GET)
	public String tree(Model model){
		setParameterToModel(request, model);
		return getViewNamePerfix() + "book_index_tree";
	}
	
	@RequestMapping(value="create",method=RequestMethod.GET)
	public String create(Model model){
		setParameterToModel(request, model);
		return getViewNamePerfix() + "edit_book_index";
	}
	
	@RequestMapping(value="edit/{id}",method=RequestMethod.GET)
	public String edit(@PathVariable String id,Model model){
		model.addAttribute("bookIndex",bookIndexService.findBookIndexById(id));
		return getViewNamePerfix() + "edit_book_index";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response save(BookIndex bookIndex){
		return bookIndexService.createBookIndex(bookIndex);
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	@ResponseBody
	public Response update(BookIndex bookIndex){
		return bookIndexService.updateBookIndex(bookIndex);
	}
	
	@RequestMapping(value="{id}",method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(BookIndex bookIndex){
		return bookIndexService.deleteBookIndexAndAllChildren(bookIndex);
	}

}
