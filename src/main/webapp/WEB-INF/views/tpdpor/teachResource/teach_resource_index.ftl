<#import "/tpdpor/common/include/layout.ftl" as layout />
<#assign cssArray=['${ctx}/css/tpdpor/es/zTreeStyle/zTreeStyle.css']/>
<#assign jsArray=['/js/tpdpor/library/laypage/laypage.js','/js/tpdpor/textbook.js','${ctx}/js/common/ztree/js/jquery.ztree.core.min.js']/>
<@layout.layout jsArray=jsArray cssArray=cssArray>
<div class="g-frame">
	<div class="g-frame-mn">
		<div class="g-mn-tit">
			<h2 class="m-tit"><i class="u-ico-res"></i>最新资料</h2>
			<a href="javascript:;" class="m-slide hide" id="slideBtn">收起筛选<i class="u-ico-dp"></i></a>
		</div>
		<div class="g-mn-mod">
			<ul class="m-select-lst" id="selectLst">
				<li>
					<span class="u-type">类型：</span>
					<div id="teach_resource_type" class="chk-lst">
						<#assign extendType = (Request['param_resourceExtendType'])!''>
						<a name="type" value="" href="javascript:;" class="<#if extendType = ''>z-crt </#if>">全部</a>
						<#list DictionaryUtils.getEntryList('TEACH_RESOURCE_TYPE') as ttype>
							<a name="type" class="<#if extendType = ttype.dictValue>z-crt </#if>" value="${(ttype.dictValue)!}" href="javascript:;">${(ttype.dictName)!}</a>
						</#list>
					</div>
					<a href="javascript:;" class="u-more"><i class="u-ico-dp"></i>更多</a>
				</li>
				<li>
					<span class="u-type">学段：</span>
					<div id="stageDiv" class="chk-lst">
						<#assign pstage = param_stage!''>
						<a name="stage" value="" href="javascript:;" class="<#if pstage = ''>z-crt </#if>textBookBtn">全部</a>
						<#list TextBookUtils.getEntryList('STAGE') as stage>
							<a name="stage" class="<#if pstage = stage.textBookValue>z-crt</#if> textBookBtn" value="${(stage.textBookValue)!}" href="javascript:;">${(stage.textBookName)!}</a>
						</#list>
					</div>
					<a href="javascript:;" class="u-more"><i class="u-ico-dp"></i>更多</a>
				</li>
				<li>
					<span class="u-type">学科：</span>
					<div id="subjectDiv" class="chk-lst">
						<#assign psubject = param_subject!''>
						<a name="subject" value="" href="javascript:;" class=" <#if psubject = ''>z-crt</#if> textBookBtn">全部</a>
						<#list TextBookUtils.getEntryList(subjectTextBookParam!) as subject>
							<a name="subject" class="<#if psubject = subject.textBookValue>z-crt</#if> textBookBtn" value="${(subject.textBookValue)!}" href="javascript:;">${(subject.textBookName)!}</a>
						</#list>
					</div>
					<a href="javascript:;" class="u-more"><i class="u-ico-dp"></i>更多</a>
				</li>
				<!--
				<li class="select">
					<span class="u-type">年限：</span>
					<div class="chk-lst">
						<select name="" id="">
							<option value="">所有年限</option>
							<option value="">2016</option>
							<option value="">2015</option>
							<option value="">2014</option>
							<option value="">2013</option>
						</select>
					</div>
				</li>
				-->
			</ul>
			<div id="teach_resource_div">
				<script>
					$(function(){
						$('#teach_resource_div').load('${ctx}/teach_resource?stage=${param_stage!}&subject=${param_subject!}&resourceExtendType=${Request["param_resourceExtendType"]}&orders=${param_orders!"CREATE_TIME.DESC"}&bIndex=${param_bIndex!}&node=${param_node!}');
					});
				</script>
			</div>
		</div>
	</div>
	<div class="g-frame-sd">
		<div class="g-sd-tit">
			<h3 class="m-tit"><i class="u-ico-search"></i>目录检索</h3>
		</div>
		<#import "/tpdpor/teachResource/book_index_tree.ftl" as b/>
		<@b.bIndexTree onclick="function(event,treeId,node){bIndexNodeClick(event,treeId,node)}" defaultNode=param_node!'' />
	</div>
</div>
<script>
	$(function() {
		dropDown();
		textBookUtils.execute({
			entrys:'stage,subject',
			warp:$('#selectLst'),
			reload:function(params){
				$.each(params,function(i,param){
					var formParam = $('#list_teach_resource_form input[name='+param.name+']');
					if(formParam.size()>0){
						formParam.val(param.value);
					}
				});
				$('#list_teach_resource_form input[name="page"]').val(1);
				window.location.href = "${ctx}/teach_resource/index?" + $('#list_teach_resource_form').serialize();
			}
		});
		
		
		$('#teach_resource_type').on('click','a',function(){
			$('#teach_resource_type a').removeClass('z-crt');
			$(this).addClass('z-crt');
			$('#list_teach_resource_form input[name="resourceExtendType"]').val($(this).attr('value'));
			window.location.href = "${ctx}/teach_resource/index?" + $('#list_teach_resource_form').serialize();
		});
	});
	
	function dropDown() {
		var lst_ul = $("#selectLst"), lst_li = lst_ul.find("li"), lst_li_h = lst_li.height(), btn_more = lst_li.find(".u-more"), btn_slide = $("#slideBtn");

		//判断资源列表高度，如果超过一行，则显示 更多按钮
		lst_li.each(function() {
			var _ts = $(this), lst_chk = _ts.find(".chk-lst"), btn_more = _ts.find(".u-more");
			if (lst_chk.height() > _ts.height()) {
				btn_more.show();
			}
		});

		//点击更多，显示全部资源列表
		btn_more.on("click", function() {
			var par = $(this).parents("li");
			$(this).toggleClass("on");
			if (par.height() == lst_li_h) {
				par.height("auto");
			} else {
				par.height(lst_li_h);
			}
		});

		//点击收起筛选按钮，资源列表收起
		btn_slide.on("click", function() {
			var _ts = $(this);
			if (_ts.hasClass("hide")) {
				_ts.html("展开筛选<i class='u-ico-dp'></i>").removeClass("hide");
				lst_ul.stop().slideUp();
			} else {
				_ts.html("收起筛选<i class='u-ico-dp'></i>").addClass("hide");
				lst_ul.stop().slideDown();
			}
		});

	}
	
	function bIndexNodeClick(event,treeId,node){
		var oldSearchIndex = $('#list_teach_resource_form input[name="bIndex"]').val();
		if(oldSearchIndex == node.bIndex){
			$('#list_teach_resource_form input[name="bIndex"]').val('');
			$('#list_teach_resource_form input[name="node"]').val('');
		}else{
			$('#list_teach_resource_form input[name="bIndex"]').val(node.bIndex);
			$('#list_teach_resource_form input[name="node"]').val(node.id);
		}
		window.location.href = "${ctx}/teach_resource/index?" + $('#list_teach_resource_form').serialize();
	}
</script>
</@layout.layout>