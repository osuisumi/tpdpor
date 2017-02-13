<#include "/tpdpor/common/include/layout.ftl"/>
<#assign jsArray=['${ctx!}/js/tpdpor/upload-common.js','${ctx!}/js/common/laypage/laypage.js','${ctx!}/js/tpdpor/activity-common.js']/>
<#assign cssArray=[]/>
<@layout jsArray=jsArray cssArray=cssArray mylayer=true webuploader=true>
	<#import '/tpdpor/creative/creative_content.ftl' as mc>
	<@mc.creativeContent id=creative.id op=(op[0])!'' relationId='tpdpor' relationType='creative' type=(creative.type)!'teach'/>
</@layout>
