<#import "/tpdpor/common/include/layout.ftl" as layout />
<#assign jsArray = ["${ctx}/js/common/webuploader/webuploader.min.js","${ctx}/js/tpdpor/uploadFile.js"] />

<@layout.layout jsArray = jsArray validate=true mylayer=true>
<form id="saveCourseResourceForm" method="post" action="${ctx}/course_resource">
	<#if !(resource.id)??>
		<input type="hidden" name="type" value="course">
		<input type="hidden" name="resourceRelations[0].relation.id" value="course">
		<input type="hidden" name="resourceRelations[0].relation.type" value="course">
	<#else>
		<input type="hidden" name="id" value="${resource.id}">
	</#if>
	
	<span id="fileParam">
		<#if (resource.fileInfos)??>
			<#list resource.fileInfos as fileInfo>
				<input type="hidden" name="fileInfos[${fileInfo_index}].id" value="${fileInfo.id}" />
				<input type="hidden" name="fileInfos[${fileInfo_index}].fileName" value="${(fileInfo.fileName)!}" />
				<input type="hidden" name="fileInfos[${fileInfo_index}].url" value="${(fileInfo.url)!}" />
			</#list>			
		</#if>
	</span>
<div class="g-auto">
	<#if (resource.id)??>
		<#assign tabName = '编辑资源'/>
	<#else>
		<#assign tabName = '上传资源'/>
	</#if>
	<div class="g-crm no-border">
		<span class="txt">您当前的位置：</span>
		<a href="${ctx!}/tpdpor/index" class="u-goHome" title="首页"><i class="u-home-ico"></i></a>
		<span class="trg">&gt;</span>
		<a href="${ctx!}/course_resource/index">课程案例</a>
		<span class="trg">&gt;</span>
		<em>${tabName!}</em>
	</div>
	<div class="g-frame spc">
		<div class="g-frame-mod1">
			<div class="g-mn-tit2">
				<h2 class="m-tit"><i class="u-ico-upload1"></i>${tabName!}</h2>
			</div>
			<div class="g-upload-wrap">
				<div class="m-pb-row">
					<#if !(resource.id)??>
					<div class="pb-mn">
						<div class="m-pb-mod">
							<div class="pb-txt">
								<span>您想上传：</span>
							</div>
							<div class="m-choose-mod">
								<label class="u-choose on"> <a href="${ctx}/course_resource/create">
									<input type="radio" name="jion" checked="checked">
									<i class="u-ico-rd"></i> <span>课程案例素材</span> </a> </label>
								<label class="u-choose"> <a href="${ctx}/course_resource/create_muti">
									<input type="radio" name="jion">
									<i class="u-ico-rd"></i> <span>课程案例资源包</span> </a> </label>
							</div>
						</div>
					</div>
					</#if>
				</div>
				<div id="uploadDiv" class="m-upload-file" <#if (resource.id)??>style="display:none"</#if> >
					<div>
						<span id="picker" class="u-up">
							<span style="display:block;text-align:center;line-height:22px;padding-top:120px">点击上传文件</span>
						</span>
					</div>
					<p class="tips">
						你可以上传 Word、Execl、PPT、PDF文档,mp4、flv视频,zip、rar压缩文件,及Jpg、Png、Gif图片
					</p>
				</div>
				<div class="m-rate-bar success" id="m-rate-bar" <#if !(resource.id)??>style="display:none"</#if>>
                    <div class="now-rate" id="now-rate" style="width:100%;">
                        <p class="now-rate-num">已完成：<span>100%</span></p>
                        <div class="rate-success" id="u-success">
                            <p><i></i>上传完成</p>
                        </div>
                        <div class="rate-fail">
                            <p><i></i>上传失败</p>
                        </div>
                    </div>
                    <div class="file-info">
                        <div class="m-bRsc-block doc">
                            <a href="javascript:void(0);"><i class="type-ico"></i></a>
                            <h4 class="tt"><a href="javascript:void(0);">${(resource.fileInfos?first.fileName)!}</a></h4>
                            <p class="info">
                                <span>${(FileSizeUtils.getFileSize(resource.fileInfos?first.fileSize))!}</span>
                            </p>
                        </div>
                    </div>
                    <div id="reUpload" class="u-ope">
                        <a  href="javascript:void(0);"><i></i>重新上传</a>
                    </div>
                </div>
				<div class="m-pb-row">
					<div class="pb-mn">
						<div class="m-pb-mod">
							<div class="pb-txt">
								<span>资源标题：</span>
							</div>
							<div class="m-ipt-mod">
								<input type="text" name="title" required value="${(resource.title)!}" class="u-ipt" placeholder="填写资源标题">
							</div>
						</div>
					</div>
				</div>
				<div class="m-pb-row">
					<div class="pb-mn">
						<div class="m-pb-mod">
							<div class="pb-txt">
								<span>资源描述：</span>
							</div>
							<div class="m-ipt-mod">
								<textarea  name="summary" value="" placeholder="请您对本资源进行描述。" class="u-textarea">${(resource.summary)!}</textarea>
							</div>
						</div>
					</div>
				</div>
				<div class="m-pb-row">
					<div class="pb-mn">
						<div class="m-pb-mod">
							<div class="pb-txt">
								<span>选择资源类型：</span>
							</div>
							<div class="m-choose-mod">
								<#assign etype = (resource.resourceExtend.type)!'01'/>
								<#list DictionaryUtils.getEntryList('COURSE_RESOURCE_TYPE') as dtype>
									<label class="u-choose on">
										<input type="radio" value="${(dtype.dictValue)!}" name="resourceExtend.type" <#if etype = dtype.dictValue>checked="checked"</#if> >
										<i class="u-ico-rd"></i> <span>${(dtype.dictName)!}</span> 
									</label>
								</#list>
							</div>
						</div>
					</div>
				</div>
				<div class="m-pb-row">
					<div class="pb-mn">
						<div class="m-pb-mod">
							<div class="pb-txt">
								<span>学科/学段/年级：</span>
							</div>
							<div class="m-linkage-choose">
								<div class="m-slt-block1 mid">
									<a href="javascript:;" class="show-txt"> 
										<span class="txt"><#if (resource.resourceExtend.stage)??>${TextBookUtils.getEntryName('STAGE',resource.resourceExtend.stage)}<#else>请选择学段</#if></span>
										<input type="hidden" name="resourceExtend.stage" value="${(resource.resourceExtend.stage)!''}"> 
										<i class="trg"></i> 
									</a>
									<dl id="stageSelect" class="lst">
										<dd><a href="javascript:;" >请选择学段</a></dd>
										<#assign rstage = (resource.resourceExtend.stage)!''>
										<#list TextBookUtils.getEntryList('STAGE') as stage>
											<dd><a href="javascript:;" value="${(stage.textBookValue)!}" class="<#if rstage=stage.textBookValue>z-crt </#if>">${(stage.textBookName)!}</a></dd>
										</#list>
									</dl>
								</div>
								<div class="m-slt-block1 mid">
									<a href="javascript:;" class="show-txt">
										 <span class="txt"><#if (resource.resourceExtend.subject)??>${TextBookUtils.getEntryName('SUBJECT',resource.resourceExtend.subject)}<#else>请选择学科</#if></span> <i class="trg"></i>
										 <input type="hidden" name="resourceExtend.subject" value="${(resource.resourceExtend.subject)!''}">
									</a>
									<dl id="subjectSelect" class="lst">
										<dd><a href="javascript:;" class="z-crt">请选择学科</a></dd>
										<#assign rsubject = (resource.resourceExtend.subject)!''>
										<#list TextBookUtils.getEntryList(TextBookParamUtils.buildTextBookParam('SUBJECT',resource!'')) as subject>
											<dd><a href="javascript:;" value="${(subject.textBookValue)!}" class="<#if rsubject=subject.textBookValue>z-crt </#if>">${(subject.textBookName)!}</a></dd>
										</#list>
									</dl>
								</div>
								<div class="m-slt-block1 mid">
									<a href="javascript:;" class="show-txt">
										 <span class="txt"><#if (resource.resourceExtend.grade)??>${TextBookUtils.getEntryName('GRADE',resource.resourceExtend.grade)}<#else>请选择年级</#if></span> <i class="trg"></i>
										 <input type="hidden" name="resourceExtend.grade" value=${(resource.resourceExtend.grade)!''}>
									</a>
									<dl id="gradeSelect" class="lst">
										<dd><a href="javascript:;" class="z-crt">请选择年级</a></dd>
										<#assign rgrade = (resource.resourceExtend.grade)!''>
										<#list TextBookUtils.getEntryList(TextBookParamUtils.buildTextBookParam('GRADE',resource!'')) as grade>
											<dd><a href="javascript:;" value="${(grade.textBookValue)!}" class="<#if rgrade=grade.textBookValue>z-crt </#if>">${(grade.textBookName)!}</a></dd>
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
							<div class="pb-txt">
								<span>选择教材：</span>
							</div>
							<div class="m-linkage-choose">
								<div class="m-slt-block1 mid">
									<a href="javascript:;" class="show-txt">
										 <span class="txt"><#if (resource.resourceExtend.tbVersion)??>${TextBookUtils.getEntryName('VERSION',resource.resourceExtend.tbVersion)}<#else>请选择教材</#if></span> <i class="trg"></i>
										 <input type="hidden" name="resourceExtend.tbVersion" value="${(resource.resourceExtend.tbVersion)!''}">
									</a>
									<dl id="versionSelect" class="lst">
										<dd><a href="javascript:;" class="z-crt">请选择教材</a></dd>
										<#assign rversion = (resource.resourceExtend.tbVersion)!''>
										<#list TextBookUtils.getEntryList(TextBookParamUtils.buildTextBookParam('VERSION',resource!'')) as version>
											<dd><a href="javascript:;" value="${(version.textBookValue)!}" class="<#if rversion=version.textBookValue>z-crt </#if>">${(version.textBookName)!}</a></dd>
										</#list>
									</dl>
								</div>
								
								<div class="m-slt-block1 mid">
									<a href="javascript:;" class="show-txt">
										<span class="txt"><#if (resource.resourceExtend.chapter)??>${TextBookUtils.getEntryName('SECTION',resource.resourceExtend.chapter)}<#else>请选择章</#if></span> <i class="trg"></i> 
										<input type="hidden" name="resourceExtend.chapter" value="${(resource.resourceExtend.chapter)!''}">
									</a>
									<dl id="sectionSelect" class="lst">
										<dd><a href="javascript:;" class="z-crt">请选择章</a></dd>
										<#assign section = (resource.resourceExtend.section)!''>
										<#list TextBookUtils.getEntryList(TextBookParamUtils.buildTextBookParam('SECTION',resource!'')) as section>
											<dd><a href="javascript:;" value="${(section.textBookValue)!}" class="<#if section=section.textBookValue>z-crt </#if>">${(section.textBookName)!}</a></dd>
										</#list>
									</dl>
								</div>
								<div class="m-slt-block1 mid">
									<a href="javascript:;" class="show-txt">
										 <span class="txt"><#if (resource.resourceExtend.section)??>${TextBookUtils.getEntryName('SECTION',resource.resourceExtend.section)}<#else>请选择节</#if></span> <i class="trg"></i> 
										 <input type="hidden" name="resourceExtend.section" value="${(resource.resourceExtend.section)!''}">
									</a>
									<dl id="chapterSelect" class="lst">
										<dd><a href="javascript:;" class="z-crt">请选择节</a></dd>
										<#assign chapter = (resource.resourceExtend.chapter)!''>
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
							<div class="pb-txt">
								<span>积分设置：</span>
							</div>
							<div class="m-ipt-mod mid">
								<input type="text" name="resourceExtend.price" max="50" min="0" value="${(resource.resourceExtend.price)}" class="u-ipt" placeholder="请输入下载资源所需积分">
								<span class="u-tips">（“0”即为免费下载）</span>
							</div>
						</div>
					</div>
				</div>
				<div class="m-pb-row">
					<div class="pb-mn">
						<div class="m-pb-mod">
							<a href="javascript:;" onclick="saveCourseResource()" class="u-btn-theme">确定</a>
							<a href="javascript:location.href=document.referrer;" class="u-btn-cancel">取消</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</form>
