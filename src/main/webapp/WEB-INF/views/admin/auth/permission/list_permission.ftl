<#assign jsArray=["${ctx}/js/common/ztree/js/jquery.ztree.core.min.js"]/>
<#import "/admin/common/include/layout.ftl" as lo> 
<@lo.layout jsArray=jsArray>
		<div class="mis-index-wrap">
			<div class="mis-column-innerBox mis-block-cont">
                        <div class="mis-column-innerL">
		                    <div class="mis-mod-tt">
                                <h2 class="tt t1">
                                    <span>栏目</span>
                                </h2>  
                            </div> 
                            <div class="mis-ztree">
                                <ul id="misZtree" class="ztree"></ul>
                            </div>                    
             			</div>
					<#assign formId="listArticlesForm"/>
					<@authPermissionListDataDirective page=param_page!"1" size=param_size!"10" channelId=channel.id state=param_state!""  title=param_title!"" isTop=param_isTop!"">
					<div class="mis-column-innerR">
                            <div class="mis-mod-tt">
                                <h2 class="tt t1">
                                    <span>权限操作管理</span>
                                </h2>                                
                            </div>
                            <div class="mis-content" style="padding-left:10px;" id="authPermissionContent">
							<#import "/admin/common/include/form.ftl" as cf>
							<@cf.form id="${formId}" action="${ctx}/auth_permissions/resource_permission/{resourceId}" method="get">
			                    <div class="mis-srh-layout">
			                        <ul class="mis-ipt-lst">                            
			                            <li class="item">
			                                <div class="mis-ipt-row">
			                                    <div class="tl">
			                                        <span>权限操作名称:</span>
			                                    </div>
			                                    <div class="tc">
			                                        <div class="mis-ipt-mod">
			                                            <input type="text" name="name" value="${param_name!""}" placeholder="请输入标题" class="mis-ipt">
			                                        </div>
			                                    </div>
			                                </div>
			                            </li>
			                                                     
			                        </ul>
			                        <div class="mis-btn-row indent1">
			                            <button type="submit" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			                            <button type="reset" class="mis-btn mis-default-btn"><i class="mis-refresh-ico"></i>重置</button>
			                        </div>
			                    </div>
			                    <div class="mis-table-layout">
			                    	<div class="mis-table-srhTl">
			                                <i class="mis-srh-result"></i>
			                                <span>搜索结果</span>
			                        </div>
			                        <div class="mis-opt-row">
			                            <div class="mis-opt-mod fl">
			                                <button type="button" class="mis-btn mis-inverse-btn" onclick="editForm('channelId=${channel.id}');" ><i class="mis-add-ico"></i>新建</button>
			                                <button type="button" class="mis-btn mis-inverse-btn disabled-btn  disabled" disabled="disabled" onclick="editForm('resourceId=${resourceId!}');" ><i class="mis-alter-ico"></i>修改</button>
			                                <button type="button" onclick="deleteArticle()" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled"><i class="mis-detele-ico"></i>删除</button>                                
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
													<th width="25%">名称</th>
													<th width="5%">action</th>
													<th width="5%">actionURI</th>
			                                    </tr>
			                                </thead>
			                                <tfoot>
			                                	
			                                    <tr>
			                                        <td colspan="4">
			                                            <#import "/admin/common/include/pagination.ftl" as page/>
														<@page.adminPage formId="${formId}" divId="" paginator=paginator/>
			                                        </td>
			                                    </tr>
			                                </tfoot>
			                                <tbody>
												<#if authPermissionList??>
												<#list authPermissionList as authPermission>
			                                    <tr>
			                                        <td>
			                                        <label class="mis-checkbox">
			                                               <strong>
			                                                    <i class="ico"></i>
			                                                    <input type="checkbox" name="checkboxId" class="checkRow" value="${authPermission.id}">
			                                               </strong>
			                                        </label>
			                                        </td>
													<td>${authPermission.name}</td>
													
													<td>${authPermission.action!}</td>
													<td>
														${authPermission.actionURI!}
													</td>
			                                    </tr> 
			                                    </#list>
			                                    </#if>                                  
			                                </tbody>
			                            </table>
			                        </div>
			                    </div> <!--end module layout -->
			                </@cf.form>
			            </div><!--end inner page -->
			          </div>
				</div>
						<script type="text/javascript">	
								function openCreatePermission(){
									 mylayerFn.open({
							            id: 12345,
							            type: 2,
							            title: '新增栏目',
							            content: '${ctx}/admin/auth_permissions/create/${resourceId}',
										area: [600,600],
							            zIndex: 19999
							        });
								}				
								function editForm(data){
									var value = getCheckedboxValues('${formId}','checkboxId',1);
									if(value!=''){
										mylayerFn.open({
								            id: 12345,
								            type: 2,
								            title: '新增栏目',
								            content: '${ctx}/admin/auth_permissions/'+value+'/edit',
											area: [600,600],
								            zIndex: 19999
							        	});
									}
								}
								
								
								function deletePermission(){
									var value = getCheckedboxValues('${formId}','checkboxId',1);
									if(value!=''){
										confirm('确认要删除选中记录吗？',function(r){
											$.ajaxDelete('${ctx}/auth_permissions/'+value, "", function(){
										    	$("#${formId}").submit();
											});
										});
									} 
								}
						</script>
			            </@authPermissionListDataDirective>
						<script>
							function onClick(event, treeId, treeNode, clickFlag) {
								window.location.href="${ctx}/admin/auth_permissions/resource_permissions/"+treeNode.id;
							}	
						</script>
						<#import "/admin/auth/resource/tree_click.ftl" as tc> 
						<@tc.resourceTreeClick resourceTreeId="misZtree">
						</@tc.resourceTreeClick>
</@lo.layout>