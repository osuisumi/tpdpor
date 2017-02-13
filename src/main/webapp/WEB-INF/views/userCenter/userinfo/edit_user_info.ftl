<#import "/userCenter/common/include/layout.ftl" as lo>
<#assign jsArray = ["${ctx}/js/common/webuploader/webuploader.min.js","${ctx}/js/tpdpor/uploadFile.js"] />
<#assign cssArray = ["${ctx}/css/admin/fileUpload.css"]>
<@lo.layout validate=true mylayer=true menu='grzl' jsArray=jsArray cssArray=cssArray >
<form id="accountForm" action="${ctx}/userCenter/user_info/update" method="put">
	<input type="hidden" name="id" value="${Session.loginer.id}">
	<input type="hidden" name="avatar" value="${Session.loginer.avatar}">
	<div class="g-subscribe g-imformation">
		<div class="m-subscribe-tab">
			账号信息
		</div>
		<div class="m-inner-imformation">
			<div class="m-build-head">
				<#import "/tpdpor/common/tags/image.ftl" as image/>
				<@image.imageFtl url="${(Session.loginer.avatar)! }" default="/images/tpdpor/${app_path}/defaultAvatar.jpg" />
				<div class="m-file-upload">
					<a id="picker" href="javascript:;" class="u-file-show-btn"><i></i>编辑头像</a>
					<#--<input type="file" class="u-file-hide-btn">-->
					<p class="upload-txt">
						仅支持jpg、png格式（2M以下）
					</p>
				</div>
			</div>
			<div class="m-pb-row">
				<div class="m-pb-row">
					<div class="pb-mn">
						<div class="m-pb-mod">
							<div class="pb-txt">
								<span>真实姓名：</span>
							</div>
							<div class="m-ipt-mod">
								<input type="text" name="realName" class="u-ipt" required placeholder="请输入真实姓名" value="${Session.loginer.realName}">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="m-pb-Workunit">
                <div class="m-pb-row">
                    <div class="pb-mn">
                        <div class="m-pb-mod">
                            <div class="pb-txt"><span>工作单位：</span></div>
								<div id="deptSelect" class="m-slt-block1 " style="width:200px">
                                    <a href="javascript:;" class="show-txt">
                                    	<input type="hidden" name="department.id" value="${(userInfo.department.id)!}">
                                        <span class="txt">请选择机构</span>
                                        <i class="trg"></i>
                                    </a>
                                    <@departmentsDataDirective>
	                                    <dl class="lst">
	                                        <dd><a href="javascript:;"  class="<#if ((userInfo.department.id)!'') == ''>z-crt</#if>">请选择机构</a></dd>
	                                        <#if departments??>
                                				<#list departments as d>
                                					<dd><a href="javascript:;" class="<#if ((userInfo.department.id)!'') == d.id>z-crt</#if>"  value="${d.id}">${(d.deptName)!}</a></dd>
		                                		</#list>
                                			</#if>
	                                    </dl>
                                    </@departmentsDataDirective>
                                </div>
                        </div>
                    </div>
                </div>
            </div>
			<div class="m-pb-row">
				<div class="pb-mn">
					<div class="m-pb-mod">
						<div class="pb-txt">
							<span>学段/学科：</span>
						</div>
						<div class="m-linkage-choose">
							<div class="m-slt-block1 mid">
								<a href="javascript:;" class="show-txt"> 
									<span class="txt"><#if (userInfo.stage)??>${TextBookUtils.getEntryName('STAGE',userInfo.stage)}<#else>请选择学段</#if></span>
									<input type="hidden" name="stage" value="${(userInfo.stage)!''}"> 
									<i class="trg"></i> 
								</a>
								<dl id="stageSelect" class="lst">
									<dd><a href="javascript:;" >请选择学段</a></dd>
									<#assign rstage = (userInfo.stage)!''>
									<#list TextBookUtils.getEntryList('STAGE') as stage>
										<dd><a href="javascript:;" value="${(stage.textBookValue)!}" class="<#if rstage=stage.textBookValue>z-crt </#if>">${(stage.textBookName)!}</a></dd>
									</#list>
								</dl>
							</div>
							<div class="m-slt-block1 mid">
								<a href="javascript:;" class="show-txt">
									 <span class="txt"><#if (userInfo.subject)??>${TextBookUtils.getEntryName('SUBJECT',userInfo.subject)}<#else>请选择学科</#if></span> <i class="trg"></i>
									 <input type="hidden" name="subject" value="${(userInfo.subject)!''}">
								</a>
								<dl id="subjectSelect" class="lst">
									<dd><a href="javascript:;" class="z-crt">请选择学科</a></dd>
									<#assign rsubject = (userInfo.subject)!''>
									<#list TextBookUtils.getEntryList(TextBookParamUtils.buildTextBookParam('SUBJECT',resource!'')) as subject>
										<dd><a href="javascript:;" value="${(subject.textBookValue)!}" class="<#if rsubject=subject.textBookValue>z-crt </#if>">${(subject.textBookName)!}</a></dd>
									</#list>
								</dl>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="m-pb-Workunit">
                <div class="m-pb-row">
                    <div class="pb-mn">
                        <div class="m-pb-mod">
                            <div class="pb-txt"><span>手机：</span></div>
                            <div class="m-ipt-mod">
                                <input type="text" name="phone" class="u-ipt" placeholder="手机" value="${(userInfo.phone)!}">
                            </div>
                        </div>
                    </div>
                </div>                                 
            </div>
            <div class="m-pb-Workunit">
                <div class="m-pb-row">
                    <div class="pb-mn">
                        <div class="m-pb-mod">
                            <div class="pb-txt"><span>邮箱：</span></div>
                            <div class="m-ipt-mod">
                                <input type="text" name="email" class="u-ipt" placeholder="邮箱" value="${(userInfo.email)!}">
                            </div>
                        </div>
                    </div>
                </div>                                 
            </div>
            <div class="m-pb-row">
                <div class="pb-mn">
                    <div class="m-pb-mod">
                        <div class="pb-txt"><span>帐号属性：</span></div>
                        <div class="u-opa">
                            ${AccountRoleCode.viewName((Session.loginer.roleCode)!'')}
                        </div>
                    </div>
                </div>
            </div>
            <div class="m-pb-row">
                <div class="pb-mn">
                    <div class="m-pb-mod">
                        <div class="pb-txt"><span>角色：</span></div>
                        <div class="u-opa">
                        	<#if SecurityUtils.getSubject().hasRole('superAdmin')>
                        		超级管理员
                        	</#if>
                        	<#if SecurityUtils.getSubject().hasRole('divisionManager')>
                        		部门管理员
                        	</#if>
                        	<#if SecurityUtils.getSubject().hasRole('divisionEditor')>
                        		部门编辑
                        	</#if>
                        </div>
                    </div>
                </div>
            </div>
			<div class="m-btm-opa">
	            <a href="javascript:;" class="u-btn-theme" onclick="saveUserInfo()">保存</a>
	            <a href="javascript:;" class="u-btn-cancel">取消</a>
	        </div>
		</div>
	</div>
