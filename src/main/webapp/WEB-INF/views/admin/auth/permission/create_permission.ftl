		<#import "/admin/common/include/form_layer.ftl" as fl>
		<@fl.form id="createPermissionForm" action="${ctx}/auth_permissions" method="post">
		<input type="hidden" name="resource.id" value="${resourceId!}"/>
		<ul class="mis-ipt-lst">
        	<li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>权限名称：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-ipt-mod">
                            <input type="text" name="name" value="" class="mis-ipt">
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
                            	<option value="read">查询</option>
                            	<option value="update">更新</option>
                            	<option value="create">创建</option>
                            	<option value="delete">删除</option>
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
                            <input type="text" name="actionURI" value="" class="mis-ipt">
                        </div>
                    </div>
                </div>
            </li>
 		</ul>
		</@fl.form>