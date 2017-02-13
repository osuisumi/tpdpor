<#import "/admin/common/include/layout.ftl" as lo>
<@lo.layout>
<#assign formId="readRecordForm"/>
<@resourceApplyRecordsDirective resourceType='teach' deptId=param_deptId! applyState=param_applyState! applyYear=param_applyYear! page=(param_page)!1 limit=(param_limit)!10 orders=param_orders!'CREATE_TIME.DESC'>
<div class="mis-index-wrap">
	<#import "/admin/common/include/form.ftl" as cf>
	<@cf.form id="${formId}" action="${ctx}/admin/resource_apply_record" method="get">
	<input type="hidden" name="menuTreeId" value="${menuTreeId!}">
	<div class="mis-mod">
		<div class="mis-mod-tt">
			<h2 class="tt t1"><span>阅览申请审核</span></h2>
		</div>
		<div class="mis-content">
			<div class="mis-srh-layout">
				<ul class="mis-ipt-lst">
					<li class="item">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>年份：</span>
							</div>
							<div class="tc">
								<div class="mis-ipt-mod">
									<input type="text" name="applyYear" value="${param_applyYear!""}" placeholder="请输入申请年份" class="mis-ipt">
								</div>
							</div>
						</div>
					</li>
					<li class="item">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>所属机构：</span>
							</div>
							<div class="tc">
								<div class="mis-select">
									<select name="deptId">
										<option value="" <#if ((param_deptId!'') == '')>selected="selected"</#if> >请选择机构</option>
										<@departmentsDataDirective>
											<#if departments??>
												<#list departments as department>
													<option <#if ((param_deptId!'') == department.id)>selected="selected"</#if> value="${(department.id)!}">${(department.deptName)!}</option>
												</#list>
											</#if>
										</@departmentsDataDirective>
									</select>
								</div>
							</div>
						</div>
					</li>
					<li class="item">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>审核状态：</span>
							</div>
							<div class="tc">
								<div class="mis-select">
									<select name="applyState" id="">
										<option value="" <#if ((param_applyState!'') == '')>selected="selected"</#if>>请选择审核状态</option>
										<option value="apply" <#if ((param_applyState!'') == 'apply')>selected="selected"</#if> >待审核</option>
										<option value="passed" <#if ((param_applyState!'') == 'passed')>selected="selected"</#if> >通过</option>
										<option value="nopass" <#if ((param_applyState!'') == 'nopass')>selected="selected"</#if> >不通过</option>
									</select>
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
						<button type="button" class="mis-btn mis-inverse-btn disabled-btn  disabled" disabled="disabled" onclick="changeApplyState_pass()" >
							<i class="mis-alter-ico"></i>审核通过
						</button>
						<button type="button" class="mis-btn mis-inverse-btn disabled-btn  disabled" disabled="disabled" onclick="changeApplyState_nopass()" >
							<i class="mis-alter-ico"></i>审核不通过
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
								<th>标题</th>
								<th>所属机构</th>
								<th>类型</th>
								<th>申请人</th>
								<th>申请时间</th>
								<th>审核状态</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="9"> <#import "/admin/common/include/pagination.ftl" as page/>
								<@page.adminPage formId="${formId}" divId="" paginator=paginator/> </td>
							</tr>
						</tfoot>
						<tbody>
							<#if resourceApplyRecords??>
								<#list resourceApplyRecords as record>
								<tr>
									<td>
									<input class="checkRow" type="checkbox" name="checkboxId" value="${(record.id)!}">
									</td>
									<td>${(record.resource.title)!}</td>
									<td>${(record.userInfo.department.deptName)!}</td>
									<td>
										<#if (record.resource.type!'')== 'teach'>
											教研资料
										<#else>
											培训学习
										</#if>
									</td>
									<td>${(record.userInfo.realName)!}</td>
									<td>${TimeUtils.formatDate(record.createTime,'yyyy-MM-dd')!}</td>
									<td>
										<#if record.applyState == 'apply'>
											待审核
										<#elseif record.applyState == 'passed'>
											通过
										<#else>
											未通过
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
	
	function changeApplyState_pass(){
		var value = getCheckedboxValues('${formId}', 'checkboxId');
		if (value != '') {
			confirm('确定通过审核吗？', function(r) {
				$.ajaxPut('${ctx}/admin/resource_apply_record?id='+value + '&applyState=passed',null,function(response){
					if(response.responseCode =='00'){
						alert('操作成功',function(){
							$("#${formId}").submit();
						});
					}
				});
			});
		}
	}
	
	function changeApplyState_nopass(){
		var value = getCheckedboxValues('${formId}', 'checkboxId');
		if (value != '') {
			confirm('确定不通过审核吗？', function(r) {
				$.ajaxPut('${ctx}/admin/resource_apply_record?id='+value + '&applyState=nopass',null,function(response){
					if(response.responseCode =='00'){
						alert('操作成功',function(){
							$("#${formId}").submit();
						});
					}
				});
			});
		}
	}
</script>
</@resourceApplyRecordsDirective>
</@lo.layout>