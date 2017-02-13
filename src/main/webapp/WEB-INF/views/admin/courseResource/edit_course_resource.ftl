<#import "/admin/common/include/layout.ftl" as lo>
<#assign jsArray = ["${ctx}/js/common/webuploader/webuploader.min.js","${ctx}/js/tpdpor/uploadFile.js"] />
<#assign cssArray = ["${ctx}/css/admin/fileUpload.css"]>
<@lo.layout jsArray=jsArray cssArray=cssArray validate=true>
<#import "/admin/common/include/form.ftl" as fl>
<@fl.form id="createCourseResourceForm" action="${ctx}/admin/course_resource" method="post" saveCallback="function(){location.href='${ctx}/admin/course_resource?menuTreeId=${menuTreeId}'}" saveValidate="function(){return validate()}">
<#if (resource.id)??>
	<input type="hidden" name="id" value="${(resource.id)!}">
<#else>
	<input type="hidden" name="type" value="course">
	<input type="hidden" name="resourceRelations[0].relation.id" value="course">
	<input type="hidden" name="resourceRelations[0].relation.type" value="course">
	<input type="hidden" name="resourceExtend.source" value="admin" >
</#if>
<div class="mis-inner-wrap">
	<div class="mis-mod">
		<div class="mis-crm">
			<div class="crm">
				<a href="${ctx}/admin/course_resource?menuTreeId=${menuTreeId!}">课程案例</a>
				<span class="trg">&gt;</span>
				<a href="javascript:;"><#if (resource.id)??>编辑课程案例<#else>新增课程案例</#if></a>
			</div>
		</div>
		<div class="mis-addElement-item">
			<div class="ltxt">
				文件：
			</div>
			<div class="center">
				<div class="m-pbMod-udload">
					<a id="picker"  href="javascript:void(0);" class="mis-opt-upbtn mis-inverse-btn"><i class="mis-upload-ico"></i>上传文件</a>
					<span>你可以上传 Word、Execl、PPT、PDF文档,mp4、flv视频,zip、rar压缩文件,及Jpg、Png、Gif图片</span>
				</div>
				<ul id="fileList" class="mis-sfile-lst">
					<#if (resource.id)??> 
						<#if (resource.fileInfos)??>
							<#list resource.fileInfos as fileInfo>
								<li state="success">
	                                <i class="mis-sfile-ico ${FileTypeUtils.getFileTypeClass((fileInfo.fileName)!'','suffix')}"></i>
	                                <a href="javascript:void(0);" class="name" title="${(fileInfo.fileName)!}">${(fileInfo.fileName)!}</a>
	                                <span class="size">${FileSizeUtils.getFileSize((fileInfo.fileSize)!)}</span>
	                                <a href="javascript:void(0);" class="dlt"><i class="mis-delete-ico1"></i>删除</a>
	                            </li>
							</#list>
						</#if>
					</#if>
				</ul>
				<span id="fileParam">
					<#if (resource.fileInfos)??>
						<#list resource.fileInfos as fileInfo>
							<input type="hidden" name="fileInfos[${fileInfo_index}].id" value="${fileInfo.id}">
							<input type="hidden" name="fileInfos[${fileInfo_index}].fileName" value="${(fileInfo.fileName)!}">
							<input type="hidden" name="fileInfos[${fileInfo_index}].url" value="${(fileInfo.url)!}">
						</#list>
					</#if>
				</span>
				<div style="display:none">
					<li id="fileModel" >
						<i class="mis-sfile-ico"></i>
						<a href="javascript:void(0);" class="name" title="二元二次方程教学方案.doc">二元二次方程教学方案.doc</a>
						<span class="size">196K</span>
						<div class="mis-pbar">
							<div class="bar">
								<div class="yet" style="width: 50%;">
									<span>50%</span>
								</div>
							</div>
							<span class="bar-txt">上传中....</span>
						</div>
						<a href="javascript:void(0);" class="dlt"><i class="mis-delete-ico1"></i>删除</a>
					</li>
				</div>
			</div>
		</div>
		
			<ul class="mis-ipt-lst">
				<li class="item w1">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>资源描述：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="mis-ipt-mod">
	                            <textarea name="summary" class="mis-textarea" placeholder="输入资源简介" aria-required="true">${(resource.summary)!}</textarea>
	                        </div>
	                    </div>
	                </div>
	           </li>
				<li class="item w1">
					<div class="mis-ipt-row">
						<div class="tl">
							<span>选择资源类型：</span>
						</div>
						<div class="tc">
							<div class="mis-check-mod">
								<#list DictionaryUtils.getEntryList('COURSE_RESOURCE_TYPE') as dtype>
									<label class="mis-radio-tick"> <strong class="on">
										<i class="ico"></i>
										<input type="radio" name="resourceExtend.type" <#if etype = dtype.dictValue>checked="checked"</#if> value="${(dtype.dictValue)!}" >
										</strong> <span>${(dtype.dictName)!}</span> 
									</label>
								</#list>
							</div>
						</div>
					</div>
				</li>
				<li class="item">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>学段/年级/学科：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="mis-slt-row ">
								<div class="mis-selectbox">
									<strong><span class="simulateSelect-text">小学</span><i class="trg"></i></strong>
									<select id="stageSelect" name="resourceExtend.stage"  aria-required="true">
										<option value="">请选择学段</option>
							 			${TextBookUtils.getEntryOptionsSelected('STAGE',(resource.resourceExtend.stage)!'')}
									</select>
								</div>
								<div class="mis-selectbox">
									<strong><span class="simulateSelect-text" required="" aria-required="true">请选择学科</span><i class="trg"></i></strong>
									<select id="subjectSelect" name="resourceExtend.subject">
										<option value="" selected="selected">请选择学科</option>
										${TextBookUtils.getEntryOptionsSelected('SUBJECT',(resource.resourceExtend.subject)!'')}
									</select>
								</div>
								<div class="mis-selectbox">
									<strong><span class="simulateSelect-text">请选择年级</span><i class="trg"></i></strong>
									<select id="gradeSelect" name="resourceExtend.grade">
										<option value="" selected="selected">请选择年级</option>
										${TextBookUtils.getEntryOptionsSelected('GRADE',(resource.resourceExtend.grade)!'')}
									</select>
								</div>
	                        </div>
	                    </div>
	                </div>
	            </li>
	            <li class="item">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>教材：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="mis-slt-row ">
								<div class="mis-selectbox">
									<strong><span class="simulateSelect-text">小学</span><i class="trg"></i></strong>
									<select id="versionSelect" name="resourceExtend.tbVersion"  aria-required="true">
										<option value="">请选择教材</option>
							 			${TextBookUtils.getEntryOptionsSelected('VERSION',(resource.resourceExtend.tbVersion)!'')}
									</select>
								</div>
								<div class="mis-selectbox">
									<strong><span class="simulateSelect-text" required="" aria-required="true">请选择章</span><i class="trg"></i></strong>
									<select id="sectionSelect" name="resourceExtend.chapter">
										<option value="" selected="selected">请选择章</option>
										${TextBookUtils.getEntryOptionsSelected('SECTION',(resource.resourceExtend.chapter)!'')}
									</select>
								</div>
								<div class="mis-selectbox">
									<strong><span class="simulateSelect-text">请选择节</span><i class="trg"></i></strong>
									<select id="chapterSelect" name="resourceExtend.section">
										<option value="" selected="selected">请选择节</option>
										${TextBookUtils.getEntryOptionsSelected('SECTION',(resource.resourceExtend.section)!'')}
									</select>
								</div>
	                        </div>
	                    </div>
	                </div>
	            </li>
				<li class="item w1">
					<div class="mis-ipt-row">
						<div class="tl">
							<span>积分设置：</span>
						</div>
						<div class="tc">
							<div class="mis-ipt-mod">
								<input style="width:200px" type="text" max="50" min="0" name="resourceExtend.price" value="${(resource.resourceExtend.price)!}" placeholder="" class="mis-ipt">
							</div>
						</div>
					</div>
				</li>
			</ul>
			</form>
			</@fl.form>
	</div>
