<#import "/tpdpor/common/include/layout.ftl" as layout />
<#import "/tpdpor/common/tags/image.ftl" as image/>
<#assign jsArray=['${ctx!}/js/tpdpor/library/laypage/laypage.js','${ctx!}/js/common/jquery.flexslider-min.js']/>
<#assign cssArray=[]/>
<@layout.layout  jsArray=jsArray cssArray=cssArray mylayer=true>

<div class="g-cont-tab " id="trianResourcePost">
	<#list DictionaryUtils.getEntryList('TRAIN_RESOURCE_POST') as dic>
		<#if dic_index == 0>
			<#assign firstPostVal=(dic.dictValue)!'' />
			<#if (param_post!'') == ''>
				<#assign param_post = (dic.dictValue)!'' />
			</#if>
		</#if>
		<a name="post" href="javascript:;" class="item1 <#if ((param_post!'')=dic.dictValue)> z-crt <#elseif ((param_post!'') == '') && dic_index == 0> z-crt </#if>" value="${(dic.dictValue)!}">${(dic.dictName)!}</a>
	</#list>
</div>
<div class="g-frame spc">
	<div class="g-mn-mod">
		<ul class="m-select-lst case " id="selectLst">
			<script>
				$(function(){
					var post = $('#trianResourcePost a:eq(0)').attr('value');
					$('#selectLst').load('${ctx}/train_resource/queryParam?post='+post);
				});
			</script>
		</ul>
	</div>
</div>
<div class="g-frame">
	<div id="train_resource_div" class="g-frame-mn">
		<script>
			$(function(){
				var post = $('#trianResourcePost a:eq(0)').attr('value');
				$('#train_resource_div').load('${ctx}/train_resource?post='+post);
			});
		</script>
	</div>
	<div class="g-frame-sd">
		<div class="g-sd-tit">
			<h3 class="m-tit1">专家推荐</h3>
			<a href="${ctx!}/expert" class="more" target="_blank">更多&gt;</a>
		</div>
		<div class="g-sd-mod spc">
			<div class="g-expert-info" id="expertInfo">
				<ul class="m-expert-lst slides">
					<@expertsData limit=3>
						<#if (experts)??>
							<#list experts as expert>
								<li>
									<a href="${ctx!}/expert/${(expert.id)}/view" class="block" target="_blank"> 
										<span class="img">
											<@image.imageFtl url="${(expert.user.avatar)!'' }" default="/images/tpdpor/${app_path}/defaultAvatar.jpg"/>
										</span> 
										<span class="name">${(expert.user.realName)!}</span>
										<p class="txt">
											${(expert.professionalTitle)!}
										</p> 
									</a>
								</li>
							</#list>
						</#if>
					</@expertsData>
				</ul>
			</div>
		</div>
	</div>
	<div class="g-frame-sd">
		<div class="g-sd-tit">
			<h3 class="m-tit1">部门推荐</h3>
			<a class="more" href="${ctx!}/division" target="_blank">更多&gt;</a>
		</div>
		<div class="g-sd-mod spc">
			<@divisionsDirective page=1 limit=3 orders='CREATE_TIME.DESC'>
		        <div class="g-workshop-recommend">
		            <ul class="m-workshop-recommend">
			            <#if (divisions)?size>
							<#list divisions as d>
				                <li>
				                    <a class="block" href="${ctx!}/division/${(d.id)!}/view" target="_blank">
				                        <span class="img">
				                        	<@image.imageFtl url="${(d.imageUrl)!}" default="/images/tpdpor/${(app_path)!}/defaultDivision.jpg"/>
				                        </span>
				                        <p class="txt">${(d.name)!}</p>
				                    </a>
				                </li>
			                </#list>
		                </#if>
		            </ul>
		        </div>
	    	</@divisionsDirective>
	    </div>
	</div>
</div>
<script>
	$(function(){
	
		dropDown();
	
		//专家推荐
	    $('#expertInfo').flexslider({
	        animation: "slide",
	        slideshowSpeed: 3000,
	        itemWidth: 300,
	        slideshow: true,
	        prevText: "prev",
	        nextText: "next", 
	        pauseOnHover: true
	    });
	    
		$('#trianResourcePost a').on('click',function(){
			var _this = $(this);
			var v = _this.attr('value');
			var attr = _this.attr('name');
			$('#list_train_resource_form input[name="' + attr + '"]').val(v);
			
			_this.closest('div').find('a').removeClass('z-crt');
			_this.addClass('z-crt');
			
			$('#list_train_resource_form').find('input[name="type"]').val('');
			$('#list_train_resource_form').find('input[name="stage"]').val('');
			$('#list_train_resource_form').find('input[name="subject"]').val('');
			$('#list_train_resource_form').find('input[name="belong"]').val('');
			$('#list_train_resource_form').find('input[name="topic"]').val('');
			$('#list_train_resource_form').find('input[name="page"]').val(1);
			$.ajaxQuery('list_train_resource_form','train_resource_div');
			
			$('#selectLst').load('${ctx}/train_resource/queryParam?post='+v);
			
		});
		
		$(".m-stars i").unbind();
		
	});
	
	function dropDown(){
	    var lst_ul = $("#selectLst"),
	        lst_li = lst_ul.find("li"),
	        lst_li_h = lst_li.height(),
	        btn_more = lst_li.find(".u-more"),
	        btn_slide = $("#slideBtn");
	
	    //判断资源列表高度，如果超过一行，则显示 更多按钮
	    lst_li.each(function(){
	        var _ts = $(this),
	            lst_chk = _ts.find(".chk-lst"),
	            btn_more = _ts.find(".u-more");
	        if(lst_chk.height() > _ts.height()){
	            btn_more.show();
	        }
	    });
	
	    //点击更多，显示全部资源列表
	    btn_more.on("click",function(){
	        var par = $(this).parents("li");
	        $(this).toggleClass("on");
	        if(par.height() == lst_li_h){
	            par.height("auto");
	        }
	        else{
	            par.height(lst_li_h);
	        }
	    });
	
	    //点击收起筛选按钮，资源列表收起
	    btn_slide.on("click",function(){
	        var _ts = $(this);
	
	        if(_ts.hasClass("hide")){
	            _ts.html("展开筛选<i class='u-ico-dp'></i>").removeClass("hide");
	            lst_ul.stop().slideUp();
	        }
	        else{
	            _ts.html("收起筛选<i class='u-ico-dp'></i>").addClass("hide");
	            lst_ul.stop().slideDown();
	        }
	    });
	    
	};
</script>

</@layout.layout>
