<#import "/admin/common/include/layout.ftl" as lo> 

<@lo.layout>
<script>
	$(function(){
		$('#misTree .inner-item a').get(0).click();		//默认打开第一个菜单的页面
	});
</script>
</@lo.layout>