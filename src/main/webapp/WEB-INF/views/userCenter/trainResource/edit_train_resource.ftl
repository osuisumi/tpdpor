<#assign formId="createTrainResourceForm"/>
<form id="${(formId)!}" action="${ctx!}/userCenter/train_resource" method="post">
	<#if (trainResource.resource.id)??>
		<script>
			$(function(){
				$('#${(formId)!}').attr('method', 'put');
				$('#${(formId)!}').attr('action', '${ctx!}/userCenter/train_resource/${(trainResource.resource.id)!}?resource.id=${(trainResource.resource.id)!}&train.id=${(trainResource.train.id)!}');
			});
		</script>
	<#else>
		<input type="hidden" name="resource.belong" value="${(Session.loginer.id)!}">
	</#if>
	<div class="m-subscribe-cont">
		<div class="g-upload-wrap">
			<div class="m-pb-row">
		         <div class="pb-mn">
		             <div class="m-pb-mod">
		                 <div class="pb-txt"><span>类别：</span></div>
		                 <div class="m-linkage-choose">
		                     <div class="m-slt-block1 mid">
		                         <a href="javascript:;" class="show-txt">
		                             <span id="resourceExtendPostSpan" class="txt" value="${(trainResource.resource.resourceExtend.post)!}">请选择类别</span>
		                             <input type="hidden" name="resource.resourceExtend.post" value="${(trainResource.resource.resourceExtend.post)!}">
		                             <i class="trg"></i>
		                         </a>
		                         <dl class="lst">
		                             <dd><a href="javascript:;" class="z-crt">请选择类别</a></dd>
		                             <#list DictionaryUtils.getEntryList('TRAIN_RESOURCE_POST') as dic>
		                             	<dd><a href="javascript:;" value="${(dic.dictValue)!}">${(dic.dictName)!}</a></dd>
		                             	<#if (trainResource.resource.resourceExtend.post)! == (dic.dictValue)!>
		                             		<script>
		                             			$(function(){
		                             				$('#resourceExtendPostSpan').text('${(dic.dictName)!}');
		                             			});
		                             		</script>
		                             	</#if>
		                             </#list>
		                         </dl>
		                     </div>
		                 </div>
		             </div>
		         </div>
		     </div>
		     <div class="m-pb-row">
		         <div class="pb-mn">
		             <div class="m-pb-mod">
		                 <div class="pb-txt"><span>主题：</span></div>
		                 <div class="m-linkage-choose">
		                     <div class="m-slt-block1 mid">
		                         <a href="javascript:;" class="show-txt">
		                             <span id="resourceExtendTopicSpan" class="txt" value="${(trainResource.resource.resourceExtend.topic)!}">请选择主题</span>
		                             <input type="hidden" name="resource.resourceExtend.topic" value="${(trainResource.resource.resourceExtend.topic)!}">
		                             <i class="trg"></i>
		                         </a>
		                         <dl class="lst">
		                             <dd><a href="javascript:;" class="z-crt">请选择主题</a></dd>
		                             <#list DictionaryUtils.getEntryList('TRAIN_RESOURCE_TOPIC') as dic>
		                             	<dd><a href="javascript:;" value="${(dic.dictValue)!}">${(dic.dictName)!}</a></dd>
		                             	<#if (trainResource.resource.resourceExtend.topic)! == (dic.dictValue)!>
		                             		<script>
		                             			$(function(){
		                             				$('#resourceExtendTopicSpan').text('${(dic.dictName)!}');
		                             			});
		                             		</script>
		                             	</#if>
		                             </#list>
		                         </dl>
		                     </div>
		                 </div>
		             </div>
		         </div>
		     </div>
		     <div class="m-pb-row">
		         <div class="pb-mn">
		             <div class="m-pb-mod">
		                 <div class="pb-txt"><span>资源类型：</span></div>
		                 <div class="m-linkage-choose">
		                     <div class="m-slt-block1 mid">
		                         <a href="javascript:;" class="show-txt">
		                             <span id="typeSapn" class="txt" value="${(trainResource.resource.type)!'curriculum'}">课程</span>
		                             <input type="hidden" name="resource.type" value="${(trainResource.resource.type)!'curriculum'}">
		                             <i class="trg"></i>
		                         </a>
		                         <dl class="lst" id="resourceTypeDl">
		                             <dd><a href="javascript:;" value="curriculum" class="z-crt">课程</a></dd>
		                             <dd><a href="javascript:;" value="case">案例</a></dd>
		                             <dd><a href="javascript:;" value="material">素材</a></dd>
		                             <dd><a href="javascript:;" value="other">其他</a></dd>
		                         </dl>
		                         <script>
                           			$(function(){
                           				$('#resourceTypeDl a').each(function(){
                           					var _this = $(this);
                           					if(_this.attr('value') == '${(trainResource.resource.type)!}'){
                           						$('#typeSapn').text(_this.text());
                           					}
                           				});
                           			});
                           		 </script>
		                     </div>
		                 </div>
		             </div>
		         </div>
		     </div>
	    	<div class="m-pb-row">
	    		<div class="pb-mn">
		            <div class="m-pb-mod">
		            	<div class="pb-txt"><span>标题：</span></div>
		            	<div class="m-ipt-mod">
		                	<input name="resource.title" type="text" class="u-ipt" placeholder="填写培训资源标题" value="${(trainResource.resource.title)!}">
		            	</div>
		         	</div>
		         </div>
		     </div>
		     <div class="m-pb-row">
	             <div class="pb-mn">
	                 <div class="m-pb-mod">
	                     <div class="pb-txt"><span>免费开放范围：</span></div>
	                     <div class="m-choose-mod">
	                         <label class="u-choose">
	                             <input type="radio" class="apply"  name="privilegeRadio" value="free" checked="checked" >
	                             <i class="u-ico-rd"></i>
	                             <span>免费公开</span>
	                         </label>
	                         <label class="u-choose">
	                             <input type="radio" class="apply" name="privilegeRadio" value="apply" <#if ((trainResource.resource.privilege)!'free')?index_of('free')=-1> checked="checked" </#if>>
	                             <i class="u-ico-rd"></i>
	                             <span>指定对象</span>
	                         </label>
	                     </div>
	                 </div>
	             </div>
	         </div>
	         <#if ((trainResource.resource.privilege)!'free')?contains('free')>
					<script>
						$(function(){
							$('#ayylyRow').hide();
						});
					</script>
				</#if>
		     <div class="m-pb-row" id="ayylyRow">
	             <div class="pb-mn">
	                 <div class="m-pb-mod">
	                     <div class="pb-txt"><span>开放对象：</span></div>
	                     <div class="m-choose-mod">
	                         <label class="u-choose ">
	                             <input type="checkbox" name="resource.privilege" value="${AccountRoleCode.ZSXJS}" <#if ((trainResource.resource.privilege)!'')?contains(AccountRoleCode.ZSXJS)> checked="checked" </#if> >
	                             <i class="u-ico-rd"></i>
	                             <span>直属校教师</span>
	                         </label>
	                         <label class="u-choose">
	                             <input type="checkbox" name="resource.privilege" value="${AccountRoleCode.ZSXXS}" <#if ((trainResource.resource.privilege)!'')?contains(AccountRoleCode.ZSXXS)> checked="checked" </#if> >
	                             <i class="u-ico-rd"></i>
	                             <span>直属校学生</span>
	                         </label>
	                         <label class="u-choose">
	                             <input type="checkbox" name="resource.privilege" value="${AccountRoleCode.JSRZHY}" <#if ((trainResource.resource.privilege)!'')?contains(AccountRoleCode.JSRZHY)> checked="checked" </#if> >
	                             <i class="u-ico-rd"></i>
	                             <span>教师认证会员</span>
	                         </label>
	                     </div>
	                 </div>
	             </div>
	         </div>
		     <div class="m-pb-row">
		         <div class="pb-mn">
		             <div class="m-pb-mod">
		                 <div class="pb-txt"><span>资源简介：</span></div>
		                 <div class="m-ipt-mod">
		                     <textarea name="resource.summary" placeholder="请您对培训资源进行简介，200字以内。" class="u-textarea">${(trainResource.resource.summary)!}</textarea>
		                 </div>
		             </div>
		         </div>
		     </div>
		     <div class="m-pb-row">
		         <div class="pb-mn">
		             <div class="m-pb-mod">
		                 <div class="pb-txt"><span>所属项目：</span></div>
		                 <div class="m-linkage-choose">
		                     <div class="m-slt-block1 mid">
		                         <a href="javascript:;" class="show-txt">
		                             <span id="projectSpan" class="txt" value="${(trainResource.train.project.id)!}">请选择项目</span>
		                             <input type="hidden" name="train.project.id" value="${(trainResource.train.project.id)!}">
		                             <i class="trg"></i>
		                         </a>
		                         <dl class="lst">
		                         	<dd><a href="javascript:;" class="z-crt">请选择项目</a></dd>
		                         	<@projectsDataDirective>
		                            	<#list projects as project>
					                    	<dd><a href="javascript:;" value="${(project.id)!}">${(project.name)!}</a></dd>
					                    	<#if (trainResource.train.project.id)! == (project.id)!>
			                             		<script>
			                             			$(function(){
			                             				$('#projectSpan').text('${(project.name)!}');
			                             			});
			                             		</script>
			                             	</#if>
										</#list>
		                         	</@projectsDataDirective>
		                         </dl>
		                     </div>
		                 </div>
		             </div>
		         </div>
		     </div>
		     <div class="m-pb-row">
		         <div class="pb-mn">
		             <div class="m-pb-mod">
		                 <div class="pb-txt"><span>学段/学科/年级：</span></div>
		                 <div class="m-linkage-choose">
		                     <div class="m-slt-block1 mid">
		                         <a href="javascript:;" class="show-txt">
		                             <span id="stageSpan" class="txt" value="${(trainResource.resource.resourceExtend.stage)!}>请选择学段</span>
		                             <input type="hidden" name="resource.resourceExtend.stage" value="${(trainResource.resource.resourceExtend.stage)!}">
		                             <i class="trg"></i>
		                         </a>
		                         <dl class="lst" id="stageSelect">
		                             <dd><a href="javascript:;" class="z-crt">请选择学段</a></dd>
		                             <#list TextBookUtils.getEntryList('STAGE') as tb>
		                             	<dd><a href="javascript:;" value="${(tb.textBookValue)!}">${(tb.textBookName)!}</a></dd>
		                             	<#if (trainResource.resource.resourceExtend.stage)! == (tb.textBookValue)!>
		                             		<script>
		                             			$(function(){
		                             				$('#stageSpan').text('${(tb.textBookName)!}');
		                             			});
		                             		</script>
		                             	</#if>
		                             </#list>
		                         </dl>
		                     </div>
		                     <div class="m-slt-block1 mid">
		                         <a href="javascript:;" class="show-txt">
		                             <span id="subjectSpan" class="txt" value="${(trainResource.resource.resourceExtend.subject)!}">请选择学科</span>
		                             <input type="hidden" name="resource.resourceExtend.subject" value="${(trainResource.resource.resourceExtend.subject)!}">
		                             <i class="trg"></i>
		                         </a>
		                         <dl class="lst" id="subjectSelect">
		                             <dd><a href="javascript:;" class="z-crt">请选择学科</a></dd>
		                             <#list TextBookUtils.getEntryList('SUBJECT') as tb>
		                             	<dd><a href="javascript:;" value="${(tb.textBookValue)!}">${(tb.textBookName)!}</a></dd>
		                             	<#if (trainResource.resource.resourceExtend.subject)! == (tb.textBookValue)!>
		                             		<script>
		                             			$(function(){
		                             				$('#subjectSpan').text('${(tb.textBookName)!}');
		                             			});
		                             		</script>
		                             	</#if>
		                             </#list>
		                         </dl>
		                     </div>
		                     <div class="m-slt-block1 mid">
		                         <a href="javascript:;" class="show-txt">
		                             <span id="gradeSpan" class="txt" value="${(trainResource.resource.resourceExtend.grade)!}">请选择年级</span>
		                             <input type="hidden" name="resource.resourceExtend.grade" value="${(trainResource.resource.resourceExtend.grade)!}">
		                             <i class="trg"></i>
		                         </a>
		                         <dl class="lst" id="gradeSelect">
		                             <dd><a href="javascript:;" class="z-crt">请选择年级</a></dd>
		                             <#list TextBookUtils.getEntryList('GRADE') as tb>
		                             	<dd><a href="javascript:;" value="${(tb.textBookValue)!}">${(tb.textBookName)!}</a></dd>
		                             	<#if (trainResource.resource.resourceExtend.grade)! == (tb.textBookValue)!>
		                             		<script>
		                             			$(function(){
		                             				$('#gradeSpan').text('${(tb.textBookName)!}');
		                             			});
		                             		</script>
		                             	</#if>
		                             </#list>
		                         </dl>
		                     </div>
		                 </div>
		             </div>
		         </div>
		     </div>
		     <div class="m-pb-row">
		         <div class="pb-mn">
		             <div class="m-pb-mod">
		                 <div class="pb-txt"><span>封面上传：</span></div>
		                 <div class="g-publish-box">
		                     <div class="m-publish-box">
		                         <p>只允许用户上传1个封面图片，总容量不超过20M</p>
		                         <ul class="res-lst" id="coverFileList">
		                         	<#if (trainResource.resource.id)??>
										<@filesDirective relationId = (trainResource.resource.id)! type='resource_cover'>
											<#list fileInfos as fileInfo>
												<li id="coverModel" class="">
												    <a class="block" href="javascript:;">
												        <img src="${FileUtils.getFileUrl(fileInfo.url)}" alt="封面图片"/>
												        <p ></p>
												    </a>
												    <i class="u-close"></i>
												</li>
											</#list>
										</@filesDirective>
									</#if>
		                         </ul>
		                         <span id="coverFileParam" style="display:none"></span>
		                         <div class="u-opa">
		                             <a id="coverUrlPicker" href="javascript:;" class="u-btn">上传封面</a>
		                         </div>
		                     </div>
		                 </div>
		             </div>
		         </div>
		     </div>
		     <div class="m-pb-row">
		         <div class="pb-mn">
		             <div class="m-pb-mod">
		                 <div class="pb-txt"><span>资源包上传：</span></div>
		                 <div class="g-publish-box">
		                     <div class="m-publish-box">
		                         <p>允许用户同时上传30个文件，总容量不超过500M</p>
		                         <ul class="res-lst" id="fileList" paramName="resource.fileInfos">
		                         	<#if (trainResource.resource.id)??>
			                        	<@filesDirective relationId = (trainResource.resource.id)! type='resources'>
			                        		<#list fileInfos as fileInfo>
					                            <li id="${(fileInfo.id)!}" fileId="${(fileInfo.id)!}" fileName="${(fileInfo.fileName)!}" url="${(fileInfo.url)!}" class="u-${FileTypeUtils.getFileTypeClass((fileInfo.fileName)!'','suffix')}" >
												    <a class="block" href="javascript:;">
												        <i></i>
												        <p class="name">${(fileInfo.fileName)!}</p>
												    </a>
												    <i class="u-close"></i>
												</li>
				                            </#list>
			                            </@filesDirective>
		                            </#if>
		                             <li class="last">
		                                 <a href="javascript:;" class="block picker">
		                                     <i></i>
		                                     <p>继续添加</p>
		                                 </a>
		                             </li>
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
		                         <div class="u-opa">
		                             <a id="" href="javascript:;" class="u-btn picker">上传资源</a>
		                         </div>
		                     </div>
		                 </div>
		             </div>
		         </div>
		     </div>
		     <div class="m-pb-row">
		         <div class="pb-mn">
		             <div class="m-pb-mod">
		                 <a onclick="saveTrainResource();" href="javascript:;" class="u-btn-theme">上传</a>
		                 <a onclick="cancle();" href="javascript:;" class="u-btn-cancel">取消上传</a>
		             </div>
		         </div>
		     </div>
	    </div>
	</div>
