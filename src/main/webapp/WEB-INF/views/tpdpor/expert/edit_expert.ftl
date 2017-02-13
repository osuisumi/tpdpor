<#assign formId='updateExpertForm' />
<form id="${(formId)!}" action="${ctx!}/expert/${(expert.id)!}" method="put">
	<div class="g-want-see g-publish-buCourse">        
        <div class="m-addElement-item">
            <div class="ltxt ltxt2">
               	 职位：
            </div>
            <div class="center">
                <div class="m-pbMod-ipt">
                    <input type="text" name="position" value="${(expert.position)! }" placeholder="请在这里输入你的职位" class="u-pbIpt">
                </div>
            </div>
        </div>
        <div class="m-addElement-item">
            <div class="ltxt ltxt2">
               	 专业：
            </div>
            <div class="center">
                <div class="m-pbMod-ipt">
                    <input type="text" name="specialty" value="${(expert.specialty)! }" placeholder="请在这里输入你的专业" class="u-pbIpt">
                </div>
            </div>
        </div>
        <div class="m-addElement-item">
            <div class="ltxt ltxt2">
               	 职称：
            </div>
            <div class="center">
                <div class="m-pbMod-ipt">
                    <input type="text" name="professionalTitle" value="${(expert.professionalTitle)! }" placeholder="请在这里输入你的职称" class="u-pbIpt">
                </div>
            </div>
        </div>
        <div class="m-addElement-item">
        	<div class="ltxt ltxt2">研究主题与成果：</div>
        	<div class="center">
	            <div class="m-textarea-builCourse">
	                <script id="editor" type="text/plain" style="height: 280px; width: 100%"></script>
					<input id="researchResult" name="researchResult" type="hidden">                       
	        	</div>
        	</div>
        </div>
        <div class="m-addElement-item">
        	<div class="ltxt ltxt2">培训项目经验：</div>
        	<div class="center">
	            <div class="m-textarea-builCourse">
	                <script id="editor1" type="text/plain" style="height: 280px; width: 100%"></script>
					<input id="trainExperience" name="trainExperience" type="hidden">                       
	        	</div>
        	</div>
        </div>
        <div class="m-addElement-item">
        	<div class="ltxt ltxt2">贡献资源：</div>
        	<div class="center">
	            <div class="m-textarea-builCourse">
	                <script id="editor2" type="text/plain" style="height: 280px; width: 100%"></script>
					<input id="contributeResource" name="contributeResource" type="hidden">                       
	        	</div>
        	</div>
        </div>
        <div class="m-addElement-btn">
            <a onclick="saveExpert();" class="btn u-main-btn" id="submitCreative" href="javascript:;">确定</a>
            <a onclick="cancle();" class="btn u-inverse-btn u-cancelLayer-btn" href="javascript:;">取消</a>
        </div>
    </div>
</form>

<script>
	var ue = initProduceEditor('editor', '${(expert.researchResult)!}', '${(Session.loginer.id)!}');
	var ue1 = initProduceEditor('editor1', '${(expert.trainExperience)!}', '${(Session.loginer.id)!}');
	var ue2 = initProduceEditor('editor2', '${(expert.contributeResource)!}', '${(Session.loginer.id)!}');
	
	$(function(){		
		
	});
	
	function saveExpert(){
		if(!$('#${formId!}').validate().form()){
			return false;
		}

		var content = ue.getContent();
		var content1 = ue1.getContent();
		var content2 = ue2.getContent();
		$('#researchResult').val(content);
		$('#trainExperience').val(content1);
		$('#contributeResource').val(content2);
		
		var data = $.ajaxSubmit('${formId!}');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			alert('修改成功');
			window.location.href = '${ctx!}/expert/${(expert.id)!}/view'
		}
	};
	
	function cancle(){
		$('.mylayer-wrap').remove();
	};
	
</script>