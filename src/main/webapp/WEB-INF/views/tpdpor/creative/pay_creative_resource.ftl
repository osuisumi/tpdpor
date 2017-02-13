<#assign resourceId=(creative.resources[0].id)!>
<#assign fileInfoId=(creative.resources[0].fileInfos[0].id)!>
<@creativeData id=(creative.id)!>
	<#assign creative=creativeModel>
</@creativeData>
<@creativeSignStatDirective creator=Session.loginer.id relationId="tpdpor" relationType="creative">
	<#assign score=(score)!0>
</@creativeSignStatDirective>
<div class="g-dld-layer">
    <p>下载/浏览本资源需要<b><#if ((creative.state)!'') == 'excellent'>20<#else>10</#if></b>积分</p>
    <p>您目前有<b>${(score)!0}</b>积分</p>
    <p>确定支付积分下载/浏览吗？</p>
    <div class="opa-btn">
        <a onclick="downloadResource();" href="javascript:;" class="u-btn theme">确定下载</a>
        <a onclick="preview();" href="javascript:;" class="u-btn center">在线预览</a>
        <a onclick="cancle();" href="javascript:;" class="u-btn">取消</a>
    </div>
</div>

<script>
	function downloadResource(){
		$.get('${ctx!}/creative/${(creative.id)!}/resource/${(resourceId)!}/pay','',function(data){
			if (data.responseCode == '00') {				
				downloadFile('${file.id}','','creative','${(r.id)!}');
				cancle();	
			}else{
				alert('您的积分不够，请积极获取积分吧！');
			}
		});
	};
	
	function preview(creativeId,resourceId){
		$.get('${ctx!}/creative/${(creative.id)!}/resource/${(resourceId)!}/pay','',function(data){
			if (data.responseCode == '00') {				
				window.open('${ctx!}/creative/${(creative.id)!}/resource/${(resourceId)!}/view');
				cancle();	
			}else{
				alert('您的积分不够，请积极获取积分吧！');
			}
		});
	};
	
	function cancle(){
		 mylayerFn.close('payCreativeResourceLayer');
	};
</script>