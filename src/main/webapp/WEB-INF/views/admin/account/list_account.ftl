<#import "/admin/common/include/layout.ftl" as lo>
<#assign jsArray = [] />
<#assign cssArray = []>
<@lo.layout jsArray=jsArray cssArray=cssArray validate=true>

<#assign formId="listAccountForm"/>
<@accountsDirective realName=param_realName! page=param_page!1 limit=param_limit!10 orders=param_orders!'CREATE_TIME.DESC'>
<div class="mis-index-wrap">
	<#import "/admin/common/include/form.ftl" as cf>
	<@cf.form id="${formId!}" action="${ctx!}/tpdpor/admin/account?menuTreeId=${menuTreeId!}" method="get">
	<div class="mis-mod">
		<div class="mis-mod-tt">
			<h2 class="tt t1"><span>用户管理</span></h2>
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
									<input type="text" name="realName" value="${(param_realName)!}" placeholder="" class="mis-ipt">
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
						<button type="button" onclick="createAccount();" class="mis-btn mis-inverse-btn">
							<i class="mis-pass-ico"></i>新增用户
						</button>
						<button type="button" onclick="editAccount();" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
							<i class="mis-unpass-ico"></i>修改
						</button>
						<button onclick="resetPassword();" type="button" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
							<i class="mis-key-ico"></i> 修改密码
						</button>
						<button type="button" onclick="deleteAccount();" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
							<i class="mis-delete-ico"></i>删除
						</button>
						<#if SecurityUtils.getSubject().hasRole('admin') || SecurityUtils.getSubject().hasRole('superAdmin')>
							<button type="button" class="mis-btn mis-inverse-btn disabled-btn  disabled" disabled="disabled" onclick="editUserRole();" ><i class="mis-authorization-ico"></i>分配角色</button>
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
								<th>用户名</th>
								<th>姓名</th>
								<th>所属机构</th>
								<th>帐号类型</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="8"> 
									<#import "/admin/common/include/pagination.ftl" as page/>
									<@page.adminPage formId="${formId!}" divId="" paginator=paginator/> 
								</td>
							</tr>
						</tfoot>
						<tbody>
							<#if accounts??>
								<#list accounts as a>
								<tr>
									<input type="hidden" value="${(a.user.id)!}" class="userId">
									<td>
										<input class="checkRow" type="checkbox" name="checkboxId" value="${(a.id)!}">
									</td>
									<td>${(a.userName)!}</td>
									<td>${(a.user.realName)!}</td>
									<td>${(a.user.department.deptName)!}</td>
									<td>
										<#if (a.roleCode)??>
											${DictionaryUtils.getEntryName('ACCOUNT_ROLE_CODE',a.roleCode)}
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
	
	function createAccount(){
		mylayerFn.open({
            id: "createAccountLayer",
            type: 2,
            title: '新增用户',
            content: '${ctx}/admin/account/create',
			area: [600,500],
            zIndex: 19999,
            yes: {
	            close: true,
	            btnName: '.mylayer-confirm',
	            yesFn : function(){
	                
	            }
	        }
        });
	}
	
	function editAccount(){
		var value = getCheckedboxValues('${formId}','checkboxId',1);
		if(value == ''){
			return false;
		}
		mylayerFn.open({
            id: "editAccountLayer",
            type: 2,
            title: '编辑用户',
            content: '${ctx}/admin/account/'+value+'/edit',
			area: [600,500],
            zIndex: 19999,
            yes: {
	            close: true,
	            btnName: '.mylayer-confirm',
	            yesFn : function(){
	                
	            }
	        }
        });
	}
	
	function deleteAccount(){
		var value = getCheckedboxValues('${formId}', 'checkboxId');
		if (value != '') {
			confirm('确认要删除选中记录吗？', function(r) {
				$.ajaxDelete('${ctx!}/manage/accounts/batch/delete?id=' + value, "", function() {
					$("#${formId}").submit();
				});
			});
		}
	}
	
	function editUserRole(){
		var value = getCheckedboxValues('${formId}','checkboxId',1);
		if(value!=''){
			var row = $('input[value="'+value+'"]').closest('tr');
			var userId = row.find('.userId').val();
			window.location.href="${ctx}/admin/auth_users/"+userId+"/editUserRole?menuTreeId=${menuTreeId!}";
		}
	}
	
	function resetPassword() {
		var value = getCheckedboxValues('${formId}','checkboxId',1);
		if(value == ''){
			return false;
		}
		mylayerFn.open({
            id: "editPasswordLayer",
            type: 2,
            title: '修改密码',
            content: '${ctx}/admin/account/'+value+'/editPassword',
			area: [600,500],
            zIndex: 19999,
            yes: {
	            close: true,
	            btnName: '.mylayer-confirm',
	            yesFn : function(){
	                
	            }
	        }
        });
	}

</script>
</@accountsDirective>
</@lo.layout>