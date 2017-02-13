<#import "/admin/common/include/layout.ftl" as lo>
<#assign jsArray = ['${ctx!}/js/common/ueditorUtils.js','${ctx!}/js/common/ueditor/ueditor.config.js','${ctx!}/js/common/ueditor/ueditor.all.min.js'] />
<#assign cssArray = []>
<@lo.layout jsArray=jsArray cssArray=cssArray validate=true webuploader=true>
<#import "/admin/common/include/form.ftl" as fl>

<#if SecurityUtils.getSubject().hasRole('training') == true>
	<@divisionsDirective limit=999999999>
		<#if (divisions)??>
			<#assign divisions = divisions! />
		</#if>
	</@divisionsDirective >
<#elseif (SecurityUtils.getSubject().hasRole('divisionManager') == true || SecurityUtils.getSubject().hasRole('divisionEditor') == true) >
	<#assign roles = ['manager','editor'] />
	<@divisionUsersDirective roles=roles userId=(Session.loginer.id)!>
		<#if (divisionUsers)??>
			<#assign divisionUsers = divisionUsers! />
		</#if>
	</@divisionUsersDirective>
<#else>
</#if>

<#assign formId="saveTrainResourceForm"/>

<div class="mis-inner-wrap">
	<div class="mis-mod">
		<div class="mis-crm">
			<div class="crm">
				<a href="${ctx}/tpdpor/admin/train_resource?menuTreeId=${menuTreeId!}">培训资源</a>
				<span class="trg">&gt;</span>
				<a href="javascript:;"><#if (trainResource.resource.id)??>修改资源包<#else>新增资源包</#if></a>
			</div>
		</div>
		<@fl.form id="${(formId)!}" action="${ctx!}/tpdpor/admin/train_resource" method="post" saveCallback="function(){location.href='${ctx!}/tpdpor/admin/train_resource?menuTreeId=${menuTreeId!}'}" saveValidate="function(){return saveValidate();}">
		<#if (trainResource.resource.id)??>
			<script>
				$(function(){
					$('#${(formId)!}').attr('method', 'put');
					$('#${(formId)!}').attr('action', '${ctx!}/tpdpor/admin/train_resource/${(trainResource.resource.id)!}?resource.id=${(trainResource.resource.id)!}&train.id=${(trainResource.train.id)!}');
				});
			</script>
		</#if>
		<div class="mis-srh-layout">
			<ul class="mis-ipt-lst">
				<li class="item">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>类别：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="mis-slt-row ">
								<div class="mis-selectbox" style="width: 100%">
									<strong><span class="simulateSelect-text">请选择</span><i class="trg"></i></strong>
									<select id="" name="resource.resourceExtend.post"  aria-required="true">
										<option value="">请选择</option>
										<#list DictionaryUtils.getEntryList('TRAIN_RESOURCE_POST') as dic>
											<option value="${(dic.dictValue)!}" <#if (trainResource.resource.resourceExtend.post)! == (dic.dictValue)!>selected="selected"</#if> >${(dic.dictName)!}</option>
										</#list>
									</select>
								</div>
	                        </div>
	                    </div>
	                </div>
	            </li>
	            <li class="item">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>主题：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="mis-slt-row ">
								<div class="mis-selectbox" style="width: 100%">
									<strong><span class="simulateSelect-text">请选择</span><i class="trg"></i></strong>
									<select id="" name="resource.resourceExtend.topic"  aria-required="true">
										<option value="">请选择</option>
										<#list DictionaryUtils.getEntryList('TRAIN_RESOURCE_TOPIC') as dic>
											<option value="${(dic.dictValue)!}" <#if (trainResource.resource.resourceExtend.topic)! == (dic.dictValue)>selected="selected"</#if>>${(dic.dictName)!}</option>
										</#list>
									</select>
								</div>
	                        </div>
	                    </div>
	                </div>
	            </li>
	            <li class="item">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>资源类型：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="mis-slt-row ">
								<div class="mis-selectbox" style="width: 100%">
									<strong><span class="simulateSelect-text">请选择</span><i class="trg"></i></strong>
									<select id="resourceTypeSelect" name="resource.type"  aria-required="true">
										<option value="curriculum">课程</option>
										<option value="case">案例</option>
										<option value="material">素材</option>
										<option value="other">其他</option>
									</select>
									<script>
										$(function(){
											$('#resourceTypeSelect option').each(function(i){
												if($(this).attr('value') == '${(trainResource.resource.type)!}'){
													$(this).attr('selected','selected');
												}
											});
										});
									</script>
								</div>
	                        </div>
	                    </div>
	                </div>
	            </li>
	            <li class="item w1">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>学段/年级/学科：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="mis-slt-row ">
								<div class="mis-selectbox">
									<strong><span class="simulateSelect-text">请选择学段</span><i class="trg"></i></strong>
									<select id="stageSelect" name="resource.resourceExtend.stage"  aria-required="true">
										<option value="">请选择学段</option>
							 			${TextBookUtils.getEntryOptionsSelected('STAGE',(trainResource.resource.resourceExtend.stage)!'')}
									</select>
								</div>
								<div class="mis-selectbox">
									<strong><span class="simulateSelect-text" required="" aria-required="true">请选择学科</span><i class="trg"></i></strong>
									<select id="subjectSelect" name="resource.resourceExtend.subject">
										<option value="" >请选择学科</option>
										${TextBookUtils.getEntryOptionsSelected('SUBJECT',(trainResource.resource.resourceExtend.subject)!'')}
									</select>
								</div>
								<div class="mis-selectbox">
									<strong><span class="simulateSelect-text">请选择年级</span><i class="trg"></i></strong>
									<select id="gradeSelect" name="resource.resourceExtend.grade">
										<option value="">请选择年级</option>
										${TextBookUtils.getEntryOptionsSelected('GRADE',(trainResource.resource.resourceExtend.grade)!'')}
									</select>
								</div>
	                        </div>
	                    </div>
	                </div>
	            </li>
	            <#if (trainResource.id)??>
	            <#else>
	            <li class="item">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>所属部门：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="mis-slt-row ">
								<div class="mis-selectbox" style="width: 100%">
									<strong><span class="simulateSelect-text">请选择</span><i class="trg"></i></strong>
									<select name="resource.belong" aria-required="true">
										<#if divisionUsers??>
											<#list divisionUsers as divisionUser>
												<option value="${(divisionUser.division.id)!}">${(divisionUser.division.name)!}</option>
											</#list>
										</#if>
										<#if divisions??>
											<#list divisions as d>
												<option value="${(d.id)!}">${(d.name)!}</option>
											</#list>
										</#if>
									</select>
								</div>
	                        </div>
	                    </div>
	                </div>
	            </li>
	            </#if>
	            <li class="item">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>所属项目：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="mis-slt-row ">
								<div class="mis-selectbox" style="width: 100%">
									<strong><span class="simulateSelect-text">请选择</span><i class="trg"></i></strong>
									<select id="" name="train.project.id" aria-required="true">
										<option value="">请选择</option>
										<@projectsDataDirective>
											<#list projects as project>
												<option value="${(project.id)!}" <#if (trainResource.train.project.id)! == (project.id)!>selected="selected"</#if> >${(project.name)!}</option>
											</#list>
										</@projectsDataDirective>
									</select>
								</div>
	                        </div>
	                    </div>
	                </div>
	            </li>
				<li class="item w1">
					<div class="mis-ipt-row">
						<div class="tl">
							<span>标题：</span>
						</div>
						<div class="tc">
							<div class="mis-ipt-mod">
								<input type="text" name="resource.title" value="${(trainResource.resource.title)!}" placeholder="请输入标题" class="mis-ipt">
							</div>
						</div>
					</div>
				</li>
				<li class="item w1">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>开放范围：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="mis-check-mod">
	                            <label class="mis-radio-tick">
	                                <strong>
	                                    <i class="ico"></i>
	                                    <input type="radio" value="free" name="privilegeRadio" class="apply" checked="checked">
	                                </strong>
	                                <span>免费公开</span>
	                            </label>
	                            <label class="mis-radio-tick">
	                                <strong class="on">
	                                    <i class="ico"></i>
	                                    <input type="radio" value="apply"  name="privilegeRadio" class="apply" <#if ((trainResource.resource.privilege)!'free')?index_of('free')=-1>checked="checked"</#if>>
	                                </strong>
	                                <span>指定对象</span>
	                            </label>
	                        </div>
	                    </div>
	                </div>
	            </li>
	            <#if ((trainResource.resource.privilege)!'free')?contains('free')>
					<script>
						$(function(){
							$('#ayylyLi').hide();
						});
					</script>
				</#if>
				<li class="item w1" id="ayylyLi">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>开放对象：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="mis-check-mod">
	                            <label class="mis-checkbox"> <strong> <i class="ico"></i>
									<input type="checkbox" name="resource.privilege" value="${AccountRoleCode.ZSXJS}" <#if ((trainResource.resource.privilege)!'')?contains(AccountRoleCode.ZSXJS) || !(trainResource.resource.id)??>checked="checked"</#if>  class="checkRow" required="" aria-required="true">
									</strong> <span>直属校教师</span> 
								</label>
								<label class="mis-checkbox"> <strong> <i class="ico"></i>
									<input type="checkbox" name="resource.privilege" class="checkRow" value="${AccountRoleCode.ZSXXS}" <#if ((trainResource.resource.privilege)!'')?contains(AccountRoleCode.ZSXXS) || !(trainResource.resource.id)??>checked="checked"</#if> aria-required="true">
									</strong> <span>直属校学生</span> 
								</label>
								<label class="mis-checkbox"> <strong> <i class="ico"></i>
									<input type="checkbox" name="resource.privilege" class="checkRow" value="${AccountRoleCode.JSRZHY}" <#if ((trainResource.resource.privilege)!'')?contains(AccountRoleCode.JSRZHY) || !(trainResource.resource.id)??>checked="checked"</#if> aria-required="true">
									</strong> <span>教师认证会员</span> 
								</label>                                           
	                        </div>
	                    </div>
	                </div>
	            </li>
				<li class="item w1">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>简介：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-ipt-mod">
		                        <script id="editor" type="text/plain" style="width:100%; height:370px;"></script>
								<input id="resourceSummary" name="resource.summary" type="hidden">
		                    </div>
		                </div>
		            </div>
		        </li>
	            <li class="item w1">
					<div class="mis-ipt-row">
						<div class="tl">
							<span>封面图片：</span>
							<span id="coverFileParam" style="display:none"></span>
						</div>
						<div class="tc">
							<div class="mis-uplad-Aclayer"  style="text-align:left">
								<ul id="imageList" class="mis-hadup-img">
									<#if (trainResource.resource.id)??>
										<@filesDirective relationId = (trainResource.resource.id)! type='resource_cover'>
											<#list fileInfos as fileInfo>
											<li><img src="${FileUtils.getFileUrl(fileInfo.url)}" alt=""><i onclick="removeImg(this)" class="u-close">×</i><span class="what-pic">封面图片</span></li>
											</#list>
										</@filesDirective>
									</#if>
						            <li class="imagePicker">
						                <div id="coverUrlPicker" class="img">
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
	                        <span>资源包上传：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="m-pbMod-udload">
	                            <a id="picker" class="mis-opt-upbtn mis-inverse-btn"><i class="mis-upload-ico"></i>上传资源</a>
	                        </div>
	                        <ul class="mis-sfile-lst" id="fileList" paramName="resource.fileInfos">
	                        	<#if (trainResource.resource.id)??>
		                        	<@filesDirective relationId = (trainResource.resource.id)! type='resources'>
		                        		<#list fileInfos as fileInfo>
				                            <li state="success" id="${(fileInfo.id)!}" fileId="${(fileInfo.id)!}" fileName="${(fileInfo.fileName)!}" url="${(fileInfo.url)!}">
				                                <i class="mis-sfile-ico ${FileTypeUtils.getFileTypeClass((fileInfo.fileName)!'','suffix')}"></i>
				                                <a href="javascript:void(0);" class="name" title="${(fileInfo.fileName)!}">${(fileInfo.fileName)!}</a>
				                                <span class="size">${FileSizeUtils.getFileSize((fileInfo.fileSize)!)}</span>
				                                <a href="javascript:void(0);" class="dlt"><i class="mis-delete-ico1"></i>删除</a>
				                            </li>
			                            </#list>
		                            </@filesDirective>
	                            </#if>
	                        </ul>
			                <span id="fileParam">
		                    	<#if (trainResource.resource.id)??>
		                        	<@filesDirective relationId = (trainResource.resource.id)! type='resources'>
		                        		<#list fileInfos as fileInfo>
		                        			<input type="hidden" value="${(fileInfo.id)!}" name="resource.fileInfos[${fileInfo_index}].id">
											<input type="hidden" value="${(fileInfo.fileName)!}" name="resource.fileInfos[${fileInfo_index}].fileName">
											<input type="hidden" value="${(fileInfo.url)!}" name="resource.fileInfos[${fileInfo_index}].url">
		                        		</#list>
		                            </@filesDirective>
	                            </#if>
		                    </span>
	                    </div>
	                </div>
		        </li>
			</ul>
    	</div>
		</@fl.form>
	</div>
