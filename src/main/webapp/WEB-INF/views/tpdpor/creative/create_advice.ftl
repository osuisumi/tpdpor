<div class="g-want-see">     
	<#if (isTimeout[0])! == 'N'>
		<h2 class="m-end-wnatSee-tl little-size">提建议帮助完善创客项目</h2>   
		<p class="m-wnat-see-txt"><i class="u-tipicon"></i>以下为观摩意向联系方式，信息有误请在<a >个人中心</a>修改；感谢您的支持，我们将创客结果优先通知您。</p>
		<ul class="m-who-see">
		    <li>姓名：<a href="javascript:;">${(Session.loginer.realName)!'' }</a></li>
		    <li>单位：<span>${(Session.loginer.deptName)!'' }</span></li>
		    <li>电话：<span>${(Session.loginer.attributes.phone)!'' }</span></li>
		</ul>
	<#else>
		<h2 class="m-end-wnatSee-tl">支持请早，项目已结束！</h2>
	</#if>
	<div class="m-see-discuss">
	    <p class="tl">创客交流区：</p>
	    <div class="m-pbMod-ipt">
	        <textarea name="" id="creativeAdviceContent" placeholder="给教师创客想法提些建议或说一些鼓励的话支持创课行动" class="u-textarea"></textarea>           
	    </div>
	</div>
	<div class="m-addElement-btn">
	    <a onclick="saveAdvice();" href="javascript:void(0);" class="btn u-main-btn" id="confirmAddChapter">提交</a>
	    <a onclick="cancle();" href="javascript:void(0);" class="btn u-inverse-btn u-cancelLayer-btn">取消</a>
	</div>
</div>
<script>
	function saveAdvice(){
		var content = $('#creativeAdviceContent').val().trim();
		if(content == '' || content == undefined){
			alert('建议内容不能为空');
			return false;
		}
		
		$.post('${ctx!}/comment','relation.id=${(creative.id)!}&relation.type=creative_advice&content='+content, function(data){
			if(data.responseCode == '00'){
				$('#creativeAdviceContent').val('');
				alert('发表成功!');
				window.location.href = '${ctx!}/creative/${(creative.id)!}/view?type=${(creative.type)!'teach'}';
				$('.mylayer-wrap').remove();
			}else{
				alert('发表失败!');
			}
		});
	};
	
	function cancle(){
		$('.mylayer-wrap').remove();
	};
</script>
