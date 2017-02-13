<#import "/admin/common/include/form_layer.ftl" as fl>
		<@fl.form id="createUsersForm" action="${ctx}/auth_users/${authUser.id}" method="put">
		<ul class="mis-ipt-lst">
            <li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>姓名：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-ipt-mod">
                            <input type="text" name="realName" value="${authUser.realName!}" class="mis-ipt">
                        </div>
                    </div>
                </div>
            </li>
            
            <li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>用户名：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-ipt-mod">
                            <input type="text" name="username" value="${authUser.username!}" class="mis-ipt">
                        </div>
                    </div>
                </div>
            </li>
            <li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>密码：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-ipt-mod">
                            <input type="password" name="password" value="" class="mis-ipt">
                        </div>
                    </div>
                </div>
            </li>
            <li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>重复密码：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-ipt-mod">
                            <input type="password" name="repeatPassword" value="" class="mis-ipt">
                        </div>
                    </div>
                </div>
            </li>
 		</ul>
</@fl.form>