</div>	

<span style="display:none">
	<li id="fileModel">
		<i class="mis-sfile-ico"></i>
	    <a href="javascript:void(0);" class="name" >---</a>
	    <span class="size">0K</span>
	    <div class="mis-pbar">
	    	<div class="bar"><div class="yet" style="width: =0%;"><span>00%</span></div></div>
	       	<span class="bar-txt">上传中....</span>
	   	</div>
	   	<a href="javascript:void(0);" class="dlt"><i class="mis-delete-ico1"></i>删除</a>
	</li>
</span>

<script>
	var ue;
	$(function(){	
		$('.mis-radio-tick input').bindCheckboxRadioSimulate();
		$(".mis-selectbox select").simulateSelectBox();
		
		$(':radio.apply').click(function(){
			if($(this).val() == 'free'){
				$('#ayylyLi').hide();
			}else{
				$('#ayylyLi').show();
			}
		});
		
		ue = initProduceEditor('editor', '${(trainResource.resource.summary)!}', '${(Session.loginer.id)!}');
		
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
		
		//封面上传
		var coverUploader = $('#coverUrlPicker').createUploader({
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
					$('#coverFileParam').empty();
					var fileInfo = response.responseData;
					$('#coverFileParam').append('<input type="hidden" name="resource.resourceExtend.coverFileInfo.id" value="'+fileInfo.id+'">');
					$('#coverFileParam').append('<input type="hidden" name="resource.resourceExtend.coverFileInfo.fileName" value="'+fileInfo.fileName+'">');
					$('#coverFileParam').append('<input type="hidden" name="resource.resourceExtend.coverFileInfo.url" value="'+fileInfo.url+'">');
					$('#coverFileParam').append('<input type="hidden" name="resource.resourceExtend.coverUrl" value="'+fileInfo.url+'">');
					$('#' + file.id).find('.mis-pbar').addClass('finish');
					$('#' + file.id).attr('state','success');
					$('#' + file.id).find('.mis-pbar .bar-txt').text('上传完成');
				}
			}
		});
		
		//资源包上传
		var uploader1 = $('#picker').createUploader({
			fileSingleSizeLimit:500*1024*1024,
			accept:{
				//extensions: 'gif,jpg,jpeg,png,docx,doc,xlsx,xls,ppt,pdf,txt',
			},
			fileQueued:function(file){
				var li = $('#fileModel').clone();
				$(li).attr('id',file.id);
				$(li).find('.name').text(file.name);
				$(li).find('.size').text(getFileSize(file.size));
				$(li).find('.mis-sfile-ico').addClass(getFileType(file.name));

				$('#fileList').append(li);
			},
			uploadProgress:function(file,percentage){
				$('#' + file.id).find('.bar .yet').css('width',percentage*100 + '%');
				$('#' + file.id).find('.bar .yet span').text(percentage*100 + '%');
			},
			uploadSuccess:function(file,response){
       			$('#' + file.id).find('.mis-pbar').addClass('finish');
				$('#' + file.id).attr('state','success');
				$('#' + file.id).find('.mis-pbar .bar-txt').text('上传完成');
				var fileInfo = response.responseData;
       			$('#' + file.id).attr('fileId', fileInfo.id);
       			$('#' + file.id).attr('url', fileInfo.url);
       			$('#' + file.id).attr('fileName', fileInfo.fileName);
     
       			initFileParam();
        	}
		});
		
		$('#${(formId)!}').on('click','a.dlt',function(){
			var _this = $(this);
			var ulId = _this.closest('ul').attr('id');
			_this.closest('li').remove();
			if(ulId == 'coverFileList'){
				$('#coverFileParam').empty();
			}
			if(ulId == 'fileList'){
				$('#fileParam').empty();
				initFileParam();
			}
		});
		
	});
	
	function initFileParam(){
		$('#fileParam').empty();
		var $list = $('#fileList');
		$list.find('li[state="success"]').each(function(i) {
			var fileId = $(this).attr('fileId');
    		var fileName = $(this).attr('fileName');
    		var url = $(this).attr('url');
    		var paramName = $('#fileList').attr('paramName');
    		$('#fileParam').append('<input name="'+paramName+'[' + i + '].id" value="' + fileId + '" type="hidden"/>');
    		$('#fileParam').append('<input name="'+paramName+'[' + i + '].fileName" value="' + fileName + '" type="hidden"/>');
    		$('#fileParam').append('<input name="'+paramName+'[' + i + '].url" value="' + url + '" type="hidden"/>');
			
		});
		
	};
	
	function resetSelect(s){
		var defaultOption = s.find('option').eq(0)?s.find('option').eq(0).clone():'';
		s.empty();
		if(defaultOption){
			s.append(defaultOption);
			s.simulateSelectBox();
		}
	};
	
	function saveValidate(){
		if($('#imageList li:not(":last")').size()<=0){
			alert('请上传封面');
			return false;
		};
		
		if($('#fileList li[state=success]').size()<=0){
			alert('请在资源包中上传资源');
			return false;
		};
		
		var rTitle = $('input[name="resource.title"]').val().trim();
		if(rTitle == null || rTitle == '' || rTitle == undefined){
			alert('请填写标题');
			return false;
		};
		
		var applyRadio = $('.apply:checked').val();
		if(applyRadio == 'free'){
			$('#ayylyLi').remove();
			$('#${(formId)!}').append('<input name="resource.privilege" value="free" type="hidden"/>');
		}
		
		var content = ue.getContentTxt();
		$('#resourceSummary').val(content);
		
		return true;
	};
	
	function removeImg(a){
		$(a).closest('li').remove();
		$('#coverFileParam').empty();
		$('.imagePicker').show();
	}
</script>
</@lo.layout>