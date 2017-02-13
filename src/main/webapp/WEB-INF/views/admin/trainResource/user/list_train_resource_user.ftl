<#import "/admin/common/include/layout.ftl" as lo>
<#assign jsArray = [] />
<#assign cssArray = []>
<@lo.layout jsArray=jsArray cssArray=cssArray>

<#assign divisionIds=[] />
<#if SecurityUtils.getSubject().hasRole('divisionManager') >
	<#assign roles = ['manager','editor'] />
	<@divisionUsersDirective roles=roles userId=(Session.loginer.id)!>
		<#if (divisionUsers)??>
			<#list divisionUsers as divisionUser>
				<#assign divisionIds=divisionIds + [(divisionUser.division.id)!] />
			</#list>
			<#assign divisionUsers = divisionUsers! />
		</#if>
	</@divisionUsersDirective>
</#if>

<#assign formId="listTrainResourceUserForm"/>
<@trainResourceUsersData belong=(param_belong)! belongs=(divisionIds)! state=(param_state)! resourceName=(param_resourceName)!
	page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders=(orders[0])!'CREATE_TIME.DESC'>
<div class="mis-index-wrap">
	<#import "/admin/common/include/form.ftl" as cf>
	<@cf.form id="${formId!}" action="${ctx!}/tpdpor/admin/train_resource/user?menuTreeId=${menuTreeId!}" method="get">
	<div class="mis-mod">
		<div class="mis-mod-tt">
			<h2 class="tt t1"><span>学习申请管理</span></h2>
		</div>
		<div class="mis-content">
			<div class="mis-srh-layout">
				<ul class="mis-ipt-lst">
		        <#--     <li class="item">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>年份：</span>
							</div>
							<div class="tc">
								<div class="mis-select">
									<select name="type" id="yearSelect">
										<option value="" >请选择...</option>
									</select>
									<script>
										$(function(){
											var d = new Date();
											var year = d.getFullYear();
											for(var i = year - 1; i < year + 2; i++){
												$('#yearSelect').append('<option value="'+i+'">'+i+'</option>');
											}
											$('#yearSelect').find('option[value="${(param_year)!}"]').attr('selected',true);
										});
									</script>
								</div>
							</div>
						</div>
					</li> -->
					<li class="item">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>教学部门：</span>
							</div>
							<div class="tc">
								<div class="mis-select">
									<select name="belong" id="selectDivision">
										<option value="" >请选择...</option>
										<#if (divisionUsers)??>
											<#list divisionUsers as du>
												<option value="${(du.division.id)!}" >${(du.division.name)!}</option>
											</#list>
										</#if>
									</select>
									<script>
										$(function(){
											$("#selectDivision").find("option[value='${(param_belong)!}']").attr("selected",true);
										});
									</script>
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
									<select name="state" id="selectState">
										<option value="" >请选择...</option>
										<option value="apply" >未审核</option>
										<option value="passed" >审核通过</option>
										<option value="nopass" >审核不通过</option>
									</select>
									<script>
										$(function(){
											$("#selectState").find("option[value='${(param_state)!}']").attr("selected",true);
										});
									</script>
								</div>
							</div>
						</div>
					</li>
					<li class="item">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>标题：</span>
							</div>
							<div class="tc">
								<div class="mis-ipt-mod">
									<input type="text" name="resourceName" value="${(param_resourceName)!}" placeholder="请输入标题" class="mis-ipt">
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
						<button type="button" onclick="updateTrainResourceUserState();" class="mis-btn mis-inverse-btn">
							<i class="mis-pass-ico"></i>审核通过
						</button>
						<button type="button" onclick="viewTrainResourceUser();" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
							<i class="mis-look-ico"></i>查看详情
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
								<th>所属教学部门/机构</th>
								<th>资源类型</th>
								<th>申请人</th>
								<#-- <th>实名认证</th> -->
								<th>申请时间</th>
								<th>审核状态</th>
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
							<#if trainResourceUsers??>
								<#list trainResourceUsers as tru>
									<tr>
										<td>
											<input class="checkRow" type="checkbox" name="checkboxId" value="${(tru.id)!}">
										</td>
										<td>${(tru.trainResource.resource.title)!'----'}</td>
										<td>${(tru.trainResource.division.name)!'----'}</td>
										<td>
											<#if (tru.trainResource.resource.type)! == 'curriculum'>
												课程
											<#elseif (tru.trainResource.resource.type)! == 'case'>
												案例
											<#elseif (tru.trainResource.resource.type)! == 'material'>
												素材
											<#elseif (tru.trainResource.resource.type)! == 'other'>
												其他
											<#else>
												----
											</#if>
										</td>
										<td>${(tru.user.realName)!}</td>
										<#-- <td>----</td> -->
										<td>${TimeUtils.formatDate(((tru.createTime)!0), 'yyyy-MM-dd')! }</td>
										<td>
											<#if (tru.state)! == 'apply'>
												未审核
											<#elseif (tru.state)! == 'passed'>
												通过
											<#elseif (tru.state)! == 'nopass'>
												未通过
											<#else>
												----
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
	
	function viewTrainResourceUser(){
		var id = getCheckedboxValues('${formId!}', 'checkboxId',1);
		if (id != ''){
			mylayerFn.open({
				id : "viewTrainResourceUser",
				type : 2,
				title : '查看申请',
				content : '${ctx!}/tpdpor/admin/train_resource/user/'+id+'/view',
				area: [400,600],
				offset : [$(document).scrollTop()],
				fix : false,
				shadeClose : true,
				zIndex : 19999,
			});
		}
	};
	
	function updateTrainResourceUserState(){
		var id = getCheckedboxValues('${formId!}', 'checkboxId',1);
		if (id != ''){
			mylayerFn.confirm({
		        content: '确定审核通过？',
		        icon: 3,
		        yesFn: function(){
		        	$.ajaxPut('${ctx!}/admin/resource_apply_record', '&id='+id+'&applyState=passed', function(){
		        		window.location.reload();
					})
		        }
		    });
		}
	};
</script>
</@trainResourceUsersData>
</@lo.layout>