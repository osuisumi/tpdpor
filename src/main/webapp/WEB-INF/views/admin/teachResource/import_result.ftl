<#import "/admin/common/include/layout.ftl" as lo>
<@lo.layout webuploader=true>
<div class="mis-mod-tt">
	<h2 class="tt t1"><span>导入失败的数据列表</span></h2>
</div>           
<table id="listVideoRecordTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
	<thead>
		<tr>
			<th data-options="field:'result'">失败信息</th>
		</tr>
	</thead>
	<tbody>
		<#if resultMap.failList??>
			<#list resultMap.failList as result>
				<tr>
					<td>${result!}</td>
				</tr>
			</#list>
		</#if>
	</tbody>
</table>
<div class="mis-mod-tt">
	<h2 class="tt t1"><span>成功导入${(resultMap.successNum)!0}条数据</span></h2>
</div>                    

</@lo.layout>