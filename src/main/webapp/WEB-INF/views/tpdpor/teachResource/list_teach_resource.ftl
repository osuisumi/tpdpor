<@resourcesDirective relationId="teach" resourceExtendType=(param_resourceExtendType)! stage=(param_stage)! subject=(param_subject)! page=(param_page)!1 limit=(param_limit)!10 bIndex=param_bIndex! orders=param_orders!'CREATE_TIME.DESC' type="teach">
<#if resources?? && (resources?size >0)>
<table class="m-tb-resorce">
	<thead>
		<th width="28%">题名</th>
		<th width="20%">著者</th>
		<th width="20%">来源</th>
		<th width="13%">
			<span class="txt">出版时间
				<!--<i class="u-ico-sort up"></i>
				<i class="u-ico-sort down"></i>
				-->
			</span>
		</th>
		<!--
		<th width="13%">
			<span class="txt">下载次数
				<i class="u-ico-sort up" onclick="sort('DOWNLOAD_NUM.ASC')"></i>
				<i class="u-ico-sort down" onclick="sort('DOWNLOAD_NUM.DESC')"></i>
			</span>
		</th>
		-->
	</thead>
		<tbody>
				<#list resources as r>
					<tr>
						<td class="book-name"><a href="${ctx}/teach_resource/view/${(r.id)!}">${(r.title)!}</a></td>
						<td>${(r.resourceExtend.author)!}</td>
						<td>${(r.resourceExtend.source)!}</td>
						<td>
							<span class="">
								<#if (r.resourceExtend.issueDate)??>
									${(((r.resourceExtend.issueDate)!)?string('yyyy'))!}
								</#if>
							</span><!--<a href="${ctx}/teach_resource/view/${(r.id)!}" class="btn u-btn-theme"><i class="u-ico-eyes"></i>预览</a>-->
						</td>
						<!--<td><span class="">${(r.resourceRelations[0].downloadNum)!0}</span><a href="javascript:;" class="btn u-btn-minor"><i class="u-ico-dld"></i>下载</a></td>-->
					</tr>
				</#list>
		</tbody>
</table>
<#else>
<div class="m-no-resorce">
    <p>还没有资源哦~</p>
</div>
</#if>
</@resourcesDirective>
<form id="list_teach_resource_form" action="${ctx}/teach_resource" method="get">
	<input type="hidden" name="type" value="${param_type!}">
	<input type="hidden" name="stage" value="${param_stage!}">
	<input type="hidden" name="subject" value="${param_subject!}">
	<input type="hidden" name="resourceExtendType" value="${param_resourceExtendType!}">
	<input type="hidden" name="orders" value="${(param_orders)!}">
	<input type="hidden" name="bIndex" value="${param_bIndex!}">
	<input type="hidden" name="node" value="${param_node!}">
	<div class="g-res-page">
		<span class="num">共<b>${(paginator.totalCount)!}</b>个资源</span>
		<div id="teach_resource_page" class="m-page-jump res"></div>
		<#import '/tpdpor/common/tags/pagination_ajax.ftl' as p />
		<@p.paginationAjaxFtl formId="list_teach_resource_form" divId="teach_resource_page" paginator=paginator contentId='teach_resource_div' />
	</div>
</form>

<script>
	function sort(orders){
		$('#list_teach_resource_form input[name="orders"]').val(orders);
		window.location.href = "${ctx}/teach_resource/index?" + $('#list_teach_resource_form').serialize();
	}
</script>