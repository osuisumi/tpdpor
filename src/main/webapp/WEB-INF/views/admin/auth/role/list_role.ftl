<#import "/admin/common/include/layout.ftl" as lo> 
<@lo.layout>
		<#assign formId="rolesForm"/>
		<@authRolesDirective page=param_page!"1" limit=param_limit!"10"  name=param_name!"">
		<div class="mis-index-wrap">
				<#import "/admin/common/include/form.ftl" as cf>
				<@cf.form id="${formId}" action="${ctx}/admin/auth_roles/list" method="get">				
                <div class="mis-mod">
                	<div class="mis-mod-tt">
                        <h2 class="tt t1"><span>角色管理</span></h2>
                    </div>
                    <div class="mis-content">  
                    <div class="mis-srh-layout">
                        <ul class="mis-ipt-lst">                            
                            <li class="item">
                                <div class="mis-ipt-row">
                                    <div class="tl">
                                        <span>角色名称：</span>
                                    </div>
                                    <div class="tc">
                                        <div class="mis-ipt-mod">
                                            <input type="text" name="name" value="${param_name!""}" placeholder="请输入角色名称" class="mis-ipt">
                                        </div>
                                    </div>
                                </div>
                            </li>                            
                        </ul>
                        <div class="mis-btn-row indent1">
                            <button tyle="submit" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
                            <button tyle="button" class="mis-btn mis-default-btn"><i class="mis-refresh-ico"></i>重置</button>
                        </div>
                    </div>
                    <div class="mis-table-layout">
                        <div class="mis-opt-row">
                            <div class="mis-opt-mod fl">
                                <a href="javascript:" onclick="createRole();" class="mis-btn mis-inverse-btn"><i class="mis-add-ico"></i>新建</a>
                                <button type="button" class="mis-btn mis-inverse-btn disabled-btn  disabled" disabled="disabled" onclick="editForm();" ><i class="mis-alter-ico"></i>修改</button>                                
                                <button type="button" onclick="deleteRole()" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled"><i class="mis-detele-ico"></i>删除</button> 
                                <!--<button type="button" class="mis-btn mis-inverse-btn disabled-btn  disabled" disabled="disabled" onclick="editRolePermission();" ><i class="mis-authorization-ico"></i>分配操作权限</button>--> 
                                <button type="button" class="mis-btn mis-inverse-btn disabled-btn  disabled" disabled="disabled" onclick="editRoleMenu();" ><i class="mis-authorization-ico"></i>分配菜单权限</button>                               
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
										<th width="8%">角色名称</th>
										<th width="5%">角色标识</th>
										<th width="10%">角色描述</th>
										<th width="5%">创建时间</th>	
                                    </tr>
                                </thead>
                                <tfoot>
                                	
                                    <tr>
                                        <td colspan="9">
                                            <#import "/admin/common/include/pagination.ftl" as page/>
											<@page.adminPage formId="${formId}" divId="" paginator=paginator/>
                                        </td>
                                    </tr>
                                </tfoot>
                                <tbody>
									<#if authRoles??>
									<#list authRoles as authRole>
                                    <tr>
                                        <td><input class="checkRow" type="checkbox" name="checkboxId" value="${authRole.id}"></td>
										<td>${authRole.name!}</td>
										<td>${authRole.code!}</td>
										<td>${authRole.description!}</td>										
										<td>${TimeUtils.formatDate(authRole.createTime,'yyyy-MM-dd HH:mm')}</td>
                                    </tr> 
                                    </#list>
                                    </#if>                                  
                                </tbody>
                            </table>
                        </div>
                    </div> 
                   </div>
                </div><!--end module layout -->
                </@cf.form>
            </div><!--end inner page -->
			<script type="text/javascript">
					$(document).ready(function(){
						$('input[type=checkbox]').click(function(){
							if($("input[name='checkboxId']:checked").length >0)
							{
								$(".mis-btn.disabled-btn").removeAttr("disabled");
								$(".mis-btn.disabled-btn").removeClass("disabled");
							}else{
								$(".mis-btn.disabled-btn").attr("disabled","disabled");
								$(".mis-btn.disabled-btn").addClass("disabled");
							}
						});
					});
					function createRole(){
						mylayerFn.open({
				            id: "createRoleLayer",
				            type: 2,
				            title: '新增角色',
				            content: '${ctx}/admin/auth_roles/create',
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
					function editForm(){
						var value = getCheckedboxValues('${formId}','checkboxId',1);
						if(value!=''){
							mylayerFn.open({
				            id: "updateRoleLayer",
				            type: 2,
				            title: '编辑角色',
				            content: "${ctx}/admin/auth_roles/"+value+"/edit",
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
					}
					
					function deleteRole(){
						var value = getCheckedboxValues('${formId}','checkboxId',1);
						if(value!=''){
							confirm('确认要删除选中记录吗？',function(r){
								$.ajaxDelete('${ctx}/admin/auth_roles/'+value, "", function(){
									$("#${formId}").submit();
								});
							});
						} 
					}
					
					function editRolePermission(){
						var value = getCheckedboxValues('${formId}','checkboxId',1);
						if(value!=''){
							window.location.href="${ctx}/admin/auth_roles/"+value+"/editRolePermission?menuTreeId=${menuTreeId!}"
						}
					}
					
					function editRoleMenu(){
						var value = getCheckedboxValues('${formId}','checkboxId',1);
						if(value!=''){
							window.location.href="${ctx}/admin/auth_roles/"+value+"/editRoleMenu?menuTreeId=${menuTreeId!}"
						}
					}
			</script>
            </@authRolesDirective>
</@lo.layout>