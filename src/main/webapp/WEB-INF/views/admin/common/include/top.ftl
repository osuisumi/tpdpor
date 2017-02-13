<div class="mis-hd-inner">
	<h1 class="mis-logo"><a href="${ctx!}/admin"> <img src="/images/admin/${app_path}/logo.png" alt="广东第二师范学院教师专业发展在线资源平台"> </a></h1>
	<!--
	<ul class="mis-hd-opt">
		<li class="item1">
			<a href="javascript:;" title="浏览痕迹"></a>
		</li>
		<li class="item2">
			<a href="javascript:;" title="系统消息"></a>
		</li>
	</ul>
	-->
	<div class="mis-tuser">
		<a href="javascript:;" class="tuser-show">
			<#import "/tpdpor/common/tags/image.ftl" as image/>
			<@image.imageFtl url="${(Session.loginer.avatar)!}" default="/images/admin/${app_path}/defaultAvatar.jpg" />
		 	<strong class="txt"><span class="name">${(Session.loginer.realName)!}</span></strong> 
		 	<!--<span class="status"><i class="mis-super-ico"></i>超级管理员</span>--> 
		 	<i class="trg"></i> 
		</a>
		<div class="tuser-lst">
			<i class="trg"></i>
			<ul class="lst">
				<!--
				<li class="item">
					<a href="javascript:;" class="cmt"><span class="txt">我的评论</span><strong class="num">56</strong></a>
				</li>
				<li class="item">
					<a href="javascript:;" class="user"><span class="txt">个人资料</span></a>
				</li>
				<li class="item">
					<a href="javascript:;" class="record"><span class="txt">系统记录</span></a>
				</li>
				<li class="item">
					<a href="javascript:;" class="setting"><span class="txt">账号设置</span></a>
				</li>
				-->
				<li class="item last">
					<a href="${ctx}/logout" class="exit"><span class="txt">退出</span></a>
				</li>
			</ul>
		</div>
	</div>
</div>

