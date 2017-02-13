<#import "/admin/common/include/layout.ftl" as lo>
<#assign jsArray = [] />
<#assign cssArray = []>
<@lo.layout jsArray=jsArray cssArray=cssArray>
<#assign formId="listProjectForm"/>
<@projectsDataDirective project=project! pageBounds=pageBounds!>
<div class="mis-index-wrap">
	<#import "/admin/common/include/form.ftl" as cf>
	<@cf.form id="${formId!}" action="${ctx!}/tpdpor/admin/project" method="get">
	<input type="hidden" name="menuTreeId" value="${menuTreeId!}">
	<div class="mis-mod">
		<div class="mis-mod-tt">
			<h2 class="tt t1"><span>项目管理</span></h2>
		</div>
		<div class="mis-content">
			<div class="mis-srh-layout">
				<ul class="mis-ipt-lst">
					<li class="item">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>项目名称：</span>
							</div>
							<div class="tc">
								<div class="mis-ipt-mod">
									<input type="text" name="name" value="${(project.name)!}" placeholder="请输入项目名称" class="mis-ipt">
								</div>
							</div>
						</div>
					</li>
					<li class="item">
		                <div class="mis-ipt-row">
		                    <div class="tl">
		                        <span>项目性质：</span>
		                    </div>
		                    <div class="tc">
		                        <div class="mis-select">
		                            <select name="" style="width:200px" >
		                            	
		                            </select>    
		                        </div>
		                    </div>
		                </div>
		            </li>
		            <li class="item">
		                <div class="mis-ipt-row">
		                    <div class="tl">
		                        <span>项目类型：</span>
		                    </div>
		                    <div class="tc">
		                        <div class="mis-select">
		                            <select name="type" style="width:200px" >
		                            	${DictionaryUtils.getEntryOptionsSelected('PROJECT_TYPE',(project.type)!'')}
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
						<button type="button" onclick="createProject();" class="mis-btn mis-inverse-btn">
							<i class="mis-add-ico"></i>新增
						</button>
						<button type="button" onclick="goUpdateProject();" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
							<i class="mis-alter-ico"></i>修改
						</button>
						<button type="button" onclick="deleteProject();" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
							<i class="mis-delete-ico"></i>注销
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
								<th>项目名称</th>
								<th>项目性质</th>
								<th>项目类型</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="4"> 
									<#import "/admin/common/include/pagination.ftl" as page/>
									<@page.adminPage formId="${formId!}" divId="" paginator=paginator!/> 
								</td>
							</tr>
						</tfoot>
						<tbody>
							<#if projects??>
								<#list projects as project>
								<tr>
									<td>
										<input class="checkRow" type="checkbox" name="checkboxId" value="${(project.id)!}">
									</td>
									<td>${(project.name)!}</td>
									<td>---</td>
									<td>
										${DictionaryUtils.getEntryName('PROJECT_TYPE', (project.type)!) }
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

<script>
	function createProject(){
		window.location.href = '${ctx!}/tpdpor/admin/project/create?menuTreeId=${menuTreeId!}';
	};
	
	function goUpdateProject(){
		var id = getCheckedboxValues('${formId!}', 'checkboxId',1);
		if(id != ''){
			window.location.href = '${ctx!}/tpdpor/admin/project/'+id+'/edit?menuTreeId=${menuTreeId!}';
		}else{
			alert('请选择一条记录');
		}
	};
	
	function deleteProject(){
		var id = getCheckedboxValues('${formId!}', 'checkboxId',1);
		if(id != ''){
			mylayerFn.confirm({
		        content: "确定对所选记录注销？",
		        icon: 3,
		        yesFn: function(){
		        	$.ajaxDelete('${ctx!}/project/'+id, '', function(){
						$('#${formId!}').submit();
					})
		        }
		    });
		}else{
			alert('请选择一条记录');
		}
	};
	
</script>
</@projectsDataDirective>
</@lo.layout>