<#macro layout cssArray=[] jsArray=[] validate=false webuploader=false>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${ctx}/css/admin/neat.css" type="text/css">
<link rel="stylesheet" href="${ctx}/js/common/mylayer/v1.0/skin/default/mylayer.css" type="text/css">
<link rel="stylesheet" href="${ctx}/css/admin/skin/blue1/mis-style.css" type="text/css">

<script type="text/javascript" src="${ctx}/js/common/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/common/ztree/js/jquery.ztree.core.min.js"></script>
<script type="text/javascript" src="${ctx}/js/admin/mis.js"></script>
<script type="text/javascript" src="${ctx}/js/common/mylayer/v1.0/mylayer.js"></script>
<script type="text/javascript" src="${ctx}/js/admin/sip-common.js"></script>

<#if validate>
	<link type="text/css" rel="stylesheet" href="${ctx }/js/common/validation/css/cmxform.css">
	<script type="text/javascript" src="${ctx }/js/common/validation/jquery.validate.js"></script> 
	<script type="text/javascript" src="${ctx }/js/common/validation/lib/jquery.metadata.js"></script>
	<script type="text/javascript" src="${ctx }/js/common/validation/expand.js"></script>
	<script type="text/javascript" src="${ctx }/js/common/validation/localization/messages_cn.js"></script>
</#if>

<#if webuploader>
	<link type="text/css" rel="stylesheet" href="${ctx }/js/common/webuploader/webuploader.css">
	<link type="text/css" rel="stylesheet" href="${ctx}/css/admin/fileUpload.css">
	<script type="text/javascript" src="${ctx }/js/common/webuploader/webuploader.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/tpdpor/uploadFile.js" ></script>
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
<title>广东第二师范学院教师专业发展在线资源平台</title>
</head>
<body id="misBody">
<div class="mis-wrap">
	
    <div class="mis-hd">
        <#include "/admin/common/include/top.ftl" />
    </div>
    
    <div class="mis-sd" id="misSide">
         <#include "/admin/common/include/menu_left.ftl" />
    </div>
    
    <div class="mis-bd" id="misContent">
        <div class="mis-bd-inner">
            <#nested>
            <div class="mis-ft">
            	<#include "/admin/common/include/footer.ftl" />
            </div>
        </div>
    </div>
</div>
</body>
<#import "/tpdpor/common/tags/function.ftl" as ft />
<@ft.function />
</html>
</#macro>