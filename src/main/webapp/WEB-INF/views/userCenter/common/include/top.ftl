<div class="g-header-frame">
	<div class="g-hd">
	    <div class="g-auto">
	        <div class="m-logo">
	            <h1><a href="${ctx}/tpdpor/index"><img alt="教师专业发展在线资源平台" src="/images/tpdpor/${app_path}/logo.png"><span>教师专业发展在线资源平台</span></a></h1>
	        </div>
	        <div class="m-search style1">
	            <input id="searchKeywords" type="text" value="${(param_searchKeywords)!}" class="ipt" placeholder="输入资源名称">
	            <input type="hidden" id="searchType" value="${(param_searchType)!}">
	            <div class="slt">
	            	<#if (param_searchType!'') == 'teach'>
                		<#assign typeShowName = '教研资料'/>
                	<#elseif (param_searchType!'') == 'course'>
                		<#assign typeShowName = '课程案例'/>
                	<#elseif (param_searchType!'') == 'train_resource' >
                		<#assign typeShowName = '培训学习'/>
                	<#elseif (param_searchType!'') == 'creative'>
                		<#assign typeShowName = '教师创客'/>
                	<#else>
                		<#assign typeShowName = '全库搜索'/>
                	</#if>
	                <strong><span>全库搜索</span><i class="ico"></i></strong>
	                <div class="lst">
	                    <a value="" href="javascript:;" class="z-crt">全库搜索</a>
                        <a value="teach" href="javascript:;">教研资料</a>
                        <a value="course" href="javascript:;">课程案例</a>
                        <a value="train_reosurce" href="javascript:;">培训学习</a>
                        <a value="creative" href="javascript:;">教师创客</a>
	                </div>
	            </div>
	            <a class="submit" onclick="doSearch();" href="javascript:;">搜索</a>
	        </div>
	    </div>
	</div>
	<div class="g-menu">
	    <div class="g-auto">
	        <ul class="m-menu tab-menu">
	            <li class="index"><a href="${ctx}/tpdpor/index">首页</a></li>
                <li class="teach"><a href="${ctx}/teach_resource/index">教研资料</a></li>
                <li class="course"><a href="${ctx}/course_resource/index">课程案例</a></li>
                <li class="train"><a href="${ctx}/train_resource/index">培训学习</a></li>
                <li class="creative"><a href="${ctx}/creative/index">教师创客</a></li>
	        </ul>
	        <ul class="m-us-opt">
	            <li>
	                <a class="u-message" href="${ctx}/userCenter/message?orders=CREATE_TIME.DESC"><i class="u-mail-ico"></i><#-- <i class="has"> --></i></a>
	            </li>
	            <li class="u-uOpt">
	                <a class="u" href="${ctx!}/userCenter">
	                	<#import "/tpdpor/common/tags/image.ftl" as image/>
						<@image.imageFtl url="${(Session.loginer.avatar)! }" default="/images/tpdpor/${app_path}/defaultAvatar.jpg" />
	                	<span>${(Session.loginer.realName)!}</span><i class="u-trg1-ico"></i></a>
	                <div class="lst">
	                    <i class="trg"><i></i></i>
	                    <a href="${ctx}/userCenter/user_info/edit_my_user_info"><i class="u-user2-ico"></i>用户资料</a>
                        <#if (Session.hasMenu)?? && Session.hasMenu>
							<a href="${ctx}/admin"><i class="u-user2-ico"></i>管理后台</a>	                            
                        </#if>
	                    <a href="${ctx}/logout"><i class="u-exit2-ico"></i>退出登录</a>
	                </div>
	            </li>
	        </ul>
	    </div>
	</div>
</div>

<script>
	$(function(){
		searchSelect();
	});

	//搜索框下拉框
	function searchSelect(){
	    var $searchSelect = $(".m-search .slt");
	
	    $searchSelect.stop().on({
	        mouseenter : function(){
	            $(this).children('.lst').slideDown(200);
	        },
	        mouseleave : function(){
	            $(this).children('.lst').hide();
	        }
	    });
	    $searchSelect.on('click','.lst a',function(){
	        var $this = $(this);
	        $('#searchType').val($this.attr('value'));
	        $this.addClass('z-crt').siblings().removeClass('z-crt');
	        $this.parent().hide().prevAll('strong').children('span').text($this.text());
	    });
	};
	
</script>