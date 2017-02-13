function initUploadFileInfoRemote(data, uploadBtn, successFn) {
	var uploader = WebUploader.create({
		swf : '/common/js/webuploader/Uploader.swf',
		server : '/file/uploadFileInfoRemote?' + data,
		pick : uploadBtn,
		resize : true
	});
	// 当有文件被添加进队列的时候
	uploader.on('fileQueued', function(file) {
		uploader.upload();
		ajaxLoading();
	});
	// 文件上传过程中创建进度条实时显示。
	uploader.on('uploadProgress', function(file, percentage) {

	});
	uploader.on('uploadSuccess', function(file, response) {
		if (response != null && response.responseCode == '00') {
			if (successFn != undefined) {
				if (!$.isFunction(successFn)){
					successFn = eval('(' + successFn + ')');
				}
				successFn(file, response);
			}
		}
		ajaxEnd();
	});
	uploader.on('uploadError', function(file) {
		alert('上传出错');
		ajaxEnd();
	});
	uploader.on('error', function(type) {
		if (type == 'Q_TYPE_DENIED') {
			alert('不支持该类型的文件');
		}
		ajaxEnd();
	});
}