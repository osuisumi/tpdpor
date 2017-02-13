<@resourcesDirective getFile=true resourceExtendType=(param_resourceExtendType)! grade=(param_grade)! version=(param_version)! stage=(param_stage)! subject=(param_subject)! chapter=(param_chapter)! section=param_section! page=(param_page)!1 limit=(param_limit)!10 orders=param_orders!'CREATE_TIME.DESC' type="course">
<#if resources?? && (resources?size >0)>
<ul class="m-resource-lst">
	<#list resources as resource>
		<#if ((resource.fileInfos?size)>1)>
			<#assign cname = "zip"/>
		<#elseif ((resource.fileInfos?size)=1)>
			<#assign cname = FileTypeUtils.getFileTypeClass((resource.fileInfos?first.fileName)!,'tpdpor')/>
		</#if>
		<li class="${cname!}">
			<h4 class="u-tit"><i class="u-ico"></i><a href="${ctx}/course_resource/view/${resource.id}">${(resource.title)!}</a></h4>
			<p class="u-info">
				<span class="u-name">${(recourse.creator.realName)!}</span>
				<span class="info-txt">
					上传于 ${TimeUtils.formatDate(resource.createTime,'yyyy-MM-dd HH:mm:ss')}
					<i class="u-line">|</i>
					类型：${(DictionaryUtils.getEntryName('COURSE_RESOURCE_TYPE',(resource.resourceExtend.type)!''))!}
					<i class="u-line">|</i>
					下载量：${(resource.resourceRelations[0].downloadNum)!0}
					<i class="u-line">|</i>
					浏览量：${(resource.resourceRelations[0].browseNum)!0}
					<i class="u-line">|</i>
					下载积分：${(resource.resourceExtend.price)!0}
				</span>
			</p>
			<#--
			<div class="m-stars">
				<#assign score = (resource.resourceExtend.evaluateResult)!0>
				<div class="u-stars">
					<i class="u-small-star <#if (score>0)>full<#else>null</#if>"></i>
					<i class="u-small-star <#if (score>1)>full<#else>null</#if>"></i>
					<i class="u-small-star <#if (score>2)>full<#else>null</#if>"></i>
					<i class="u-small-star <#if (score>3)>full<#else>null</#if>"></i>
					<i class="u-small-star <#if (score>4)>full<#else>null</#if>"></i>
				</div>
			</div>
			-->
		</li>
	</#list>
</ul>
<#else>
<div class="m-no-resorce">
    <p>还没有资源哦~</p>
</div>
</#if>
</@resourcesDirective>
<form id="list_course_resource_form" action="${ctx}/course_resource" method="get">
	<input type="hidden" name="stage" value="${param_stage!}">
	<input type="hidden" name="subject" value="${param_subject!}">
	<input type="hidden" name="grade" value="${param_grade!}">
	<input type="hidden" name="version" value="${param_version!}">
	<input type="hidden" name="resourceExtendType" value="${param_resourceExtendType!}">
	<input type="hidden" name="section" value="${param_section!}">
	<input type="hidden" name="orders" value="${(param_orders)!}">
<div class="g-res-page">
	<span class="num">共<b>${(paginator.totalCount)!}</b>个资源</span>
	<div id="course_resource_page" class="m-page-jump res"></div>
	<#import '/tpdpor/common/tags/pagination_ajax.ftl' as p />
	<@p.paginationAjaxFtl formId="list_course_resource_form" divId="course_resource_page" paginator=paginator contentId='course_resource_div' />
</div>
</form>