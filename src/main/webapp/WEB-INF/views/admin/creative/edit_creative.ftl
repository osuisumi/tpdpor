<#import "/admin/common/include/layout.ftl" as lo>
<#assign jsArray = ['${ctx!}/js/common/ueditorUtils.js','${ctx!}/js/common/ueditor/ueditor.config.js','${ctx!}/js/common/ueditor/ueditor.all.min.js'] />
<#assign cssArray = []>
<@lo.layout jsArray=jsArray cssArray=cssArray validate=true>
<#import "/admin/common/include/form.ftl" as fl>
<div class="mis-inner-wrap">
	<div class="mis-mod">
	<div class="mis-crm">
		<div class="crm">
			<a href="${ctx}/tpdpor/admin/creative?menuTreeId=${menuTreeId!}">教师创客</a>
			<span class="trg">&gt;</span>
			<a href="javascript:;">发起创客项目</a>
		</div>
	</div>
	<div class="mis-mod">
		<@fl.form id="createCreativeForm" action="${ctx!}/tpdpor/admin/creative" method="post" saveCallback="function(){location.href='${ctx!}/tpdpor/admin/creative?menuTreeId=${menuTreeId!}&type=${(creative.type)!}'}" saveValidate="function(){return saveValidate();}">
			<script>
				var ue = initProduceEditor('editor', '', '${(Session.loginer.id)!}');
				
				function saveValidate(){
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
					return true;
				};
			</script>
			<input type="hidden" name="state" value="${(creative.state)!'passed'}">
			<input type="hidden" name="claimType" value="claim">
			<input type="hidden" name="claimState" value="claiming">
			<input type="hidden" name="creativeRelations[0].relation.id" value="${creative.creativeRelations[0].relation.id }">
			<input type="hidden" name="creativeRelations[0].relation.type" value="${creative.creativeRelations[0].relation.type }">
			<div class="mis-srh-layout">
				<ul class="mis-ipt-lst">
					<li class="item w1">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>标题：</span>
							</div>
							<div class="tc">
								<div class="mis-ipt-mod">
									<input type="text" name="title" value="" placeholder="请输入标题" class="mis-ipt">
								</div>
							</div>
						</div>
					</li>
					<li class="item w1">
			            <div class="mis-ipt-row">
			                <div class="tl">
			                    <span>想法：</span>
			                </div>
			                <div class="tc">
			                    <div class="mis-ipt-mod">
			                        <script id="editor" type="text/plain" style="width:100%; height:370px;"></script>
									<input id="creativeContent" name="content" type="hidden">
			                    </div>
			                </div>
			            </div>
			        </li>
			        <li class="item w1">
		                <div class="mis-ipt-row">
		                    <div class="tl">
		                        <span>科目：</span>
		                    </div>
		                    <div class="tc">
		                        <div class="mis-slt-row ">
									<div class="mis-selectbox">
										<strong><span class="simulateSelect-text">小学</span><i class="trg"></i></strong>
										<select id="stageSelect" name="stage"  aria-required="true">
											<option value="">请选择学段</option>
								 			${TextBookUtils.getEntryOptionsSelected('STAGE',(creative.stage)!'')}
										</select>
									</div>
									<div class="mis-selectbox">
										<strong><span class="simulateSelect-text" required="" aria-required="true">请选择学科</span><i class="trg"></i></strong>
										<select id="subjectSelect" name="subject">
											<option value="" selected="selected">请选择学科</option>
											${TextBookUtils.getEntryOptionsSelected('SUBJECT',(creative.subject)!'')}
										</select>
									</div>
		                        </div>
		                    </div>
		                </div>
		            </li>
		            <li class="item w1">
		                <div class="mis-ipt-row">
		                    <div class="tl">
		                        <span>年级：</span>
		                    </div>
		                    <div class="tc">
		                        <div class="mis-slt-row ">
									<div class="mis-selectbox">
										<strong><span class="simulateSelect-text">小学</span><i class="trg"></i></strong>
										<select id="gradeSelect" name="grade"  aria-required="true">
											<option value="">请选择学段</option>
								 			${TextBookUtils.getEntryOptionsSelected('GRADE',(creative.grade)!'')}
										</select>
									</div>
		                        </div>
		                    </div>
		                </div>
		            </li>
		            <li class="item w1">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>征集天数：</span>
							</div>
							<div class="tc">
								<div class="mis-ipt-mod">
									<input id="collectDay" type="text" required name="creativeRelations[0].collectDays" value="" placeholder="请输入征集天数，填30~90任意一个整数" class="mis-ipt">
								</div>
							</div>
						</div>
					</li>
		            <li class="item w1">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>所属类别：</span>
							</div>
							<div class="tc">
								<div class="mis-ipt-mod">
									<div class="mis-selectbox">
										<strong><span class="simulateSelect-text">小学</span><i class="trg"></i></strong>
										<select id="" name="type"  aria-required="true">
											<#if (creative.type)!?contains('teach')>
												<option value="teach">教学</option>
											</#if>	
											<#if (creative.type)!?contains('study')>
												<option value="study">研究</option>
											</#if>
											<#if (creative.type)!?contains('innovate')>
												<option value="innovate">创新</option>
											</#if>
										</select>
									</div>
								</div>
							</div>
						</div>
					</li>
		            <li class="item">
		                <div class="mis-ipt-row">
		                    <div class="tl">
		                        <span>召集对象：</span>
		                    </div>
		                    <div class="tc">
		                        <div class="mis-slt-row ">
									<div class="mis-selectbox">
										<strong><span class="simulateSelect-text">在校老师</span><i class="trg"></i></strong>
										<select id="claimRoleSelect" name="claimRole"  aria-required="true">
											<option value="${(AccountRoleCode.getZSXJS())!}">直属校教师</option>
											<option value="${(AccountRoleCode.getZSXXS())!}">直属校学生</option>
											<#-- <option value="">认证会员</option> -->
										</select>
									</div>
		                        </div>
		                    </div>
		                </div>
		            </li>
	        	</ul>
    		</div>
		</@fl.form>
	</div>
</div>
</div>
<script>
	$(function(){
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
	
	function resetSelect(s){
		var defaultOption = s.find('option').eq(0)?s.find('option').eq(0).clone():'';
		s.empty();
		if(defaultOption){
			s.append(defaultOption);
			s.simulateSelectBox();
		}
	};
</script>
</@lo.layout>