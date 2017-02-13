<#import "/tpdpor/common/include/layout.ftl" as layout />
<#assign jsArray=["${ctx}/js/tpdpor/follow.js",'/js/tpdpor/library/laypage/laypage.js','/js/tpdpor/uploadFile.js','/js/common/pdfobject/pdfobject.min.js']/>
<@layout.layout jsArray=jsArray mylayer=true flowplayer=true>
<@cRDownloadPermissionDirective resourceId=(resource.id)!>
<div class="g-auto">
	<div class="g-crm">
		<span class="txt">您当前的位置：</span>
		<a href="${ctx}/index" class="u-goHome" title="首页"><i class="u-home-ico"></i></a>
		<span class="trg">&gt;</span>
		<a href="${ctx}/course_resource/index">课程案例</a>
		<span class="trg">&gt;</span>
		<em>${(resource.title)!}</em>
	</div>
	<div class="g-frame case-detail">
		<div class="g-frame-mn">
			<div class="g-case-detail">
				<div class="m-case-tit">
					<h2 class="u-tt">
						<#if ((resource.resourceExtend.type)!'') != 'package' >
							<i class="u-ico-file ${FileTypeUtils.getFileTypeClass((resource.fileInfos?first.fileName)!,'suffix')}"></i>
						<#else>
							<i class="u-ico-file zip"></i>
						</#if>
						&nbsp;${(resource.title)!}
						<!--<i class="u-ico-prize good"></i>-->
					</h2>
					<div class="u-info">
						<#--<#assign score = (resource.resourceExtend.evaluateResult)!0>
						<div class="u-stars">
							<i class="u-small-star <#if (score>0)>full<#else>null</#if>"></i>
							<i class="u-small-star <#if (score>1)>full<#else>null</#if>"></i>
							<i class="u-small-star <#if (score>2)>full<#else>null</#if>"></i>
							<i class="u-small-star <#if (score>3)>full<#else>null</#if>"></i>
							<i class="u-small-star <#if (score>4)>full<#else>null</#if>"></i>
						</div>-->
						<span class="txt">(${(resource.resourceRelations[0].replyNum)!}条评价)<i class="u-line">|</i>${(resource.resourceRelations?first.browseNum)!}次阅读<i class="u-line">|</i>${(resource.resourceRelations?first.downloadNum)!}次下载</span>
					</div>
				</div>
				<#if resource.creator.id == Session.loginer.id>
					<div class="am-opa1">
	                    <a  href="${ctx}/course_resource/edit/${(resource.id)!}" class="au-edit"><i class="au-alter-ico"></i>编辑</a>
	                    <a onclick="deleteCourseResource('${resource.id}')" href="javascript:void(0);" class="au-delete"><i class="au-dlt-ico"></i>删除</a>
	                </div>
				</#if>
				<#if ((resource.resourceExtend.type)!'') != 'package' >
					<input id="${(resource.fileInfos?first.id)!}" type="hidden" value="${(resource.fileInfos?first.fileName)!}">
					<div class="g-ppt-view">
						<div id="simpleCourseResourceFileContent" class="m-pic" style="height:500px">
							<script>
								$(function(){
									$('#simpleCourseResourceFileContent').load('${ctx}/tpdpor/file/previewFile?fileId=${(resource.fileInfos?first.id)!}','downloadFunction=downloadResourceFile("${(resource.id)!}","${(resource.fileInfos?first.id)!}","${(mapResult['downloadPermission'])!}",${(mapResult['myPoint'])!0})');
								});
							</script>
						</div>
						<div class="m-pro">
								<a href="javascript:;" onclick="downloadResourceFile('${(resource.id)!}','${(resource.fileInfos?first.id)!}','${(mapResult['downloadPermission'])!}','${(mapResult['myPoint'])!0}')" class="u-btn-theme" id="dldResource"><i class="u-ico-dld1"></i>下载文档</a>
							<span class="u-score">下载所需积分：<b>${(resource.resourceExtend.price)!0}</b></span>
						</div>
						<div class="m-share">
							<!--
							<div class="u-lt">
								<span>分享到：</span>
								<div class="share-wrap">
									<div class="bdsharebuttonbox share-con">
										<a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a>
									</div>
								</div>
							</div>
							-->
							<div class="u-rt">
								<a href="javascript:;" followRelationId="${(resource.id)!}" class="u-collection">收藏</a>
								<a href="javascript:;" class="u-zan" id="uZan"> <i class="u-ico-zan"></i> <span class="num">${(resource.resourceRelations[0].supportNum)!}</span> <span class="addNum">+1</span> <span class="tips">来点个赞吧，这个发现更多人知道。</span> </a>
							</div>
						</div>
					</div>
				<#elseif ((resource.resourceExtend.type)!'') == 'package'>
					<div class="g-ppt-view package">
                        <div class="m-res">
                            <ul class="m-resource-lst">
                            	<#list resource.fileInfos as fileInfo>
	                                <li class="${FileTypeUtils.getFileTypeClass(fileInfo.fileName,'suffix')}">
	                                	<input id="${(fileInfo.id)!}" type="hidden" value="${(fileInfo.fileName)!}">
	                                    <h4 class="u-tit"><i class="u-ico"></i><a href="javascript:;">${(fileInfo.fileName)!}</a></h4>
	                                    <a href="javascript:;" onclick="previewFile('${(fileInfo.id)!}','downloadResourceFile(\'${(resource.id)!}\',\'${(fileInfo.id)!}\',\'${(mapResult['downloadPermission'])!}\',${(mapResult['myPoint'])!0})')" class="btn u-btn-theme btn-preview" url="${FileUtils.getFileUrl(fileInfo.url)}"><i class="u-ico-eyes"></i>预览</a>
	                                    <a href="javascript:;" class="btn u-btn-minor" onclick="downloadResourceFile('${(resource.id)!}','${(fileInfo.id)!}','${(mapResult['downloadPermission'])!}','${(mapResult['myPoint'])!0}')"><i class="u-ico-dld"></i>下载</a>
	                                </li>
                                </#list>
                            </ul>
                        </div>
						<div class="m-pro">
							<!--<a href="javascript:;" class="u-btn-theme" id="dldResource"><i class="u-ico-dld1"></i>下载文档</a>-->
							<span class="u-score">下载所需积分：<b>${(resource.resourceExtend.price)!0}</b></span>
						</div>
                        <div class="m-share">
                            <div class="u-rt">
								<a href="javascript:;" followRelationId="${(resource.id)!}" class="u-collection">收藏</a>
								<a href="javascript:;" class="u-zan" id="uZan"> <i class="u-ico-zan"></i> <span class="num">${(resource.resourceRelations[0].supportNum)!}</span> <span class="addNum">+1</span> <span class="tips">来点个赞吧，这个发现更多人知道。</span> </a>
                            </div>
                        </div>
                    </div>
				</#if>
				<div class="g-comment">
					<#import "/tpdpor/common/tags/comment.ftl" as c/>
					<@c.comment relationId=(resource.id)! relationType='course_resource' attitudeRelationType='course_resource'></@c.comment>
				</div>
			</div>
		</div>
		<div class="g-frame-sd spc">
			<div class="g-upload-btn">
				<a href="javascript:;" onclick="createCourseResource()" class="u-btn-upload"><b><i class="u-ico-upload"></i>上传我的课程</b>已有${(creatorNum)!}名教师，贡献 ${(resourceNum)!} 个课程</a>
			</div>
			<div class="g-sd-mod">
				<div class="g-upload-info">
					<div class="m-user">
						<a href="javascript:;" class="img">
							<#import "/tpdpor/common/tags/image.ftl" as image/>
							<@image.imageFtl url="${(resource.creator.avatar)! }" default="/images/tpdpor/${app_path}/defaultAvatar.jpg" />
						</a>
						<a href="javascript:;" class="name">${(resource.creator.realName)!}</a>
						<span class="txt">贡献于</span>
						<p>
							${TimeUtils.formatDate((resource.createTime)!0,'yyyy/MM/dd HH:mm')}
						</p>
					</div>
					<div class="m-info">
						<#if (resource.resourceExtend.type)??>
							<#if resource.resourceExtend.type == 'package'>
								<p>
									<span>类别：</span>资源包
									<#else>
									<span>类别：</span>${DictionaryUtils.getEntryName('COURSE_RESOURCE_TYPE',resource.resourceExtend.type)}
								</p>
							</#if>
						</#if>
						<#if (resource.resourceExtend.stage)??>
							<p>
								<span>学段：</span>${TextBookUtils.getEntryName('STAGE',(resource.resourceExtend.stage)!'')}
							</p>
						</#if>
						<#if (resource.resourceExtend.subject)??>
							<p>
								<span>学科：</span>${TextBookUtils.getEntryName('SUBJECT',(resource.resourceExtend.subject)!'')}
							</p>
						</#if>
						<#if (resource.resourceExtend.grade)??>
							<p>
								<span>年级：</span>${TextBookUtils.getEntryName('GRADE',(resource.resourceExtend.grade)!'')}
							</p>
						</#if>
						<#if (resource.resourceExtend.tbVersion)??>
							<p>
								<span>版本：</span>${TextBookUtils.getEntryName('VERSION',(resource.resourceExtend.tbVersion)!'')}
							</p>						
						</#if>
						<#if (resource.resourceExtend.section)??>
							<p>
								<span>章节：</span>${TextBookUtils.getEntryName('SECTION',(resource.resourceExtend.chapter)!'')}-${TextBookUtils.getEntryName('SECTION',(resource.resourceExtend.section)!'')}
							</p>
						</#if>
					</div>
				</div>
			</div>
			<div class="g-sd-mod">
				<div class="g-sd-tit1">
					<h4 class="m-tit">猜你喜欢的</h3>
				</div>
				<div class="g-sd-con">
					<ul class="m-resource-list">
						<#if intrestsResources??>
							<#list intrestsResources as ir>
								<li>
									<a href="${ctx}/course_resource/view/${(ir.id)!}"><i class="u-ico-file word"></i>${(ir.title)!}</a>
								</li>
							</#list>
						</#if>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
