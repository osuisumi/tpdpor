<#import "/admin/common/include/layout.ftl" as lo>
<#assign jsArray = ['${ctx!}/js/common/ueditorUtils.js','${ctx!}/js/common/ueditor/ueditor.config.js','${ctx!}/js/common/ueditor/ueditor.all.min.js'] />
<#assign cssArray = []>
<@lo.layout jsArray=jsArray cssArray=cssArray validate=true>
<#assign formId="saveProjectForm"/>

<#import "/admin/common/include/form.ftl" as fl>
<div class="mis-inner-wrap">
	<div class="mis-mod">
		<@fl.form id="${formId!}" action="${ctx!}/project" method="post" saveCallback="function(){location.href='${ctx!}/tpdpor/admin/project?menuTreeId=${menuTreeId!}'}" saveValidate="function(){return saveValidate();}">
			<script>
				var ue = initProduceEditor('editor', '${(project.description)!}', '${(Session.loginer.id)!}');
				
				function saveValidate(){
					var content = ue.getContent();
					
					if(content.length == 0){
						alert("内容不能为空");
						return false;
					}
					$('#projectDescription').val(content);
					
					return true;
				};
			</script>
			<#if (project.id)??>
				<input type="hidden" name="id" value="${(project.id)!}">
				<script>
					$(function(){
						$('#${formId!}').attr('method','put');
						$('#${formId!}').attr('action','${ctx!}/project');
					});
				</script>
			<#else>
				<input type="hidden" name="relationId" value="tpdpor">
			</#if>
			<div class="mis-srh-layout">
				<ul class="mis-ipt-lst">
					<li class="item w1">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>项目名称：</span>
							</div>
							<div class="tc">
								<div class="mis-ipt-mod">
									<input type="text" name="name" value="${(project.name)!}" placeholder="请输入项目名称" class="mis-ipt">
								</div>
							</div>
						</div>
					</li>
			        <li class="item w1">
		                <div class="mis-ipt-row">
		                    <div class="tl">
		                        <span>项目性质：</span>
		                    </div>
		                    <div class="tc">
		                        <div class="mis-slt-row ">
									<div class="mis-selectbox">
										<strong><span class="simulateSelect-text">小学</span><i class="trg"></i></strong>
										<select id="stageSelect" name=""  aria-required="true">
										</select>
									</div>
		                        </div>
		                    </div>
		                </div>
		            </li>
		            <li class="item w1">
		                <div class="mis-ipt-row">
		                    <div class="tl">
		                        <span>项目类型：</span>
		                    </div>
		                    <div class="tc">
		                        <div class="mis-slt-row ">
									<div class="mis-selectbox">
										<strong><span class="simulateSelect-text">小学</span><i class="trg"></i></strong>
										<select id="typeSelect" name="type"  aria-required="true">
											<option value="">请选择</option>
								 			${DictionaryUtils.getEntryOptionsSelected('PROJECT_TYPE',(project.type)!'')}
										</select>
									</div>
		                        </div>
		                    </div>
		                </div>
		            </li>
		            <li class="item w1">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>培训对象：</span>
							</div>
							<div class="tc">
								<div class="mis-ipt-mod">
									<input type="text" name="" value="" placeholder="请输入项目名称" class="mis-ipt">
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
									<input id="projectDescription" name="description" type="hidden">
			                    </div>
			                </div>
			            </div>
			        </li>
	            </ul>
			</@fl.form>
	    	</div>
		</div>
	</div>
<script>
	
</script>
</@lo.layout>