<#import "/admin/common/include/layout.ftl" as lo>
<#assign jsArray = [] />
<#assign cssArray = [] />
<@lo.layout jsArray=jsArray cssArray=cssArray>

<#assign divisionIds = [] />
<#if (SecurityUtils.getSubject().hasRole('superAdmin') == true || SecurityUtils.getSubject().hasRole('admin') == true)>
<#else>
	<@divisionUsersDirective role='manager' userId=(Session.loginer.id)!>
		<#if (divisionUsers)??>
			<#if (divisionUsers)??>
				<#list divisionUsers as divisionUser>
					<#if (divisionUser.division.id)??>
						<#assign divisionIds = divisionIds +  [(divisionUser.division.id)!] />
					</#if>
				</#list>
			</#if>
		</#if>
	</@divisionUsersDirective>
</#if>

<#assign formId="listDivisionForm"/>
<@divisionsDirective ids=divisionIds! name=(division.name)! getManager=true getEditor=true page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders=(param_orders)!'CREATE_TIME.DESC'>
<div class="mis-index-wrap">
	<#import "/admin/common/include/form.ftl" as cf>
	<@cf.form id="${formId!}" action="${ctx!}/tpdpor/admin/division" method="get">
	<input type="hidden" name="menuTreeId" value="${menuTreeId!}">
	<div class="mis-mod">
		<div class="mis-mod-tt">
			<h2 class="tt t1"><span>教学部门管理</span></h2>
		</div>
		<div class="mis-content">
			<div class="mis-srh-layout">
				<ul class="mis-ipt-lst">
					<li class="item">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>名称：</span>
							</div>
							<div class="tc">
								<div class="mis-ipt-mod">
									<input type="text" name="name" value="${(division.name)!}" placeholder="请输入部门名称..." class="mis-ipt">
								</div>
							</div>
						</div>
					</li>
				</ul>
				<div class="mis-btn-row indent1">
					<button type="submit" class="mis-btn mis-main-btn">
						<i class="mis-srh-ico"></i>查询
					</button>
					<button type="reset" class="mis-btn mis-default-btn">
						<i class="mis-refresh-ico"></i>重置
					</button>
				</div>
			</div>
			
			<div class="mis-table-layout">
				<div class="mis-opt-row">
					<div class="mis-opt-mod fl">
						<#if (SecurityUtils.getSubject().hasRole('superAdmin') == true || SecurityUtils.getSubject().hasRole('admin') == true)>
							<button type="button" onclick="createDivision();" class="mis-btn mis-inverse-btn">
								<i class="mis-add-ico"></i>新增
							</button>
						</#if>
						<button type="button" onclick="goUpdateDivision();" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
							<i class="mis-alter-ico"></i>修改
						</button>
						<#if (SecurityUtils.getSubject().hasRole('superAdmin') == true || SecurityUtils.getSubject().hasRole('admin') == true)>
						<button type="button" onclick="deleteDivision();" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
							<i class="mis-delete-ico"></i>注销
						</button>
						</#if>
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
								<th>教学部门名称</th>
								<th>管理员</th>
								<th>编辑</th>
								<th>联系电话</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="5"> 
									<#import "/admin/common/include/pagination.ftl" as page/>
									<@page.adminPage formId="${formId!}" divId="" paginator=paginator!/> 
								</td>
							</tr>
						</tfoot>
						<tbody>
							<#if divisions??>
								<#list divisions as division>
									<tr>
										<td>
											<input class="checkRow" type="checkbox" name="checkboxId" value="${(division.id)!}">
										</td>
										<td>${(division.name)!}</td>
										<td>
											<#if ((divisionManagerMap[division.id]))??>
												<#list (divisionManagerMap[division.id]) as du>
													${(du.user.realName)!}
													<#if du_has_next>
														,
													</#if>
												</#list>
											<#else>
												----
											</#if>
										</td>
										<td>
											<#if ((divisionEditorMap[division.id]))??>
												<#list (divisionEditorMap[division.id]) as du>
													${(du.user.realName)!}
													<#if du_has_next>
														,
													</#if>
												</#list>
											<#else>
												----
											</#if>
										</td>
										<td>${(division.phone)!}</td>
									</tr>
								</#list>
							</#if>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	</@cf.form>
</div>

<script>
	function createDivision(){
		window.location.href = '${ctx!}/tpdpor/admin/division/create?menuTreeId=${menuTreeId!}';
	};
	
	function goUpdateDivision(){
		var id = getCheckedboxValues('${formId!}', 'checkboxId',1);
		if(id != ''){
			window.location.href = '${ctx!}/tpdpor/admin/division/'+id+'/edit?menuTreeId=${menuTreeId!}';
		}else{
			alert('请选择一条记录');
		}
	};
	
	function deleteDivision(){
		var id = getCheckedboxValues('${formId!}', 'checkboxId',1);
		if(id != ''){
			mylayerFn.confirm({
		        content: "确定对所选记录注销？",
		        icon: 3,
		        yesFn: function(){
		        	$.ajaxDelete('${ctx!}/tpdpor/admin/division/'+id, '', function(){
						$('#${formId!}').submit();
					})
		        }
		    });
		}else{
			alert('请选择一条记录');
		}
	};
	
</script>
</@divisionsDirective>
</@lo.layout>