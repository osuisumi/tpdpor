String.prototype.trim= function(){  
    return this.replace(/(^\s*)|(\s*$)/g, "");  
};
$.extend({
	ajaxQuery:function(formId,divId,callback,type){
		if(type == null || type == ''){
			type = 'get';
		}
		$.ajax({
			url:$("#"+formId).attr("action"),
			data:$("#"+formId).serialize(),
			type:type,
			beforeSend:function(){
				ajaxLoading();
			},
			success:function(data){
				$("#"+divId).html(data);
				if(callback!=undefined){
					var $callback = callback;
					if (! $.isFunction($callback)) $callback = eval('(' + callback + ')');
					$callback();
				}
			},
			complete:function(){
				ajaxEnd();
			}
		});		
	},
	ajaxSubmit:function(formId){
		var data = $("#"+formId).serialize();
		var method = $("#"+formId).attr("method");
		if (method == 'delete' || method == 'DELETE' || method == 'put' || method == 'PUT') {
			data = '_method='+method+'&'+data;
		}
		var rData = $.ajax({
			url:$("#"+formId).attr("action"),
			data:data,
			type:'post',
			async:false,
			beforeSend:function(){
				ajaxLoading();
			},
			success:function(data){
				 
			},
			complete:function(){
				ajaxEnd();
			}
		}).responseText;
		return rData;
	},
	ajaxDelete:function(url, data, callback){
		$.ajax({
			url:url,
			type:'post',
			data:'_method=DELETE&'+data,
			beforeSend:function(){
				ajaxLoading();
			},
			success:function(data){
				if(callback!=undefined){
					var $callback = callback;
					if (! $.isFunction($callback)) $callback = eval('(' + callback + ')');
					$callback(data);
				}
			},
			complete:function(){
				ajaxEnd();
			}
		});
	},
	put:function(url, data, callback){
		$.ajax({
			url:url,
			type:'post',
			data:'_method=PUT&'+data,
			beforeSend:function(){
				ajaxLoading();
			},
			success:function(data){
				if(callback!=undefined){
					var $callback = callback;
					if (! $.isFunction($callback)) $callback = eval('(' + callback + ')');
					$callback(data);
				}
			},
			complete:function(){
				ajaxEnd();
			}
		});
	}
});

function reloadWindow(){
	window.location.reload();
}

function assignParam(formId,objectId){
	$.each($('#'+formId+' :input'),function(){
		$(this).val($('#'+$(this).attr('id')+'_'+objectId).text());
	});
}

function checkAllBox(formId, obj){
	$(obj).click(function(){
		if($(this).prop("checked")){
			$('#'+formId+' :checkbox').each(function(){
				$(this).prop("checked",true);			
			});
		}else{
			$('#'+formId+' :checkbox').each(function(){
				$(this).prop("checked",false);			
			});
		}
	});
}

function checkedBoxNum(formId,checkboxName){
	var checkedBox = $("#"+formId+" input[name="+checkboxName+"]:checked");
	return checkedBox.length;
}

function getCheckedboxValues(formId,checkboxName,num){
	var checkedbox = $("#"+formId+" input[name="+checkboxName+"]:checked");
	var values="";
	if(num!=undefined){
		if(checkedbox.length>num){
			alert("只允许选择"+num+"条记录进行操作")
			return "";
		}else if(checkedbox.length==0){
			alert("未选中任何记录！");
			return "";
		}		
		if(num==1){
			return checkedbox[0].value;
		}
	}
	if(checkedbox.length>0){
		for(i=0;i<checkedbox.length;i++){
			values+=checkedbox[i].value;
			if(i<checkedbox.length-1){
				values+=",";
			}
		}
	}
	return values;
}

