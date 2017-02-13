<#import "/admin/common/include/layout.ftl" as lo>
<#assign jsArray = ['${ctx!}/js/common/ueditorUtils.js','${ctx!}/js/common/ueditor/ueditor.config.js',
	'${ctx!}/js/common/ueditor/ueditor.all.min.js','${ctx!}/js/admin/selectUser.js'] />
<#assign cssArray = ['${ctx!}/css/admin/userSelect.css'] />
<@lo.layout jsArray=jsArray cssArray=cssArray validate=true webuploader=true>
<#assign formId="saveDivisionForm"/>

<#if (division.id)??>
	<@divisionDirective id=(division.id)! getManager=true getEditor=true>
		<#assign division=divisionModel!/>
		<#assign divisionManagers=divisionManagers!/>
		<#assign divisionEditors=divisionEditors!/>
	</@divisionDirective>
</#if>
<#import "/admin/common/include/form.ftl" as fl>
<div class="mis-inner-wrap">
	<div class="mis-mod">
		<div class="mis-crm">
			<div class="crm">
				<a href="${ctx!}/tpdpor/admin/division?menuTreeId=${menuTreeId!}">教学部门管理</a>
				<span class="trg">&gt;</span>
				<a href="javascript:;"><#if (division.id)??>修改教学部门<#else>新增教学部门</#if></a>
			</div>
		</div>
		<div class="mis-mod">
			<@fl.form id="${formId!}" action="${ctx!}/tpdpor/admin/division" method="post" saveCallback="function(){location.href='${ctx!}/tpdpor/admin/division?menuTreeId=${menuTreeId!}'}" saveValidate="function(){return saveValidate();}" saveError="function(){}">
				<input type="hidden" name="manager.role" value="manager">
				<#if (division.id)??>
					<script>
						$(function(){
							$('#${formId!}').attr('method','put');
							$('#${formId!}').attr('action','${ctx!}/tpdpor/admin/division/${(division.id)!}');
						});
					</script>
				<#else>
				</#if>
				<script>
					var ue = initProduceEditor('editor', '${(JsonMapper.getJsonMapValue(division.summary, "content"))!}', '${(Session.loginer.id)!}');
					
					function saveValidate(){
						
						var name = $('#${formId!} input[name="name"]').val();
						if(name == null || name == '' || name == undefined){
							alert("请输入教学部门名称!");
							return false;
						}
						var content = ue.getContent();
						var text = ue.getContentTxt();
						$('#summary').val('{"text":"'+text.replace(new RegExp(/(\")/g),"\\\"")+'","content":"'+content.replace(new RegExp(/(\")/g),"\\\"")+'"}');
						
						var managerUserDiv = $('#managerUserDiv');
						managerUserDiv.empty();
						$.each($('#managerUserList li'),function(i,n){
							managerUserDiv.append('<input type="hidden" name="managers['+i+'].user.id" value="'+$(n).find("a").attr('uid')+'" />');
						});
						
						var editorUserDiv = $('#editorUserDiv');
						editorUserDiv.empty();
						$.each($('#editorUserList li'),function(i,n){
							editorUserDiv.append('<input type="hidden" name="editors['+i+'].user.id" value="'+$(n).find("a").attr('uid')+'" />');
						});
						
						return true;
					};
				</script>
				<div class="mis-srh-layout">
					<ul class="mis-ipt-lst">
						<li class="item">
							<div class="mis-ipt-row">
								<div class="tl">
									<span>教学部门名称：</span>
								</div>
								<div class="tc">
									<div class="mis-ipt-mod">
										<input type="text" name="name" value="${(division.name)!}" placeholder="请输入教学部门名称" class="mis-ipt required">
									</div>
								</div>
							</div>
						</li>
						<li class="item">
							<div class="mis-ipt-row">
								<div class="tl">
									<span>联系电话：</span>
								</div>
								<div class="tc">
									<div class="mis-ipt-mod">
										<input type="text" name="phone" value="${(division.phone)!}" placeholder="请输入联系电话" class="mis-ipt">
									</div>
								</div>
							</div>
						</li>
						<li class="item">
							<div class="mis-ipt-row">
								<div class="tl">
									<span>邮箱：</span>
								</div>
								<div class="tc">
									<div class="mis-ipt-mod">
										<input type="text" name="email" value="${(division.email)!}" placeholder="请输入邮箱" class="mis-ipt">
									</div>
								</div>
							</div>
						</li>
			            <li class="item w1">
			                <div class="mis-ipt-row">
			                    <div class="tl">
			                        <span>部门简介：</span>
			                    </div>
			                    <div class="tc">
				                    <div class="mis-ipt-mod">
				                        <script id="editor" type="text/plain" style="width:100%; height:370px;"></script>
										<input id="summary" name="summary" type="hidden">
				                    </div>
				                </div>
			                </div>
			            </li>
			            <li class="item w1">
							<div class="mis-ipt-row">
								<div class="tl">
									<span>封面图片：</span>
									<span id="imageFileParam" style="display:none"></span>
								</div>
								<div class="tc">
									<div class="mis-uplad-Aclayer"  style="text-align:left">
										<ul id="imageList" class="mis-hadup-img">
											<#if (division.id)??>
												<@filesDirective relationId = (division.id)! type='division'>
													<#list fileInfos as fileInfo>
													<li><img src="${FileUtils.getFileUrl(fileInfo.url)}" alt=""><i onclick="removeImg(this)" class="u-close">×</i><span class="what-pic">封面图片</span></li>
													</#list>
												</@filesDirective>
											</#if>
								            <li class="imagePicker">
								                <div id="imageUrlPicker" class="img">
								                    <a href="javascript:;">
								                        <i class="u-add"></i>
								                        <input type="file" class="u-file">
								                        <p class="txt">点击上传封面图片</p>
								                    </a>
								                </div>
								            </li>
								        </ul>
									</div>
								</div>
							</div>
						</li>
			            <li class="item w1">
				            <div class="mis-ipt-row">
				                <div class="tl">
				                    <span>部门管理员：</span>
				                </div>
				                <div class="tc">
				                    <div class="mis-ipt-mod">
				                        <input id="managerUserName" type="text" name="" value="" placeholder="请输入名称..." class="mis-ipt ">
				                        <div id="managerUserList" class="m-name-lst">
										</div>
										<div id="managerUserDiv" style="display:none;">
										</div>
				                    </div>
				                </div>
				            </div>
				        </li>
				        <li class="item w1">
				            <div class="mis-ipt-row">
				                <div class="tl">
				                    <span>部门编辑：</span>
				                </div>
				                <div class="tc">
				                    <div class="mis-ipt-mod">
				                        <input id="editorUserName" type="text" name="" value="" placeholder="请输入名称..." class="mis-ipt ">
				                        <div id="editorUserList" class="m-name-lst">
										</div>
										<div id="editorUserDiv" style="display:none;">
										</div>
				                    </div>
				                </div>
				            </div>
				        </li>
		            </ul>
				</@fl.form>
	    	</div>
		</div>
	</div>
</div>

<script>
	$(function(){
		//封面上传
		var imageUploader = $('#imageUrlPicker').createUploader({
			accept : {
				extensions: 'gif,jpg,jpeg,png',
			},
			fileSingleSizeLimit:2*1024*1024,
			//fileNumLimit:1,
			fileQueued:function(file,uploader){
				$('#imageList li').not('.imagePicker').remove();
				var li = $('<li id="'+file.id+'"><img src="" alt=""><i onclick="removeImg(this)" class="u-close">×</i><div class="u-progress"><ins class="progressW"></ins><span class="txt">已上传40%</span></div><span class="what-pic">'+file.name+'</span></li>');
			    uploader.makeThumb( file, function( error, src ) {
			        if ( error ) {
			        	li.find('img').attr('alt','不能预览');
			            return;
			        }
			        li.find('img').attr( 'src', src );
			    });
			    $('.imagePicker').before(li);
			},
			uploadProgress:function(file,percentage){
				var li = $('#'+file.id);
				li.find('.progressW').css('width',percentage*100 + '%');
				li.find('.u-progress .txt').text('已上传'+percentage*100 + '%');
			},
			uploadSuccess:function(file,response){
				if(response.responseCode == '00'){
					//上传成功清空上一次
					$('#imageFileParam').empty();
					var fileInfo = response.responseData;
					$('#imageFileParam').append('<input type="hidden" name="imageFileInfo.id" value="'+fileInfo.id+'">');
					$('#imageFileParam').append('<input type="hidden" name="imageFileInfo.fileName" value="'+fileInfo.fileName+'">');
					$('#imageFileParam').append('<input type="hidden" name="imageFileInfo.url" value="'+fileInfo.url+'">');
					$('#imageFileParam').append('<input type="hidden" name="imageUrl" value="'+fileInfo.url+'">');
					$('#' + file.id).find('.mis-pbar').addClass('finish');
					$('#' + file.id).attr('state','success');
					$('#' + file.id).find('.mis-pbar .bar-txt').text('上传完成');
				}
			}
		});
		
		//部门管理员
		var ul = $('#managerUserList');
		var managerInitData = new Array();
		<#if divisionManagers??>
			<#list divisionManagers as divisionManager>
				managerInitData[${(divisionManager_index)!}]={id:'${(divisionManager.user.id)!}',realName:'${(divisionManager.user.realName)!}'};
			</#list>
		</#if>
		$('#managerUserName').userSelect({
			url:'${ctx!}/users/entities',
			userList:ul,
			paramName:'paramMap[realName]',
			afterInit:function(selectDiv){
				selectDiv.find('.labelLi').css('height','26px');
				selectDiv.find('.u-add-tag').addClass('u-btn-add');
				selectDiv.append(ul);
			},
			onBeforeSelect:function(value){
				var isAllow = true;
				return isAllow;	
			},
			initData:managerInitData
		});
		
		//部门编辑
		var ul = $('#editorUserList');
		var editorInitData = new Array();
		<#if divisionEditors??>
			<#list divisionEditors as divisionEditor>
				editorInitData[${(divisionEditor_index)!}]={id:'${(divisionEditor.user.id)!}',realName:'${(divisionEditor.user.realName)!}'};
			</#list>
		</#if>
		$('#editorUserName').userSelect({
			url:'${ctx!}/users/entities',
			userList:ul,
			paramName:'paramMap[realName]',
			afterInit:function(selectDiv){
				selectDiv.find('.labelLi').css('height','26px');
				selectDiv.find('.u-add-tag').addClass('u-btn-add');
				selectDiv.append(ul);
			},
			onBeforeSelect:function(value){
				var isAllow = true;
				return isAllow;	
			},
			initData:editorInitData
		});
		
		
		$('.u-nbtn.u-add-tag').hide();
	});
	
	function removeImg(a){
		$(a).closest('li').remove();
		$('#imageFileParam').empty();
		$('.imagePicker').show();
	}
	
</script>

</@lo.layout>