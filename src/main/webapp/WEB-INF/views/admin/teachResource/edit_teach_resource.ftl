<#import "/admin/common/include/layout.ftl" as lo>
<#assign jsArray = ["${ctx}/js/common/webuploader/webuploader.min.js","${ctx}/js/tpdpor/uploadFile.js"] />
<#assign cssArray = ["${ctx}/css/admin/fileUpload.css"]>
<@lo.layout jsArray=jsArray cssArray=cssArray validate=true>
<#import "/admin/common/include/form.ftl" as fl>
<@fl.form id="createTeachResourceForm" action="${ctx}/admin/teach_resource/save" method="post" saveCallback="function(){location.href='${ctx}/admin/teach_resource?menuTreeId=${menuTreeId}'}" saveValidate="function(){return validate()}">
<#if (resource.id)??>
	<input type="hidden" name="id" value="${(resource.id)!}">
<#else>
	<input type="hidden" name="type" value="teach">
	<input type="hidden" name="resourceRelations[0].relation.id" value="teach">
	<input type="hidden" name="resourceRelations[0].relation.type" value="teach">
</#if>
<div class="mis-inner-wrap">
	<div class="mis-mod">
		<div class="mis-crm">
			<div class="crm">
				<a href="${ctx}/admin/teach_resource?menuTreeId=${menuTreeId}">教研资料</a>
				<span class="trg">&gt;</span>
				<a href="javascript:;"><#if (resource.id)??>编辑教研资料<#else>新增教研资料</#if></a>
			</div>
		</div>
		<ul class="mis-ipt-lst">
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>选择上传类型：</span>
					</div>
					<div class="tc">
						<div class="mis-check-mod">
							<#assign isOriginal=(resource.resourceExtend.isOriginal)!'Y' />
							<label class="mis-radio-tick"> <strong class="on"> <i class="ico"></i>
								<input type="radio" onclick="changeUploadType('file')" name="resourceExtend.isOriginal" <#if isOriginal=='Y'>checked="checked"</#if> value="Y">
								</strong> <span>文件</span>
							</label>
							<label class="mis-radio-tick"> <strong> <i class="ico"></i>
								<input  id="urlCheckBox" type="radio" onclick="changeUploadType('url')" <#if isOriginal=='N'>checked="checked"</#if> name="resourceExtend.isOriginal" value="N">
								</strong> <span>链接</span> 
							</label>
						</div>
					</div>
				</div>
			</li>
		</ul>
		<div style="margin:0 0 0 0" class="mis-addElement-item" id="uploadFileDiv">
			<div class="center">
				<div>
					<div class="ltxt">
						附件：
					</div>
					<div class="m-pbMod-udload">
						<a id="picker"  href="javascript:void(0);" class="mis-opt-upbtn mis-inverse-btn"><i class="mis-upload-ico"></i>上传文件</a>
					</div>
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
			<ul  class="mis-ipt-lst" style="margin-top:0px">
				<li id="urlDiv" class="item w1">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>资源地址：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="mis-ipt-mod">
	                            <input style="width:400px"  type="text" name="resourceExtend.previewUrl" value="${(resource.resourceExtend.previewUrl)!}" placeholder="请输入资源地址"  class="mis-ipt"  aria-required="true">
	                            <span>此功能仅为计划开发的内部资源使用,暂为非必填项</span>
	                        </div>
	                    </div>
	                </div>
	            </li>
				
	            <!--
				<li class="item">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>索引：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="mis-slt-row ">
	                            <div class="mis-selectbox">
	                                <strong><span class="simulateSelect-text">小学</span><i class="trg"></i></strong>
	                                <select required="" aria-required="true">
	                                    <option value="">请选择学段</option>
	                                    <option value="" selected="selected">小学</option>
	                                    <option value="1">初中</option>
	                                    <option value="2">高中</option>
	                                    <option value="3">大学</option>
	                                </select>
	                            </div>
	                            <div class="mis-selectbox">
	                                <strong><span class="simulateSelect-text" required="" aria-required="true">请选择年级</span><i class="trg"></i></strong>
	                                <select>
	                                    <option value="" selected="selected">请选择年级</option>
	                                    <option value="">一年级</option>
	                                    <option value="1">二年级</option>
	                                    <option value="2">三年级</option>
	                                    <option value="3">四年级</option>
	                                </select>
	                            </div>
	                            <div class="mis-selectbox">
	                                <strong><span class="simulateSelect-text">请选择学科</span><i class="trg"></i></strong>
	                                <select>
	                                    <option value="" selected="selected">请选择学科</option>
	                                    <option value="">语文</option>
	                                    <option value="1">数学</option>
	                                    <option value="2">英语</option>
	                                    <option value="3">政治</option>
	                                </select>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </li>
	            -->
				<li class="item w1" >
					<div class="mis-ipt-row">
						<div class="tl">
							<span>标题：</span>
						</div>
						<div class="tc">
							<div class="mis-ipt-mod">
								<input type="text" style="width:768px" required name="title" value="${(resource.title)!}" placeholder="请输入标题" class="mis-ipt">
							</div>
						</div>
					</div>
				</li>
				<li class="item" style="width:450px">
					<div class="mis-ipt-row" style="padding-right:0px">
						<div class="tl">
							<span>作者：</span>
						</div>
						<div class="tc">
							<div class="mis-ipt-mod">
								<input type="text" name="resourceExtend.author" value="${(resource.resourceExtend.author)!}" placeholder="请输入作者" class="mis-ipt">
							</div>
						</div>
					</div>
				</li>
				<li class="item" style="width:450px">
					<div class="mis-ipt-row" style="padding-right:0px">
						<div class="tl">
							<span>出版社：</span>
						</div>
						<div class="tc">
							<div class="mis-ipt-mod">
								<input type="text"  name="resourceExtend.source" value="${(resource.resourceExtend.source)!}" placeholder="请输入出版社" class="mis-ipt">
							</div>
						</div>
					</div>
				</li>
				<li class="item" style="width:450px">
					<div class="mis-ipt-row" style="padding-right:0px">
						<div class="tl">
							<span>出版年：</span>
						</div>
						<div class="tc">
							<div class="mis-ipt-mod">
								<input type="text" name="year" digits="true" min="0" value="${(resource.resourceExtend.issueDate?string('yyyy'))!}" placeholder="请输入出版年,如2000" class="mis-ipt">
							</div>
						</div>
					</div>
				</li>
				<li class="item" style="width:450px">
					<div class="mis-ipt-row">
						<div class="tl">
							<span>类型：</span>
						</div>
						<div class="tc" style="width:344px">
			                <div class="mis-selectbox"  >
			                    <strong><span class="simulateSelect-text">广州市</span><i class="trg"></i></strong>
			                    <select name="resourceExtend.type" >
			                        ${DictionaryUtils.getEntryOptionsSelected('TEACH_RESOURCE_TYPE',(resource.resourceExtend.type)!'')}
			                    </select>
			                </div>
						</div>
					</div>
				</li>
				<li class="item w1" >
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>学段/年级/学科：</span>
	                    </div>
	                    <div class="tc" style="width:794px">
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
				<li class="item w1">
					<div class="mis-ipt-row">
						<div class="tl">
							<span>索引：</span>
						</div>
						<#if (resource.resourceExtend.bIndex)??>
							<@bookIndexDirective bIndex = resource.resourceExtend.bIndex>
								<#assign bookIndex = bookIndex!>
							</@bookIndexDirective>
						</#if>
						<div class="tc">
							<div class="mis-ipt-mod" style="width:350px">
									<input style="width:80%" type="text" value="${(bookIndex.bIndex)!}  ${(bookIndex.name)!}" id="bookIndexParent" readonly  class="mis-ipt"   onclick="showMenu();"/>
									<a  id="selectMenuBtn" href="javascript:;" class="selectBtn" onclick="showMenu(); return false;">请选择</a>
								<div id="bookIndexZtreeContent" class="menuZtreeContent" style="display:none">
									<ul id="parentBookIndexTree" class="ztree selectTree"></ul>
								</div>
							</div>
						</div>
					</div>
				</li>
				<li class="item w1">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>资源简介：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="mis-ipt-mod">
	                            <textarea style="width:768px" name="summary" class="mis-textarea" placeholder="输入资源简介" aria-required="true">${(resource.summary)!}</textarea>
	                        </div>
	                    </div>
	                </div>
	            </li>
				<li class="item w1" >
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>开放范围：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="mis-check-mod">
	                            <label class="mis-radio-tick">
	                                <strong>
	                                    <i class="ico"></i>
	                                    <input onclick="belongDiv('hide')" type="radio" value="free" <#if ((resource.privilege)!'free') == 'free'>checked="checked"</#if> name="privilege">
	                                </strong>
	                                <span>免费公开</span>
	                            </label>
	                            <label class="mis-radio-tick">
	                                <strong class="on">
	                                    <i class="ico"></i>
	                                    <input onclick="belongDiv('show')" type="radio" value="apply" <#if ((resource.privilege)!'free') == 'apply'>checked="checked"</#if>  name="privilege">
	                                </strong>
	                                <span>指定公开对象</span>
	                            </label>
	                        </div>
	                    </div>
	                </div>
	            </li>
				<li id="belongDiv" class="item" <#if ((resource.privilege)!'free') == 'free'>style="display:none"</#if> >
					<div class="mis-ipt-row">
						<div class="tl">
							<span>开放对象：</span>
						</div>
						<div class="tc">
							<div class="mis-check-mod" style="width:500px">
								<label class="mis-checkbox"> 
									<strong> <i class="ico"></i>
									<input type="checkbox" id="" name="belong" <#if ((resource.belong)!'')?contains(AccountRoleCode.ZSXJS) || !(resource.id)??>checked="checked"</#if>  class="checkRow" value="${AccountRoleCode.ZSXJS}" required="" aria-required="true">
									</strong> 
									<span>直属校教师</span> 
								</label>
								<label class="mis-checkbox"> <strong> <i class="ico"></i>
									<input type="checkbox" name="belong" class="checkRow" value="${AccountRoleCode.ZSXXS}" <#if ((resource.belong)!'')?contains(AccountRoleCode.ZSXXS) || !(resource.id)??>checked="checked"</#if> aria-required="true">
									</strong> <span>直属校学生</span> 
								</label>
								<label class="mis-checkbox"> <strong> <i class="ico"></i>
									<input type="checkbox" name="belong" class="checkRow" value="${AccountRoleCode.JSRZHY}" <#if ((resource.belong)!'')?contains(AccountRoleCode.JSRZHY) || !(resource.id)??>checked="checked"</#if> aria-required="true">
									</strong> <span>教师认证会员</span> 
								</label>
							</div>
						</div>
					</div>
				</li>
				<li class="item w1">
					<div class="mis-ipt-row">
						<div class="tl">
							<span id="imageParam" style="display:none">
								
								
							</span>
						</div>
						<div class="tc">
							<div class="mis-uplad-Aclayer"  style="text-align:left">
								<ul id="imageList" class="mis-hadup-img">
									<#if (resource.resourceExtend.coverUrl)??>
										<li><img src="${FileUtils.getFileUrl(resource.resourceExtend.coverUrl)}" alt=""><i onclick="removeImg(this)" class="u-close">×</i><span class="what-pic">风景图片</span></li>
									</#if>
						            <li class="imagePicker">
						                <div id="imagePicker" class="img">
						                    <a href="javascript:;">
						                        <i class="u-add"></i>
						                        <input type="file" class="u-file">
						                        <p class="txt">点击上传封面图片</p>
						                    </a>
						                </div>
						            </li>
						            <p>建议尺寸:280*415,允许格式:jpg,png</p>
						        </ul>
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
		$('#createTeachResourceForm').on('click','a.dlt',function(){
			$(this).closest('li').remove();
			$('#fileList').empty();
		});
		
		//上传附件按钮
		var uploader = $('#picker').createUploader({
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
					$('#' + file.id).find('.mis-pbar').addClass('finish');
					$('#' + file.id).attr('state','success');
					$('#' + file.id).find('.mis-pbar .bar-txt').text('上传完成');
				}
			}
		});
		
		//编辑时判断是哪种类型的
		var resourceId = "${(resource.id)!''}";
		if(resourceId != ''){
			var isOriginal = "${(resource.resourceExtend.isOriginal)!''}";
			if(isOriginal == 'N'){
				changeUploadType('url');
			}else{
				changeUploadType('file');
			}
		}else{
			changeUploadType('file');
		}
		
		//上传封面按钮
		var imageUploader = $('#imagePicker').createUploader({
			accept:{
				extensions:'jpg,png,gif'				
			},
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
			    //$('.imagePicker').hide();
			},
			uploadProgress:function(file,percentage){
				var li = $('#'+file.id);
				li.find('.progressW').css('width',percentage*100 + '%');
				li.find('.u-progress .txt').text('已上传'+percentage*100 + '%');
			},
			uploadSuccess:function(file,response){
				if(response.responseCode == '00'){
					$('#imageParam').empty();
					var fileInfo = response.responseData;
					$('#imageParam').append('<input type="hidden" name="resourceExtend.coverFileInfo.id" value="'+fileInfo.id+'">');
					$('#imageParam').append('<input type="hidden" name="resourceExtend.coverFileInfo.fileName" value="'+fileInfo.fileName+'">');
					$('#imageParam').append('<input type="hidden" name="resourceExtend.coverFileInfo.url" value="'+fileInfo.url+'">');
				}
			}
		});
		
		
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
		
		function resetSelect(s){
			var defaultOption = s.find('option').eq(0)?s.find('option').eq(0).clone():'';
			s.empty();
			if(defaultOption){
				s.append(defaultOption);
				s.simulateSelectBox();
			}
		}
		
		//索引特效
		//$('#bookIndexZtreeContent')
	});
	
	function validate(){
		var isOriginal = $('#createTeachResourceForm input[name="resourceExtend.isOriginal"]:checked').val();
		if(isOriginal == 'Y'){
			if($('#fileList li[state=success]').size()<=0){
				alert('必须上传文件');
				return false;
			}
			$('#createTeachResourceForm input[name="previewUrl"]').val('');
		}else{
			var previewUrl = $('#createTeachResourceForm input[name="resourceExtend.previewUrl"]').val();
			previewUrl = $.trim(previewUrl);
			/*if(previewUrl == ''){
				alert('必须填写资源地址');
				return false;
			}*/
			$('#fileParam').empty();
		}
		return $('#createTeachResourceForm').validate().form();
	}
	
	function removeImg(a){
		$(a).closest('li').remove();
		$('.imagePicker').show();
	}
	
	function changeUploadType(type){
		if(type == 'file'){
			$('#uploadFileDiv').show();
			$('#urlDiv').hide();
		}else{
			$('#uploadFileDiv').hide();
			$('#urlDiv').show();
		}
	}
	
	function belongDiv(type){
		if(type == 'show'){
			$('#belongDiv').show();
		}else{
			$('#belongDiv').hide();
		}
	}
	
	
	
</script>
</@lo.layout>