</@cRDownloadPermissionDirective>
<div id="followModel" style="display:none">
	<a href="javascript:;" followRelationId="${(resource.id)!}" class="u-collection follow">收藏</a>
	<a href="javascript:;" followRelationId="${(resource.id)!}" class="u-collection unFollow">取消收藏</a>
</div>

<!--end footer frame -->
<div id="resource-preview-box" class="resource-preview-box">
    <div class="res-box">
		
    </div>
    <a href="javascript:;" class="close"></a>
</div>

<script>
	var hasPay = false;
	$(function(){
		commonJs.fn.evaluateStat();//用户星星评价
		followFn.init('${(Session.loginer.id)!""}','courseResource',$('.case-detail .u-collection'),$('#followModel .follow'),$('#followModel .unFollow'),'','收藏');
		//preview();
		//点赞
		$('#uZan').on('click',function(){
			var _this = $(this);
			$.post('${ctx}/attitudes',{
				'attitude':'support',
				'relation.id':'${(resource.id)!}',
				'relation.type':'course_resource'
			},function(response){
				if(response.responseCode == '00'){
					var nowNum = _this.find('.num');
					nowNum.text(parseInt(nowNum.text()) + 1);
		            $(".addNum").addClass("ant");
		            clearTimeout(times);
		            var times = setTimeout(function(){
		                $(".addNum").removeClass("ant");
		            },500);
				}else if(response.responseCode == '01' && response.responseMsg == 'duplicate create attitudeUser!'){
					alert('已经赞过');
				}else{
					alert('操作失败');
				}
			});
		});
	});
	
	function downloadResourceFile(resourceId,fileInfoId,permission,myPoint){
		var loginId = "${(Session.loginer.id)!''}";
		if(loginId == ''){
			alert('您尚未登录,不能进行该操作');
			return false;
		}
		
		var fileName = $('#'+fileInfoId).val();
		if(hasPay == true){
			downloadFile(fileInfoId,fileName,'resources',resourceId);
			return false;
		}
		if(permission == 'download'){
			downloadFile(fileInfoId,fileName,'resources',resourceId);
		}else if(permission == 'need_more_point'){
			alert('下载该资源需要${(resource.resourceExtend.price)!0}积分,您现在有'+myPoint+'积分,不足以下载该资源');
		}else if(permission == 'pay_download'){
			confirm('下载该资源需要${(resource.resourceExtend.price)!0}积分,您现在有'+myPoint+'积分,确定支付积分下载吗?',function(){
				$.post('${ctx}/course_resource/pay/${(resource.id)!}',null,function(response){
					if(response.responseCode == '00'){
						hasPay = true;
						downloadFile(fileInfoId,fileName,'resources',resourceId);
					}else{
						alert('支付失败');
					}
				});
			});
		}
	}
	
	
	function deleteCourseResource(rid){
		confirm('确定删除吗？',function(){
			$.ajaxDelete('${ctx}/course_resource/delete/'+rid,null,function(response){
				if(response.responseCode == '00'){
					alert('操作成功',function(){
						window.location.href = "${ctx}/course_resource/index";
					});
				}
			});
		});
	}
	
	function createCourseResource(){
		var loginId = '${(Session.loginer.id)!""}';
		if(loginId == ''){
			alert('您尚未登录,不能进行该操作!');
			return false;
		}
		window.location.href = '${ctx}/course_resource/create';
	}

	
</script>
</@layout.layout>