</div>

<#import "/admin/bookindex/select_book_index.ftl" as sbi>
<@sbi.selectBookIndex bookIndexTreeId="parentBookIndexTree" onClick="selectParentMenu" bookIndexInputId="bookIndexParent" bookIndexInputName="parent" bookIndexContentId="bookIndexZtreeContent" selectedId=pid!''>
<script>
	function selectParentMenu(e, treeId, treeNode) {
		$("input[name$='bIndex']").remove();
		console.log(treeNode);
		$("#bookIndexParent").append("<input type='hidden' name='resourceExtend.bIndex' value='" + treeNode.bIndex + "' />");
		$("#bookIndexParent").val(treeNode.name);
		hideMenu();
	}
</script>
</@sbi.selectBookIndex>

<script>
	$(function(){
		$('#createCourseResourceForm').on('click','a.dlt',function(){
			$(this).closest('li').remove();
			$('#fileList').empty();
		});
		
		//上传附件按钮
		var uploader = $('#picker').createUploader({
			accept:{
				extensions:'doc,docx,xls,xlsx,ppt,pptx,pdf,mp4,flv,zip,rar,jpg,png,gif'				
			},
			fileQueued:function(file){
				var li = $('#fileModel').clone();
				$(li).attr('id',file.id);
				$(li).find('.name').text(file.name);
				$(li).find('.size').text(getFileSize(file.size));
				$(li).find('.mis-sfile-ico').addClass(getFileType(file.name));
				//单个上传，清空上一次
				$('#fileList').empty();
				$('#fileList').append(li);
			},
			uploadProgress:function(file,percentage){
				$('#' + file.id).find('.bar .yet').css('width',percentage*100 + '%');
				$('#' + file.id).find('.bar .yet span').text(percentage*100 + '%');
			},
			uploadSuccess:function(file,response){
				if(response.responseCode == '00'){
					//上传成功清空上一次
					$('#fileParam').empty();
					var fileInfo = response.responseData;
					$('#fileParam').append('<input type="hidden" name="fileInfos[0].id" value="'+fileInfo.id+'">');
					$('#fileParam').append('<input type="hidden" name="fileInfos[0].fileName" value="'+fileInfo.fileName+'">');
					$('#fileParam').append('<input type="hidden" name="fileInfos[0].url" value="'+fileInfo.url+'">');
					$('#fileParam').append('<input type="hidden" name="title" value="'+fileInfo.fileName+'">');
					$('#' + file.id).find('.mis-pbar').addClass('finish');
					$('#' + file.id).attr('state','success');
					$('#' + file.id).find('.mis-pbar .bar-txt').text('上传完成');
				}
			}
		});
		
		
		//学科学段下拉框联动
		$('#stageSelect').on('change',function(){
			$.post('${ctx}/textBook/getEntryListByEntity',{
				textBookTypeCode:'SUBJECT,GRADE,VERSION',
				stage:$('#stageSelect').val()
			},function(entrys){
				//重置subjectSelect
				resetAfterSelect($('#stageSelect'));
				$.each(entrys,function(i,entry){
					if(entry.textBookTypeCode == 'SUBJECT'){
						$('#subjectSelect').append('<option value="'+entry.textBookValue+'">'+entry.textBookName+'</option>');
					}else if(entry.textBookTypeCode == 'GRADE'){
						$('#gradeSelect').append('<option value="'+entry.textBookValue+'">'+entry.textBookName+'</option>');
					}else if(entry.textBookTypeCode == 'VERSION'){
						$('#versionSelect').append('<option value="'+entry.textBookValue+'">'+entry.textBookName+'</option>');
					}
				});
			});
		});
		
		$('#subjectSelect').on('change',function(){
			$.post('${ctx}/textBook/getEntryListByEntity',{
				textBookTypeCode:'GRADE,VERSION',
				stage:$('#stageSelect').val(),
				subject:$('#subjectSelect').val()
			},function(entrys){
				//重置gradeSelect
				resetAfterSelect($('#subjectSelect'));
				$.each(entrys,function(i,entry){
					if(entry.textBookTypeCode == 'GRADE'){
						$('#gradeSelect').append('<option value="'+entry.textBookValue+'">'+entry.textBookName+'</option>');
					}else if(entry.textBookTypeCode == 'VERSION'){
						$('#versionSelect').append('<option value="'+entry.textBookValue+'">'+entry.textBookName+'</option>');
					}
				});
			});
		});
		
		$('#gradeSelect').on('change',function(){
			$.post('${ctx}/textBook/getEntryListByEntity',{
				textBookTypeCode:'VERSION',
				stage:$('#stageSelect').val(),
				subject:$('#subjectSelect').val(),
				grade:$(this).val()
			},function(entrys){
				//重置gradeSelect
				resetAfterSelect($('#gradeSelect'));
				$.each(entrys,function(i,entry){
					if(entry.textBookTypeCode == 'VERSION'){
						$('#versionSelect').append('<option value="'+entry.textBookValue+'">'+entry.textBookName+'</option>');
					}
				});
			});
		});
		
		$('#versionSelect').on('change',function(){
			$.post('${ctx}/textBook/getEntryListByEntity',{
				textBookTypeCode:'SECTION',
				stage:$('#stageSelect').val(),
				subject:$('#subjectSelect').val(),
				grade:$('#gradeSelect').val(),
				version:$(this).val(),
			},function(entrys){
				//重置gradeSelect
				resetAfterSelect($('#versionSelect'));
				$.each(entrys,function(i,entry){
					if(entry.textBookTypeCode == 'SECTION'){
						$('#sectionSelect').append('<option value="'+entry.textBookValue+'">'+entry.textBookName+'</option>');
					}
				});
			});
		});
		
		$('#sectionSelect').on('change',function(){
			$.post('${ctx}/textBook/getEntryListByEntity',{
				textBookTypeCode:'SECTION',
				stage:$('#stageSelect').val(),
				subject:$('#subjectSelect').val(),
				grade:$('#gradeSelect').val(),
				version:$('#versionSelect').val(),
				section:$(this).val(),
			},function(entrys){
				//重置gradeSelect
				resetAfterSelect($('#sectionSelect'));
				$.each(entrys,function(i,entry){
					if(entry.textBookTypeCode == 'SECTION'){
						$('#chapterSelect').append('<option value="'+entry.textBookValue+'">'+entry.textBookName+'</option>');
					}
				});
			});
		});
		
		function resetAfterSelect(s){
			var afterSelect = $(s).closest('.mis-selectbox').nextAll('.mis-selectbox').find('select');
			var afterRow = $(s).closest('.item').next();
			$.each(afterSelect,function(i,n){
				var defaultOption = $(n).find('option').eq(0)?$(n).find('option').eq(0).clone(true):'';
				$(n).empty();
				if(defaultOption){
					$(n).append(defaultOption);
				}
				var selectParent = $(n).closest('.mis-selectbox');
				selectParent.find('.simulateSelect-text').text(defaultOption.text());
			});
			
			$.each(afterRow,function(i,n){
				var selects = $(n).find('select');
				$.each(selects,function(i,n){
					var defaultOption = $(n).find('option').eq(0)?$(n).find('option').eq(0).clone(true):'';
					$(n).empty();
					if(defaultOption){
						$(n).append(defaultOption);
					}
					var selectParent = $(n).closest('.mis-selectbox');
					selectParent.find('.simulateSelect-text').text(defaultOption.text());
				});
			});
		}
	});
	
	function validate(){
		if($('#fileList li[state=success]').size()<=0){
			alert('必须上传文件');
			return false;
		}
		return $('#createCourseResourceForm').validate().form();
	}
	
</script>
</@lo.layout>
