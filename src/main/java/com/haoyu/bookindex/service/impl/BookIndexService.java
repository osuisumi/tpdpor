package com.haoyu.bookindex.service.impl;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.sip.utils.Identities;
import com.haoyu.bookindex.dao.IBookIndexDao;
import com.haoyu.bookindex.entity.BookIndex;
import com.haoyu.bookindex.service.IBookIndexService;

@Service
public class BookIndexService implements IBookIndexService{
	@Resource
	private IBookIndexDao bookIndexDao;

	@Override
	public Response createBookIndex(BookIndex bookIndex) {
		if(StringUtils.isEmpty(bookIndex.getbIndex())){
			return Response.failInstance().responseMsg("index is empty");
		}
		
		if(!validateForCreate(bookIndex)){
			return Response.failInstance().responseMsg("error index");
		}
		
		BookIndex exist = this.findBookIndexByBIndex(bookIndex.getbIndex());
		if(exist!=null){
			return Response.failInstance().responseMsg("index already exist");
		}
		
		if(StringUtils.isEmpty(bookIndex.getId())){
			bookIndex.setId(Identities.uuid2());
		}

		bookIndex.setDefaultValue();
		return bookIndexDao.insertBookIndex(bookIndex)>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public Response updateBookIndex(BookIndex bookIndex) {
		bookIndex.setUpdateValue();
		BookIndex old = this.findBookIndexById(bookIndex.getId());
		if(old != null){
			boolean indexValidate = true;//能否执行更新
			boolean isChangeSonsIndex = false;//是否修改子项的索引
			if(old.getParent() == null || StringUtils.isEmpty(old.getParent().getId())){
				//单修改索引，不改父亲
				if(bookIndex.getbIndex()!=null && !bookIndex.getbIndex().equals(old.getbIndex())){
					if(bookIndex.getParent() == null || bookIndex.getParent().getId() == null){
						BookIndex exist = findBookIndexByBIndex(bookIndex.getbIndex());
						if(exist!=null){
							return Response.failInstance().responseMsg("index already exist");
						}
						isChangeSonsIndex = true;
						bookIndex.setValue(bookIndex.getbIndex());
					}
				}
				//修改父亲
				if(bookIndex.getParent()!=null && StringUtils.isNotEmpty(bookIndex.getParent().getId())){
					BookIndex parent = this.findBookIndexById(bookIndex.getParent().getId());
					if(bookIndex.getbIndex().indexOf(parent.getbIndex())!=0){
						indexValidate = false;
					}else{
						indexValidate = true;
						isChangeSonsIndex = true;
						bookIndex.setValue(bookIndex.getbIndex().replaceFirst(parent.getbIndex(), ""));
					}
				}
			}else{
				//单修改索引，不改父亲
				if(bookIndex.getbIndex()!=null && !bookIndex.getbIndex().equals(old.getbIndex())){
					if(bookIndex.getParent() == null || bookIndex.getParent().getId() == null || bookIndex.getParent().getId().equals(old.getParent().getId())){
						BookIndex exist = findBookIndexByBIndex(bookIndex.getbIndex());
						if(exist!=null){
							return Response.failInstance().responseMsg("index already exist");
						}
						BookIndex parent = this.findBookIndexById(old.getParent().getId());
						if(bookIndex.getbIndex().indexOf(parent.getbIndex())!=0){
							indexValidate = false;
						}else{
							indexValidate = true;
							isChangeSonsIndex = true;
							bookIndex.setValue(bookIndex.getbIndex().replaceFirst(parent.getbIndex(), ""));
						}
					}
				}
				//修改父亲
				if(bookIndex.getParent()!=null && bookIndex.getParent().getId()!=null && !bookIndex.getParent().getId().equals(old.getParent().getId())){
					if(bookIndex.getParent().getId().equals("")){
						if(StringUtils.isNotEmpty(bookIndex.getbIndex())&&!bookIndex.getbIndex().equals(old.getbIndex())){
							indexValidate = true;
							isChangeSonsIndex = true;
						}else{
							indexValidate = true;
						}
					}else{
						BookIndex parent = this.findBookIndexById(bookIndex.getParent().getId());
						if(bookIndex.getbIndex().indexOf(parent.getbIndex())!=0){
							indexValidate = false;
						}else{
							indexValidate = true;
							isChangeSonsIndex = true;
							bookIndex.setValue(bookIndex.getbIndex().replaceFirst(parent.getbIndex(), ""));
						}
					}
				}
			}
			if(!indexValidate){
				return Response.failInstance().responseMsg("error index");
			}
			int count = bookIndexDao.updateBookIndex(bookIndex);
			if(count>0&&StringUtils.isNotEmpty(bookIndex.getValue())){
				if(isChangeSonsIndex){
					BookIndex root = this.getAsTree(bookIndex.getId());
					List<BookIndex> allTreeNode = Lists.newArrayList();
					root.getTreeAllNode(allTreeNode);
					allTreeNode.remove(bookIndex);
					//循环update子项的index
					if(CollectionUtils.isNotEmpty(allTreeNode)){
						for(BookIndex bi:allTreeNode){
							BookIndex update = new BookIndex();
							update.setId(bi.getId());
							update.setbIndex(bi.getbIndex().replaceFirst(old.getbIndex(), bookIndex.getbIndex()));
							bookIndexDao.updateBookIndex(update);
						}
					}
				}
			}
			return count>0?Response.successInstance():Response.failInstance();
		}else{
			return Response.failInstance();
		}
	}

	@Override
	public Response deleteBookIndex(BookIndex bookIndex) {
		bookIndex.setUpdateValue();
		return Response.failInstance();
	}

	@Override
	public BookIndex findBookIndexById(String id) {
		return bookIndexDao.selectBookIndexById(id);
	}

	@Override
	public List<BookIndex> findBookIndexs(Map<String, Object> parameter, PageBounds pageBounds,boolean getTree) {
		if(getTree){
			return buildTree(bookIndexDao.findAll(parameter, pageBounds));
		}else{
			return bookIndexDao.findAll(parameter, pageBounds);
		}
	}
	
	private boolean validateForCreate(BookIndex bookIndex){
		if(bookIndex.getParent()!=null&&bookIndex.getParent().getId()!=null){
			BookIndex parent = bookIndex.getParent();
			if(parent.getbIndex()==null){
				parent = this.findBookIndexById(parent.getId());
				bookIndex.setParent(parent);
			}
			if(bookIndex.getbIndex().indexOf(parent.getbIndex())!=0){
				return false;
			}else{
				bookIndex.setValue(bookIndex.getbIndex().replaceFirst(parent.getbIndex(), ""));
				return true;
			}
		}else{
			bookIndex.setValue(bookIndex.getbIndex());
			return true;
		}
	}
	
	private List<BookIndex> buildTree(List<BookIndex> input){
		List<BookIndex> result = Lists.newArrayList();
		if(CollectionUtils.isNotEmpty(input)){
			Map<String,BookIndex> biMap = Collections3.extractToMap(input, "id",null);
			for(BookIndex bi:input){
				if(bi.getParent() == null ||StringUtils.isEmpty(bi.getParent().getId()) || biMap.get(bi.getParent().getId())!=null){
					result.add(bi);
				}else{
					biMap.get(bi.getParent().getId()).getChildren().add(bi);
				}
			}
		}
		return result;
	}
	
	
	private BookIndex getAsTree(String id){
		List<BookIndex> roots = this.findBookIndexs(Maps.newHashMap(), null, true);
		BookIndex result = null;
		for(BookIndex root:roots){
			result = root.getChildTreeById(id);
			if(result!=null){
				break;
			}
		}
		return result;
	}

	@Override
	public Response deleteBookIndexAndAllChildren(BookIndex bookIndex) {
		BookIndex root = this.getAsTree(bookIndex.getId());
		if(root!=null){
			List<String> allId = Lists.newArrayList();
			root.getTreeAllId(allId);
			if(CollectionUtils.isNotEmpty(allId)){
				return this.bookIndexDao.deleteLogicByIds(allId)>0?Response.successInstance():Response.failInstance();
			}
		}
		return Response.failInstance();
	}

	@Override
	public BookIndex findBookIndexByBIndex(String bIndex) {
		Map<String,Object> parameter = Maps.newHashMap();
		parameter.put("bIndex", bIndex);
		List<BookIndex> bookIndexs = findBookIndexs(parameter, null, false);
		if(CollectionUtils.isNotEmpty(bookIndexs)){
			return bookIndexs.get(0);
		}
		return null;
	}

}
