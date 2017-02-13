<#import "/admin/common/include/form_layer.ftl" as fl>
		<@fl.form id="createRolesForm" action="${ctx}/auth_roles" method="post">
		<ul class="mis-ipt-lst">
            <li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>角色名称：</span>
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
                        <span>角色标识：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-ipt-mod">
                            <input type="text" name="code" value="" class="mis-ipt">
                        </div>
                    </div>
                </div>
            </li>
            <li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>角色描述：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-ipt-mod">
                            <textarea style="height:50px;"   name="description" class="mis-ipt"></textarea>
                        </div>
                    </div>
                </div>
            </li>
 		</ul>
</@fl.form>