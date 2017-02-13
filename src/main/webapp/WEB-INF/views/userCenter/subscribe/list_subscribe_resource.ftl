<#import "/userCenter/common/include/layout.ftl" as lo>
<#assign jsArray = ['${ctx!}/js/common/laypage/laypage.js'] />
<#assign cssArray = ['${ctx!}/js/common/laypage/skin/laypage.css']>
<@lo.layout jsArray=jsArray cssArray=cssArray menu='dytj'>
<div class="g-subscribe">
	<div class="m-subscribe-cont">
		<div class="m-subscribe-tl">
			<h3>个性订阅标签</h3>
			<#--<span class="u-user-manage"><i></i>管理</span>-->
		</div>
		<@subscribesDirective>
		<ul class="m-user-cue subscribes">
			<#if experts??>
				<#list experts as expert>
					<li class="${expert.user.id}">
						${(expert.user.realName)!}
					</li>
				</#list>
			</#if>
			<#if divisions??>
				<#list divisions as division>
					<li class="${(division.id)!}">
						${(division.name)!}
					</li>
				</#list>
			</#if>
		</ul>
		</@subscribesDirective>
		<@resourcesBizDirective relationType='train_resource' subscribeCreator="${Session.loginer.id}" subscribe='Y' page=(param_page)!1 limit=param_limit!10 orders=param_orders!'CREATE_TIME.DESC' >
			<p class="m-subscribe-decri">
				符合您订阅的资源有<span>${(paginator.totalCount)!}</span>个
			</p>
			<ul class="m-subscribe-resc">
				<#if resources>
					<#list resources as resource>
						<li class="m-SCbe-resc-list"  belong="${(resource.belong)!}">
							<a href="${ctx}/train_resource/${resource.id}/view" class="m-ftTiled-block"> <span class="u-file-type word"></span> </a>
							<p class="m-ftTiled-tl">
								<a href="javascript:;">${(resource.title)!}</a>
							</p>
							<p class="who-upload">
								<span>${(resource.creator.realName)!}</span><span>上传于</span><span>${TimeUtils.formatDate(resource.createTime,'yyyy/MM/dd')}</span>
							</p>
							<ul class="m-user-cue">
                   	 		</ul>
						</li>
					</#list>
				</#if>
			</ul>
			<div class="m-btm-opa">
				<form id="subscribeForm" action="${ctx}/userCenter/subscribe_resource" method="get">
			       <div class="u-rt">
			           <div class="m-laypage" id="subscribe"></div>
			           <span class="num">找到<b>${(paginator.totalCount)!0}</b>条数据</span>
			           <#import '/userCenter/common/tags/pagination.ftl' as p />
					<@p.paginationFtl formId="subscribeForm" divId="subscribe" paginator=paginator! />
			       </div>
				</form>
			</div>
		</@resourcesBizDirective>
	</div>
</div>

<script>
	$(function(){
		var resources = $('.m-SCbe-resc-list');
		$.each(resources,function(i,n){
			var belong = $(n).attr('belong');
			if(belong){
				var belongTag = $('.subscribes .'+belong).clone();
				$(n).find('.m-user-cue').append(belongTag);
			}
		});
	});
	
</script>
</@lo.layout>