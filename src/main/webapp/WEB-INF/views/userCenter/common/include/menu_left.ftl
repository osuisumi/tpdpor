<#macro menuFtl menu>
<div class="g-user-side" id="userCenterMenu">
    <div class="m-user-head">
        <a href="javascript:;" class="who">
        	<#import "/tpdpor/common/tags/image.ftl" as image/>
			<@image.imageFtl url="${(Session.loginer.avatar)! }" default="/images/tpdpor/${app_path}/defaultAvatar.jpg" />
        </a>
        <h3 class="name"><a href="javascript:;">${(Session.loginer.realName)!}</a></h3>
        <!--<p class="head-tl">努力最最好的自己！</p>-->        
    </div>
    <dl class="g-user-resource">
        <dt class="m-user-resource"><i></i>我的资源</dt>
        <dd class="ucm subscribe <#if menu="dytj">crt</#if> "><a href="${ctx}/userCenter/subscribe_resource"><i></i>订阅推荐</a></dd>
        <dd class="ucm education-res <#if menu="jyzl">crt</#if> "><a href="${ctx}/userCenter/teach_resource?applyUserOrFollowCreator=${(Session.loginer.id)!}"><i></i>教研资料</a></dd>
        <dd class="ucm lesson-case <#if menu="kcal">crt</#if> "><a href="${ctx!}/userCenter/course_resource?creatorOrFollowCreator=${(Session.loginer.id)!}"><i></i>课程案例</a></dd>
        <dd class="ucm train-study <#if menu="pxxx">crt</#if> "><a href="${ctx!}/userCenter/train_resource"><i></i>培训学习</a></dd>
        <dd class="ucm teacher-build <#if menu="jsck">crt</#if> "><a href="${ctx!}/userCenter/creative"><i></i>教师创客</a></dd>
        <!--<dd class="ucm upload-res <#if menu="sczy">crt</#if> "><a><i></i>上传资源</a></dd>-->
    </dl>
    <dl class="m-score">
    	<dt class="ucm <#if menu="wdjf">crt</#if>"><a href="${ctx!}/userCenter/pointRecord"><i></i>我的积分</a></dt>
    </dl>
    <#assign hasExpertRole=SecurityUtils.getSubject().hasRole('expert') />
    <#if hasExpertRole>
    	<@expertsData userId=(Session.loginer.id)!>
    		<#if (experts)?size gt 0 >
    		<#assign expertId=(experts[0].id)! />
    		</#if>
    	</@expertsData>
	    <dl class="m-expert">
	    	<dt class="ucm <#if menu="wdzjkj">crt</#if>"><a href="${ctx!}/expert/${(expertId)!}/view" target="_blank"><i></i>我的专家空间</a></dt>
	    </dl>
    </#if>
    <dl class="g-user-resource nop">
        <dt class="ucm m-certification"><i></i>个人资料</dt>
        <dd class="ucm real-name <#if menu="grzl">crt</#if>"><a href="${ctx!}/userCenter/user_info/edit_my_user_info"><i></i>帐号信息</a></dd>
        <dd class="ucm apply-cer <#if menu="xgmm">crt</#if> "><a href="${ctx!}/userCenter/account/change_password"><i></i>修改密码</a></dd>
    </dl>
    <dl class="m-buy">
        <dt class="ucm <#if menu="sqjl">crt</#if>"><a href="${ctx}/userCenter/resource_apply_record"><i></i>申请记录</a></dt>
    </dl>
    <!--
    <dl class="m-periodical">
        <dt class="ucm"><a href="personal-periodical.html"><i></i>个性订阅</a></dt>
    </dl>
    -->
    <dl class="m-letter">
        <dt class="ucm <#if menu="znsx">crt</#if>"><a href="${ctx}/userCenter/message?orders=CREATE_TIME.DESC"><i></i>站内私信</a></dt>
    </dl>
</div>

</#macro>