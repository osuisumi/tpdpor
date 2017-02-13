<#import "../../include/layout.ftl" as lo> 
<@lo.layout>
		<#assign formId="rolesForm"/>
		<@authRolesDirective page=param_page!"1" size=param_size!"10" name=param_name!"">
		<div class="mis-index-wrap">
				<#import "../../include/form.ftl" as cf>
				<@cf.form id="${formId}" action="${ctx}/auth_roles/list" method="get">				
                <div class="mis-mod">
                	<div class="mis-mod-tt">
                        <h2 class="tt t1"><span>权限资源管理</span></h2>
                    </div>
                    <div class="mis-content">  
                    <div class="mis-srh-layout">
                        <ul class="mis-ipt-lst">                            
                            <li class="item">
                                <div class="mis-ipt-row">
                                    <div class="tl">
                                        <span>资源名称：</span>
                                    </div>
                                    <div class="tc">
                                        <div class="mis-ipt-mod">
                                            <input type="text" name="name" value="${param_name!""}" placeholder="请输入资源名称" class="mis-ipt">
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
                                <a href="${ctx}/auth_roles/create" class="mis-btn mis-inverse-btn"><i class="mis-add-ico"></i>新建</a>
                                <button type="button" class="mis-btn mis-inverse-btn disabled-btn  disabled" disabled="disabled" onclick="editForm();" ><i class="mis-alter-ico"></i>修改</button>
                                <button type="button" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled"><i class="mis-detele-ico"></i>删除</button>                                
                            </div>
                        </div>
                        <div class="mis-table-mod">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
                                <thead>
                                    <tr>
                                        <th width="2%"></th>
										<th width="8%">资源名称</th>
										<th width="8%">资源标识</th>
										<th width="5%">创建时间</th>	
                                    </tr>
                                </thead>
                                <tfoot>
                                	
                                    <tr>
                                        <td colspan="9">
                                            <#import "../../include/pagination.ftl" as page/>
											<@page.adminPage formId="${formId}" divId="" paginator=paginator/>
                                        </td>
                                    </tr>
                                </tfoot>
                                <tbody>
									<#if authRoleList??>
									<#list authRoleList as authRole>
                                    <tr>
                                        <td><input type="checkbox" name="checkboxId" value="${authRole.id}"></td>
										<td>${authRole.name!}</td>
										<td>${authRole.code!}</td>
										<td>${authRole.description!}</td>										
										<td>
											<@formatTime longtime="${authRole.createTime!}" pattern="yyyy-MM-dd HH:mm">
													${date}
											</@formatTime>
										</td>
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
					function editForm(){
						var value = getCheckedboxValues('${formId}','checkboxId',1);
						if(value!=''){
							window.location.href="${ctx}/auth_roles/"+value+"/edit";
						}
					}
			</script>
            </@authRolesDirective>
</@lo.layout>