<#import "/admin/common/include/layout.ftl" as lo>
<#assign jsArray = ["${ctx!}/js/common/My97DatePicker/WdatePicker.js"] />
<#assign cssArray = ["${ctx!}/css/admin/fileUpload.css"]>
<@lo.layout jsArray=jsArray cssArray=cssArray webuploader=true>

<#assign types=[]>
<#assign creativeTypeMap={}>

<#list DictionaryUtils.getEntryList('CREATIVE_TYPE') as t>
	<#assign types=types+[t.dictValue]>
	<#assign creativeTypeMap=creativeTypeMap+{t.dictValue:t.dictName}>
</#list>

<#assign whereCreativeTypeManager = ''>
<#list types as t>	
	<#if (SecurityUtils.getSubject().hasRole('creative_type_manager_'+t))>
		<#if whereCreativeTypeManager != '' >
			<#assign whereCreativeTypeManager = whereCreativeTypeManager+','+t>
		<#else>
			<#assign whereCreativeTypeManager =  t >
		</#if>
	</#if>
</#list>

<#assign whereCreativeTypeExpert = ''>
<#list types as t>	
	<#if (SecurityUtils.getSubject().hasRole('creative_type_expert_'+t))>
		<#if whereCreativeTypeExpert != '' >
			<#assign whereCreativeTypeExpert = whereCreativeTypeExpert+','+t>
		<#else>
			<#assign whereCreativeTypeExpert =  t >
		</#if>
	</#if>
</#list>

<#assign hadTypes = ''>
<#list types as t>
	<#if ((whereCreativeTypeManager)!?contains(t)) || ((whereCreativeTypeExpert)!?contains(t))>
		<#if hadTypes != '' >
			<#assign hadTypes = hadTypes + ',' + t >			
		<#else>
			<#assign hadTypes =  t >
		</#if>
	</#if>
</#list>

<#assign formId="listCreativeForm"/>
<@creativesData getStatus=true types=hadTypes!'' relationId=relationId relationType=relationType state=(creative.state)! creatorId=(creative.creator.id)! 
	title=(creative.title)! startTimeLessThan=((creative.creativeRelations[0].collectTimePeriod.startTime)?string('yyyy-MM-dd HH:mm:ss'))!''
	endTimeGreater=((creative.creativeRelations[0].collectTimePeriod.endTime)?string('yyyy-MM-dd HH:mm:ss'))!''
	page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders=(param_orders)!'TOP_DAYS.DESC,CREATE_TIME.DESC'>
