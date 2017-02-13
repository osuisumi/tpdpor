<#import "/userCenter/common/include/layout.ftl" as lo>
<@lo.layout validate=true mylayer=true menu='xgmm'>
<form id="changePasswordForm">
	<div class="g-subscribe g-imformation">
		<div class="m-subscribe-tab">
			修改密码
		</div>
		<div class="m-inner-imformation">
			<div class="m-pb-row">
				<div class="m-pb-row">
					<div class="pb-mn">
						<div class="m-pb-mod">
							<div class="pb-txt">
								<span>原密码：</span>
							</div>
							<div class="m-ipt-mod">
								<input type="password" name="oldPassword" class="u-ipt" required placeholder="请输入原密码">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="m-pb-row">
				<div class="m-pb-row">
					<div class="pb-mn">
						<div class="m-pb-mod">
							<div class="pb-txt">
								<span>新密码：</span>
							</div>
							<div class="m-ipt-mod">
								<input id="newPsw" type="password" name="newPassword" class="u-ipt" required placeholder="请输入新密码">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="m-pb-row">
				<div class="m-pb-row">
					<div class="pb-mn">
						<div class="m-pb-mod">
							<div class="pb-txt">
								<span>新密码确认：</span>
							</div>
							<div class="m-ipt-mod">
								<input id="repetPsw" type="password" name="checkNewPassword" class="u-ipt {required:true,equalTo:'#newPsw'}" placeholder="再次输入新密码">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="m-btm-opa">
	            <a href="javascript:;" class="u-btn-theme" onclick="savePassword()">保存</a>
	            <a href="javascript:;" class="u-btn-cancel">取消</a>
	        </div>
		</div>
	</div>
</form>
<script>
	function savePassword(){
		if(!$('#changePasswordForm').validate().form()){
			return false;
		}
		$.ajaxPut('${ctx}/userCenter/account/change_password',$('#changePasswordForm').serialize(),function(response){
			if(response.responseCode == '00'){
				alert("修改成功");
			}else{
				alert("密码错误");
			}
		});
	}
</script>
</@lo.layout>