function login(){
	window.location.href = '/tpdpor/login?spage='+window.location.href;
}

$(document).ready(function(){

    commonJs.fn.init();
    //点选按钮模拟
    $('.u-choose input').bindCheckboxRadioSimulate();
    //多选按钮模拟
    $('.m-checkbox-tick input').bindCheckboxRadioSimulate();
    //模拟下拉框
    $(".m-selectbox select").simulateSelectBox();
});

var commonJs = $(window).commonJs || {};

commonJs.fn = {
    //初始化
    init : function(){
        var _this = this;
        //自定义下拉框
        _this.drop_down_box();
        //星星等级评价
        //_this.evaluateStat();
        //展开用户评论
        //_this.showComment();
        //ppt文档左右切换
        _this.readDoc();
        //点赞加1
        //_this.sup();
    },
    drop_down_box : function(){
        var $dd_box = $(".m-slt-block1");

        $dd_box.each(function(){
            var _ts = $(this),
                $show_block = _ts.children(".show-txt"),
                $show_txt = $show_block.children(".txt"),
                $lst = _ts.children(".lst"),
                $dd = $lst.children("a"),
                cur = "z-crt",
                readonly="readonly";
            if(_ts.hasClass(readonly)){
                return false;
            }
            //点击按钮选择选项
            $show_block.on("click",function(){
                //判断是否打开
                var $this = $(this);
                if($this.hasClass(cur)){

                    $lst.hide();
                    $this.removeClass(cur);
                }else {
                    $lst.show();
                    $this.addClass(cur);
                }

                //判断是否点击其他地方
                $(document).on("click",function(e){
                    var target = $(e.target);
                    if(target.closest(_ts).length == 0){
                        $lst.hide();
                        $show_block.removeClass(cur);
                    }
                });
                //点击选项关闭
                _ts.on("click",".lst a",function(){
                    $lst.hide();
                    $show_block.removeClass(cur);
                    $show_txt.text($(this).text());
                    $show_txt.attr('value',$(this).attr('value')||'');
                    var input = $show_txt.parent().find('input');
                    if(input.size()>0){
                    	input.eq(0).val($(this).attr('value')||'');
                    }
                    if($(this).closest('dl').size()>0){
                    	$(this).closest('dl').attr('value',$(this).attr('value')||'');
                    }
                    $(this).addClass(cur).siblings().removeClass(cur);
                })
            })

        });

    },
    //星星等级评价
    evaluateStat : function(){
        //鼠标移动上去，星星变亮
        $(document).on('mouseenter','.m-stars i',function(event){
            var _ts = $(this);
            var star = _ts.parent().children('i');
            //判断鼠标移动上去的是第几个
            var indexs = star.index(_ts);
            //阻止冒泡事件
            event.stopPropagation();
            //全部移除再添加
            star.removeClass('z-crt');
            for(var i = 0; i <= indexs; i++){
                star.eq(i).addClass("z-crt");
            }
        });
        //鼠标移除，星星变灰
        $(document).on('mouseleave','.m-stars',function(){
            var _ts = $(this);
            var star = _ts.children('i');

            star.removeClass('z-crt');
        });
        //d点击让星星变亮
        $(document).on('click','.m-stars i',function(){
            var _ts = $(this);
            var star = _ts.parent().children('i');
            //var tips = _ts.siblings('.tips');
            var indexs = star.index(_ts);
            //var tipsTextArr = ['20','40','60','80','100'];
            //var tipsPositionX = [53,74,97,119,141];
            //添加星星
            star.removeClass('z-in');
            for(var i = 0; i <= indexs; i++){
                console.log(indexs);
                star.eq(i).addClass("z-in");
            }
            //修改评分文本
            //tips.show().find('span').text(tipsTextArr[indexs]);
            //修改评分位置
            //tips.show().css("left",tipsPositionX[indexs]);
        });
    },
    showComment : function(){
        $("#commentLst .reply").click(function(){            //展开用户评论
        var _ts = $(this);
        if(_ts.hasClass("z-crt")){
            _ts.removeClass("z-crt");
        }else{
            _ts.addClass("z-crt");
        }
        _ts.parents(".u-btm").next(".g-reply").toggle();
        _ts.parents("li").siblings().find(".g-reply").hide();
        _ts.parents(".li").siblings().find(".reply").removeClass("z-crt");
        });
    },
    readDoc : function(){
        var btn_par = $("#turnPage"),
            prev = btn_par.find(".prev"),
            next = btn_par.find(".next"),
            pic_par = $("#turnPicBox ul"),
            nowP = btn_par.find(".now"),
            length = pic_par.find("li").length,
            page=1,
            v_width=874;
        btn_par.find(".all").html(length);

        next.click(function(){
            if(!pic_par.is(":animated")){
                if(page==length){
                    $(this).css("visible","false");
                }else{
                    pic_par.animate({
                        left:"-="+v_width
                    },500);
                    page++;
                }
            }
            nowP.val("0"+page);
        });

        prev.click(function(){
            if(!pic_par.is(":animated")){
                if(page==1){
                    $(this).css("visible","false");
                }else{
                    pic_par.animate({
                        left:"+="+v_width
                    },500);
                    page--;
                }
            }
            nowP.val("0"+page);
        });

    },
    //点赞加1
    sup : function(){
        var btn = $("#uZan");
        var nowNum = btn.find(".num");
        var n = parseInt(nowNum.text());
        btn.click(function(){
            n++;
            nowNum.text(n);
            $(".addNum").addClass("ant");
            clearTimeout(times);
            var times = setTimeout(function(){
                $(".addNum").removeClass("ant");
            },500);
        });
    }
};
/*--start-----radio单选与checkbox多选按钮的模拟---start---*/
;(function ($) {
    $.fn.bindCheckboxRadioSimulate = function (options) {
        var settings = {
            className: 'on',
            onclick: null,
            checkbox_checked_fn: function (obj) {
                obj.parent().addClass(this.className);
            },
            checkbox_nochecked_fn: function (obj) {
                obj.parent().removeClass(this.className);
            },
            radio_checked_fn: function (obj) {
                obj.parent().addClass(this.className);
            },
            radio_nochecked_fn: function (obj) {
                obj.parent().removeClass(this.className);
            }
        };
        $.extend(true, settings, options);

        //input判断执行
        function inputJudge_fn(obj_this) {
           
            var $this = obj_this,
                $type;
            if ($this.attr('type') != undefined) {
                $type = $this.attr('type');
                if ($type == 'checkbox') {//if=多选按钮
                    if ($this.prop("checked")) {
                        settings.checkbox_checked_fn($this);
                    } else {
                        settings.checkbox_nochecked_fn($this);
                    }
                } else if ($type == 'radio') {//if=单选按钮
                    var $thisName;
                    if ($this.attr('name') != undefined) {
                        $thisName = $this.attr('name');
                        if ($this.prop("checked")) {
                            settings.radio_checked_fn($this);
                            $("input[name='" + $thisName + "']").not($this).each(function () {
                                settings.radio_nochecked_fn($(this));
                            });
                        } else {
                            settings.radio_nochecked_fn($this);
                        }
                    }
                }
            }
        }
        return this.each(function () {
            inputJudge_fn($(this));
        }).click(function () {
            inputJudge_fn($(this));
            if (settings.onclick) {
                settings.onclick(this, {
                    isChecked: $(this).prop("checked"),//返回是否选中
                    objThis: $(this)//返回自己
                });
            }
        });
    };
})(jQuery);
/*--end-----radio单选与checkbox多选按钮的模拟---end---*/

