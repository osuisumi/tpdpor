<#import "/userCenter/common/include/layout.ftl" as lo>
<#assign jsArray = ['${ctx!}/js/common/laypage/laypage.js'] />
<#assign cssArray = ['${ctx!}/js/common/laypage/skin/laypage.css']>
<@lo.layout jsArray=jsArray cssArray=cssArray menu='znsx'>
<#assign formId="listMessageForm"/>
<@messagesDataDirective message=message pageBounds=pageBounds>
	<#import "/userCenter/common/include/form.ftl" as cf>
	<@cf.form id="${formId!}" action="${ctx!}/userCenter/message" method="get">
	<#if (messages?size > 0)>
		<div class="g-subscribe">
		    <ul class="m-letter-lst">
				<#list messages as message>
			        <li class="m-letter-con">
			            <div class="u-tit">
			                <h3 class="tt">
			                    <a href="javascript:;">${(message.title)!}</a>
			                </h3>
			                <span class="date">${TimeUtils.formatDate(message.createTime,'yyyy-MM-dd  HH:mm:ss')}</span>
			            </div>
			            <div class="u-txt">
			                <p>${(message.content)!}</p>
			            </div>
			        </li>
		    	</#list>
			</ul>
		</div>
		<div class="m-EduResc-cont">
			<div class="m-btm-opa">
				<div class="u-rt">
		        	<div class="m-laypage" id="listMessageFormPage"></div>
		        	<span class="num">找到<b>${(paginator.totalCount)!0}</b>条数据</span>
		        	<#import '/userCenter/common/tags/pagination.ftl' as p />
					<@p.paginationFtl formId="${(formId)!}" divId="listMessageFormPage" paginator=paginator! />
		    	</div>
	    	</div>
		</div>
	<#else>
		<div class="m-no-resorce">
        	<p>还没有站内私信哦~</p>
        </div>	    	
	</#if>
	</@cf.form>
<script>

</script>
</@messagesDataDirective>
</@lo.layout>