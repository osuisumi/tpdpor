<#import "/tpdpor/common/include/layout.ftl" as layout />
<@layout.layout jsArray=jsArray cssArray=cssArray containSearch=false>
<form id="defFrom" action="${ctx}/def" method="post">
<a href="javascript:;" onclick="send()">发送</a>
</form>
<script>
	function send(){
		$.when($.ajaxSubmit("defFrom")).done(function(data){
			console.log(data.id);
		});
	}
</script>
</@layout.layout>