<#import "/tpdpor/common/include/layout.ftl" as layout />
<#assign cssArray=['${ctx}/css/tpdpor/es/zTreeStyle/zTreeStyle.css']/>
<#assign jsArray=['/js/tpdpor/library/laypage/laypage.js','/js/tpdpor/textbook.js','${ctx}/js/common/ztree/js/jquery.ztree.core.min.js']/>
<@layout.layout jsArray=jsArray cssArray=cssArray containSearch=false>
<div class="g-cont-detail-box m-upres">
<@searchDirective keywords=param_searchKeywords! type=param_searchType! page=param_page!1 limit=param_limit!10>
	<div class="m-upres-head">                        
        <div class="m-search style1">
            <input id="searchKeywords" type="text" placeholder="输入资源名称" class="ipt" value="${(param_searchKeywords)!}">
            <input type="hidden" id="searchType" value="${(param_searchType)!}">
            <div class="slt">
            	<#if (param_searchType!'') == 'teach'>
            		<#assign typeShowName = '教研资料'/>
            	<#elseif (param_searchType!'') == 'course'>
            		<#assign typeShowName = '课程案例'/>
            	<#elseif (param_searchType!'') == 'train_resource' >
            		<#assign typeShowName = '培训学习'/>
            	<#elseif (param_searchType!'') == 'creative'>
            		<#assign typeShowName = '教师创客'/>
            	<#else>
            		<#assign typeShowName = '全库搜索'/>
            	</#if>
                <strong><span>${typeShowName!}</span><i class="ico"></i></strong>
                <div class="lst">
                    <a value="" href="javascript:;" class="z-crt">全库搜索</a>
                    <a value="teach" href="javascript:;">教研资料</a>
                    <a value="course" href="javascript:;">课程案例</a>
                    <a value="train_resource" href="javascript:;">培训学习</a>
                    <a value="creative" href="javascript:;">教师创客</a>
                </div>
            </div>
            <a onclick="doSearch()" href="javascript:;" class="submit">搜索</a>
        </div>
    </div>
	<div class="m-search-result">
		<h3 class="u-srh-rst"><i class="u-sch-ico"></i>搜索结果</h3>
		<#if searchResults?? && (searchResults?size >0)>
		<ul class="m-slt-option">
				<#list searchResults as r>
						<#if ((r.type)!'') == 'course'>
						<li class="sch-li u-news">
							<i class="u-ltl-ico">课程案例</i>
							<a href="${ctx}/course_resource/view/${(r.id)!}" class="txt">${(r.title)!}</a>
						<#elseif ((r.type)!'') == 'teach'>
						<li class="sch-li u-res">
							<i class="u-ltl-ico">教研资料</i>
							<a href="${ctx}/teach_resource/view/${(r.id)!}" class="txt">${(r.title)!}</a>
						<#elseif ((r.type)!'') == 'train_resource'>
						<li class="sch-li u-find">					
							<i class="u-ltl-ico">培训学习</i>
							<a href="${ctx}/train_resource/${r.id}/view" class="txt">${(r.title)!}</a>
						<#elseif ((r.type)!'') == 'creative'>
						<li class="sch-li u-active">
							<i class="u-ltl-ico">教师创课</i>
							<a href="${ctx}/creative/${r.id}/view" class="txt">${(r.title)!}</a>
						</#if>
						<span class="u-time">上传于 ${(r.createTime)!}</span>
					</li>
				</#list>
		</ul>
		<#else>
			<div class="m-no-resorce">
			    <p>还符合条件的资源</p>
			</div>
		</#if>
		<p class="res-num">
			找到与<em>”${(param_searchKeywords)!}“</em>相关的资源有<em>${(paginator.totalCount)!}</em>条记录
		</p>
		<form id="listSearchForm" action="${ctx}/search">
			<input type="hidden" name="searchKeywords" value="${param_searchKeywords!}">
			<input type="hidden" name="searchType" value="${param_searchType!}">
			<div id="listSearchPage" class="g-res-page"></div>
			<#import '/userCenter/common/tags/pagination.ftl' as p />
			<@p.paginationFtl formId="listSearchForm" divId="listSearchPage" paginator=paginator! />
		</form>
	</div>
</@searchDirective>
</div>

<script>
	$(function(){
	    searchSelect();	
	});
	
	//搜索框下拉框
	function searchSelect(){
	    var $searchSelect = $(".m-search .slt");
	
	    $searchSelect.stop().on({
	        mouseenter : function(){
	            $(this).children('.lst').slideDown(200);
	        },
	        mouseleave : function(){
	            $(this).children('.lst').hide();
	        }
	    });
	    $searchSelect.on('click','.lst a',function(){
	        var $this = $(this);
	        $('#searchType').val($this.attr('value'));
	        $this.addClass('z-crt').siblings().removeClass('z-crt');
	        $this.parent().hide().prevAll('strong').children('span').text($this.text());
	    });
	};
</script>
</@layout.layout>