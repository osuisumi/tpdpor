<#import "/admin/common/include/layout.ftl" as lo> 
<@lo.layout>
		<#assign formId="usersForm"/>
		<@authUserListDataDirective page=param_page!"1" size=param_size!"10" realName=param_realName!"">
		<div class="mis-index-wrap">
				<#import "/admin/common/include/form.ftl" as cf>
				<@cf.form id="${formId}" action="${ctx}/admin/auth_users/list" method="get">				
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
                                        <span>用户名称：</span>
                                    </div>
                                    <div class="tc">
                                        <div class="mis-ipt-mod">
                                            <input type="text" name="realName" value="${param_realName!""}" placeholder="请输入用户姓名" class="mis-ipt">
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
                                <a href="javascript:" onclick="createUser();" class="mis-btn mis-inverse-btn"><i class="mis-add-ico"></i>新建</a>
                                <button type="button" class="mis-btn mis-inverse-btn disabled-btn  disabled" disabled="disabled" onclick="editForm();" ><i class="mis-alter-ico"></i>修改</button>                                
                                <button type="button" onclick="deleteUser()" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled"><i class="mis-detele-ico"></i>删除</button> 
                                <button type="button" class="mis-btn mis-inverse-btn disabled-btn  disabled" disabled="disabled" onclick="editUserRole();" ><i class="mis-authorization-ico"></i>分配角色</button>                          
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
										<th width="8%">姓名</th>
										<th width="5%">用户名</th>
										<th width="10%">头像</th>
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
									<#if authUserList??>
									<#list authUserList as authUser>
                                    <tr>
                                        <td><input class="checkRow" type="checkbox" name="checkboxId" value="${authUser.id}"></td>
										<td>${authUser.realName!}</td>
										<td>${authUser.username!}</td>
										<td>${authUser.avatar!}</td>										
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
					function createUser(){
						mylayerFn.open({
				            id: "createUserLayer",
				            type: 2,
				            title: '新增用户',
				            content: '${ctx}/admin/auth_users/create',
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
				            id: "updateUserLayer",
				            type: 2,
				            title: '编辑用户',
				            content: "${ctx}/admin/auth_users/"+value+"/edit",
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
					
					function deleteUser(){
						var value = getCheckedboxValues('${formId}','checkboxId',1);
						if(value!=''){
							confirm('确认要删除选中记录吗？',function(r){
								$.ajaxDelete('${ctx}/admin/auth_users/'+value, "", function(){
									$("#${formId}").submit();
								});
							});
						} 
					}
					
					function editUserRole(){
						var value = getCheckedboxValues('${formId}','checkboxId',1);
						if(value!=''){
							window.location.href="${ctx}/admin/auth_users/"+value+"/editUserRole?menuTreeId=${menuTreeId!}"
						}
					}
					
					
			</script>
            </@authUserListDataDirective>
</@lo.layout>