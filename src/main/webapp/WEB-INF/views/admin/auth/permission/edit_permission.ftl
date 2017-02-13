		<#import "/admin/common/include/form_layer.ftl" as fl>
		<@fl.form id="updatePermissionForm" action="${ctx}/auth_permissions/${authPermission.id}" method="put">
		<ul class="mis-ipt-lst">
        	<li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>权限名称：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-ipt-mod">
                            <input type="text" name="name" value="${authPermission.name}" class="mis-ipt">
                        </div>
                    </div>
                </div>
            </li>
            <li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>操作：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-select">
                            <select name="action">	
                            	<option value="">全部</option>
                            	<option value="read" <#if (authPermission.action??) && authPermission.action=='read'>selected</#if>>查询</option>
                            	<option value="update" <#if (authPermission.action??) && authPermission.action=='update'>selected</#if>>更新</option>
                            	<option value="create" <#if (authPermission.action??) && authPermission.action=='create'>selected</#if>>创建</option>
                            	<option value="delete" <#if (authPermission.action??) && authPermission.action=='delete'>selected</#if>>删除</option>
                            </select>
                        </div>
                    </div>
                </div>
            </li>
            
            <li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>操作链接(支持通配符)：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-ipt-mod">
                            <input type="text" name="actionURI" value="${authPermission.actionURI}" class="mis-ipt">
                        </div>
                    </div>
                </div>
            </li>
 		</ul>
		</@fl.form>