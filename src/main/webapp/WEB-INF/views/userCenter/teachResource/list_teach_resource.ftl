<#import "/userCenter/common/include/layout.ftl" as lo>
<#assign jsArray = ['${ctx!}/js/common/laypage/laypage.js'] />
<#assign cssArray = ['${ctx!}/js/common/laypage/skin/laypage.css']>
<@lo.layout jsArray=jsArray cssArray=cssArray menu='jyzl'>
<@resourcesBizDirective getFile=true type="teach"  applyUserOrFollowCreator=param_applyUserOrFollowCreator! applyUser=param_applyUser!  followCreator=param_followCreator! page=(param_page)!1 limit=param_limit!10 orders=param_orders!'CREATE_TIME.DESC' >
<div class="g-EduResc-tab">
	<@createAndFollowResourceNumDirective type="teach" getApplyNum='Y' getFollowNum='Y' applyAndFollowNum='Y'>
	<#assign applyNum=applyNum!0/>
	<#assign followNum=followNum!0/>
	<#assign totalNum=applyAndFollowNum!0/>
	<ul class="m-subscribe-tab">
		<li <#if (param_applyUserOrFollowCreator!'') == Session.loginer.id>class="crt"</#if> onclick="reload('applyUserOrFollowCreator')" ><a  href="javascript:;">全部(${totalNum!})</a></li>
		<li <#if (param_applyUser!'') == Session.loginer.id>class="crt"</#if>  onclick="reload('applyUser')" ><a  href="javascript:;">申请(${(applyNum)!0})</a></li>
		<li <#if (param_followCreator!'') == Session.loginer.id>class="crt"</#if>  onclick="reload('followCreator')" ><a href="javascript:;">收藏(${(followNum)!0})</a></li>
	</ul>
	</@createAndFollowResourceNumDirective>
</div>
<div class="m-EduResc-cont">
	<table class="m-tb-resorce">
		<thead>
			<th width="26%">题名</th>
			<th width="18%">著者</th>
			<th width="18%">出版社</th>
			<th width="10%"><span class="txt">出版年<!--<i class="u-ico-sort up add"></i><i class="u-ico-sort down add blur"></i>--></span></th>
			<!--<th width="10%"><span class="txt">下载</span></th>-->
			<th width="12%">文件大小</th>
			<#if (param_applyUser!'') == Session.loginer.id>
				<th width="12%">申请状态</th>
			<#elseif (param_followCreator!'') == Session.loginer.id>
				<th width="12%">操作</th>
			</#if>
		</thead>
		<tbody>
			<#if resources??>
				<#if (param_applyUser!'') == Session.loginer.id>
					<@resourceApplyStateMapDirective resources=resources userId=Session.loginer.id>
						<#assign applyRecordMap = applyRecordMap/>
					</@resourceApplyStateMapDirective>
				</#if>
				<#list resources as resource>
					<tr>
						<td class="book-name"><a href="${ctx}/teach_resource/view/${resource.id}">${(resource.title)!}</a></td>
						<td>${(resource.resourceExtend.author)!}</td>
						<td>${(resource.resourceExtend.source)!}</td>
						<td>
							<#if (resource.resourceExtend.issueDate)??>
								${resource.resourceExtend.issueDate?string('yyyy')}
							</#if>
						</td>
						<td>
							<span>
								<#if (resource.fileInfos)?? && (resource.fileInfos?size>0)>
									${FileSizeUtils.getFileSize(resource.fileInfos?first.fileSize)!}
								</#if>
							</span>
						</td>
						<#if resource.creator == Session.loginer.id>
							<td><a onclick="delTeachResource('${resource.id}')" href="javascript:;" class="operate">删除</a></td>
						<#elseif param_followCreator == Session.loginer.id>
							<td><a onclick="cancelFollow('${resource.id}')" href="javascript:;" class="operate">取消收藏</a></td>
						<#elseif param_applyUser == Session.loginer.id>
							<td>
								<span href="javascript:;">
									<#if ((applyRecordMap[resource.id].applyState)!'') == 'apply'>
										审核中
									<#elseif ((applyRecordMap[resource.id].applyState)!'') == 'passed'>
										审核通过
									<#elseif ((applyRecordMap[resource.id].applyState)!'') == 'nopass'>
										审核不通过
									<#else>
										-
									</#if>
								</span>
							</td>
						<#else>
							
						</#if>
					</tr>
				</#list>
			</#if>
		</tbody>
	</table>
	<div class="m-btm-opa">
		<form id="myTeachResourceFrom" action="${ctx}/userCenter/teach_resource" method="get">
			<input type="hidden" name="applyUserOrFollowCreator" value="${param_applyUserOrFollowCreator!}">
	    	<input type="hidden" name="followCreator" value="${param_followCreator!}">
	    	<input type="hidden" name="applyUser" value="${param_applyUser!}">
	       <div class="u-rt">
	           <div class="m-laypage" id="my_teach_resource_page"></div>
	           <span class="num">找到<b>${(paginator.totalCount)!0}</b>条数据</span>
	           <#import '/userCenter/common/tags/pagination.ftl' as p />
			<@p.paginationFtl formId="myTeachResourceFrom" divId="my_teach_resource_page" paginator=paginator! />
	       </div>
		</form>
	</div>
</div>

<script>
	function delTeachResource(id){
		confirm('确定删除吗？',function(){
			$.ajaxDelete('${ctx}/resource/'+id+'/delete',{},function(response){
				if(response.responseCode == '00'){
					alert('操作成功',function(){
						$('#myTeachResourceFrom').submit();
					});
				}
			});
		});
	}
	
	function reload(loadType){
		$('#myTeachResourceFrom input[name="applyUserOrFollowCreator"]').val('');
		$('#myTeachResourceFrom input[name="followCreator"]').val('');
		$('#myTeachResourceFrom input[name="applyUser"]').val('');
		
		$('#myTeachResourceFrom input[name="'+loadType+'"]').val('${(Session.loginer.id)!}');
		
		window.location.href = "${ctx}/userCenter/teach_resource?" + $('#myTeachResourceFrom').serialize();
	}
	
	function cancelFollow(rid){
		confirm("确定取消收藏吗？",function(){
			$.post("${ctx}/follows/deleteByUserAndFollowEntity",{
				"_method":"DELETE",
				"creator.id":"${Session.loginer.id}",
				"followEntity.id":rid,
				"followEntity.type":"teachResource"
			},function(response){
				if(response.responseCode == '00'){
					alert('取消成功',function(){
						$('#myTeachResourceFrom').submit();
					});
				}
			});
		});
	}
	
</script>
</@resourcesBizDirective>
</@lo.layout>