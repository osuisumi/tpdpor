<#import "/admin/common/include/layout.ftl" as lo>
<#assign jsArray = [] />
<#assign cssArray = []>
<@lo.layout jsArray=jsArray cssArray=cssArray>

<#assign formId="listDepartmentForm"/>
<@departmentExtendsDirective deptName=(department.deptName)! page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders=(orders[0])!'CREATE_TIME.DESC'>
<div class="mis-index-wrap">
	<#import "/admin/common/include/form.ftl" as cf>
	<@cf.form id="${formId!}" action="${ctx!}/tpdpor/admin/department" method="get">
	<input type="hidden" name="menuTreeId" value="${menuTreeId!}">
	<div class="mis-mod">
		<div class="mis-mod-tt">
			<h2 class="tt t1"><span>机构管理</span></h2>
		</div>
		<div class="mis-content">
			<div class="mis-srh-layout">
				<ul class="mis-ipt-lst">
					<li class="item">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>机构名称：</span>
							</div>
							<div class="tc">
								<div class="mis-ipt-mod">
									<input type="text" name="deptName" value="${(department.deptName)!}" placeholder="请输入机构名称" class="mis-ipt">
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
						<a href="${ctx!}/tpdpor/admin/department/create?menuTreeId=${menuTreeId!}" class="mis-btn mis-inverse-btn"><i class="mis-add-ico"></i>新建</a>
						<button type="button" onclick="goUpdateDepartmrnt();" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
							<i class="mis-alter-ico"></i>修改
						</button>
						<button type="button" onclick="goDeleteDepartmrnt();" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
							<i class="mis-delete-ico"></i>注销
						</button>
						<#-- 
						<button type="button" onclick="goManageUser();" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
							<i class="mis-authorization-ico"></i>机构管理员
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
								<th></th>
								<th>机构名称</th>
								<!--<th>组织机构代码</th>-->
								<!--<th>机构类型</th>-->
								<th>省</th>
								<th>市</th>
								<th>区</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="99"> 
									<#import "/admin/common/include/pagination.ftl" as page/>
									<@page.adminPage formId="${formId!}" divId="" paginator=paginator/> 
								</td>
							</tr>
						</tfoot>
						<tbody>
							<#if departmentExtends??>
								<#list departmentExtends as d>
								<tr>
									<td>
										<input class="checkRow" type="checkbox" name="checkboxId" value="${(d.id)!}">
									</td>
									<td>${(d.deptName)!}</td>
									<#--<td>${(d.deptCode)!}</td>-->
									<#--<td>
										<#if (d.deptType)! == '1'>
											行政机构
										<#elseif (d.deptType)! == '2'>
											学校机构
										<#elseif (d.deptType)! == '3'>
											个人用户
										<#else>
										</#if>
									</td>
									-->
									<td>
										<#if (d.province.regionsCode)??>
											${RegionsUtils.getEntryName('1',(d.province.regionsCode)!)}
										</#if>
									</td>
									<td>
										<#if (d.city.regionsCode)??>
											${RegionsUtils.getEntryName('2',(d.city.regionsCode)!)}
										</#if>
									</td>
									<td>
										<#if (d.county.regionsCode)??>
											${RegionsUtils.getEntryName('3',(d.county.regionsCode)!)}
										</#if>
									</td>
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
	
	function goUpdateDepartmrnt(){
		var id = getCheckedboxValues('${formId!}', 'checkboxId',1);
		if(id != ''){		
			window.location.href = '${ctx!}/tpdpor/admin/department/'+id+'/edit?menuTreeId=${menuTreeId!}';
		}
	};
	
	function goDeleteDepartmrnt(){
		var id = getCheckedboxValues('${formId!}', 'checkboxId',1);
		if(id != ''){
			confirm("确定注销该机构？",function(r){
				$.ajaxDelete('${ctx!}/tpdpor/admin/department/'+id, '', function(){
					$('#${formId!}').submit();
				})
			});
		}
	};
</script>
</@departmentExtendsDirective>
</@lo.layout>