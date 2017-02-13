package com.haoyu.tpdpor.teachresource.excel;

import com.haoyu.sip.excel.DataType;
import com.haoyu.sip.excel.annotations.ImportField;
import com.haoyu.sip.excel.model.ImportModel;

public class TeachResourceModel extends ImportModel{
	/*资源地址	学段	年级	学科	标题	索引号	作者	出版社	出版年	类型	资源简介	开放对象*/
	@ImportField(colName = "外部资源链接地址", validate = { DataType.REQURIED })
	private String previewUrl;
	@ImportField(colName = "学段")
	private String stage;
	@ImportField(colName = "年级")
	private String grade;
	@ImportField(colName = "学科")
	private String subject;
	@ImportField(colName = "标题", validate = { DataType.REQURIED })
	private String title;
	@ImportField(colName = "索引号")
	private String bIndex;
	@ImportField(colName = "作者")
	private String author;
	@ImportField(colName = "出版社")
	private String source;
	@ImportField(colName = "出版年")
	private String issueDate;
	@ImportField(colName = "类型")
	private String type;
	@ImportField(colName = "资源简介")
	private String summary;
	@ImportField(colName = "开放对象")
	private String belong;
	public String getPreviewUrl() {
		return previewUrl;
	}
	public void setPreviewUrl(String previewUrl) {
		this.previewUrl = previewUrl;
	}
	public String getStage() {
		return stage;
	}
	public void setStage(String stage) {
		this.stage = stage;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getBIndex() {
		return bIndex;
	}
	public void setBIndex(String bIndex) {
		this.bIndex = bIndex;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getIssueDate() {
		return issueDate;
	}
	public void setIssueDate(String issueDate) {
		this.issueDate = issueDate;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getBelong() {
		return belong;
	}
	public void setBelong(String belong) {
		this.belong = belong;
	}

	
	
	

}
