<#import "/userCenter/common/include/layout.ftl" as lo>
<#assign jsArray = ['${ctx!}/js/common/laypage/laypage.js'] />
<#assign cssArray = ['${ctx}/css/tpdpor/${app_path}/style.css']>
<@lo.layout jsArray=jsArray cssArray=cssArray validate=true menu='sqjl'>
<div class="g-EduResc-tab">
	<@resourceApplyStateCountDirective userId=Session.loginer.id>
	<ul class="m-subscribe-tab">
		<li <#if (param_applyState!'') == ''>class="crt"</#if> >
			<a href="javascript:;" onclick="reload('')">全部(${(resourceApplyRecordStateCount['total'])!0})</a>
		</li>
		<li <#if (param_applyState!'') == 'passed'>class="crt"</#if> >
			<a href="javascript:;" onclick="reload('passed')">已通过(${(resourceApplyRecordStateCount['passed'])!0})</a>
		</li>
		<li <#if (param_applyState!'') == 'nopass'>class="crt"</#if> >
			<a href="javascript:;" onclick="reload('nopass')" >未通过(${(resourceApplyRecordStateCount['nopass'])!0})</a>
		</li>
		<li <#if (param_applyState!'') == 'apply'>class="crt"</#if> >
			<a href="javascript:;" onclick="reload('apply')" >待审核(${(resourceApplyRecordStateCount['apply'])!0})</a>
		</li>
	</ul>
	</@resourceApplyStateCountDirective>
	<!--<div class="chk-lst">
		<div class="m-slt-block1 mid">
			<a href="javascript:;" class="show-txt"> <span class="txt">按年限筛选</span> <i class="trg"></i> </a>
			<dl class="lst">
				<dd>
					<a href="javascript:;" class="z-crt">按年限筛选</a>
				</dd>
				<dd>
					<a href="javascript:;">按分类筛选</a>
				</dd>
				<dd>
					<a href="javascript:;">按年限筛选</a>
				</dd>
				<dd>
					<a href="javascript:;">按大小筛选</a>
				</dd>
				<dd>
					<a href="javascript:;">按年限筛选</a>
				</dd>
			</dl>
		</div>
	</div>-->
</div>
<@resourceApplyRecordsDirective  userId=Session.loginer.id applyState=param_applyState! page=(param_page)!1 limit=param_limit!10 orders=param_orders!'CREATE_TIME.DESC'>
<div class="m-EduResc-cont">
	<table class="m-tb-resorce">
		<thead>
			<th width="30%">题名</th>
			<th width="14%"><span class="txt">类型</span></th>
			<!-- <th width="10%">
			<span class="txt">价格</span>
			</th> -->
			<th width="18%">申请时间
				<span class="txt">
					<i class="u-ico-sort up add"   onclick="sort('CREATE_TIME.ASC')"></i>
					<i class="u-ico-sort down add blur" onclick="sort('CREATE_TIME.DESC')"></i>
				</span>
			</th>
			<th width="18%">状态</th>

			<#--<th width="14%">操作</th>-->
		</thead>
		<tbody>
				<#if resourceApplyRecords??>
					<#list resourceApplyRecords as record>
						<tr>
							<td class="book-name">
								<#if (record.resource.type!'')== 'teach'>
									<a href="${ctx}/teach_resource/view/${(record.resource.id)!}" target="_blank">${(record.resource.title)!}</a>
								<#else>
									<a href="${ctx}/train_resource/${(record.relation.id)!}/view" target="_blank">${(record.resource.title)!}</a>
								</#if>
							</td>
							<td>
								<#if (record.resource.type!'')== 'teach'>
									教研资料
								<#else>
									培训学习
								</#if>
							</td>
							<td>${TimeUtils.formatDate(record.createTime,'yyyy-MM-dd')}</td>
							<td>
								<span class="operate">
									<#if record.applyState == 'apply'>
										待审核
									<#elseif record.applyState == 'passed'>
										通过
									<#else>
										不通过
									</#if>
								</span>
							</td>
							<#--<td>
								<#if record.applyState == 'passed'>
									<a href="javascript:;" onclick="editEvaluate('${(record.resource.id)!}','${(record.resource.type)!}')" class="operate">评价</a>								
								<#else>
									-
								</#if>
							</td>
							-->
						</tr>
					</#list>
				</#if>
		</tbody>
	</table>
	<div class="m-btm-opa">
		<form id="myReadRecordFrom" action="${ctx}/userCenter/resource_apply_record" method="get">
	    	<input type="hidden" name="applyState" value="${param_applyState!}">
			<input type="hidden" name="orders" value="${param_orders!}">
	       <div class="u-rt">
	           <div class="m-page-jump" id="record_page"></div>
	           <span class="num">找到<b>${(paginator.totalCount)!0}</b>条数据</span>
	           <#import '/userCenter/common/tags/pagination.ftl' as p />
			<@p.paginationFtl formId="myReadRecordFrom" divId="record_page" paginator=paginator! />
	       </div>
		</form>
	</div>
</div>
</@resourceApplyRecordsDirective>

<script>
	function reload(state){
		$('#myReadRecordFrom input[name="applyState"]').val(state);
		$('#myReadRecordFrom').submit();
	}
	
	function editEvaluate(rid,rtype){
		var relationType = 'teach_resource_evaluate';
		if(rtype != null || rtype != '' || rtype != undefined){
			if(rtype != 'teach'){
				relationType = 'train_resource_evaluate';
			}
		}
		
		mylayerFn.open({
			id : 'editReadEvaluate',
			type : 2,
			title : '评价',
			content : '${ctx}/userCenter/resource_apply_record/edit_evaluate?resourceId='+rid+'&relationType='+relationType,
			area : [600, 380],
			offset : ['auto', 'auto'],
			fix : false,
		});
	}
	
	function sort(orders){
		$('#myReadRecordFrom input[name="orders"]').val(orders);
		$('#myReadRecordFrom').submit();
	}
</script>
</@lo.layout>