</form>
<script>
	$(function(){
		var uploader = $('#picker').createUploader({
			serverUrl:'${ctx}/file/uploadRemote',
			accept:{
				extensions:'jpg,png'				
			},
			uploadSuccess:function(file,response){
				if(response.responseCode == '00'){
					var file = response.responseData.newestFile;
					$('#accountForm input[name="avatar"]').val(file.url);
					$('#accountForm img').attr('src',file.remark);
				}
			}
		}
		);
		
		//部门回显
		var userDeptId = "${(userInfo.department.id)!''}";
		if(userDeptId != ''){
			var txt = $('#deptSelect .txt');
			var selected = $('#deptSelect a.z-crt');
			txt.text(selected.text());
		}
		
		//学科学段下拉框联动
		$('#stageSelect').on('click','a',function(){
			$.post('${ctx}/textBook/getEntryListByEntity',{
				textBookTypeCode:'SUBJECT,GRADE,VERSION',
				stage:$(this).attr('value')
			},function(entrys){
				//重置subjectSelect,gradeSelect,versionSelect,sectionSelect,chapterSelect
				resetAfterSelect($('#stageSelect'));
				$.each(entrys,function(i,entry){
					if(entry.textBookTypeCode == 'SUBJECT'){
						$('#subjectSelect').append('<dd><a href="javascript:;" value="'+entry.textBookValue+'" class="">'+entry.textBookName+'</a></dd>');
					}else if(entry.textBookTypeCode == 'GRADE'){
						$('#gradeSelect').append('<dd><a href="javascript:;" value="'+entry.textBookValue+'" class="">'+entry.textBookName+'</a></dd>');
					}else if(entry.textBookTypeCode == 'VERSION'){
						$('#versionSelect').append('<dd><a href="javascript:;" value="'+entry.textBookValue+'" class="">'+entry.textBookName+'</a></dd>');
					}
				});
			});
		});
		
		$('#subjectSelect').on('click','a',function(){
			$.post('${ctx}/textBook/getEntryListByEntity',{
				textBookTypeCode:'GRADE,VERSION',
				stage:$('#stageSelect').attr('value'),
				subject:$(this).attr('value')
			},function(entrys){
				//重置gradeSelect
				resetAfterSelect($('#subjectSelect'));
				$.each(entrys,function(i,entry){
					if(entry.textBookTypeCode == 'GRADE'){
						$('#gradeSelect').append('<dd><a href="javascript:;" value="'+entry.textBookValue+'" class="">'+entry.textBookName+'</a></dd>');
					}else if(entry.textBookTypeCode == 'VERSION'){
						$('#versionSelect').append('<dd><a href="javascript:;" value="'+entry.textBookValue+'" class="">'+entry.textBookName+'</a></dd>');
					}
				});
			});
		});
		
		function resetAfterSelect(s){
			var afterSelect = $(s).closest('.m-slt-block1').nextAll('.m-slt-block1').find('.lst');
			var afterRow = $(s).closest('.m-pb-row').next();
			$.each(afterSelect,function(i,n){
				var defaultOption = $(n).find('dd').eq(0)?$(n).find('dd').eq(0).clone(true):'';
				$(n).empty();
				if(defaultOption){
					$(n).append(defaultOption);
				}
				//重置模拟select的数据
				var selectParent = $(n).closest('.m-slt-block1');
				$(n).attr('value','');
				selectParent.find('input').val('');
				selectParent.find('span.txt').attr('value','').text(defaultOption.text());
			});
			
			$.each(afterRow,function(i,n){
				var selects = $(n).find('.lst');
				$.each(selects,function(i,n){
					var defaultOption = $(n).find('dd').eq(0)?$(n).find('dd').eq(0).clone(true):'';
					$(n).empty();
					if(defaultOption){
						$(n).append(defaultOption);
						//defaultOption.find('a').trigger('click');
					}
					//重置模拟select的数据
					var selectParent = $(n).closest('.m-slt-block1');
					$(n).attr('value','');
					selectParent.find('input').val('');
					selectParent.find('span.txt').attr('value','').text(defaultOption.text());
				});
			});
		}
	});

	function saveUserInfo(){
		if(!$('#accountForm').validate().form()){
			return false;
		}
		$.ajaxPut('${ctx}/userCenter/user_info/update',$('#accountForm').serialize(),function(response){
			if(response.responseCode == '00'){
				alert('保存成功',function(){
					window.location.reload();
				});
			}
			
		});
	}
</script>
</@lo.layout>