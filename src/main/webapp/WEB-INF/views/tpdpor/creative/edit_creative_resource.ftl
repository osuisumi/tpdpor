<#include "/tpdpor/common/include/layout.ftl"/>
<#import "/tpdpor/common/tags/image.ftl" as image/>
<#assign jsArray=[]>
<#assign cssArray=[]>
<@layout jsArray=jsArray cssArray=cssArray validate=true mylayer=true webuploader=true>

<form id="saveCreativeResourceForm" action="${ctx!}/creative/${(creative.id)!}/resource" method="post">
	<#if (creative.resources[0].id)??>
		<input id="resourcesId" type="hidden" name="resources[0].id" value="${(creative.resources[0].id)!}">
		<script>
			$('#saveCreativeResourceForm').attr('method', 'put');
			$('#saveCreativeResourceForm').attr('action', '${ctx!}/creative/${(creative.id)!}/resource/${(creative.resources[0].id)!}');
		</script>
	<#else>
		<input type="hidden" name="resources[0].resourceRelations[0].relation.id" value="${(creative.id)!}" />
		<input type="hidden" name="resources[0].resourceRelations[0].relation.type" value="creative" />
	</#if>	
		
		<div class="g-auto">
	    <div class="g-crm no-border">
	        <span class="txt">您当前的位置：</span>
	        <a href="${ctx!}/tpdpor/index" class="u-goHome" title="首页"><i class="u-home-ico"></i></a>
	        <span class="trg">&gt;</span>
	        <a href="${ctx!}/creative">教师创客</a>
	        <span class="trg">&gt;</span>
	        <a href="${ctx!}/creative/${(creative.id)!}/view">${(creative.title)!}</a>
	        <span class="trg">&gt;</span>
	        <em>上传资源</em>
	    </div>
	    <div class="g-frame spc">
	        <div class="g-frame-mod1">
	            <div class="g-mn-tit2">
	                <h2 class="m-tit"><i class="u-ico-upload1"></i>上传资源</h2>
	            </div>
		         <div class="g-upload-wrap" >
	            <#if (creative.resources[0].fileInfos[0])?? >
					<div class="m-rate-bar" id="m-rate-bar">
                        <div class="now-rate" id="now-rate" style="width:100%;">
                            <p class="now-rate-num">已完成：<span>100%</span></p>
                            <div class="rate-success" id="u-success">
                                <p><i></i>上传完成</>
                            </div>
                        </div>
                        <div class="file-info">
                            <div class="m-bRsc-block">
                                <a href="javascript:void(0);"><i class="type-ico"></i></a>
                                <h4 class="tt"><a href="javascript:void(0);">${(creative.resources[0].fileInfos[0].fileName)!}</a></h4>
                                <p class="info">
                                    <span>${FileSizeUtils.getFileSize((creative.resources[0].fileInfos[0].fileSize)!)}</span>
                                </p>
                            </div>
                        </div>
                        <div class="u-ope">
                            <a id="reUpload" class="picker"><i></i>重新上传</a>
                        </div>
                    </div>
				<#else>
	            	<div class="m-rate-bar" id="m-rate-bar" style="display:none;">
                        <div class="now-rate" id="now-rate" style="width:00%;">
                            <p class="now-rate-num">已完成：<span>00%</span></p>
                            <div class="rate-success" id="u-success">
                                <p><i></i>上传完成</>
                            </div>
                            <div class="rate-fail">
                                <p><i></i>上传失败</>
                            </div>
                        </div>
                        <div class="file-info">
                            <div class="m-bRsc-block">
                                <a href="javascript:void(0);"><i class="type-ico"></i></a>
                                <h4 class="tt"><a href="javascript:void(0);">111111.doc</a></h4>
                                <p class="info">
                                    <span>0MB</span>
                                </p>
                            </div>
                        </div>
                        <div class="u-ope">
                            <a id="reupload" class="picker"><i></i>重新上传</a>
                        </div>
                    </div>
	                <div class="m-upload-file">
	                	<a class="picker" id="uploadBtn">
	                    	<span class="u-up">点击上传文件</span>
	                    </a>
	                    <p class="tips">你可以上传不超过50MB的 Word、Execl、PPT、PDF、压缩文件及Jpg、Png、Gif图片</p>
	                </div>
	                </#if>
	                <div class="m-pb-row">
	                    <div class="pb-mn">
	                        <div class="m-pb-mod">
	                            <div class="pb-txt"><span>资源描述：</span></div>
	                            <div class="m-ipt-mod">
	                                <textarea name="resources[0].summary"  placeholder="请您对本资源进行描述，200字以内。" class="u-textarea">${(creative.resources[0].summary)!''}</textarea>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="m-pb-row">
	                    <div class="pb-mn">
	                        <div class="m-pb-mod">
	                            <div class="pb-txt"><span>选择资源类型：</span></div>
	                            <div class="m-choose-mod">
	                                <label class="u-choose on">
	                                    <input type="radio" class="resourceType" name="resources[0].type" checked="checked" value="webCourse">
	                                    <i class="u-ico-rd"></i>
	                                    <span>网络课程</span>
	                                </label>
	                                <label class="u-choose">
	                                    <input type="radio" class="resourceType" name="resources[0].type" value="micVideo">
	                                    <i class="u-ico-rd"></i>
	                                    <span>微课视频</span>
	                                </label>
	                                <label class="u-choose">
	                                    <input type="radio" class="resourceType" name="resources[0].type" value="classroomRecord">
	                                    <i class="u-ico-rd"></i>
	                                    <span>课堂实录</span>
	                                </label>
	                                <label class="u-choose">
	                                    <input type="radio" class="resourceType" name="resources[0].type" value="teachDesign">
	                                    <i class="u-ico-rd"></i>
	                                    <span>教学设计</span>
	                                </label>
	                                <label class="u-choose">
	                                    <input type="radio" class="resourceType" name="resources[0].type" value="teachCourse">
	                                    <i class="u-ico-rd"></i>
	                                    <span>教学课程</span>
	                                </label>
	                                <label class="u-choose">
	                                    <input type="radio" class="resourceType" name="resources[0].type" value="teachMaterial">
	                                    <i class="u-ico-rd"></i>
	                                    <span>教学素材</span>
	                                </label>
	                                <label class="u-choose">
	                                    <input type="radio" class="resourceType" name="resources[0].type" value="paper">
	                                    <i class="u-ico-rd"></i>
	                                    <span>论文</span>
	                                </label>
	                                <label class="u-choose">
	                                    <input type="radio" class="resourceType" name="resources[0].type" value="other">
	                                    <i class="u-ico-rd"></i>
	                                    <span>其他</span>
	                                </label>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="m-pb-row">
	                    <div class="pb-mn">
	                        <div class="m-pb-mod">
	                            <div class="pb-txt"><span>学段/学科/年级：</span></div>
	                            <div class="m-linkage-choose">
	                                <div class="m-slt-block1 mid stage">
	                                    <a href="javascript:;" class="show-txt">
	                                        <span class="txt show_stage" value="">请选择学段</span>
	                                        <input id="stage" type="hidden" name="resources[0].resourceExtend.stage" value="${(creative.resources[0].resourceExtend.stage)!''}">
	                                        <i class="trg"></i>
	                                    </a>
	                                    <dl class="lst"  id="stageSelect">
	                                        <dd><a href="javascript:;" class="z-crt">请选择学段</a></dd>
	                                        <#assign rstage = (creative.resources[0].resourceExtend.stage)!''>
	                                        <#list TextBookUtils.getEntryList('STAGE') as stage>
	                                        	<dd><a class="<#if rstage=stage.textBookValue>z-crt </#if>" href="javascript:;" value="${(stage.textBookValue)!}">${(stage.textBookName)!}</a></dd>
	                                        </#list>
	                                    </dl>
	                                </div>
	                                <div class="m-slt-block1 mid subject">
	                                    <a href="javascript:;" class="show-txt">
	                                        <span class="txt show_subject" value="">请选择学科</span>
	                                        <input id="subject" type="hidden" name="resources[0].resourceExtend.subject" value="${(creative.resources[0].resourceExtend.subject)!''}">
	                                        <i class="trg"></i>
	                                    </a>
	                                    <dl id="subjectSelect" class="lst">
	                                        <dd><a class="" href="javascript:;" class="z-crt">请选择学科</a></dd>
	                                        <#assign rsubject = (creative.resources[0].resourceExtend.subject)!''>
	                                        <#list TextBookUtils.getEntryList('SUBJECT') as subject>
		                                        <dd><a class="<#if rsubject=subject.textBookValue>z-crt </#if>" href="javascript:;" value="${(subject.textBookValue)!}">${(subject.textBookName)!}</a></dd>
											</#list>
	                                    </dl>
	                                </div>
	                                <div class="m-slt-block1 mid grade">
	                                    <a href="javascript:;" class="show-txt">
	                                        <span class="txt show_grade" value="">请选择年级</span>
	                                        <input id="grade" type="hidden" name="resources[0].resourceExtend.grade" value="${(creative.resources[0].resourceExtend.grade)!}">
	                                        <i class="trg"></i>
	                                    </a>
	                                    <dl id="gradeSelect" class="lst">
	                                        <dd><a class="" href="javascript:;" class="z-crt">请选择年级</a></dd>
	                                        <#assign rgrade = (creative.resources[0].resourceExtend.grade)!''>
	                                        <#list TextBookUtils.getEntryList('GRADE') as grade>
		                                        <dd><a class="<#if rgrade=grade.textBookValue>z-crt </#if>" href="javascript:;" value="${(grade.textBookValue)!}">${(grade.textBookName)!}</a></dd>
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
	                            <div class="pb-txt"><span>选择教材：</span></div>
	                            <div class="m-linkage-choose">
	                            	<div class="m-slt-block1 mid">
										<a href="javascript:;" class="show-txt">
											 <span class="txt">请选择教材</span> <i class="trg"></i>
											 <input type="hidden" name="resources[0].resourceExtend.tbVersion" value="${(resources[0].resourceExtend.tbVersion)!''}">
										</a>
										<dl id="versionSelect" class="lst">
											<dd><a href="javascript:;" class="z-crt">请选择教材</a></dd>
											<#assign rversion = (resources[0].resourceExtend.tbVersion)!''>
											<#list TextBookUtils.getEntryList('VERSION') as version>
												<dd><a href="javascript:;" value="${(version.textBookValue)!}" class="<#if rversion=version.textBookValue>z-crt </#if>">${(version.textBookName)!}</a></dd>
											</#list>
										</dl>
									</div>
	                                <div class="m-slt-block1 mid">
										<a href="javascript:;" class="show-txt">
											<span class="txt">请选择章</span> <i class="trg"></i> 
											<input type="hidden" name="resources[0].resourceExtend.chapter" value="${(creative.resources[0].resourceExtend.chapter)!''}">
										</a>
										<dl id="sectionSelect" class="lst">
											<dd><a href="javascript:;" class="z-crt">请选择章</a></dd>
											<#assign section = (creative.resources[0].resourceExtend.section)!''>
											<#list TextBookUtils.getEntryList('SECTION') as section>
												<dd><a href="javascript:;" value="${(section.textBookValue)!}" class="<#if section=section.textBookValue>z-crt </#if>">${(section.textBookName)!}</a></dd>
											</#list>
										</dl>
									</div>
									<div class="m-slt-block1 mid">
										<a href="javascript:;" class="show-txt">
											 <span class="txt">请选择节</span> <i class="trg"></i> 
											 <input type="hidden" name="resources[0].resourceExtend.section" value="${(creative.resources[0].resourceExtend.section)!''}">
										</a>
										<dl id="chapterSelect" class="lst">
											<dd><a href="javascript:;" class="z-crt">请选择节</a></dd>
											<#assign chapter = (creative.resources[0].resourceExtend.chapter)!''>
											<#list TextBookUtils.getEntryList('CHAPTER') as chapter>
												<dd><a href="javascript:;" value="${(chapter.textBookValue)!}" class="<#if chapter=chapter.textBookValue>z-crt </#if>">${(chapter.textBookName)!}</a></dd>
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
	                            <a onclick="createResource();" class="u-btn-theme">上传</a>
	                            <a onclick="cancel();" class="u-btn-cancel">取消上传</a>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
	