</form>	

<span style="display:none">
	<li id="coverModel" class="">
	    <a class="block" href="javascript:;">
	        <img />
	        <p ></p>
	    </a>
	    <i class="u-close"></i>
	</li>
	<li id="fileModel" class="u-word" >
	    <a class="block" href="javascript:;">
	        <i></i>
	        <p class="name">---.doc</p>
	    </a>
	    <i class="u-close"></i>
	</li>
</span>	
                             
<script>
	$(function(){
		
		commonJs.fn.init();
		$('.u-choose input').bindCheckboxRadioSimulate();
		
		$(':radio.apply').click(function(){
			if($(this).val() == 'free'){
				$('#ayylyRow').hide();
			}else{
				$('#ayylyRow').show();
			}
		});
		
		//学科学段下拉框联动
		$('#stageSelect').on('click','a',function(){
			$.post('${ctx}/textBook/getEntryListByEntity',{
				textBookTypeCode:'SUBJECT,GRADE',
				stage:$(this).attr('value')
			},function(entrys){
				//重置subjectSelect,gradeSelect
				resetAfterSelect($('#stageSelect'));
				$.each(entrys,function(i,entry){
					if(entry.textBookTypeCode == 'SUBJECT'){
						$('#subjectSelect').append('<dd><a href="javascript:;" value="'+entry.textBookValue+'" class="">'+entry.textBookName+'</a></dd>');
					}else if(entry.textBookTypeCode == 'GRADE'){
						$('#gradeSelect').append('<dd><a href="javascript:;" value="'+entry.textBookValue+'" class="">'+entry.textBookName+'</a></dd>');
					}
				});
			});
		});
		
		$('#subjectSelect').on('click','a',function(){
			$.post('${ctx}/textBook/getEntryListByEntity',{
				textBookTypeCode:'GRADE',
				stage:$('#stageSelect').attr('value'),
				subject:$(this).attr('value')
			},function(entrys){
				//重置gradeSelect
				resetAfterSelect($('#subjectSelect'));
				$.each(entrys,function(i,entry){
					if(entry.textBookTypeCode == 'GRADE'){
						$('#gradeSelect').append('<dd><a href="javascript:;" value="'+entry.textBookValue+'" class="">'+entry.textBookName+'</a></dd>');
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
				var li = $('#coverModel').clone();
				$(li).attr('id',file.id);
				//$(li).find('.name').text(file.name);
				$(li).find('.mis-sfile-ico').addClass(getFileType(file.name));
				uploader.makeThumb( file, function( error, src ) {
			        if ( error ) {
			        	li.find('img').attr('alt','不能预览');
			            return;
			        }
			        li.find('img').attr( 'src', src );
			    });
				//单个上传，清空上一次
				$('#coverFileList').empty();
				$('#coverFileList').append(li);
			},
			uploadProgress:function(file,percentage){
				//$('#' + file.id).find('.bar .yet').css('width',percentage*100 + '%');
				//$('#' + file.id).find('.bar .yet span').text(percentage*100 + '%');
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
					//$('#' + file.id).find('.mis-pbar').addClass('finish');
					//$('#' + file.id).attr('state','success');
					//$('#' + file.id).find('.mis-pbar .bar-txt').text('上传完成');
				}
			}
		});
		
		//资源包上传
		var uploader1 = $('.picker').createUploader({
			fileSingleSizeLimit:500*1024*1024,
			accept:{},
			fileQueued:function(file){
				var li = $('#fileModel').clone();
				$(li).attr('id',file.id);
				$(li).find('.name').text(file.name);
				//$(li).find('.size').text(getFileSize(file.size));
				$(li).addClass('u-'+getFileType(file.name));

				$('#fileList').prepend(li);
			},
			uploadProgress:function(file,percentage){
				//$('#' + file.id).find('.bar .yet').css('width',percentage*100 + '%');
				//$('#' + file.id).find('.bar .yet span').text(percentage*100 + '%');
			},
			uploadSuccess:function(file,response){
       			//$('#' + file.id).find('.mis-pbar').addClass('finish');
				//$('#' + file.id).attr('state','success');
				//$('#' + file.id).find('.mis-pbar .bar-txt').text('上传完成');
				var fileInfo = response.responseData;
       			$('#' + file.id).attr('fileId', fileInfo.id);
       			$('#' + file.id).attr('url', fileInfo.url);
       			$('#' + file.id).attr('fileName', fileInfo.fileName);
     
       			initFileParam();
        	}
		});
		
		
		$('#${(formId)!}').on('click','i.u-close',function(){
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
	
	function cancle(){
		$('.mylayer-wrap').remove();
	};
	
	function saveTrainResource(){
		if(!$('#${(formId)!}').validate().form()){
			return false;
		}
		if($('#coverFileList li').size()<=0){
			alert('请上传封面');
			return false;
		};
		
		if($('#fileList li').size()<=1){
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
			$('#ayylyRow').remove();
			$('#${(formId)!}').append('<input name="resource.privilege" value="free" type="hidden"/>');
		}
		
		var data = $.ajaxSubmit('${(formId)!}');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			window.location.href = '${ctx!}/userCenter/train_resource';
			alert('上传成功');
		}
	};
	
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
	};
	
	function initFileParam(){
		$('#fileParam').empty();
		var $list = $('#fileList');
		$list.find('li:not(":last")').each(function(i) {
			var fileId = $(this).attr('fileId');
    		var fileName = $(this).attr('fileName');
    		var url = $(this).attr('url');
    		var paramName = $('#fileList').attr('paramName');
    		$('#fileParam').append('<input name="'+paramName+'[' + i + '].id" value="' + fileId + '" type="hidden"/>');
    		$('#fileParam').append('<input name="'+paramName+'[' + i + '].fileName" value="' + fileName + '" type="hidden"/>');
    		$('#fileParam').append('<input name="'+paramName+'[' + i + '].url" value="' + url + '" type="hidden"/>');
			
		});
		
	};
</script>