<#macro layout cssArray=[] jsArray=[] validate=false mylayer=true menu=''>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${ctx}/css/tpdpor/${app_path}/user.css" type="text/css">
<link rel="stylesheet" href="${ctx}/css/tpdpor/${app_path}/neat.css" type="text/css">
<link rel="stylesheet" href="${ctx}/css/tpdpor/${app_path}/style.css">

<script type="text/javascript" src="${ctx}/js/common/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/admin/sip-common.js"></script>
<script type="text/javascript" src="${ctx}/js/tpdpor/common.js"></script>

<#if validate>
	<link type="text/css" rel="stylesheet" href="${ctx }/js/common/validation/css/cmxform.css">
	<script type="text/javascript" src="${ctx }/js/common/validation/jquery.validate.js"></script> 
	<script type="text/javascript" src="${ctx }/js/common/validation/lib/jquery.metadata.js"></script>
	<script type="text/javascript" src="${ctx }/js/common/validation/expand.js"></script>
	<script type="text/javascript" src="${ctx }/js/common/validation/localization/messages_cn.js"></script>
</#if>

<#if mylayer>
	<link rel="stylesheet" href="${ctx }/js/common/mylayer/v1.0/skin/default/mylayer.css">
	<script type="text/javascript" src="${ctx}/js/common/mylayer/v1.0/mylayer.js"></script>
</#if>

<#if jsArray??>
	<#list jsArray as js>
		<script type="text/javascript" src="${js}"></script>	
	</#list>
</#if>
<#if cssArray??>
	<#list cssArray as css>
		<link rel="stylesheet" href="${css}" type="text/css">	
	</#list>
</#if>
<title>广东第二师范学院教师专业发展在线资源平台</title>
</head>
<body id="innerPageBody">
<div id="wrap">
	<#include "/userCenter/common/include/top.ftl"/>
	<div class="g-bd">
    	<div id="innerPage">
            <div class="g-auto">
            	<div class="g-side-frame">
            		<#import "/userCenter/common/include/menu_left.ftl" as m />
					<@m.menuFtl menu=menu />
            	</div>
            	<div class="g-right-cont">
                    <div class="g-subscribe" id="content">
                    	<#nested>
                    </div>
                </div>
            </div>
        </div>
    </div>    
	<#include "/userCenter/common/include/footer.ftl"/>
</div>

</body>

<#import "/tpdpor/common/tags/function.ftl" as ft />
<@ft.function />
</html>
</#macro>