<div class="mis-index-wrap">
	<#import "/admin/common/include/form.ftl" as cf>
	<@cf.form id="${formId!}" action="${ctx!}/tpdpor/admin/creative" method="get">
	<input type="hidden" name="menuTreeId" value="${menuTreeId!}">
	<div class="mis-mod">
		<div class="mis-mod-tt">
			<h2 class="tt t1"><span>教师创客管理</span></h2>
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
									<input type="text" name="title" value="${(creative.title)!}" placeholder="请输入标题" class="mis-ipt">
								</div>
							</div>
						</div>
					</li>
					<li class="item item-twoIpu">
		                <div class="mis-ipt-row">
		                    <div class="tl">
		                        <span>活动时间：</span>
		                    </div>
		                    <div class="center">
		                        <div class="tc">
		                            <div class="mis-ipt-mod">
		                                <input id="collectStartTime" name="creativeRelations[0].collectStartTime" type="text" value="${(creative.creativeRelations[0].collectTimePeriod.startTime?string("yyyy-MM-dd"))! }" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="mis-ipt">
		                            </div>
		                        </div>
		                        <span class="to">至</span>
		                        <div class="tc">
		                            <div class="mis-ipt-mod">
		                                <input id="collectEndTime" name="creativeRelations[0].collectEndTime" type="text" value="${(creative.creativeRelations[0].collectTimePeriod.endTime?string("yyyy-MM-dd"))!}" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'collectStartTime\')}',dateFmt:'yyyy-MM-dd'})" class="mis-ipt" >
		                            </div>
		                        </div>                                            
		                    </div>
		                </div>
		            </li>
		            <li class="item">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>板块：</span>
							</div>
							<div class="tc">
								<div class="mis-select">
									<select name="type" id="selectType">
									
										<option value="" >请选择...</option>
										<#list DictionaryUtils.getEntryList('CREATIVE_TYPE') as t>
											<#if ((whereCreativeTypeManager)!?contains(t.dictValue)) || ((whereCreativeTypeExpert)!?contains(t.dictValue))>
												<option value="${(t.dictValue)!}">${(t.dictName)!}</option>
											</#if>
										</#list>
									</select>
									<script>
										$(function(){
											$("#selectType").find("option[value='${(creative.type)!}']").attr("selected",true);
										});
									</script>
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
				<div class="mis-srh-layout">
					<div class="mis-table-layout">
						<div class="mis-opt-row">
							<div class="mis-opt-mod fl">
								<button type="button" onclick="goCreateCreative();" class="mis-btn mis-inverse-btn">
									<i class="mis-look-ico"></i>发起创客项目
								</button>
								<#if whereCreativeTypeManager != ''>
								<button type="button" onclick="updateCreativeState('passed');" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
									<i class="mis-pass-ico"></i>审核通过
								</button>
								<button type="button" onclick="updateCreativeState('no_pass');" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
									<i class="mis-unpass-ico"></i>审核不通过
								</button>
								</#if>
								<button type="button" onclick="deleteCreative();" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
									<i class="mis-delete-ico"></i>删除
								</button>
								<button type="button" onclick="goUpdateCreative_Status('top');" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
									<i class="mis-top-ico"></i>置顶
								</button>
								<button type="button" onclick="updateCreative_StatusCancel('top');" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
									<i class="mis-untop-ico"></i>取消置顶
								</button>
								<button type="button" onclick="viewCreative();" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
									<i class="mis-look-ico"></i>项目预览
								</button>
								<#assign hasSuperAdminRole=SecurityUtils.getSubject().hasRole('superAdmin') />
								<#if hasSuperAdminRole >
									<a href="${ctx!}/tpdpor/admin/creative/typeManage?menuTreeId=${menuTreeId!}" class="mis-btn mis-inverse-btn"><i class="mis-setting-ico"></i>板块管理设置</a>
								</#if>
								<#if whereCreativeTypeExpert != ''>
									<button type="button" onclick="updateExcellentState('excellent');" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
										<i class="mis-pass-ico"></i>评优通过
									</button>
									<button type="button" onclick="updateExcellentState('no_excellent');" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
										<i class="mis-unpass-ico"></i>评优不通过
									</button>
								</#if>
								<#if whereCreativeTypeManager != ''>
								<button type="button" onclick="goManageAgreement();" class="mis-btn mis-inverse-btn" >
									<i class="mis-setting-ico"></i>申请协议管理
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
										<th>标题</th>
										<th>板块</th>
										<th>发布时间</th>
										<th>审核状态</th>
										<th>领取人</th>
										<th>领取人角色</th>
										<th>顶置天数</th>
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
									<#if creatives??>
										<#list creatives as creative>
										<tr>
											<td>
												<input class="checkRow" type="checkbox" name="checkboxId" value="${(creative.id)!}">
											</td>
											<td>${(creative.title)!}</td>
											<td>
												${(creativeTypeMap["${(creative.type)!}"])!'----'}
											</td>
											<td>
												<#if (creative.creativeRelations[0].collectTimePeriod.startTime)??>
													${TimeUtils.formatDate(creative.creativeRelations[0].collectTimePeriod.startTime, 'yyyy-MM-dd')! }
													~
													${TimeUtils.formatDate(creative.creativeRelations[0].collectTimePeriod.endTime, 'yyyy-MM-dd')! }
												<#else>
													----	
												</#if>
											</td>
											<td>
												<#if (creative.creativeRelations[0].collectTimePeriod.startTime)??>
													<#if (creative.state)! == 'auditing'>
														审核中
													<#elseif (creative.state)! == 'passed'>
														审核通过
													<#elseif (creative.state)! == 'no_pass'>
														审核不通过
													<#elseif (creative.state)! == 'excellent'>
														评优通过
													<#elseif (creative.state)! == 'no_excellent'>
														评优不通过
													<#else>
														----
													</#if>
												<#else>
													未认领	
												</#if>
											</td>
											<td>${(creative.creativeUser.user.realName)!'----'}</td>
											<td>
												<#if (creative.claimRole)??>
													<#if (creative.claimRole)! == '2'>
														在校老师
													<#elseif (creative.claimRole)! == '3'>
														在校学生
													<#elseif (creative.claimRole)! == 'member'>
														认证会员
													</#if>
												<#else>
													----
												</#if>
											</td>
											<td>${(statusMap[creative.id].top.days)!'----' }</td>
										</tr>
										</#list>
									</#if>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</@cf.form>
