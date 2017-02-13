package com.haoyu.tpdpor.search.service;

import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.tpdpor.search.entity.PageAndResults;

public interface ISearchService {

	PageAndResults list(Map<String,Object> parameter, PageBounds pageBounds);

	Response initSearchIndex();

}