//txt:鏂囨湰妗唈query瀵硅薄
//limit:闄愬埗鐨勫瓧鏁�
//isbyte:true:瑙唋imit涓哄瓧鑺傛暟锛沠alse:瑙唋imit涓哄瓧绗︽暟
//cb锛氬洖璋冨嚱鏁帮紝鍙傛暟涓哄彲杈撳叆鐨勫瓧鏁�
function initLimit(txt,limit,isbyte,cb){
	txt.keyup(function(){
		var str=txt.val();
		var charLen;
		var byteLen=0;
		if(isbyte){
			for(var i=0;i<str.length;i++){
				if(str.charCodeAt(i)>255){
					byteLen+=2;
				}else{
					byteLen++;
				}
			}
			charLen = Math.floor((limit-byteLen)/2);
		}else{
			byteLen=str.length;
			charLen=limit-byteLen;
		}
		cb(charLen);
	});	
}

function guid(){
	var guid = (G() + G() + "" + G() + "" + G() + "" + 
			G() + "" + G() + G() + G()).toUpperCase();
	return guid;
}
function G() {
	return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
}

function hintJumpLayer(){
	$('.hint-blackbg').show();
	var layer = $('.g-hint-layer');
	var width = layer.innerWidth(),
    height = layer.innerHeight();
    layer.show().css({'margin-top':-height/2+'px','margin-left':-width/2+'px'});
}

window.alert = function(txt, confirmFn, time){
	//layer.alert(txt, confirmFn);
	if(time == null || time == ''){
		time = 1500;
	}
	mylayerFn.msg(txt, {time: time}, confirmFn);
};

window.confirm = function(txt, confirmFn, cancelFn){
	mylayerFn.confirm({
        title: '提示',
        content: txt,
        icon: 6,
        yesFn : function(){
            ok();
        },
        cancelFn : function(){
           cancel();
        }
    });
	this.cancel = function(obj){
		if(cancelFn!=undefined){			
			var $callback = cancelFn;
			if (! $.isFunction($callback)){
				$callback = eval('(' + callback + ')');
			} 
			$callback();
		}
		return false;
	};
	this.ok = function(obj){
		if(confirmFn!=undefined){
			var $callback = confirmFn;
			if (! $.isFunction($callback)){
				$callback = eval('(' + callback + ')');
			} 
			$callback();
		}
		return true;
	};
};

function getByteLength(value){
	var length = value.trim().length; 
    for(var i = 0; i < value.length; i++){      
        if(value.charCodeAt(i) > 127){      
        	length = length+2;      
        }      
    }
    return length;
}

function getSuffix(fileName){
	var index = fileName.lastIndexOf(".");
	return fileName.substring(index+1,fileName.length);
}

function getOuterHtml(obj) {
    var box = $('<div></div>');
    for (var i = 0; i < obj.length; i ++) {
        box.append($(obj[i]).clone());
    }
    return box.html();
}

/*--start----多个同类名选项卡----start---*/
$.fn.extend({
    myTab : function(options)
    {
        var defaults = 
        {
            pars    : '.myTab',   //最外层父级
            tabNav  : '.tabNav',  //标签导航
            li      : 'li',       //标签
            tabCon  : '.tabCon',  //区域父级
            tabList : '.tabList', //t区域模块
            cur     : 'cur',      //选中类
            eType   : 'click',    //事件
            page    : 0 //默认显示第几个模块
        }
        var options = $.extend(defaults,options),
        _ts = $(this),
        tabBtn  = _ts.find(options.tabNav).find(options.li);
        tabList  = _ts.find(options.tabCon).find(options.tabList);
        this.each(function(){
            tabBtn.removeClass(options.cur);
            tabBtn.eq(options.page).addClass(options.cur);
            tabList.hide();
            tabList.eq(options.page).show();
            tabBtn.eq(options.page).show();
            tabBtn.on(options.eType,function(){
                var index = $(this).parents(options.tabNav).find(options.li).index(this);
                $(this).addClass(options.cur).siblings().removeClass(options.cur);
                $(this).parents(options.pars).find(options.tabCon).find(options.tabList).eq(index).css({'display':'block'}).siblings().css({'display':'none'});
            })
        })
        return this;
    }
});
/*--end-----多个同类名选项卡---end---*/

function ajaxLoading(){
    mylayerFn.loading({
        id: 999,
        content: '正在加载中...',
        shade: [0.4,"#ccc"]
    });
}

function ajaxEnd(){
	 mylayerFn.close(999);
}