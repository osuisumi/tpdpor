(function($){
	$.fileUploader = function(element,config){
		this.element = element;
		this.config = config;
		this.config.accept = config.accept||{};
		this.ctx = config.ctx||$('#ctx').val()||'';
		this.serverUrl = config.serverUrl||this.ctx + '/file/uploadTemp';
		this.init();
		var _this = this;
	};
	
	var $cU = $.fileUploader;
	
	$cU.fn = $cU.prototype = {
		version:'0.0.1'
	};
	
	$cU.fn.extend = $cU.extend = $.extend;
	
	$cU.fn.extend({
		init:function(){
			var _this = this;
    		var uploader = WebUploader.create({
    			pick : {
    				id:_this.element,
    			},
        		swf : _this.ctx + '/js/common/webuploader/Uploader.swf',
        		server : _this.serverUrl,
        		resize : true,
        		duplicate : true,
        		fileNumLimit : _this.config.fileNumLimit||10,
        		fileSingleSizeLimit:1048576000,
        		accept : {
        		    extensions: _this.config.accept.extensions||'',
        		}
        	});
        	_this.uploader = uploader;
        	// 当有文件被添加进队列的时候
        	uploader.on('fileQueued', function(file) {
        		if(_this.config.fileQueued){
        			_this.config.fileQueued(file,_this.uploader);
        		}
        		uploader.upload();
        	});
        	// 文件上传过程中创建进度条实时显示。
        	uploader.on('uploadProgress', function(file, percentage) {
        		if(_this.config.uploadProgress){
        			_this.config.uploadProgress(file,percentage);
        		}
        	});
        	uploader.on('uploadSuccess', function(file, response) {
        		if(_this.config.uploadSuccess){
        			_this.config.uploadSuccess(file,response);
        		}
        	});
        	uploader.on('uploadError', function(file) {
        		if(_this.config.uploadError){
        			_this.config.uploadError(file);
        		}
        	});
        	uploader.on('uploadComplete', function(file) {
        		if(_this.config.uploadComplete){
        			_this.config.uploadComplete(file);
        		}
        	});
        	uploader.on('error', function(type) {
        		if (type == 'Q_TYPE_DENIED') {
        			alert('请检查上传的文件类型');
        		}
        		if(type == 'Q_EXCEED_NUM_LIMIT'){
        			alert('超出个数限制');
        		}
        		if(type == 'Q_EXCEED_SIZE_LIMIT'){
        			alert('文件总大小超出限制');
        		}
        		if(type == 'F_EXCEED_SIZE'){
        			alert('单个文件大小超出限制');
        		}
        	});
		},
		
	});
	
	
	$.fn.createUploader = function(config){
		var cU = new $cU($(this),config||new Object());
		return cU;
	};
})(jQuery);

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
}


function getFileType(fileName,nameFormat){
		var _nameFormat = nameFormat||{};
		var nameMap = new Object();
		nameMap.doc = _nameFormat.doc||'doc';
		nameMap.excel = _nameFormat.excel||'excel';
		nameMap.ppt = _nameFormat.ppt||'ppt';
		nameMap.pdf = _nameFormat.pdf||'pdf';
		nameMap.txt = _nameFormat.txt||'txt';
		nameMap.zip = _nameFormat.zip||'zip';
		nameMap.pic = _nameFormat.pic||'pic';
		nameMap.video = _nameFormat.video||'video';
		
		var $names = fileName //文件名字
        var strings = $names.split(".");
        var s_length = strings.length;
        var suffix = strings[s_length -1];
        if(s_length == 1){
           return ''
        }else {
            if(suffix == "doc" || suffix == "docx"){
            	return nameMap.doc;
            }else if(suffix == "xls" || suffix == "xlsx"){
            	return nameMap.excel;
            }else if(suffix == "ppt" || suffix == "pptx"){
            	return nameMap.ppt;
            }else if(suffix == "pdf"){
            	return nameMap.pdf;
            }else if(suffix == "txt"){
            	return nameMap.txt;
            }else if(suffix == "zip" || suffix == "rar"){
            	return nameMap.zip;
            }else if(suffix == "jpg" || suffix == "jpeg" || suffix == "png" || suffix == "gif"){
            	return nameMap.pic;
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
            	return nameMap.video;
            }else {
            	return 'other';
            }
        }
}