<script>
	$(function(){
		$('#picker').createUploader({
			accept:{
				extensions:'doc,docx,xls,xlsx,ppt,pptx,pdf,mp4,flv,zip,rar,jpg,png,gif'				
			},
			fileQueued:function(file){
				$('#uploadDiv').hide();
				$('#m-rate-bar .file-info .tt a').text(file.name);
				$('#m-rate-bar .file-info .info span').text(getFileSize(file.size));
				$('#m-rate-bar .file-info .m-bRsc-block').attr('class','m-bRsc-block').addClass(getFileType(file.name,{pic:'img'}));
				$('#m-rate-bar').show();
				$('#m-rate-bar').removeClass('success');
			},
			uploadProgress:function(file,percent){
				$('#now-rate').css('width',percent*100 + '%');
				$('#now-rate .now-rate-num span').text(percent*100 + '%');
			},
			uploadComplete:function(){
				$('#m-rate-bar').addClass('success');
			},
			uploadSuccess:function(file,response){
				var fileInfo = response.responseData;
				if(response.responseCode == '00'){
					$('#fileParam').empty();
					$('#fileParam').append('<input type="hidden" name="fileInfos[0].id" value="'+fileInfo.id+'" />');
					$('#fileParam').append('<input type="hidden" name="fileInfos[0].fileName" value="'+fileInfo.fileName+'" />');
					$('#fileParam').append('<input type="hidden" name="fileInfos[0].url" value="'+fileInfo.url+'" />');
				}	
			}
		});
		
		$('#reUpload').on('click',function(){
			$('#picker label').trigger('click');
		});
		
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
	
	function saveCourseResource(){
		if($('#fileParam input').size()<=0){
			alert('必须上传文件');
			return false;
		}
		
		if(!$('#saveCourseResourceForm').validate().form()){
			return false;
		}
		
		var response = $.ajaxSubmit('saveCourseResourceForm');
		response = $.parseJSON(response);
		if(response.responseCode =='00'){
			alert('保存成功',function(){
				window.location.href = "${ctx}/course_resource/index";
			});
		}
	}
	
</script>
</@layout.layout>