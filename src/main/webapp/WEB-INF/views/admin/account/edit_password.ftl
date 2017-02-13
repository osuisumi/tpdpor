<#import "/admin/common/include/form_layer.ftl" as fl>
		<@fl.form id="saveAccountPasswordForm" action="${ctx!}/admin/accounts/batch/resetPassword" method="put" onConfirm="saveAccountPassword()">
		<input id="id" type="hidden" name="id" value="${(account.id)!}">
		<ul class="mis-ipt-lst">
           <li class="item">
				<div class="mis-ipt-row">
	                <div class="tl">
	                    <span>用户名：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" id="userName" name="userName" value="${(account.userName)!}" placeholder="请输入用户名..." class="mis-ipt required" readonly="readonly">
	                    </div>
	                </div>
	            </div>
			</li>
			<li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>重置密码：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="password" id="password" name="password" placeholder="请输入重置密码..." class="mis-ipt required">
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>重置密码确认：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="password" name="repassword" placeholder="请输入重置密码..." class="mis-ipt required">
	                    </div>
	                </div>
	            </div>
	        </li>
 		</ul>
</@fl.form>
<script>
	function saveAccountPassword() {
		if(!$('#saveAccountPasswordForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('saveAccountPasswordForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			alert('操作成功',function(){
				$('#listAccountForm').submit();
			});
		}
	}
</script>