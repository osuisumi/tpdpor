<#import "/tpdpor/common/tags/image.ftl" as image/>
<#assign formId='listResorceRecommendForm'/>
<@resourcesDirective page=(pageBounds.page)!1 limit=(pageBounds.limit)!3 orders=(param_order)!'CREATE_TIME.DESC' type=(param_type)!''>
<ul class="m-file-lst">
	<#if (resources)?size>
		<#list resources as r>
		    <li>
		        <a href="javascript:;" class="block">
		            <i class="u-file-type word"></i>
		            <h4 class="u-tit">${(r.title)!}</h4>
		            <span class="u-tips">${(r.resourceRelations[0].downloadNum)!0}人下载</span>
		            <div class="u-btm">
		                <div class="m-stars">
		                <#assign score = (r.resourceExtend.evaluateResult)!0>
		                    <i class="u-small-star <#if (score>0)>full<#else>null</#if>"></i>
		                    <i class="u-small-star <#if (score>1)>full<#else>null</#if>"></i>
		                    <i class="u-small-star <#if (score>2)>full<#else>null</#if>"></i>
		                    <i class="u-small-star <#if (score>3)>full<#else>null</#if>"></i>
		                    <i class="u-small-star <#if (score>4)>full<#else>null</#if>"></i>
		                </div>
		            </div>
		        </a>
		    </li>
    	</#list>
	</#if>
</ul>

<form id="${(formId)!}" action="${ctx!}/train_resource/recommendResource" method="get">
	<input type="hidden" name="type" value="${(param_type)!}">
	<input type="hidden" name="limit" value="${(param_limit)!}">
	<input type="hidden" name="order" value="${(param_order)!'CREATE_TIME.DESC'}">
	<input type="hidden" name="page" value="${(paginator.page)!1}" />
</form>
</@resourcesDirective>