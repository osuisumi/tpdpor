<#import "/userCenter/common/include/layout.ftl" as lo>
<#assign jsArray = ['${ctx!}/js/common/laypage/laypage.js'] />
<#assign cssArray = ['${ctx}/css/tpdpor/${app_path}/style.css','${ctx!}/js/common/laypage/skin/laypage.css']>
<@lo.layout jsArray=jsArray cssArray=cssArray menu='kcal'>

<@resourcesDirective  type="course" creatorOrFollowCreator=param_creatorOrFollowCreator! creator=param_creator! followCreator=param_followCreator! page=(param_page)!1 limit=param_limit!10 orders=param_orders!'CREATE_TIME.DESC'>
<div class="g-EduResc-tab">
	<@createAndFollowResourceNumDirective type="course" getCreateNum='Y' getFollowNum='Y'>
	<#assign createNum=createNum!0/>
	<#assign followNum=followNum!0/>
	<#assign totalNum=createNum+followNum/>
    <ul class="m-subscribe-tab">
        <li <#if (param_creatorOrFollowCreator!'') == Session.loginer.id>class="crt"</#if>  onclick="reload('creatorOrFollowCreator')"><a href="javascript:;">全部(${totalNum})</a></li>
        <li <#if (param_creator!'') == Session.loginer.id>class="crt"</#if> onclick="reload('creator')"><a href="javascript:;">上传(${(createNum)!0})</a></li>
        <li <#if (param_followCreator!'') == Session.loginer.id>class="crt"</#if>  onclick="reload('followCreator')"><a href="javascript:;">收藏(${(followNum)!0})</a></li>
    </ul>
    </@createAndFollowResourceNumDirective>
    <!--      
    <div class="chk-lst">
        <div class="m-slt-block1 mid">
            <a href="javascript:;" class="show-txt">
                <span class="txt">按年限筛选</span>
                <i class="trg"></i>
            </a>
            <dl class="lst">
                <dd><a href="javascript:;" class="z-crt">按年限筛选</a></dd>
                <dd><a href="javascript:;">按分类筛选</a></dd>
                <dd><a href="javascript:;">按年限筛选</a></dd>
                <dd><a href="javascript:;">按大小筛选</a></dd>
                <dd><a href="javascript:;">按年限筛选</a></dd>
            </dl>
        </div>
    </div>
    -->
</div>
<div class="m-LessonCase-cont m-EduResc-cont">
	<!--
    <div class="am-line-block">
        <div class="l">
            <a href="javascript:void(0);" class="au-uploadFile au-default-btn">
                <i class="au-uploadFile-ico"></i>上传文件
            </a>
            <a href="javascript:void(0);" class="au-add-folder au-default-btn">
                <i class="au-addFolder-ico"></i>创建文件夹
            </a>
        </div>                            
        <div class="r">
            <a onclick="changeDisplay('block');" class="across crt"><i></i></a>
            <a onclick="changeDisplay('list');" class="list"><i></i></a>
        </div>
    </div>
   -->
	<ul class="m-resource-lst">
		<#if resources??>
			<#list resources as resource>
				<li class="${FileTypeUtils.getFileTypeClass((resource.title)!,'tpdpor')}">
					<h4 class="u-tit"><i class="u-ico"></i><a href="${ctx}/course_resource/view/${(resource.id)!}">${(resource.title)!}</a></h4>
					<p class="u-info">
						<span class="u-name">${(resource.creator.realName)!}</span>
						<span class="info-txt">
							上传于 ${TimeUtils.formatDate(resource.createTime,'yyyy-MM-dd HH:mm:ss')}<i class="u-line">|</i>
							类型：
							<#if (resource.resourceExtend.type)??>
								<#if resource.resourceExtend.type == 'package'>
									资源包
								<#else>
									${DictionaryUtils.getEntryName('COURSE_RESOURCE_TYPE',resource.resourceExtend.type)}
								</#if>
							</#if><i class="u-line">|</i>
							下载量：${(resource.resourceRelations[0].downloadNum)!0}<i class="u-line">|</i>
							浏览量：${(resource.resourceRelations[0].browseNum)!0}<i class="u-line">|</i>
							下载积分：${(resource.resourceExtend.price)!0}
						</span>
					</p>
					<#assign score = (resource.resourceExtend.evaluateResult)!0>
					<div class="m-stars">
						<i class="u-star <#if (score>0)>full<#else>null</#if>"></i>
						<i class="u-star <#if (score>1)>full<#else>null</#if>"></i>
						<i class="u-star <#if (score>2)>full<#else>null</#if>"></i>
						<i class="u-star <#if (score>3)>full<#else>null</#if>"></i>
						<i class="u-star <#if (score>4)>full<#else>null</#if>"></i>
					</div>
				</li>
			</#list>
		</#if>
	</ul>
	<div class="m-btm-opa">
		<form id="list_course_resource_form" action="${ctx!}/userCenter/course_resource" method="get">
	    	<input type="hidden" name="creatorOrFollowCreator" value="${param_creatorOrFollowCreator!}">
	    	<input type="hidden" name="followCreator" value="${param_followCreator!}">
	    	<input type="hidden" name="creator" value="${param_creator!}">
	       <div class="u-rt">
	           <div class="m-laypage" id="course_resource_page"></div>
	           <span class="num">找到<b>${(paginator.totalCount)!0}</b>条数据</span>
	           <#import '/userCenter/common/tags/pagination.ftl' as p />
			<@p.paginationFtl formId="list_course_resource_form" divId="course_resource_page" paginator=paginator! />
	       </div>
		</form>
	</div>
</div>
</@resourcesDirective>

<script>
	function reload(loadType){
		$('#list_course_resource_form input[name="creatorOrFollowCreator"]').val('');
		$('#list_course_resource_form input[name="followCreator"]').val('');
		$('#list_course_resource_form input[name="creator"]').val('');
		
		$('#list_course_resource_form input[name="'+loadType+'"]').val('${(Session.loginer.id)!}');
		window.location.href = "${ctx!}/userCenter/course_resource?" + $('#list_course_resource_form').serialize();
	}
</script>
</@lo.layout>