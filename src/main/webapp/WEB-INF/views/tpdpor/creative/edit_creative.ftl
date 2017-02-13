<form id="saveCreativeForm" action="${ctx!}/creative" method="post">
	<#if (creative.id)??>
		<input id="id" type="hidden" name="id" value="${(creative.id)!}">
		<script>
			$('#saveCreativeForm').attr('method', 'put');
			$('#saveCreativeForm').attr('action', '${ctx}/creative/${(creative.id)!}');
			/* $('#creativeAgreementDiv').hide(); */
		</script>
	</#if>	
	<input type="hidden" name="state" value="${(creative.state)!'auditing'}">
	<input type="hidden" name="creativeRelations[0].relation.id" value="${creative.creativeRelations[0].relation.id }">
	<input type="hidden" name="creativeRelations[0].relation.type" value="${creative.creativeRelations[0].relation.type }">
	<div class="g-want-see g-publish-buCourse">        
        <h2 class="m-publish-CourseTl">说出创客想法，一起努力让你的想法行动起来！</h2>
        <ul class="m-publish-progress">
            <li class="btn-progress crt">
                <a href="javascript:;">说出你的想法</a>
            </li>
            <li class="btn-line"></li>
            <li class="btn-progress">
                <a href="javascript:;">获得点赞支持</a>
            </li>
            <li class="btn-line"></li>
            <li class="btn-progress">
                <a href="javascript:;">分享课程资源</a>
            </li>
            <li class="btn-line"></li>
            <li class="btn-progress">
                <a href="javascript:;">收集观课意向</a>
            </li>
            <li class="btn-line"></li>
            <li class="btn-progress">
                <a href="javascript:;">专家评审</a>
            </li>
        </ul>

        <p class="m-wnat-see-txt"><i class="u-tipicon"></i>发表创客前，请先了解<a href="${ctx!}/creative/demo">《什么是创客》</a></p>
        <div class="m-addElement-item">
            <div class="ltxt ltxt2">
               	 标题：
            </div>
            <div class="center">
                <div class="m-pbMod-ipt">
                    <input type="text" name="title" value="${creative.title! }" placeholder="请在这里输入你的标题" class="u-pbIpt">
                </div>
            </div>
        </div>
        <div class="m-addElement-item">
                <div class="ltxt ltxt2">想法：</div>
                <div class="center">
                    <div class="m-textarea-builCourse">
                        <script id="editor" type="text/plain" style="height: 280px; width: 100%"></script>
						<input id="creativeContent" name="content" type="hidden">                       
                    </div>
    
                </div>
        </div>
        <div class="m-addElement-item">
            <div class="ltxt">科目：</div>
            <div class="center">
                <div class="m-slt-row m-active-grade">
                    <div class="block block-first">
                        <div class="m-selectbox style1">
                            <strong><span class="simulateSelect-text">请选择学段</span><i class="trg"></i></strong>
                            <select id="stageSelect" name="stage">
                                <option value="" <#if (creative.stage)! = ''> selected="selected" </#if> >请选择学段</option>
                                ${TextBookUtils.getEntryOptionsSelected('STAGE','${(creative.stage)!}')}
                            </select>
                        </div>
                    </div>

                    <div class="block">
                        <div class="m-selectbox style1">
                            <strong><span class="simulateSelect-text">请选择学科</span><i class="trg"></i></strong>
                            <select id="subjectSelect" name="subject">
                                <option value="" <#if (creative.subject)! = ''> selected="selected"</#if>>请选择学科</option>
                                ${TextBookUtils.getEntryOptionsSelected('SUBJECT','${(creative.subject)!}') }
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="m-addElement-item">
            <div class="ltxt">年级：</div>
            <div class="center">
                <div class="m-slt-row m-active-grade">
                    <div class="block">
                        <div class="m-selectbox style1">
                            <strong><span class="simulateSelect-text">请选择年级</span><i class="trg"></i></strong>
                            <select id="gradeSelect" name="grade">
                                <option value="" <#if (creative.grade)! = ''> selected="selected"</#if> >请选择年级</option>
                                ${TextBookUtils.getEntryOptionsSelected('GRADE','${(creative.grade)!}') }
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </div>   
        <div class="m-addElement-item spc">
            <div class="ltxt ltxt2">
                	项目类别：
            </div>
            <div class="center">
                <div class="m-choose-mod">
                <#list DictionaryUtils.getEntryList('CREATIVE_TYPE') as t>
                	<label class="u-choose">
                        <input type="radio" name="type" value="${(t.dictValue)!}" checked>
                        <i class="u-ico-rd"></i>
                        <span>${(t.dictName)!}</span>
                    </label>
                </#list>
                </div>
            </div>
        </div>
        <div class="m-addElement-item spc">
            <div class="ltxt ltxt2">
               	 征集天数：
            </div>
            <div class="center">
                <div class="m-pbMod-ipt">
                    <input id="collectDay" type="text" name="creativeRelations[0].collectDays" value="${(creative.creativeRelations[0].collectDays)!30}" placeholder="请输入征集天数，填30~90任意一个整数" class="u-pbIpt">
                </div>
            </div>
        </div> 
        <#-- 
        <div class="m-addElement-item spc1">
            <div class="ltxt ltxt2">
                	成果展示期资源换购积分：
            </div>
            <div class="center">
                <div class="m-pbMod-ipt">
                    <input type="text" value="" placeholder="请输入成果展示期资源换购积分" class="u-pbIpt">
                </div>
            </div>
        </div>
        --> 
        <div class="u-btm">
            <p class="tips">通过管理员审核后，学员下载一次资源，本人即可获得10个积分，通过评优则除专家奖励100积分，学员每下载一次资源，本人即可获得20积分</p>
        </div>
        <div class="u-btm" id="creativeAgreementDiv">
        <@filesDirective relationId = "creative" type="creative_apply_agreement">
        	<#if fileInfos??>
				<#list fileInfos as fileInfo>
		            <p class="u-check">
		                <label class="m-checkbox-tick">
		                    <strong>
		                        <i class="ico"></i>
		                        <input type="checkbox" id="creativeAgreement" checked="checked">
		                    </strong>
		                </label>
		                <a  onclick="downloadFile('${fileInfo.id}','${(fileInfo.fileName)!}','creative_apply_agreement','creative')">《${(fileInfo.fileName)!}》</a>
		                <span>（确认同意，请勾选）</span>
		            </p>
            	</#list>
			</#if>
        </@filesDirective>
        </div> 
        <div class="m-addElement-btn">
            <a onclick="saveCreative();" class="btn u-main-btn" id="submitCreative" href="javascript:;">确定</a>
            <a onclick="cancle();" class="btn u-inverse-btn u-cancelLayer-btn" href="javascript:;">取消</a>
        </div>
    </div>
