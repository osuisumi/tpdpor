<#import "/admin/common/include/layout.ftl" as lo>
<#assign jsArray = [] />
<#assign cssArray = [] />
<@lo.layout jsArray=jsArray cssArray=cssArray>


<#assign divisionIds = [] />
<#if (SecurityUtils.getSubject().hasRole('superAdmin') == true || SecurityUtils.getSubject().hasRole('admin') == true)>
<#elseif (SecurityUtils.getSubject().hasRole('divisionManager') == true || SecurityUtils.getSubject().hasRole('divisionEditor') == true) >
	<#assign roles = ['manager','editor'] />
	<@divisionUsersDirective roles=roles! userId=(Session.loginer.id)!>
		<#if (divisionUsers)??>
			<#list divisionUsers as divisionUser>
				<#if (divisionUser.division.id)??>
					<#assign divisionIds = divisionIds +  [(divisionUser.division.id)!] />
				</#if>
			</#list>
		</#if>
	</@divisionUsersDirective>
<#else>	
</#if>

<#assign formId="listTrainResourceForm"/>
<@trainResourcesData belongs=divisionIds! resourceRelationType='train_resource' title=(trainResource.resource.title)! page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders=(orders[0])!'CREATE_TIME.DESC'>
<div class="mis-index-wrap">
	<#import "/admin/common/include/form.ftl" as cf>
	<@cf.form id="${formId!}" action="${ctx!}/tpdpor/admin/train_resource?menuTreeId=${menuTreeId!}" method="get">
	<div class="mis-mod">
		<div class="mis-mod-tt">
			<h2 class="tt t1"><span>培训资源管理</span></h2>
		</div>
		<div class="mis-content">
			<div class="mis-srh-layout">
				<ul class="mis-ipt-lst">
					<li class="item">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>标题：</span>
							</div>
							<div class="tc">
								<div class="mis-ipt-mod">
									<input type="text" name="resource.title" value="${(trainResource.resource.title)!}" placeholder="请输入标题" class="mis-ipt">
								</div>
							</div>
						</div>
					</li>
					<#--
		            <li class="item">
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
					</li>
					<li class="item">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>教学部门：</span>
							</div>
							<div class="tc">
								<div class="mis-select">
									<select name="type" id="selectDepartment">
										<option value="" >请选择...</option>
									</select>
								</div>
							</div>
						</div>
					</li>
					-->
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
						<button type="button" onclick="goCreateTrainResource();" class="mis-btn mis-inverse-btn">
							<i class="mis-pass-ico"></i>新增资源包
						</button>
						<button type="button" onclick="goUpdateTrainResource();" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
							<i class="mis-unpass-ico"></i>修改
						</button>
						<button type="button" onclick="deleteTrainResource();" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
							<i class="mis-delete-ico"></i>删除
						</button>
						<#-- <button type="button" onclick="goUpdateTrainResource_Status('top');" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
							<i class="mis-top-ico"></i>推荐
						</button>
						<button type="button" onclick="updateTrainResource_StatusCancel('top');" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
							<i class="mis-untop-ico"></i>取消推荐
						</button> -->
						<button type="button" onclick="viewTrainResource();" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
							<i class="mis-pass-ico"></i>预览
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
								<th>所属教学部门</th>
								<th>所属项目</th>
								<th>资源类型</th>
								<th>资源创建者</th>
								<th>上传者</th>
								<th>发布时间</th>
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
							<#if trainResources??>
								<#list trainResources as tr>
								<tr>
									<td>
										<input class="checkRow" type="checkbox" name="checkboxId" value="${(tr.resource.id)!}">
									</td>
									<td>${(tr.resource.title)!}</td>
									<td>${(tr.division.name)!'----'}</td>
									<td>${(tr.train.project.name)!}</td>
									<td>
										<#if (tr.resource.type)! == 'curriculum' >
											课程
										<#elseif (tr.resource.type)! == 'case'>
											案例
										<#elseif (tr.resource.type)! == 'material'>
											素材
										<#elseif (tr.resource.type)! == 'other'>
											其他
										<#else>
											----
										</#if>
									</td>
									<td>${(tr.train.creator.realName)!}</td>
									<td>${(tr.resource.creator.realName)!}</td>
									<td>${TimeUtils.formatDate(((tr.resource.createTime)!0), 'yyyy-MM-dd')! }</td>
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
	
	function goCreateTrainResource(){
		window.location.href = '${ctx!}/tpdpor/admin/train_resource/create?menuTreeId=${menuTreeId!}';
	};

	function goUpdateTrainResource(){
		var id = getCheckedboxValues('${formId!}', 'checkboxId',1);
		if(id != ''){		
			window.location.href = '${ctx!}/tpdpor/admin/train_resource/'+id+'/edit?menuTreeId=${menuTreeId!}';
		}
	};

	function deleteTrainResource(){
		var ids = getCheckedboxValues('${formId!}', 'checkboxId');
		if(ids != ''){		
			confirm('确认要删除选中记录吗？', function(r) {
				$.ajaxDelete('${ctx!}/tpdpor/admin/train_resource/batch', 'resource.id='+ids, function() {
					$("#${formId!}").submit();
				});
			});
		}
	};
	
	function viewTrainResource(){
		var id = getCheckedboxValues('${formId!}', 'checkboxId',1);
		if(id != ''){
			window.open('${ctx!}/train_resource/'+id+'/view');
		}else{
			alert('请选择一条记录!');
		}
	};
</script>
</@trainResourcesData>
</@lo.layout>