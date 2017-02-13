<#import "/userCenter/common/include/layout.ftl" as lo> 

<@lo.layout>
<script>
	$(function(){
		$('#userCenterMenu').find('a').get(2).click();		//默认打开第一个菜单的页面
	});
</script>
</@lo.layout>