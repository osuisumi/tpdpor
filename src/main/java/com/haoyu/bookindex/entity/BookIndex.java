package com.haoyu.bookindex.entity;

import java.util.List;

import com.google.common.collect.Lists;
import com.haoyu.sip.auth.entity.AuthResource;
import com.haoyu.sip.core.entity.BaseEntity;
/*
 * 图书索引
 */
public class BookIndex extends BaseEntity {

	private static final long serialVersionUID = 1L;

	private String id;
	private String name;
	private String bIndex; //图书索引号 唯一
	private String value;//去掉父索引前缀的索引号
	private BookIndex parent;
	private List<BookIndex> children = Lists.newArrayList();
	private Integer sortNo;
	private int fileNum;//文件数量
	private String parentIds;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public Integer getSortNo() {
		return sortNo;
	}

	public void setSortNo(Integer sortNo) {
		this.sortNo = sortNo;
	}

	public BookIndex getParent() {
		return parent;
	}

	public void setParent(BookIndex parent) {
		this.parent = parent;
	}

	public List<BookIndex> getChildren() {
		return children;
	}

	public void setChildren(List<BookIndex> children) {
		this.children = children;
	}

	public String getbIndex() {
		return bIndex;
	}

	public void setbIndex(String bIndex) {
		this.bIndex = bIndex;
	}
	
	
	
	public int getFileNum() {
		return fileNum;
	}

	public void setFileNum(int fileNum) {
		this.fileNum = fileNum;
	}

	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}

	//获取以当前对象为跟节点的树的所有id
	public List<String> getTreeAllId(List<String> result){
		result.add(this.getId());
		if(children!=null && children.size()>0){
			for(BookIndex bi:children){
				bi.getTreeAllId(result);
			}
		}
		return result;
	}
	
	//遍历树
	public List<BookIndex> getTreeAllNode(List<BookIndex> result){
		result.add(this);
		if(children!=null && children.size()>0){
			for(BookIndex bi:children){
				bi.getTreeAllNode(result);
			}
		}
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if(!(obj instanceof BookIndex) || obj == null){
			return false;
		}else{
			BookIndex other = (BookIndex) obj;
			if(other.getId()!=null && this.getId()!=null){
				if(other.getId().equals(this.getId())){
					return true;
				}else{
					return false;
				}
			}
			return false;
		}
		
	}
	
	//根据id获取字树
	public BookIndex getChildTreeById(String childId){
		if(this.getId().equals(childId)){
			return this;
		}else{
			BookIndex result = null;
			if(children!=null &&children.size()>0){
				for(BookIndex r:children){
					BookIndex child = r.getChildTreeById(childId);
					if(child!=null){
						result = child;
						break;
					}
				}
			}
			return result;
		}
	}
	
	

}