/*--start-----下拉多选款select按钮模拟---start---*/
(function ($) {
    $.fn.simulateSelectBox = function (options) {
        var settings = {//默认参数
            selectText: '.simulateSelect-text',
            byValue: null
        };
        //$.extend(true, settings, options);
        var options = $.extend(true,settings,options),
            _ts = this,
            selectText = options.selectText, //下拉框模拟文字class
            byValue = options.byValue;  //传入value值，重置默认选中


        return _ts.each(function(){
            var $this = $(this);
            //清除其他选中
            $this.find('option').prop('selected',false);
            //alert($this.find('option:selected').text());
            //判断是否传入value值
            if(byValue == "" || byValue == null || byValue == undefined){
                $this.find('option').eq(0).prop('selected',true);
            }else {
                //console.log(byValue);
                //编辑选项，匹配传入的value值
                for(var i = 0; i < $this.find('option').length; i++){
                    if($this.find('option').eq(i).val() == byValue) {
                        //设置传入的value值选项为默认选中
                        $this.find('option').eq(i).prop('selected',true);
                    }
                }
            }
            //改变模拟下拉框的文字
            $this.parent().find(selectText).text($this.find('option[selected="selected"]').text());
            $this.parent().find(selectText).text($this.find('option:selected').text());
        //点击下拉改变
        }).on('change',function(){
            //改变模拟下拉框的文字
            $(this).parent().find(selectText).text($(this).find('option:selected').text());
        });

    };
})(jQuery);
/*--end-----下拉多选款select按钮模拟---end---*/