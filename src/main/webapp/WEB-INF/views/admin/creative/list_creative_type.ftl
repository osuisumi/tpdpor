<#import "/admin/common/include/layout.ftl" as lo>
<#assign jsArray = ["${ctx}/js/common/ztree/js/jquery.ztree.excheck.min.js"] />
<#assign cssArray = []>
<@lo.layout jsArray=jsArray cssArray=cssArray>
<#assign formId="listCreativeTypeForm"/>
<div class="mis-index-wrap">
	<#import "/admin/common/include/form.ftl" as cf>
	<@cf.form id="${formId!}" action="" method="get">
	<div class="mis-mod">
		<div class="mis-crm">
			<div class="crm">
				<a href="${ctx}/tpdpor/admin/creative?menuTreeId=${menuTreeId!}">教师创客</a>
				<span class="trg">&gt;</span>
				<a href="javascript:;">板块管理设置</a>
			</div>
		</div>
		<div class="mis-table-layout">
			<div class="mis-opt-row">
				<div class="mis-opt-mod fl">
					<button type="button" onclick="goSetCreativeUser();" class="mis-btn mis-inverse-btn" >
						<i class="mis-setting-ico"></i>板块成员设置
					</button>
					<button type="button" onclick="goUpdateCreativeType();" class="mis-btn mis-inverse-btn" >
						<i class="mis-setting-ico"></i>修改板块信息设置
					</button>
				</div>
				<div class="selectedNum fr">
					<span>已选中<strong class="num">0</strong>条记录</span>
				</div>
			</div>
			<div class="mis-table-mod">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
					<thead>
						<tr>
							<th width="2%"></th>
							<th>板块名称</th>
							<th>管理员</th>
							<th>评优专家</th>
							<th>创建项目</th>
							<th>上传资源</th>
						</tr>
					</thead>
					<#-- 
					<tfoot>
						<tr>
							<td colspan="6"> 
								<#import "/admin/common/include/pagination.ftl" as page/>
								<@page.adminPage formId="${formId!}" divId="" paginator=paginator/> 
							</td>
						</tr>
					</tfoot>
					-->
					<tbody>
						<@adminCreativeTypeDirective>
							<#assign types=[]>
							<#assign creativeTypeMap={}>
							<#list DictionaryUtils.getEntryList('CREATIVE_TYPE') as t>
								<#assign types=types+[t.dictValue]>
								<#assign creativeTypeMap=creativeTypeMap+{t.dictValue:t.dictName}>
							</#list>
							<#list types as t>
								<tr>
									<td>
										<input class="checkRow" type="checkbox" name="checkboxId" value="${t!}">
									</td>
									<td>${(creativeTypeMap["${t}"])!'----'}</td>
									<td>${(creativeTypeParamMap[t].manager.realName)!}</td>
									<td>${(creativeTypeParamMap[t].expert.realName)!}</td>
									<td>${(creativeTypeParamMap[t].creativeNum)!0}</td>
									<td>${(creativeTypeParamMap[t].resorceNum)!0}</td>
								</tr>
							</#list>
						</@adminCreativeTypeDirective>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	</@cf.form>
</div>
</@lo.layout>
<script type="text/javascript">
	$(document).ready(function() {
		$('input[type=checkbox]').click(function() {
			if ($("input[name='checkboxId']:checked").length > 0) {
				$(".mis-btn.disabled-btn").removeAttr("disabled");
				$(".mis-btn.disabled-btn").removeClass("disabled");
			} else {
				$(".mis-btn.disabled-btn").attr("disabled", "disabled");
				$(".mis-btn.disabled-btn").addClass("disabled");
			}
		});
	});
	
	function goSetCreativeUser(){
		var type = getCheckedboxValues('${formId!}', 'checkboxId',1);
		if(type != ''){	
			mylayerFn.open({
				id : "setCreativeUserLayer",
				type : 2,
				title : '板块成员设置',
				content : '${ctx!}/tpdpor/admin/creative/user/edit?type='+type,
				area: [600,500],
				offset : [$(document).scrollTop()],
				fix : false,
				shadeClose : true,
				zIndex : 19999,
				yes : {
					close : true,
					btnName : '.mylayer-confirm',
					yesFn : function() {
					}
				}
			});
		}
	};
	
	function goUpdateCreativeType(){
		var type = getCheckedboxValues('${formId!}', 'checkboxId',1);
		if(type != ''){
			mylayerFn.open({
				id : "setCreativeTypeLayer",
				type : 2,
				title : '板块信息设置',
				content : '${ctx!}/tpdpor/admin/creative/typeManage/edit?type='+type,
				area: [600,500],
				offset : [$(document).scrollTop()],
				fix : false,
				shadeClose : true,
				zIndex : 19999,
				yes : {
					close : true,
					btnName : '.mylayer-confirm',
					yesFn : function() {
					}
				}
			});
		}
	};
</script>