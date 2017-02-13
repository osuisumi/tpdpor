<#include "/tpdpor/common/include/layout.ftl"/>
<#import "/tpdpor/common/tags/image.ftl" as image/>

<#assign jsArray=['${ctx!}/js/common/laypage/laypage.js',"${ctx}/js/tpdpor/follow.js"]/>
<#assign cssArray=[]/>
<@layout jsArray=jsArray cssArray=cssArray>
	<@divisionDirective id=(division.id)!>
		<#assign division=(divisionModel)!>
       	<div class="g-crm">
           	<span class="txt">您当前的位置：</span>
           	<a href="${ctx!}/tpdpor/index" class="u-goHome" title="首页"><i class="u-home-ico"></i></a>
           	<span class="trg">&gt;</span>
           	<a href="${ctx!}/division">教学部门</a>
           	<span class="trg">&gt;</span><em>${(division.name)!}</em>
		</div>
           <div class="g-frame spc">
            <div class="g-expert-wrap">
                <div class="m-expert-info workshop" id="m-expert-intro">
                    <h2 class="u-tt">${(division.name)!}</h2>
                    <div class="m-btm">
                        <#-- <span><i class="u-ico-resource"></i>共享资源：<b>1568</b><em>条</em></span>
                        <span><i class="u-ico-like"></i>共享资源：<b>1568</b><em>条</em></span> -->
                    </div>
                    <div class="m-txt">
		                <div class="txt-wrap">
		                    <div class="txt-con">
		                        <p>${(JsonMapper.getJsonMapValue(division.summary, 'content'))!}<p>
		                    </div>
		                </div>
		                <a href="javascript:;" class="more">展开更多+</a>
		            </div>
                    <a href="javascript:;" followRelationId="${(division.id)!}" class="u-btn-theme">订阅</a>
                </div>
            </div>
        </div>
	</@divisionDirective>
	
	<div class="g-frame">
	    <div id="train_resource_div" class="g-frame-mn">
	    	<script>
				$(function(){
					$('#train_resource_div').load('${ctx!}/train_resource?belong=${(division.id)!}');
				});
			</script>
	    </div>
	    <div class="g-frame-sd">
	        <div class="g-sd-tit">
	            <h3 class="m-tit1">猜您喜欢</h3>
	            <a href="javascript:;" class="change"><i class="u-ico-turn"></i>换一批</a>
	        </div>
	        <div id="resource_recommend_div" class="g-sd-mod spc">
				<script>
					$(function(){
						$('#resource_recommend_div').load('${ctx!}/train_resource/recommendResource?limit=3&page=1');
					});
				</script>
	        </div>
	    </div>
	 <#--    <div class="g-frame-sd">
	        <div class="g-sd-tit">
	            <h3 class="m-tit1">专家热门资源</h3>
	            <a href="javascript:;" class="change"><i class="u-ico-turn"></i>换一批</a>
	        </div>
	        <div class="g-sd-mod spc">
	            <ul class="m-file-lst">
	                <li>
	                    <a href="javascript:;" class="block">
	                        <i class="u-file-type pdf"></i>
	                        <h4 class="u-tit">C语言程序设计</h4>
	                        <span class="u-tips">125人下载</span>
	                        <div class="u-btm">
	                            <div class="m-stars">
	                                <i class="u-small-star full"></i>
	                                <i class="u-small-star full"></i>
	                                <i class="u-small-star full"></i>
	                                <i class="u-small-star null"></i>
	                                <i class="u-small-star null"></i>
	                            </div>
	                        </div>
	                    </a>
	                </li>
	            </ul>
	        </div>
	    </div>
	    <div class="g-frame-sd">
	        <div class="g-sd-tit">
	            <h3 class="m-tit1">浏览记录</h3>
	            <a href="javascript:;" class="change"><i class="u-ico-del"></i>清除记录</a>
	        </div>
	        <div class="g-sd-mod spc">
	            <ul class="m-file-lst">
	                <li>
	                    <a href="javascript:;" class="block">
	                        <i class="u-file-type ppt"></i>
	                        <h4 class="u-tit">C语言程序设计</h4>
	                        <span class="u-tips">125人下载</span>
	                        <div class="u-btm">
	                            <div class="m-stars">
	                                <i class="u-small-star full"></i>
	                                <i class="u-small-star full"></i>
	                                <i class="u-small-star full"></i>
	                                <i class="u-small-star null"></i>
	                                <i class="u-small-star null"></i>
	                            </div>
	                        </div>
	                    </a>
	                </li>
	            </ul>
	        </div>
	    </div> -->
	</div>
<div id="followModel" style="display:none">
	<a href="javascript:;" followRelationId="${(resource.id)!}" class="u-btn-theme follow">订阅</a>
	<a href="javascript:;" followRelationId="${(resource.id)!}" class="u-btn-theme unFollow">取消订阅</a>
</div>	
	<script>
		$(function(){
		    openMore();
		    followFn.init('${(Session.loginer.id)!""}','division',$('.workshop .u-btn-theme'),$('#followModel .follow'),$('#followModel .unFollow'),'','订阅');
		});
		
		function openMore(){
		    var info = $("#m-expert-intro"),
		        wrap = info.find(".txt-wrap"),
		        wrap_h = wrap.height(),
		        con = info.find(".txt-con"),
		        btn = info.find(".more");

		    if(con.height() > wrap.height()){
		        btn.show().addClass("open");
		    }

		    btn.on("click",function(){
		        var _ts = $(this);
		        if(_ts.hasClass("open")){
		            wrap.css("height","auto");
		            _ts.removeClass("open").text("收起");
		        }
		        else{
		            wrap.height(wrap_h);
		            _ts.addClass("open").text("展开更多+");
		        }
		    });
		};
	</script>
</@layout>