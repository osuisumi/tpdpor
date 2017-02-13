<#assign formId = 'updateCteativeAgreementForm'>
<#import "/admin/common/include/form_layer.ftl" as fl>
	<@fl.form id="${formId!}" action="${ctx!}/tpdpor/admin/creative/agreement" method="put" confirmTxt="保存" onConfirm="saveForm()"	cancelTxt="取消" showBtn=true>
	<@filesDirective relationId = "creative" type="creative_apply_agreement">
	<div class="g-layer-box">
	    <form action="" method="post" id="commentForm">   
	        <ul class="mis-ipt-lst">
	            <li class="item">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>附件：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="m-pbMod-udload">
	                            <a id="agreementPicker" href="javascript:void(0);" class="mis-opt-upbtn mis-inverse-btn"><i class="mis-upload-ico"></i>上传文件</a>
	                        </div>
	                        <ul class="mis-sfile-lst" id="agreementFileIndoUl">
	                        	<#if fileInfos??>
									<#list fileInfos as fileInfo>
			                            <li id="${(fileInfo.id)!}">
			                                <i class="mis-sfile-ico ${FileTypeUtils.getFileTypeClass(file.fileName, 'suffix') }"></i>
			                                <a href="javascript:void(0);" class="name" title="${(fileInfo.fileName)!}">${(fileInfo.fileName)!}</a>
			                                <span class="size">${FileSizeUtils.getFileSize((fileInfo.fileSize)!)}</span>
			                                <a href="javascript:void(0);" class="dlt"><i class="mis-delete-ico1"></i>删除</a>
			                            </li>
	                              	</#list>
								</#if>
	                        </ul>
	                    </div>
	                </div>
	            </li>
	        </ul>
	        <span id="fileParam">
				<#if fileInfos??>
					<#list fileInfos as fileInfo>
						<input type="hidden" name="resources[0].fileInfos[${fileInfo_index}].id" value="${fileInfo.id}">
						<input type="hidden" name="resources[0].fileInfos[${fileInfo_index}].fileName" value="${(fileInfo.fileName)!}">
						<input type="hidden" name="resources[0].fileInfos[${fileInfo_index}].url" value="${(fileInfo.url)!}">
					</#list>
				</#if>
			</span>
	    </form>
	</div>
	
	<div style="display:none">
		<li id="fileModel" >
			<i class="mis-sfile-ico"></i>
			<a href="javascript:void(0);" class="name" title="">二元二次方程教学方案.doc</a>
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
	
	<script>
		$(function(){
			$('#${formId!}').on('click','a.dlt',function(){
				$(this).closest('li').remove();
				$('#fileList').empty();
			});
			
			//上传附件按钮
			var uploader = $('#agreementPicker').createUploader({
				//fileNumLimit:1,
				fileQueued:function(file){
					var li = $('#fileModel').clone();
					$(li).attr('id',file.id);
					$(li).find('.name').text(file.name);
					$(li).find('.size').text(getFileSize(file.size));
					$(li).find('.mis-sfile-ico').addClass(getFileType(file.name));
					//单个上传，清空上一次
					$('#agreementFileIndoUl').empty();
					$('#agreementFileIndoUl').append(li);
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
						$('#fileParam').append('<input type="hidden" name="resources[0].fileInfos[0].id" value="'+fileInfo.id+'">');
						$('#fileParam').append('<input type="hidden" name="resources[0].fileInfos[0].fileName" value="'+fileInfo.fileName+'">');
						$('#fileParam').append('<input type="hidden" name="resources[0].fileInfos[0].url" value="'+fileInfo.url+'">');
						$('#' + file.id).find('.mis-pbar').addClass('finish');
						$('#' + file.id).attr('state','success');
						$('#' + file.id).find('.mis-pbar .bar-txt').text('上传完成');
					}
				}
			});
		});
		
	</script>
	</@filesDirective>
</@fl.form>
