 <#macro top containSearch=true>
   <div class="g-hd">
        <div class="g-auto">
            <div class="m-logo">
                <h1><a href="${ctx}/tpdpor/index"><img src="/images/tpdpor/${app_path}/logo.png" alt="教师专业发展在线资源平台"><span>教师专业发展在线资源平台</span></a></h1>
            </div>
            <#if containSearch>
            <div class="m-search style1">
                <input id="searchKeywords" type="text" placeholder="输入资源名称" class="ipt" value="${(param_searchKeywords)!}">
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
                    <strong><span>${typeShowName!}</span><i class="ico"></i></strong>
                    <div class="lst">
                        <a value="" href="javascript:;" class="z-crt">全库搜索</a>
                        <a value="teach" href="javascript:;">教研资料</a>
                        <a value="course" href="javascript:;">课程案例</a>
                        <a value="train_resource" href="javascript:;">培训学习</a>
                        <a value="creative" href="javascript:;">教师创客</a>
                    </div>
                </div>
                <a onclick="doSearch()" href="javascript:;" class="submit">搜索</a>
            </div>
            </#if>
        </div>
    </div>
<input type="hidden" id="ctx" value="${ctx}">
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
</#macro> 