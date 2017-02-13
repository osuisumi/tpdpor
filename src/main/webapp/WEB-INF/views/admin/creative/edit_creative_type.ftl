<#assign entry=(DictionaryUtils.getEntry('CREATIVE_TYPE',(param_type)!))!/>

<#import "/admin/common/include/form_layer.ftl" as fl>
	<#assign formId="updateCreativeUserForm"/>
	<@fl.form id="${formId!}" action="${ctx!}/tpdpor/admin/creative/typeManage" method="put" confirmTxt="保存" onConfirm="saveForm()" cancelTxt="取消" showBtn=true>
	<input type="hidden" name="type" value="${(param_type)!}">
	<div class="mis-srh-layout">
    	<ul class="mis-ipt-lst">
			<li class="item w1">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>板块名称：</span>
					</div>
					<div class="tc">
						<div class="mis-ipt-mod">
							<input type="text" name="name" value="${(entry.dictName)!}" placeholder="请输入板块名称" class="mis-ipt">
						</div>
					</div>
				</div>
			</li>
	    </ul>
	</div>
</@fl.form>

