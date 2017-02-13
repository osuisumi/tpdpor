<#import "/tpdpor/common/tags/image.ftl" as image/>
<#include "/tpdpor/common/include/layout.ftl"/>
<#assign jsArray=['${ctx!}/js/tpdpor/library/laypage/laypage.js']/>
<#assign cssArray=[]>
<@layout jsArray=jsArray cssArray=cssArray mylayer=true>
<#assign hasCreativeManagerRole=SecurityUtils.getSubject().hasRole('creative_manager_'+(creative.id)!)>
<#assign hasPayedCreativeResource=SecurityUtils.getSubject().hasRole('creative_manager_'+(creative.resources[0].id)!)>
	<@resourceDirective id=(creative.resources[0].id)! getAttitudeStatForSupport=true >
		<#assign resource=resourceModel!> 
		<#assign fileInfo=(resource.fileInfos[0])!>
		<#assign attitudeStatMapForSupport=attitudeStatMapForSupport!> 
	</@resourceDirective>
	<@creativeData id=(creative.id)! getResourceCount=true getResourceCreatorCount=true>
		<#assign creative=creativeModel!> 
		<#assign creativeResourceCount=creativeResourceCount!0> 
		<#assign creativeResourceCreatorCount=creativeResourceCreatorCount!0> 
	</@creativeData>
	<div class="g-crm">
	    <span class="txt">您当前的位置：</span>
	    <a href="${ctx!}/tpdpor/index" class="u-goHome" title="首页"><i class="u-home-ico"></i></a>
	    <span class="trg">&gt;</span>
	    <a href="${ctx!}/creative/index">教师创客</a>
	    <span class="trg">&gt;</span>
	    <em>${(creative.title)!''}</em>
	</div>
	<div class="g-frame case-detail">
	    <div class="g-frame-mn">
	        <div class="g-case-detail">
	            <div class="m-case-tit">
	                <h2 class="u-tt nop">${(creative.title)!''}</h2>
	                <div class="u-info">
	                    <span class="txt">(<ii class="resourceCommentNum">0</ii>人评价)<i class="u-line">|</i>0人阅读<i class="u-line">|</i>0次下载</span>
	                </div>
	            </div>
	            <div class="g-ppt-view">
	                <div class="m-pic" id="viewResourceDiv" style="height:500px">
	                </div>
	                    <script>
	                    	$(function(){
	                    		$('#viewResourceDiv').load('${(ctx)!}/tpdpor/file/previewFile?fileId=${(fileInfo.id)!}');
	                    	});
	                    </script>
	                <div class="m-pro">
	                	<#if hasCreativeManagerRole>
	                    	<a onclick="goDeleteResource('${(creative.id)!}','${(resource.id)!}');" href="javascript:;" class="u-btn-theme" >删除资源</a>
	                    </#if>
	                    <#if hasCreativeManagerRole || hasPayedCreativeResource>
		                    <a onclick="downloadFile('${(fileInfo.id)!}', '${(fileInfo.fileName)!}','creative','${(resource.id)!}');" href="javascript:;" class="u-btn-theme" >下载资源</a>
	                    <#else>
	                    	<a onclick="goPayCreativeResource('${(resource.id)!}','${fileInfo.id}')" href="javascript:;" class="u-btn-theme" >下载资源</a>
	                    </#if>
	                    <#-- 
	                    <div class="u-rt">
	                        <span class="u-full"><i class="u-ico-full"></i>全屏</span>
	                        <div class="m-page" id="turnPage">
	                            <a href="javascript:;" class="u-page next"></a>
	                            <span class="u-num">
	                                <input type="text" class="now" value="01" readonly="readonly">
	                                <i>/</i>
	                                <span class="all">20</span>
	                            </span>
	                            <a href="javascript:;" class="u-page prev"></a>
	                        </div>
	                    </div>
	                    -->
	                </div>
	                <div class="m-share">
	                    <div class="u-lt">
	                        <span>分享到：</span>
	                        <div class="share-wrap">
	                            <div class="bdsharebuttonbox share-con"><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></div>
	                        </div>
	                    </div>
	                    <div class="u-rt">
	                        <a href="javascript:;" class="u-collection">收藏</a>
	                        <#if hasPayedCreativeResource>
		                        <a href="javascript:;" class="u-zan" id="uZan">
		                            <i class="u-ico-zan"></i>
		                            <span class="num">${(attitudeStatMapForSupport[resource.id].participateNum)!0}</span>
		                            <span class="addNum">+1</span>
		                            <span class="tips">来点个赞吧，这个发现更多人知道。</span>
		                        </a>
	                        <#else>
                        		<a href="javascript:;" class="u-zan">
		                            <i class="u-ico-zan"></i>
		                            <span class="num">${(attitudeStatMapForSupport[resource.id].participateNum)!0}</span>
		                            <span class="addNum">+1</span>
		                            <span class="tips">来点个赞吧，这个发现更多人知道。</span>
		                        </a>
	                        </#if>
	                    </div>
	                </div>
	            </div>
				<#if hasPayedCreativeResource >
					<#assign canComment=true>
				<#else>
					<#assign canComment=false>
				</#if>
	            <#import "/tpdpor/common/tags/comment.ftl" as comment />
	            <@comment.comment relationId=(resource.id)!'' relationType="creative_resource" attitudeRelationType="creative_comment" canComment=canComment/>
	        </div>
	    </div>
	    <div class="g-frame-sd spc">
	        <div class="g-upload-btn">
	        
	            <a onclick="goCreateCreativeResource('${(creative.id)!}');" href="javascript:;" class="u-btn-upload"><b><i class="u-ico-upload"></i>上传资源</b>已有${creativeResourceCreatorCount!0}名教师，贡献 ${creativeResourceCount!0}个资源</a>
	        </div>
	        <div class="g-sd-mod">
	            <div class="g-upload-info">
	                <div class="m-user">
	                    <a href="javascript:;" class="img">
	                        <@image.imageFtl url="${(creative.creator.avatar)!'' }" default="/images/tpdpor/${app_path}/defaultAvatar.jpg"/>
	                    </a>
	                    <a href="javascript:;" class="name">${(creative.creator.realName)!}</a>
	                    <span class="txt">贡献于</span>
	                    <p>${TimeUtils.formatDate((resource.createTime)!, 'yyyy-MM-dd HH:mm')}</p>
	                </div>
	                <div class="m-info">
	                    <p><span>类别：</span>
                    		<#if (resource.type)! == 'webCourse'>
                    			网络课程
                    		<#elseif (resource.type)! == 'micVideo'>
                    			微课视频
                    		<#elseif (resource.type)! == 'classroomRecord'>
                    			课堂实录
                    		<#elseif (resource.type)! == 'teachDesign'>
                    			教学设计
                    		<#elseif (resource.type)! == 'teachCourse'>
                    			教学课程
                    		<#elseif (resource.type)! == 'teachMaterial'>
                    			教学素材
                    		<#elseif (resource.type)! == 'paper'>
                    			论文
                    		<#elseif (resource.type)! == 'other'>
                    			其他
                    		<#else>
                    			----
                    		</#if>
	                    </p>
	                    <p><span>年级：</span>${TextBookUtils.getEntryName('GRADE','${(creative.resources[0].resourceExtend.grade)!}') }</p>
	                    <p><span>学科：</span>${TextBookUtils.getEntryName('SUBJECT','${(creative.resources[0].resourceExtend.subject)!}') }</p>
	                    <p><span>学段：</span>${TextBookUtils.getEntryName('STAGE','${(creative.resources[0].resourceExtend.stage)!}') }</p>
	                    <p><span>版本：</span>${TextBookUtils.getEntryName('VERSION','${(creative.resources[0].resourceExtend.version)!}') }</p>
	                    <p><span>章节：</span>${TextBookUtils.getEntryName('SECTION','${(creative.resources[0].resourceExtend.section)!}') }</p>
	                </div>
	            </div>
	        </div>

			<div class="g-sd-mod">
                <div class="g-sd-tit1">
                    <h4 class="m-tit">猜你喜欢的</h3>
                </div>
                <div class="g-sd-con">
                    <ul class="m-resource-list">
                    <@resourcesDirective relationType='creative' limit=(pageBounds.limit)!6 orders=(orders[0])!'CREATE_TIME.DESC'>
                        <#if (resources)??>
                        	<#list resources as resource>
                        		<li>
		                            <a href="${ctx!}/creative/resource/${resource.id}/view" target="_blank"><i class="u-ico-file word"></i>${(resource.title)!''}</a>
		                        </li>
                        	</#list>
                        </#if>
                    </@resourcesDirective>
                    </ul>
                </div>
            </div>
			
	    </div>
	</div>
	
