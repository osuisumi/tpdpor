<#include "/tpdpor/common/include/layout.ftl"/>
<#import "/tpdpor/common/tags/image.ftl" as image/>

<#assign jsArray=['${ctx!}/js/common/laypage/laypage.js','${ctx}/js/tpdpor/follow.js','${ctx!}/js/common/ueditorUtils.js','${ctx!}/js/common/ueditor/ueditor.config.js','${ctx!}/js/common/ueditor/ueditor.all.js']/>
<#assign cssArray=[]/>
<@layout jsArray=jsArray cssArray=cssArray mylayer=true validate=true>
	<@expertData id=(expert.id)!>
		<#assign expert=(expertModel)!>
	<div class="g-crm">
		<span class="txt">您当前的位置：</span>
		<a href="${ctx!}/tpdpor/index" class="u-goHome" title="首页"><i class="u-home-ico"></i></a>
		<span class="trg">&gt;</span>
		<a href="${ctx!}/expert">专家列表</a>
		<span class="trg">&gt;</span>
		<em>${(expert.user.realName)!}</em>
	</div>
	<div class="g-frame spc">
	    <div class="g-expert-wrap">
	        <div class="m-expert-info">
	            <span class="img">
	            	<@image.imageFtl url="${(expert.user.avatar)!'' }" default="/images/tpdpor/${app_path!}/defaultAvatar.jpg"/>
	            </span>
	            <div class="name">
	            	<b>${(expert.user.realName)!}</b>
	            	<#if (expert.user.sex)! == '1'>
               			男
               		<#elseif (expert.user.sex)! == '2'>
               			女
               		<#else>
               		</#if>
	            </div>
	            <div class="m-btm">
	                <span><i class="u-ico-user"></i>${(expert.professionalTitle)!}</span>
	                <#-- 
	                <span><i class="u-ico-resource"></i>共享资源：<b>0</b><em>条</em></span>
	                <span><i class="u-ico-like"></i>共享资源：<b>0</b><em>条</em></span>
	                -->
	            </div>
	            <a href="javascript:;" followRelationId="${(expert.user.id)!}" class="u-btn-theme">订阅</a>
	            <#assign hasExpertRole=SecurityUtils.getSubject().hasRole('expert') />
    			<#if hasExpertRole && ((expert.user.id)! == (Session.loginer.id)!)>
		            <a class="u-btn-theme expert" href="javascript:;" onclick="goUpdateExpert('${(expert.id)!}');">修改专家信息</a>
    			</#if>
	        </div>
	        <div class="m-expert-intro" id="m-expert-intro">
	            <h3 class="u-tit">专家简介</h3>
	            <div class="m-txt">
	                <div class="txt-wrap">
	                    <div class="txt-con">
	                        <p>${(expert.researchResult)!}<p>
	                    </div>
	                </div>
	                <a href="javascript:;" class="more">展开更多+</a>
	            </div>
	        </div>
                      
	        <div class="m-expert-project">
	            <h3 class="u-tit">培训项目经历</h3>
	            <div class="m-project-box">
	            	<#-- 
	                <ul class="m-project-lst">
	                    <li>
	                        <i class="u-ico-circle"></i>
	                        <span class="u-date">2015.02.16-2015.02.28</span>
	                        <a href="javascript:;" class="u-txt">广东省韶关市高中教师信息技术能力提升工程  负责信息技术能力与学科融合系列课程讲座,负责信息技术能力与学科融合系列课程讲座</a>
	                    </li>
	                    <div class="u-cover top"></div>
	                    <div class="u-cover bottom"></div>
	                </ul>  
	                --> 
	                ${(expert.trainExperience)!}                             
	            </div>
	        </div>
	    </div>
	</div>
	</@expertData>
	
	<div class="g-frame">
        <div id="train_resource_div" class="g-frame-mn">
        	<script>
				$(function(){
					$('#train_resource_div').load('${ctx!}/train_resource?belong=${(expert.user.id)!}');
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
       <!--  <div class="g-frame-sd">
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
	<a href="javascript:;" followRelationId="${(expert.user.id)!}" class="u-btn-theme follow">订阅</a>
	<a href="javascript:;" followRelationId="${(expert.user.id)!}" class="u-btn-theme unFollow">取消订阅</a>
</div>
	
	<script>
		$(function(){
			//专家简介展开更多
		    openMore();
		    followFn.init('${(Session.loginer.id)!""}','expert',$('.m-expert-info .u-btn-theme'),$('#followModel .follow'),$('#followModel .unFollow'),'','订阅');
			
		    $(".change").on("click",function(){
				var page = parseInt($('#list_train_resource_recommend_form').find('input[name="page"]').val()) + 1;
				
				if($('#train_resource_recommend_div li').size() <= 0){
					page = 1;
				}
				
				$('#list_train_resource_recommend_form').find('input[name="page"]').val(page);
				$.ajaxQuery('list_train_resource_recommend_form','train_resource_recommend_div');
			});
		    
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
		
		function goUpdateExpert(id){
			mylayerFn.open({
		        type: 2,
		        title: '修改专家信息',
		        fix: false,
		        area: [900, 900],
		        offset : [$(document).scrollTop()],
				shadeClose : true,
		        content: '${ctx!}/expert/'+id+'/edit'
		    });
		};
	</script>
</@layout>