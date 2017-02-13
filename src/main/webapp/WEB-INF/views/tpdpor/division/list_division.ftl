<#include "/tpdpor/common/include/layout.ftl"/>
<#import "/tpdpor/common/tags/image.ftl" as image/>

<#assign jsArray=['${ctx!}/js/common/laypage/laypage.js']/>
<#assign cssArray=[]/>
<#assign formId='list_divisiont_form' />
<@layout jsArray=jsArray cssArray=cssArray>
	<@divisionsDirective name=(division.name)! page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders=(param_orders)!'CREATE_TIME.DESC'>
	<div class="g-frame">
		<form id="${formId!}" action="${ctx!}/division" method="get">
	    <div class="g-mn-tit">
	        <h2 class="m-tit">部门列表</h2>
	        <label class="m-srh">
	            <input name="name" value="${(division.name)!}" type="text" class="ipt" placeholder="部门名称">
	            <i onclick="$('#${formId!}').submit();" class="u-srh1-ico"></i>
	        </label>
	    </div>
	    <div class="g-mn-mod">
	        <div class="g-train-box">
	           <#--  <div class="m-type-tab">
	                <a href="javascript:;" class="z-crt">默认</a>
	                <a href="javascript:;">下载量</a>
	                <a href="javascript:;">评分</a>
	                <a href="javascript:;">上传时间</a>
	            </div> -->
	            <ul class="m-train-lst">
		            <#if (divisions)??>
		            	<#list divisions as division>
			                <li>
			                    <div class="block">
			                        <a href="${ctx!}/division/${(division.id)!}/view" class="img dept" target="_blank">
			                        	<@image.imageFtl url="${(division.imageUrl)!}" default="/images/tpdpor/${(app_path)!}/defaultDivision.jpg"/>
			                        </a>
			                        <div class="m-case-info">
			                            <h3 class="u-tit"><a href="${ctx!}/division/${(division.id)!}/view" target="_blank">${(division.name)!}</a></h3>
			                            <#assign divisionSummary = JsonMapper.getJsonMapValue(division.summary, 'text')! />
			                            <p class="u-txt">
				                            <#if divisionSummary?length lt 80>   
												${(divisionSummary)!}
											<#else> 
											     ${divisionSummary[0..80]}... 
											</#if>
			                            </p>
			                            <div class="u-btm">
			                            	 <#-- 共享资源：12<span class="line">|</span>参加人数：100资源下载量：23<span class="line">|</span>浏览量：125 -->
			                            </div>
			                        </div>
			                        <div class="m-rt">
			                            <div class="mid">
			                                <a href="${ctx!}/division/${(division.id)!}/view" class="u-btn-theme" target="_blank">进入</a>
			                            </div>
			                        </div>
			                    </div>
			                </li>
	                	</#list>
	                </#if>
	            </ul>
	        </div>
	        <div class="g-res-page">
		        <span class="num">共<b>${(paginator.totalCount)!0}</b>个教学部门</span>
		        <div id="expert_page" class="m-page-jump res"></div>
				<#import '/tpdpor/common/tags/pagination.ftl' as p />
				<@p.paginationFtl formId=formId! divId="expert_page" paginator=paginator />
		    </div>
	    </div>
		</form>
	</div>
	</@divisionsDirective>
</@layout>