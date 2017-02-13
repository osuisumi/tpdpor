package com.haoyu.tpdpor.comment.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.sip.comment.entity.Comment;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tpdpor.freemaker.util.TpdporViewNamePerfixUtil;

@Controller
@RequestMapping("**/tpdpor/comment")
public class CommentTpdporController extends AbstractBaseController{

	private String getViewNamePerfix(){
		return TpdporViewNamePerfixUtil.getPath("/common/tags/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Comment comment,Model model){
		setParameterToModel(request, model);
		getPageBounds(10, true);
		model.addAllAttributes(request.getParameterMap());
		return getViewNamePerfix() + "list_comment";
	}
}
