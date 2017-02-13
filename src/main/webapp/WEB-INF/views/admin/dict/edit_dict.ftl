<#assign formId='saveDictForm'/>
<#import "/admin/common/include/form_layer.ftl" as fl>
	<@fl.form id="${(formId)!}" action="${ctx!}/tpdpor/admin/dict" method="post" >
		<input type="hidden" name="dictTypeCode" value="${(param_dictTypeCode)!}">
		<#if (dictEntry.id)??>
			<script>
				$(function(){
					$('#${(formId)!}').attr('method', 'put');
					$('#${(formId)!}').attr('action', '${ctx!}/tpdpor/admin/dict/${(dictEntry.id)!}');
				});
			</script>
		<#else>
			<input type="hidden" name="parentValue" value="${(param_parentValue)!}">
		</#if>
		<ul class="mis-ipt-lst">
			<li class="item">
		       <div class="mis-ipt-row">
		           <div class="tl">
		               <span>主题名称：</span>
		           </div>
		           <div class="tc">
		               <div class="mis-ipt-mod">
		                   <input type="text" name="dictName" value="${(dictEntry.dictName)!}" placeholder="请输入主题名称..." class="mis-ipt">
		               </div>
		           </div>
		       </div>
		   </li>
		</ul>
	</@fl.form>