</@layout>
<script>
    window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"1","bdSize":"16"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
    $(function(){
    	commonJs.fn.evaluateStat();
    	commonJs.fn.sup();
    });
    
    function goDeleteResource(creativeId,resourceId){
    	confirm('确定要删除这个创客资源吗?', function(){
			$.post("${ctx!}/creative/${(creative.id)!}/resource/"+resourceId,{
				"_method":'delete'
			},function(response){
				if(response.responseCode == '00'){
					alert('删除成功！');
					window.location.href = '${ctx!}/creative/${(creative.id)!}/view';
				}else{
					alert('删除失败！');
				}
			})
		});
    };
    
    //点赞
    $("#uZan").on("click",function(){
   	 	var _this = $(this);
    	$.post('${ctx!}/attitudes',{
			'attitude':'support',
			'relation.id':'${(resource.id)!}',
			'relation.type':'creative_resource',
		},function(response){
			if(response.responseCode == '00'){
				_this.closest('span').text(parseInt(_this.closest('span').text()) + 1);
			}else{
			};
		});
    });
    
    //收藏
    $(".u-collection").on("click",function(){
    	createFollow('${(resource.id)!}','creative_resource',function(){alert('收藏成功！');},function(){alert('您已经收藏过！');});
	});
    
    function goPayCreativeResource(resourceId,fileInfoId){
		mylayerFn.open({
        	id: 'payCreativeResourceLayer',
            type: 2,
            title: '温馨提示',
            fix: false,
            area: [600, 300],
	        offset : [$(document).scrollTop()],
			shadeClose : true,
            content: '${ctx!}/creative/${(creative.id)!}/resource/'+resourceId+'/goPay?resources[0].fileInfos[0].id='+fileInfoId,
        });
	};
	
	function goCreateCreativeResource(id){			
		window.open('${ctx!}/creative/resource/create?id='+id);
	};
</script>