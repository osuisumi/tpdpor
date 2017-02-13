<#assign subfix=FileUtils.getFileSuffix(fileInfo.url) downloadFunction=param_downloadFunction!"downloadPreviewFile()">
<div style="text-align: center; height: 100%">
	<#if ['doc', 'docx', 'ppt', 'pptx', 'xls', 'xlsx', 'txt']?seq_contains(subfix)>
		<iframe src="${FileUtils.getPreviewPath(fileInfo.url) }" width='100%' height='100%' frameborder='0'>
		</iframe>
    <#elseif ['pdf']?seq_contains(subfix)>
    <a href="javascript:;" class="u-full-screen" id="fullScreen"></a>
    <div class="video-frame-wrap" style="height:700px;">
        <div id="pdfwrap" style="width:100%;height:700px;">
                               
        </div>
        <i class="ico-close"></i>
    </div>
    <script>
  		//加载pdf
   		PDFObject.embed('${FileUtils.getFileUrl(fileInfo.url)}', "#pdfwrap",{forcePDFJS:true,PDFJS_URL:"${FileUtils.getFileUrl(fileInfo.url)}"});
    </script>
	<#elseif ['flash', 'webm', 'mp4', 'flv', 'ogg', 'hls']?seq_contains(subfix)>
		<div id="player" style="height: 100%"></div>
		<script>
			var url = '${FileUtils.getFileUrl("")}${fileInfo.url}';
			var container = document.getElementById("player");
			var api = flowplayer(container, {
				autoplay: true,		
			    clip: {
			        sources: [
						{
							type: "video/flash",
							src:  url
						},
			        	{ 
			            	type: "video/webm",
			                src:  url 
			            },
			            {
			            	type: "video/mp4",
			                src:  url 
			            }
			        ]
			    }
			});
		</script>
	<#elseif ['jpg', 'jpng', 'png', 'gif', 'bmp']?seq_contains(subfix)>	
		<img src="${FileUtils.getFileUrl('')}${fileInfo.url}">
	<#else>	
		<div class="un-preview" style="display: block; height: 100%">
            <div class="m-point-pic">
                <p class="txt">系统无法支持该格式的在线预览，您可以进行以下操作:</p>
                <div class="m-addElement-btn">
                    <a href="javascript:void(0);"  class="btn u-inverse-btn mylayer-cancel">关闭</a>
                    <a onclick=${downloadFunction} href="javascript:void(0);" class="btn u-main-btn u-cancelLayer-btn">下载文件</a>
                </div>                 
            </div>       
        </div>
	</#if>
</div>

<script>
	function downloadPreviewFile(){
		downloadFile('${fileInfo.id}', '${fileInfo.fileName}');
	}
	
</script>