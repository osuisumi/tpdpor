package com.haoyu.tpdpor.search.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.Paginator;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.search.entity.QueryField;
import com.haoyu.search.entity.SearchResultBean;
import com.haoyu.search.utils.IndexUtils;
import com.haoyu.search.utils.SearchUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.PropertiesLoader;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.tip.creative.entity.Creative;
import com.haoyu.tip.creative.service.ICreativeService;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tip.resource.service.IResourceService;
import com.haoyu.tpdpor.search.entity.PageAndResults;
import com.haoyu.tpdpor.search.entity.SearchResult;
import com.haoyu.tpdpor.search.service.ISearchService;

//@Service
public class SearchServiceImpl2 implements ISearchService {
	@Resource
	private IResourceService resourceService;
	@Resource
	private ICreativeService creativeService;

	@Override
	public PageAndResults list(Map<String,Object> parameter, PageBounds pageBounds) {
		List<QueryField> queryFields = Lists.newArrayList();
		if (parameter.containsKey("keywords")) {
			QueryField queryField = new QueryField();
			queryField.setValue((String)parameter.get("keywords"));
			queryField.setFields(new String[]{"title"});
			queryFields.add(queryField);
		}
		if (parameter.containsKey("type")) {
			QueryField queryField = new QueryField();
			queryField.setValue((String)parameter.get("type"));
			queryField.setFields(new String[]{"type"});
			queryFields.add(queryField);
		}
		if (parameter.containsKey("stage")) {
			QueryField queryField = new QueryField();
			queryField.setValue((String)parameter.get("stage"));
			queryField.setFields(new String[]{"stage"});
			queryFields.add(queryField);
		}
		if (parameter.containsKey("subject")) {
			QueryField queryField = new QueryField();
			queryField.setValue((String)parameter.get("subject"));
			queryField.setFields(new String[]{"subject"});
			queryFields.add(queryField);
		}
		if (parameter.containsKey("grade")) {
			QueryField queryField = new QueryField();
			queryField.setValue((String)parameter.get("grade"));
			queryField.setFields(new String[]{"grade"});
			queryFields.add(queryField);
		}
		SearchResultBean searchResultBean = SearchUtils.searchDocument(queryFields, pageBounds.getPage(), pageBounds.getLimit(), true, "title", "<em class='u-key'>", "</em>");
		List<SearchResult> searchResults = Lists.newArrayList();
		if (Collections3.isNotEmpty(searchResultBean.getDocuments())) {
			for (Document doc : searchResultBean.getDocuments()) {
				SearchResult searchResult = new SearchResult();
				searchResult.setId(doc.get("id"));
//				if (searchResultBean.getHighLightValues().containsKey(searchResult.getId())) {
//					searchResult.setTitle(searchResultBean.getHighLightValues().get(searchResult.getId()));
//				}else{
//					searchResult.setTitle(doc.get("title"));
//				}
				searchResult.setTitle(doc.get("title"));
				searchResult.setType(doc.get("type"));
				searchResult.setCreateTime(doc.get("createTime"));
				searchResults.add(searchResult);
			}
		}
		Paginator paginator = new Paginator(pageBounds.getPage(), pageBounds.getLimit(), searchResultBean.getTotalCount());
		PageAndResults pageAndResults = new PageAndResults();
		pageAndResults.setSearchResults(searchResults);
		pageAndResults.setPaginator(paginator);
		return pageAndResults;
	}

	@Override
	public Response initSearchIndex() {
		List<Map<String, Object>> list = Lists.newArrayList();
		List<Resources> resources = resourceService.list(Maps.newHashMap(), null);
		if(CollectionUtils.isNotEmpty(resources)){
			for (Resources resource : resources) {
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", resource.getId());
				if(StringUtils.isNotEmpty(resource.getTitle())){
					map.put("title", resource.getTitle());
				}
				map.put("createTime", DateFormatUtils.format(resource.getCreateTime(), "yyyy-MM-dd"));
				if(StringUtils.isNotEmpty(resource.getType())){
					if(CollectionUtils.isNotEmpty(resource.getResourceRelations())&&resource.getResourceRelations().get(0).getRelation()!=null && StringUtils.isNotEmpty(resource.getResourceRelations().get(0).getRelation().getType())){
						map.put("type", resource.getResourceRelations().get(0).getRelation().getType());	
					}else{
						map.put("type", resource.getType());
					}
					if(resource.getResourceExtend()!=null){
						if (StringUtils.isNotEmpty(resource.getResourceExtend().getStage())) {
							map.put("stage", resource.getResourceExtend().getStage());
						}
						if (StringUtils.isNotEmpty(resource.getResourceExtend().getSubject())) {
							map.put("subject", resource.getResourceExtend().getSubject());
						}
						if (StringUtils.isNotEmpty(resource.getResourceExtend().getGrade())) {
							map.put("grade", resource.getResourceExtend().getGrade());
						}
					}
				}
				list.add(map);
			}
		}
		
		List<Creative> creatives = creativeService.findCreatives(Maps.newHashMap(), null);
		if(CollectionUtils.isNotEmpty(creatives)){
			for(Creative c:creatives){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", c.getId());
				map.put("title", c.getTitle());
				map.put("createTime", DateFormatUtils.format(c.getCreateTime(), "yyyy-MM-dd"));
				map.put("type","creative");
				list.add(map);
			}
		}
		IndexUtils.updateIndex(list, true);
		return Response.successInstance();
	}
	
	
	@Scheduled(cron = "0 0 6 * * ?")
	public void initTask(){
		initSearchIndex();
	}
	
	@PostConstruct
	public void init(){
		File indexDir = new File(PropertiesLoader.get("lucene.index.dir"));
		Directory fsDirectory;
		try {
			fsDirectory = FSDirectory.open(indexDir);
			if(IndexWriter.isLocked(fsDirectory)){
				IndexWriter.unlock(fsDirectory);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

}
