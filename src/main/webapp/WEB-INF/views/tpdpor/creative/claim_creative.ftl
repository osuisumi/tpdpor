<#assign claimRole=(creative.claimRole)!'' />

<#assign roleCode=(Session.loginer.roleCode)!'' />
<#if roleCode == claimRole>
	<#assign hasClaimRole=true />
<#else>
	<#assign hasClaimRole=false />
</#if>

<form id="saveClaimCreativeForm" action="${ctx!}/creative/${(creative.id)!}/claim" method="post">	
	<input type="hidden" name="creative.id" value="${(creative.id)!}">
	<input type="hidden" name="role" value="manager">
	<input type="hidden" name="user.id" value="${(Session.loginer.id)!}">
	<div class="g-dld-layer tl">
		<#if hasClaimRole>
		    <p>1、领取后将成为本项目负责人，负责意见征集及资源制作上传，通过专家审核后，可获得积分奖励，资源被下载后获得相应积分。</p>		
		<#else>
		    <p>1、抱歉，本项目指定在
		    	<a href="javascript:;">
		    	<#if claimRole == '2'>
	    			在校老师
	    		<#elseif claimRole == '3'>
	    			在校学生
	    		</#if>
		    	</a>认领，您可以看看其他合适的项目，感谢您的参与！
		    </p>
		</#if>
	    <div class="m-addElement-btn">
	    	<#if hasClaimRole>
	        	<a onclick="claimCreative('${(creative.id)!}');" class="btn u-main-btn" >确定认领</a>
	        </#if>
	        <a onclick="cancle();" class="btn u-inverse-btn u-cancelLayer-btn">放弃</a>
	    </div>
	</div>
</form>
<script>
	function claimCreative(id){
		var data = $.ajaxSubmit('saveClaimCreativeForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			alert('认领成功');
			window.location.href = '${ctx!}/creative?type=${(creative.type)!"teach"}';
		}
	};
	
	function cancle(){
		$('.mylayer-wrap').remove();
	};
</script>