<#import "/admin/common/include/layout.ftl" as lo>
<#assign jsArray = [] />
<#assign cssArray = []>
<@lo.layout jsArray=jsArray cssArray=cssArray>

<#assign userId = ''>
<#if SecurityUtils.getSubject().hasRole('expert')>
	<#assign userId = (Session.loginer.id)!>
</#if>

<#assign formId="listExpertForm"/>
<@expertsData userId=userId! realName=(expert.user.realName)! deptName=(expert.user.department.deptName)! page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders=(param_orders)!'CREATE_TIME.DESC'>
<div class="mis-index-wrap">
	<#import "/admin/common/include/form.ftl" as cf>
	<@cf.form id="${formId!}" action="${ctx!}/tpdpor/admin/expert" method="get">
	<input type="hidden" name="menuTreeId" value="${menuTreeId!}">
	<div class="mis-mod">
		<div class="mis-mod-tt">
			<h2 class="tt t1"><span>专家信息管理</span></h2>
		</div>
		<div class="mis-content">
			<div class="mis-srh-layout">
				<ul class="mis-ipt-lst">
					<li class="item">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>姓名：</span>
							</div>
							<div class="tc">
								<div class="mis-ipt-mod">
									<input type="text" name="user.realName" value="${(expert.user.realName)!}" placeholder="请输入项目名称" class="mis-ipt">
								</div>
							</div>
						</div>
					</li>
					<li class="item">
		                <div class="mis-ipt-row">
		                    <div class="tl">
		                        <span>所在单位：</span>
		                    </div>
		                    <div class="tc">
								<div class="mis-ipt-mod">
									<input type="text" name="user.department.deptName" value="${(expert.user.department.deptName)!}" placeholder="请输入项目名称" class="mis-ipt">
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
							<button type="button" onclick="createExpert();" class="mis-btn mis-inverse-btn">
								<i class="mis-add-ico"></i>新增
							</button>
						</#if>
						<button type="button" onclick="goUpdateExpert();" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
							<i class="mis-alter-ico"></i>修改
						</button>
						<#if (SecurityUtils.getSubject().hasRole('superAdmin') == true || SecurityUtils.getSubject().hasRole('admin') == true)>
							<button type="button" onclick="deleteExpert();" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
								<i class="mis-delete-ico"></i>注销
							</button>
						</#if>
						<#-- 
						<button type="button" onclick="" class="mis-btn mis-inverse-btn" >
							<i class="mis-delete-ico"></i>导入
						</button>
						-->
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
								<th>用户名</th>
								<th>姓名</th>
								<th>所在单位</th>
								<th>性别</th>
								<th>职称</th>
								<th>联系电话</th>
								<th>邮箱</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="8"> 
									<#import "/admin/common/include/pagination.ftl" as page/>
									<@page.adminPage formId="${formId!}" divId="" paginator=paginator!/> 
								</td>
							</tr>
						</tfoot>
						<tbody>
							<#if experts??>
								<#list experts as expert>
									<tr>
										<td>
											<input class="checkRow" type="checkbox" name="checkboxId" value="${(expert.id)!}">
										</td>
										<td>${(expert.account.userName)!}</td>
										<td>${(expert.user.realName)!}</td>
										<td>${(expert.user.department.deptName)!}</td>
										<td>
											<#if (expert.user.sex)! == '1'>
												男
											<#elseif (expert.user.sex)! == '2'>
												女
											<#else>
												----
											</#if>
										</td>
										<td>${(expert.professionalTitle)!}</td>
										<td>${(expert.user.phone)!}</td>
										<td>${(expert.user.email)!}</td>
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
	function createExpert(){
		window.location.href = '${ctx!}/tpdpor/admin/expert/create?menuTreeId=${menuTreeId!}';
	};
	
	function goUpdateExpert(){
		var id = getCheckedboxValues('${formId!}', 'checkboxId',1);
		if(id != ''){
			window.location.href = '${ctx!}/tpdpor/admin/expert/'+id+'/edit?menuTreeId=${menuTreeId!}';
		}else{
			alert('请选择一条记录');
		}
	};
	
	function deleteExpert(){
		var id = getCheckedboxValues('${formId!}', 'checkboxId',1);
		if(id != ''){
			mylayerFn.confirm({
		        content: "确定对所选记录注销？",
		        icon: 3,
		        yesFn: function(){
		        	$.ajaxDelete('${ctx!}/tpdpor/admin/expert/'+id, '', function(){
						$('#${formId!}').submit();
					})
		        }
		    });
		}else{
			alert('请选择一条记录');
		}
	};
	
</script>
</@expertsData>
</@lo.layout>