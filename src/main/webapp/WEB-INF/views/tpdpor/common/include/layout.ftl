<#macro layout cssArray=[] jsArray=[] validate=false mylayer=true webuploader=false flowplayer=false containSearch=true>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<meta http-equiv="Window-target" content="_top">
<link rel="Shortcut Icon" href="/images/tpdpor/${app_path}/favicon.ico">
<title>教师专业发展在线资源平台</title>
<script type="text/javascript" src="${ctx}/js/common/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/tpdpor/sip-common.js"></script>
<script type="text/javascript" src="${ctx}/js/tpdpor/common.js"></script>
<script type="text/javascript" src="${ctx}/js/common/pdfobject/pdfobject.min.js"></script>

<#if mylayer>
	<link rel="stylesheet" href="${ctx }/js/common/mylayer/v1.0/skin/default/mylayer.css">
	<script type="text/javascript" src="${ctx}/js/common/mylayer/v1.0/mylayer.js"></script>
</#if>

<#if validate>
	<link type="text/css" rel="stylesheet" href="${ctx }/js/common/validation/css/cmxform.css">
	<script type="text/javascript" src="${ctx }/js/common/validation/jquery.validate.js"></script> 
	<script type="text/javascript" src="${ctx }/js/common/validation/lib/jquery.metadata.js"></script>
	<script type="text/javascript" src="${ctx }/js/common/validation/expand.js"></script>
	<script type="text/javascript" src="${ctx }/js/common/validation/localization/messages_cn.js"></script>
</#if>

<#if webuploader>
	<link type="text/css" rel="stylesheet" href="${ctx }/js/common/webuploader/webuploader.css">
	<script type="text/javascript" src="${ctx }/js/common/webuploader/webuploader.min.js"></script> 
</#if>

<#if flowplayer>
	<link rel="stylesheet" href="${ctx}/js/common/flowplayer/skin/functional.css">
	<script type="text/javascript" src="${ctx}/js/common/flowplayer/flowplayer.min.js"></script>
</#if>

<#if jsArray??>
	<#list jsArray as js>
		<script type="text/javascript" src="${js}"></script>	
	</#list>
</#if>
<#if cssArray??>
	<#list cssArray as css>
		<link rel="stylesheet" href="${css}">	
	</#list>
</#if>
<link rel="stylesheet" href="/css/tpdpor/${app_path}/neat.css">
<link rel="stylesheet" href="/css/tpdpor/${app_path}/style.css">
</head>
<body id="innerPageBody">
<div id="wrap">
	<#import "/tpdpor/common/include/top.ftl" as t/>
	<@t.top containSearch=containSearch />
    <div class="g-menu">
        <div class="g-auto">
            <ul class="m-menu tab-menu">
                <li class="index"><a href="${ctx}/tpdpor/index">首页</a></li>
                <li class="teach"><a href="${ctx}/teach_resource/index">教研资料</a></li>
                <li class="course"><a href="${ctx}/course_resource/index">课程案例</a></li>
                <li class="train"><a href="${ctx}/train_resource/index">培训学习</a></li>
                <li class="creative"><a href="${ctx}/creative/index">教师创客</a></li>
            </ul><!--end menu -->
            	<ul class="m-us-opt">
            		<#if (Session.loginer.id)??>
	                <li>
	                    <a href="${ctx}/userCenter/message?orders=CREATE_TIME.DESC" class="u-message"><i class="u-mail-ico"></i><#-- <i class="has"></i>--></a>
	                </li>
	                <li class="u-uOpt">
	                    <a href="${ctx!}/userCenter" class="u">
	                    	<#import "/tpdpor/common/tags/image.ftl" as image/>
							<@image.imageFtl url="${(Session.loginer.avatar)! }" default="/images/tpdpor/${app_path}/defaultAvatar.jpg" />
	                    	<span>${(Session.loginer.realName)!}</span><i class="u-trg1-ico"></i>
	                    </a>
	                    <div class="lst">
	                        <i class="trg"><i></i></i>
	                        <a href="${ctx}/userCenter/user_info/edit_my_user_info"><i class="u-user2-ico"></i>用户资料</a>
                            <#if (Session.hasMenu)?? && Session.hasMenu>
								<a href="${ctx}/admin"><i class="u-user2-ico"></i>管理后台</a>	                            
                            </#if>
	                        <a href="${ctx}/logout"><i class="u-exit2-ico"></i>退出登录</a>
	                    </div>
	                </li>
	                <#else>
	                <li>
                   		<a href="javascript:;" class="u-login" onclick="login()" title="登录"><i class="u-login-ico"></i></a>
                	</li>
            	 	</#if>
	            </ul>
        </div>
    </div>
    <div class="g-bd">
        <div id="innerPage" class="innerPage">
            <div id="content" class="g-auto">
            	<#nested>
            </div>
        </div>
    </div>

	<#include "/tpdpor/common/include/footer.ftl"/>
</div>

<ul class="m-bottom-opt">
    <li class="item1">
        <a href="javascript:void(0);">
            <i class="t-ico"></i>
            <span class="txt">寻找</br>帮助</span>
        </a>   
    </li>
    <li class="item2">
        <a href="javascript:void(0);">
            <i class="t-ico"></i>
            <span class="txt">扫码</br>关注</span>
        </a>   
        <div class="tdc-block"></div>
    </li>
    <li class="item3">
        <a href="javascript:void(0);" id="toTop">
            <i class="t-ico"></i>
            <span class="txt">返回</br>顶部</span>
        </a>    
    </li>
</ul>

<script>
	$(function(){
		var path = window.location.pathname;
		if(path.indexOf('teach_resource')>0){
			$('.tab-menu li.teach').addClass('z-crt');
		}else if(path.indexOf('course_resource')>0){
			$('.tab-menu li.course').addClass('z-crt');
		}else if(path.indexOf('train_resource')>0){
			$('.tab-menu li.train').addClass('z-crt');
		}else if(path.indexOf('creative')>0){
			$('.tab-menu li.creative').addClass('z-crt');
		}
	});
</script>

</body>
<#import "/tpdpor/common/tags/function.ftl" as ft />
<@ft.function />
</html>
</#macro>