</div>
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
	
	//审核通过不通过
	function updateCreativeState(state){
		var ids = getCheckedboxValues('${formId!}', 'checkboxId');
		var msg = '';
		
		if(ids == '' || ids == undefined){
			alert('未选中任何记录');
			return false;
		}
		if(state == "passed"){
			msg = '确定所选记录通过审核?';
			state = 'passed';
		}
		if(state == "no_pass"){
			msg = '确定所选记录通过不审核?';
			state = 'no_pass';
		}
		confirm(msg,function(r){
			$.ajaxPut('${ctx!}/tpdpor/admin/creative/batch', 'id='+ids+'&state='+state, function(){
				$('#${formId!}').submit();
			});
		});
	};
	
	//删除
	function deleteCreative() {
		var ids = getCheckedboxValues('${formId!}', 'checkboxId');
		if (ids != '') {
			confirm('确认要删除选中记录吗？', function(r) {
				$.ajaxDelete('${ctx}/tpdpor/admin/creative/batch', 'id='+ids, function() {
					$("#${formId!}").submit();
				});
			});
		}
	};

	//顶置
	function goUpdateCreative_Status(state){
		var ids = getCheckedboxValues('${formId!}', 'checkboxId');	
		if (ids != '') {
			mylayerFn.confirm({
		        content: "确定对所选记录进行顶置？",
		        icon: 3,
		        yesFn: function(){
		        	mylayerFn.open({
						id : "updateCreative_Status",
						type : 2,
						title : '顶置',
						content : '${ctx}/tpdpor/admin/status/goUpdateStatus?state='+state+'&relation.id='+ids+'&relation.type=creative',
						area: [600,500],
						offset : [$(document).scrollTop()],
						fix : false,
						shadeClose : true,
						zIndex : 19999,
					});
		        }
		    });
		}
	};
	
	//取消顶置
	function updateCreative_StatusCancel (state){
		var ids = getCheckedboxValues('${formId!}', 'checkboxId');	
		if (ids != ''){
			mylayerFn.confirm({
		        content: "确定对所选记录取消顶置？",
		        icon: 3,
		        yesFn: function(){
		        	$.ajaxPut('${ctx!}/status', 'relation.id='+ids+'&relation.type=creative&state='+state+'&days=0', function(){
						$('#${formId!}').submit();
					});
		        }
		    });
		}
	};
	
	//评优
	function updateExcellentState (state){
		var ids = getCheckedboxValues('${formId!}', 'checkboxId');
		var msg = '';
		if(state == 'excellent'){
			msg = '确定对所选记录进行评优通过?(只对审核通过的创客生效)';
		}	
		if(state == 'no_excellent'){
			msg = '确定对所选记录进行评优不通过?(只对审核通过的创客生效)';
		}
		
		if (ids != ''){
			mylayerFn.confirm({
		        content: msg,
		        icon: 3,
		        yesFn: function(){
		        	$.ajaxPut('${ctx!}/tpdpor/admin/creative/batch/excellentState', 'id='+ids+'&state='+state, function(){
						$('#${formId!}').submit();
					});
		        }
		    });
		}
	};
	
	//预览
	function viewCreative(){
		var id = getCheckedboxValues('${formId!}', 'checkboxId',1);
		if(id != ''){
			window.open('${ctx!}/creative/'+id+'/view');
		}else{
			alert('请勾选一个创客');
		}
	};
	
	
	function goManageAgreement(){
		mylayerFn.open({
			id : "manageAgreement",
			type : 2,
			title : '创客项目申请协议管理',
			content : '${ctx!}/tpdpor/admin/creative/agreement',
			area: [900,500],
			offset : [$(document).scrollTop()],
			fix : false,
			shadeClose : true,
			zIndex : 19999,
		});
	};
	
	//创建创客项目
	function goCreateCreative(){
		window.location.href = '${ctx!}/tpdpor/admin/creative/create?menuTreeId=${menuTreeId!}&type=${(hadTypes)!}&creativeRelations[0].relation.id=tpdpor&creativeRelations[0].relation.type=creative';
	};
</script>
</@creativesData>
</@lo.layout>