<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<title>教师专业发展在线资源平台</title>
<script type="text/javascript" src="/js/common/jquery.js"></script>
<script type="text/javascript" src="/js/common/jquery.dsTab.js"></script>
<script type="text/javascript" src="/js/tpdpor/login.js"></script>
<script type="text/javascript" src="${ctx}/js/tpdpor/sip-common.js"></script>
<script type="text/javascript" src="${ctx}/js/tpdpor/common.js"></script>
<script type="text/javascript" src="${ctx}/js/common/mylayer/v1.0/mylayer.js"></script>
<link rel="stylesheet" href="${ctx }/js/common/mylayer/v1.0/skin/default/mylayer.css">
<link rel="stylesheet" href="/css/tpdpor/${app_path}/neat.css">
<link rel="stylesheet" href="/css/tpdpor/${app_path}/login/login.css">
<style type="text/css">
a:focus {
	outline: none;
}
input {
	outline: none;
}
</style>
</head>
<body>
	<div id="g-logWrap">
		<div id="g-logTp">
			<div class="g-tpc f-cb">
				<h1 class="g-logo"><a href="${ctx}/tpdpor/index" class="logo"><img src="/css/tpdpor/${app_path}/images/logo.png" alt=""></a><span class="txt">教师专业发展在线资源平台</span></h1>
			</div>
		</div>
		<div id="g-log-bn">
			<ul class="m-slide-lst">
				<li><img src="/css/tpdpor/${app_path}/images/login-banner1.jpg" alt=""></li>
				<li><img src="/css/tpdpor/${app_path}/images/login-banner2.jpg" alt=""></li>
			</ul>
			<a href="javascript:void(0);" class="u-bn-prev"></a>
			<a href="javascript:void(0);" class="u-bn-next"></a>
		</div>
		<input type="hidden" id="spage" value="${param_spage!''}">
		<form id="loginForm" action="${ctx}/tpdpor/login" method="post">
			<div id="g-logBox">
				<div class="m-log-box">
					<div class="m-tab-li f-cb">
						<a href="javascript:void(0);" class="item1 z-crt"><span>账号登录</span></a>
					</div>
					<div class="m-tab-cont f-cb">
						<div class="m-log-block">
							<form action="">
								<label class="m-ipt-mod m-ipt-account">
									<input id="userName" type="text" name="userName" required placeholder="用户名" class="u-ipt">
									<div class="login-popup-hint">
										<i></i>
										<span class="txt">请输入正确的帐号！</span>
									</div>
									<b class="icon-war-error ico"></b>
								</label>
								<label class="m-ipt-mod m-ipt-password">
									<input id="password" type="password" name="password" required placeholder="密码" class="u-ipt">
									<div class="login-popup-hint">
										<i></i>
										<span class="txt">你的密码不正确，请重新输入！</span>
									</div>
									<b class="icon-war-error ico"></b>
								</label>
								<div class="m-row f-cb">
									<label for="" class="m-diy-checkbox" onselectstart="return false">
										<!--<i class="u-checkbox z-slt"></i>
										<span>5天内免登录</span>
										-->
									</label>
									<!--<a href="#" class="fg-pw">找回密码</a>-->
								</div>
								<div class="m-btn-row">
									<a href="javascript:;" onclick="login()" class="main-btn1 btn"><em style="font-style: normal;">登录</em></a>
								</div>
								<div class="link-reg">
									<!--<span>还没有账号？<a href="#">免费注册</a></span>-->
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</form>
		<div id="g-logft">
			<div class="g-ftc">
				<p><span>广州昊誉信息科技有限公司技术支持</p>
				<p>广东第二师范学院版权所有  Copyright © 2015</p>
			</div>
		</div>
	</div>
<script type="text/javascript">
$(function(){
	$('#g-log-bn').dsTab({
		itemEl        : '.m-slide-lst li',
		btnElName     : 'm-fouse',
        btnItem       : 'a',
	    maxSize       : 5,
	    currentClass  : 'z-crt', //按钮当前样式
        autoCreateTab : false,
	    prev          : '.u-bn-prev',
        next          : '.u-bn-next',
	    changeType    : 'fade',
	    change        : true,
	    changeTime    : 5000,
	    overStop      : false,
	});
	
	//帐号错误提示框
	/*loginJs.indexs.accountPopupHint({
		txt : "请输入正确的帐号哦！"
	});*/

	//密码错误提示框
	/*loginJs.indexs.passwordPopupHint({
		txt : "密码错误，请重新输入密码！"
	});*/

});

function login(){
	if($('#userName').val() == ''){
		loginJs.indexs.accountPopupHint({
			txt : "请输入用户名！"
		});
		return false;
	}
	if($('#password').val() ==''){
		loginJs.indexs.passwordPopupHint({
			txt : "请输入密码!"
		});
	}
	var response = $.ajaxSubmit('loginForm');
	response = $.parseJSON(response);
	if(response.responseCode == '00'){
		var spage = $('#spage').val();
		var url = '${ctx}/entrance';
		if(spage != ''){
			url = spage;
		}
		window.location.href = url;
	}else{
		loginJs.indexs.passwordPopupHint({
			txt : "用户名或密码有误!"
		});
	}
}
</script>
</body>
</html>