</form>
<script>
	var ue = initProduceEditor('editor', '${(JsonMapper.getJsonMapValue(creative.content, "content"))!}', '${(Session.loginer.id)!}');
	
	$(function(){
		$("#stageSelect").simulateSelectBox({
			byValue: '${(creative.stage)!}'
		});
		$("#subjectSelect").simulateSelectBox({
			byValue: '${(creative.subject)!}'
		});
		$("#gradeSelect").simulateSelectBox({
			byValue: '${(creative.grade)!}'
		});
		
		$("input[type='radio']").bindCheckboxRadioSimulate();
		$("input[type='checkbox']").bindCheckboxRadioSimulate();
		/* 
		if (!$("#creativeAgreement").prop("checked")) {
			$("#submitCreative").hide();
		} 
		
		$("#creativeAgreement").on("click",function(){
			if($("#creativeAgreement").prop("checked")==true){
				$("#submitCreative").show();
			}else{
				$("#submitCreative").hide();
			}
		}); */
		
		//学科学段下拉框联动
		$('#stageSelect').on('change',function(){
			$.post('${ctx}/textBook/getEntryListByEntity',{
				textBookTypeCode:'SUBJECT,GRADE',
				stage:$('#stageSelect').val()
			},function(entrys){
				//重置subjectSelect
				resetSelect($('#subjectSelect'));
				resetSelect($('#gradeSelect'));
				$.each(entrys,function(i,entry){
					if(entry.textBookTypeCode == 'SUBJECT'){
						$('#subjectSelect').append('<option value="'+entry.textBookValue+'">'+entry.textBookName+'</option>');
					}else if(entry.textBookTypeCode == 'GRADE'){
						$('#gradeSelect').append('<option value="'+entry.textBookValue+'">'+entry.textBookName+'</option>');
					}
				});
			});
		});
		
		$('#subjectSelect').on('change',function(){
			$.post('${ctx}/textBook/getEntryListByEntity',{
				textBookTypeCode:'GRADE',
				stage:$('#stageSelect').val(),
				subject:$('#subjectSelect').val()
			},function(entrys){
				//重置gradeSelect
				resetSelect($('#gradeSelect'));
				$.each(entrys,function(i,entry){
					if(entry.textBookTypeCode == 'GRADE'){
						$('#gradeSelect').append('<option value="'+entry.textBookValue+'">'+entry.textBookName+'</option>');
					}
				});
			});
		});
		
	});
	
	function saveCreative(){
		if(!$('#saveCreativeForm').validate().form()){
			return false;
		}
		var collectDay = parseInt($('#collectDay').val());
		if(isNaN(collectDay)){
			alert("征集天数需在30~90任意一个整数");
			return false;
		}else{
			if(collectDay　> 90 || collectDay < 30){
				alert("征集天数需在30~90任意一个整数");
				return false;
			}
		}
		var content = ue.getContent();
		var text = ue.getContentTxt();
		if(content.length == 0){
			alert("内容不能为空");
			return false;
		}
		$('#creativeContent').val('{"text":"'+text+'","content":"'+content.replace(new RegExp(/(\")/g),"\\\"")+'"}');
		var data = $.ajaxSubmit('saveCreativeForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			alert('发表成功');
			window.location.href = '${ctx!}/creative?type=${(creative.type)!"teach"}'
		}
	};
	
	function cancle(){
		$('.mylayer-wrap').remove();
	};
	
	function resetSelect(s){
		var defaultOption = s.find('option').eq(0)?s.find('option').eq(0).clone():'';
		s.empty();
		if(defaultOption){
			s.append(defaultOption);
			s.simulateSelectBox();
		}
	};
</script>