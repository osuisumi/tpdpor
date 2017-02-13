<#import '/admin/common/tags/import_file.ftl' as im/>
<form id="importTeachPreviewUrlForm" action="${ctx}/admin/teach_resource/import_preview_url" method="post">
	<@im.importFile submitFunction='importPreviewUrl()' templateName='preview_url.xls'/>
</form>


<script>
	function importPreviewUrl(){
		if($('#fileUrl').val() == null || $('#fileUrl').val() == ''){
			alert('请先选择文件');
			return false;
		}
		$('#importTeachPreviewUrlForm').submit();
	}
</script>
