<#macro function>
	<form id="downloadFileForm" action="/file/downloadFile" method="post" target="_blank">
		<input type="hidden" name="id">
		<input type="hidden" name="fileName">
		<input type="hidden" name="fileRelations[0].type"> 
		<input type="hidden" name="fileRelations[0].relation.id"> 
	</form>
	<form id="updateFileForm" target="_blank">
		<input type="hidden" name="id">
		<input type="hidden" name="fileName">
	</form>
	<form id="deleteFileRelationForm" target="_blank">
		<input type="hidden" name="fileId">
		<input type="hidden" name="relation.id">
		<input type="hidden" name="type">
	</form>
	<form id="deleteFileInfoForm" target="_blank">
		<input type="hidden" name="id">
	</form>
	<form id="searchForm" action="${ctx}/search" method="get">
		<input type="hidden" name="searchKeywords">
		<input type="hidden" name="searchType">
	</form>
	
	<form id="downloadExcelForm" action="${ctx }/excel/downloadExcel" target="_blank" method="post">
		<input type="hidden" name="fileName"> 
	</form>
	
	<script>
		function downloadFile(id, fileName, type, relationId) {
			$('#downloadFileForm input[name="id"]').val(id);
			$('#downloadFileForm input[name="fileName"]').val(fileName);
			$('#downloadFileForm input[name="fileRelations[0].type"]').val(type);
			$('#downloadFileForm input[name="fileRelations[0].relation.id"]').val(relationId);
			//goLogin(function(){
				$('#downloadFileForm').submit();
			//});
		}
	
		function updateFile(id, fileName) {
			$('#updateFileForm input[name="id"]').val(id);
			$('#updateFileForm input[name="fileName"]').val(fileName);
			$.post('/file/updateFileInfo.do', $('#updateFileForm').serialize());
		}
	
		function deleteFileRelation(fileId, relationId, relationType, successFn) {
			$('#deleteFileRelationForm input[name="fileId"]').val(fileId);
			$('#deleteFileRelationForm input[name="relation.id"]').val(relationId);
			$('#deleteFileRelationForm input[name="type"]').val(relationType);
			$.post('/file/deleteFileRelation.do', $('#deleteFileRelationForm').serialize(), function(data){
				if(data.responseCode == '00'){
					if(successFn != undefined){
						if (! $.isFunction(successFn)) {
							successFn = eval('(' + successFn + ')');
						}
						successFn();
					}
				}
			});
		}
	
		function deleteFileInfo(fileId) {
			$('#deleteFileInfoForm input[name="id"]').val(fileId);
			$.post('/file/deleteFileInfo.do', $('#deleteFileInfoForm').serialize());
		}
	
		function createAttitude(relationId, type, attitude, callbackFn){
			if(!attitude){
				var attitude = 'support';
			}
			$.post("/attitudes",{
				"attitude":attitude,
				"relation.id":relationId,
				"relation.type":type
			},function(response){
				if(response.responseCode == '00'){
					if(callbackFn != undefined){
						var $callback = callbackFn;
						if (! $.isFunction($callback)) $callback = eval('(' + callback + ')');
						$callback();
					}
				}else{
					alert('已赞过');
				}
			})
		}
	
		function createFollow(followId, type, successFn, failFn){
			$.post("/follows",{
				"followEntity.id":followId,
				"followEntity.type":type
			},function(response){
				if(response.responseCode == '00'){
					if(successFn != undefined){
						if (! $.isFunction(successFn)) {
							successFn = eval('(' + successFn + ')');
						}
						successFn();
					}
				}else{
					if(failFn != undefined){
						if (! $.isFunction(failFn)) {
							failFn = eval('(' + failFn + ')');
						}
						failFn();
					}
				}
			})
		}
		
		function previewFile(fileId,downloadFunction){
			mylayerFn.open({
				id: 'previewFileDiv',
		        type: 2,
		        title: '预览文件',
		        fix: true,
		        area: [$(window).width() * 99 / 100, $(window).height() * 99 / 100],
		        content: '${ctx}/tpdpor/file/previewFile?fileId='+fileId+'&downloadFunction='+downloadFunction,
		        shadeClose: true
		    });
		}
		
		function doSearch(){
			var keywords = $('#searchKeywords').val();
			if(!keywords){
				alert('请输入关键字再进行搜索');
				return false;
			}else{
				keywords = keywords.trim();
				if(keywords == ''){
					alert('请输入关键字再进行搜索');
					return false;
				}
				$('#searchForm input[name="searchKeywords"]').val($('#searchKeywords').val());
				$('#searchForm input[name="searchType"]').val($('#searchType').val());
				$('#searchForm').submit();
			}
		}
	</script>
</#macro>