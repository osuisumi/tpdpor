var textBookUtils = new Object();
textBookUtils.execute = function(options){
	var entryArray = options.entrys.split(',');
	var ctx = options.ctx||'';
	var reload = options.reload||function(){}
	var warp = options.warp||$('');
	//处理stage
	warp.on('click','.textBookBtn',function(){
		var _this = $(this);
		
		_this.siblings('a').removeClass('z-crt');
		_this.addClass('z-crt');
		
		if(_this.attr('name') == 'stage'){
			var params = createParams(_this.attr('value'));
		}else if(_this.attr('name') == 'subject'){
			var params = createParams($('a[name="stage"].z-crt').attr('value'),_this.attr('value'));
		}else if(_this.attr('name') == 'grade'){
			var params = createParams($('a[name="stage"].z-crt').attr('value'),$('a[name="subject"].z-crt').attr('value'),_this.attr('value'));
		}else if(_this.attr('name') == 'version'){
			var params = createParams($('a[name="stage"].z-crt').attr('value'),$('a[name="subject"].z-crt').attr('value'),$('a[name="grade"].z-crt').attr('value'),_this.attr('value'));
		}
		
		reload(params);
	});
}

function getAjaxParam(options,a){
	var param = new Object();
	param.stage = $('a[name="stage"].z-crt').attr('value');
	param.subject = $('a[name="subject"].z-crt').attr('value');
	param.grade = $('a[name="grade"].z-crt').attr('value');
	param.version = $('a[name="version"].z-crt').attr('value');
	
	if(a.attr('name') == 'stage'){
		param.textBookTypeCode = 'SUBJECT,GRADE,VERSION';
		param.stage = a.attr('value');
		param.subject = '';
		param.grade = '';
		param.version = '';
	}else if(a.attr('name') == 'subject'){
		param.textBookTypeCode = 'GRADE,VERSION';
		param.subject = a.attr('value');
		param.grade = '';
		param.version = '';
	}else if(a.attr('name') == 'grade'){
		param.textBookTypeCode = 'VERSION';
		param.grade = a.attr('value');
		param.version = '';
	}
	return param;
}


function createParams(stage,subject,grade,version){
	var params = new Array();
	var p1 = createParam('stage',stage||'');
	var p2 = createParam('subject',subject||'');
	var p3 = createParam('grade',grade||'');
	var p4 = createParam('version',version||'');
	var p5 = createParam('section','');
	params.push(p1);params.push(p2);params.push(p3);params.push(p4);params.push(p5);
	return params;
}

function createParam(name,value){
	var param = new Object();
	param.name = name;
	param.value = value;
	return param;
}