<script>
	$(function(){
	
		initUpload();
		$('#reupload').on('click',function(){
			$('#uploadBtn').find('input[class="webuploader-element-invisible"]').trigger('click');
		});
		
		$('.m-choose-mod label').removeClass('on');
		$('.resourceType[value="${(creative.resources[0].type)!'webCourse'}"]').attr("checked",true);
		$('.resourceType[type="radio"]:checked').closest('label').addClass('on');
		
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
		
		$('#gradeSelect').on('click','a',function(){
			$.post('${ctx}/textBook/getEntryListByEntity',{
				textBookTypeCode:'VERSION',
				stage:$('#stageSelect').attr('value'),
				subject:$('#subjectSelect').attr('value'),
				grade:$(this).attr('value')
			},function(entrys){
				//重置gradeSelect
				resetAfterSelect($('#gradeSelect'));
				$.each(entrys,function(i,entry){
					if(entry.textBookTypeCode == 'VERSION'){
						$('#versionSelect').append('<dd><a href="javascript:;" value="'+entry.textBookValue+'" class="">'+entry.textBookName+'</a></dd>');
					}
				});
			});
		});
		
		$('#versionSelect').on('click','a',function(){
			$.post('${ctx}/textBook/getEntryListByEntity',{
				textBookTypeCode:'SECTION',
				stage:$('#stageSelect').attr('value'),
				subject:$('#subjectSelect').attr('value'),
				grade:$('#gradeSelect').attr('value'),
				version:$(this).attr('value'),
			},function(entrys){
				//重置gradeSelect
				resetAfterSelect($('#versionSelect'));
				$.each(entrys,function(i,entry){
					if(entry.textBookTypeCode == 'SECTION'){
						$('#sectionSelect').append('<dd><a href="javascript:;" value="'+entry.textBookValue+'" class="">'+entry.textBookName+'</a></dd>');
					}
				});
			});
		});
		
		$('#sectionSelect').on('click','a',function(){
			$.post('${ctx}/textBook/getEntryListByEntity',{
				textBookTypeCode:'SECTION',
				stage:$('#stageSelect').attr('value'),
				subject:$('#subjectSelect').attr('value'),
				grade:$('#gradeSelect').attr('value'),
				version:$('#versionSelect').attr('value'),
				section:$(this).attr('value'),
			},function(entrys){
				//重置gradeSelect
				resetAfterSelect($('#sectionSelect'));
				$.each(entrys,function(i,entry){
					if(entry.textBookTypeCode == 'SECTION'){
						$('#chapterSelect').append('<dd><a href="javascript:;" value="'+entry.textBookValue+'" class="">'+entry.textBookName+'</a></dd>');
					}
				});
			});
		});
		
	});
	
	function initUpload(){
		var	uploader = WebUploader.create({
			swf : '${ctx!}/js/webuploader/Uploader.swf',
			server : '${ctx!}/file/uploadTemp',
			pick : '.picker',
			resize : true,
			duplicate : true,
			accept : {
			    extensions: 'docx,doc,xlsx,xls,pptx,pdf,rar,zip,jpg,png,gif'
			},
			fileSingleSizeLimit:50*1024*1024,
			//fileNumLimit:1
		});
		// 当有文件被添加进队列的时候
		uploader.on('fileQueued', function(file) {
    		uploader.upload();
		});
		// 文件上传过程中创建进度条实时显示。
		uploader.on('uploadProgress', function(file, percentage) {
			$('.m-upload-file').hide();
			$('#m-rate-bar').show();
			var progress = Math.round(percentage * 100);
			$('#now-rate').css('width',progress+'%');
			$('#now-rate p[class="now-rate-num"]').text(progress+'%');
			$('#m-rate-bar div[class="file-info"]').find('div[class="m-bRsc-block"]').removeClass().addClass('m-bRsc-block').addClass(getFileType(file.name));
			$('#m-rate-bar').find('h4[class="tt"] a').text(file.name);
			$('#m-rate-bar').find('p[class="info"] span').text(getFileSize(file.size));
			
		});
		uploader.on('uploadSuccess', function(file, response) {
			if (response != null && response.responseCode == '00') {
				var fileInfo = response.responseData;
				$('#m-rate-bar').find('.file-info').attr('id',fileInfo.id);
				$('#m-rate-bar').find('.file-info').attr('url', fileInfo.url);
        		$('#m-rate-bar').find('.file-info').attr('fileName', fileInfo.fileName);
				$('#m-rate-bar').addClass('success');
				initFileParam();
    		}else{
    			$('#m-rate-bar').addClass('fail');
    		}
		});
		uploader.on('uploadError', function(file) {
		});
		uploader.on('error', function(type) {
		});
	};
	
	function initFileParam() {
		var successDiv = $('.m-rate-bar .success');
		
		$('#saveCreativeResourceForm').find('.fileParam').remove();
		var fileId = $('#m-rate-bar').find('.file-info').attr('id');
		var fileName = $('#m-rate-bar').find('.file-info').attr('fileName');
		var url = $('#m-rate-bar').find('.file-info').attr('url');
		
		$('#saveCreativeResourceForm').append('<input class="fileParam" name="resources[0].fileInfos[0].id" value="' + fileId + '" type="hidden"/>');
		$('#saveCreativeResourceForm').append('<input class="fileParam" name="resources[0].fileInfos[0].fileName" value="' + fileName + '" type="hidden"/>');
		$('#saveCreativeResourceForm').append('<input class="fileParam" name="resources[0].fileInfos[0].url" value="' + url + '" type="hidden"/>');
		$('#saveCreativeResourceForm').append('<input class="fileParam" name="resources[0].title" value="' + fileName + '" type="hidden"/>');

	};
	
	function getFileType(fileName){
		var $names = fileName //文件名字
        var strings = $names.split(".");
        var s_length = strings.length;
        var suffix = strings[s_length -1];
        if(s_length == 1){
           return ''
        }else {
            if(suffix == "doc" || suffix == "docx"){
            	return 'doc';
            }else if(suffix == "xls" || suffix == "xlsx"){
            	return 'excel';
            }else if(suffix == "ppt" || suffix == "pptx"){
            	return 'ppt';
            }else if(suffix == "pdf"){
            	return 'pdf';
            }else if(suffix == "txt"){
            	return 'txt';
            }else if(suffix == "zip" || suffix == "rar"){
            	return 'zip';
            }else if(suffix == "jpg" || suffix == "jpeg" || suffix == "png" || suffix == "gif"){
            	return 'pic';
            }else if(
                suffix == "mp4" || 
                suffix == "avi" || 
                suffix == "rmvb" || 
                suffix == "rm" || 
                suffix == "asf" || 
                suffix == "divx" || 
                suffix == "mpg" || 
                suffix == "mpeg" || 
                suffix == "mpe" || 
                suffix == "wmv" || 
                suffix == "mkv" || 
                suffix == "vob" || 
                suffix == "3gp"
                ){
            	return 'video';
            }else {
            	return 'other';
            }
        }
	};
	
	function createResource(){
		if(!$('#saveCreativeResourceForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('saveCreativeResourceForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			window.location.href = '${ctx!}/creative/${(creative.id)!}/view';
			alert('上传成功');
		}
	};
	
	function cancel(){
		window.location.href = '${ctx!}/creative/${(creative.id)!}/view';
	};
	
	function getFileSize(byteSize) {
		var units = [ "B", "K", "M", "G", "T" ];
		var index = 0;
		while (byteSize >= 1024) {
			if (index >= units.length - 1) {
				break;
			}
			byteSize = byteSize / 1024;
			index++;
		}
		return Math.round(byteSize*100)/100 + units[index];
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
</script>
</@layout>