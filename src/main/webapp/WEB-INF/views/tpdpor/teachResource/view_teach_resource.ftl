<#import "/tpdpor/common/include/layout.ftl" as layout />
<#assign jsArray=["${ctx}/js/tpdpor/follow.js",'/js/tpdpor/library/laypage/laypage.js']/>
<@layout.layout jsArray=jsArray mylayer=true>
<div class="g-auto">
	<div class="g-crm">
		<span class="txt">您当前的位置：</span>
		<a href="${ctx!}/tpdpor/index" class="u-goHome" title="首页"><i class="u-home-ico"></i></a>
		<span class="trg">&gt;</span>
		<a href="${ctx}/teach_resource/index">教研资料</a>
		<span class="trg">&gt;</span>
		<em>${(resource.title)!}</em>
	</div>
	<div class="g-frame book-detail">
		<div class="g-frame-mn">
			<div class="g-case-detail">
				<div class="g-book-info">
					<div class="m-book-info">
						<span class="img">
							<#import "/tpdpor/common/tags/image.ftl" as image/>
							<@image.imageFtl url="${(resource.resourceExtend.coverUrl)! }" default="/images/tpdpor/${app_path}/defaultTeachResource.jpg" class="" />
						</span>
						<div class="u-text">
							<h3 class="u-tt">${(resource.title)!}</h3>
							<#if (resource.resourceExtend.author)??>
								<p>
									作者：${(resource.resourceExtend.author)!}
								</p>
							</#if>
							<#if (resource.resourceExtend.bIndex)??>
								<p>
									中图分类号：${(resource.resourceExtend.bIndex)!}
								</p>
							</#if>
							<!--
							<p>
								国际标准书号：sfsd123455
							</p>
							-->
							<#if (resource.resourceExtend.source)??>
								<p>
									出版社：${(resource.resourceExtend.source)!}
								</p>
							</#if>
							<#if (resource.resourceExtend.issueDate)??>
								<p>
									出版年份：${(resource.resourceExtend.issueDate?string('yyyy'))!}年
								</p>
							</#if>
							<#if (resource.resourceExtend.stage)??>
								<p>
									学段：${TextBookUtils.getEntryName('STAGE',resource.resourceExtend.stage)}
								</p>
							</#if>
							<#if (resource.resourceExtend.subject)??>
								<p>
									学科：${TextBookUtils.getEntryName('SUBJECT',resource.resourceExtend.subject)}
								</p>
							</#if>
							<#if (resource.resourceExtend.grade)??>
								<p>
									年级：${TextBookUtils.getEntryName('GRADE',resource.resourceExtend.grade)}
								</p>
							</#if>
						</div>
						<#if (Session.loginer.id)??>
							<#if ((resource.privilege)!'') == 'free'>
								<#if ((resource.resourceExtend.isOriginal)!'') == 'N'>
									<a  href="javascript:;" onclick="goUrl('${(resource.resourceExtend.previewUrl)!}')" class="u-btn u-btn-theme">开始阅读</a>
								<#else>
									<a  href="javascript:;" onclick="previewFile('${(resource.fileInfos[0].id)!}')" class="u-btn u-btn-theme">开始阅读</a>
								</#if>
							<#else>
								<#if Session.loginer.id == resource.creator.id || ((resource.belong)!'')?contains((Session.loginer.roleCode)!'-')>
									<#if ((resource.resourceExtend.isOriginal)!'') == 'N'>
										<a  href="javascript:;" onclick="goUrl('${(resource.resourceExtend.previewUrl)!}')" class="u-btn u-btn-theme">开始阅读</a>
									<#else>
										<a  href="javascript:;" onclick="previewFile('${(resource.fileInfos[0].id)!}')" class="u-btn u-btn-theme">开始阅读</a>
									</#if>
								<#else>
									<@resourceApplyRecordDirective userId=Session.loginer.id resourceId=(resource.id)!>
										<#if resourceApplyRecordModel??>
											<#if resourceApplyRecordModel.applyState == 'apply'>
												<a  href="javascript:;" class="u-btn u-btn-theme">等待审核中</a>
											<#elseif resourceApplyRecordModel.applyState == 'passed'>
												<#if ((resource.resourceExtend.isOriginal)!'') == 'N'>
													<a  href="javascript:;" onclick="goUrl('${(resource.resourceExtend.previewUrl)!}')" class="u-btn u-btn-theme">开始阅读</a>
												<#else>
													<a  href="javascript:;" onclick="previewFile('${(resource.fileInfos[0].id)!}')" class="u-btn u-btn-theme">开始阅读</a>
												</#if>
											<#else>
												<a onclick="alert('您的申请未通过,暂时无权浏览');" href="javascript:;" class="u-btn u-btn-theme">申请阅读</a>
											</#if>
										<#else>
											<a onclick="applyRead()" href="javascript:;" class="u-btn u-btn-theme">申请阅读</a>
										</#if>
									</@resourceApplyRecordDirective>
								</#if>
							</#if>
						<#else>
							<#if ((resource.privilege)!'') == 'free'>
								<#if ((resource.resourceExtend.isOriginal)!'') == 'N'>
									<a  href="javascript:;" onclick="goUrl('${(resource.resourceExtend.previewUrl)!}')" class="u-btn u-btn-theme">开始阅读</a>
								<#else>
									<a  href="javascript:;" onclick="previewFile('${(resource.fileInfos[0].id)!}')" class="u-btn u-btn-theme">开始阅读</a>
								</#if>
							<#else>
								<a onclick="applyRead()" href="javascript:;" class="u-btn u-btn-theme">申请阅读</a>
							</#if>
						</#if>
						<a href="javascript:;" followRelationId="${(resource.id)!}" class="u-btn u-btn-minor follow">收藏</a>
					</div>
					<div class="m-book-intro">
						<h4 class="u-tt">资料简介</h4>
						<p>
							${(resource.summary)!}
						</p>
					</div>
				</div>
				<div class="g-comment">
					<#import "/tpdpor/common/tags/comment.ftl" as c/>
					<@c.comment relationId=(resource.id)! relationType='teach_resource_evaluate' attitudeRelationType='teach_resource'></@c.comment>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="followModel" style="display:none">
	<a href="javascript:;" followRelationId="${(resource.id)!}" class="u-btn u-btn-minor follow">收藏</a>
	<a href="javascript:;" followRelationId="${(resource.id)!}" class="u-btn u-btn-minor unFollow">取消收藏</a>
</div>

<script>
	$(function() {
		//$('.m-tit').hide();
		//$('.my-comment').hide();
		commonJs.fn.evaluateStat();
		//用户星星评价
		followFn.init('${(Session.loginer.id)!""}', 'teachResource', $('.book-detail .follow'), $('#followModel .follow'), $('#followModel .unFollow'), '', '收藏');

		//点赞
		$('#uZan').on('click', function() {
			var _this = $(this);
			$.post('${ctx}/attitudes', {
				'attitude' : 'support',
				'relation.id' : '${(resource.id)!}',
				'relation.type' : 'course_resource'
			}, function(response) {
				if (response.responseCode == '00') {
					var nowNum = _this.find('.num');
					nowNum.text(parseInt(nowNum.text()) + 1);
					$(".addNum").addClass("ant");
					clearTimeout(times);
					var times = setTimeout(function() {
						$(".addNum").removeClass("ant");
					}, 500);
				} else if (response.responseCode == '01' && response.responseMsg == 'duplicate create attitudeUser!') {
					alert('已经赞过');
				} else {
					alert('操作失败');
				}
			});
		});
	});
	
	function applyRead(){
		var loginId = "${(Session.loginer.id)!''}";
		if(loginId == ''){
			alert("您尚未登录，不能进行该操作");
			return false;
		}
		
		$.post('${ctx}/resource_apply_record',{
			'userInfo.id':loginId,
			'resource.id':'${(resource.id)!}',
			'applyState':'apply'
		},function(response){
			if(response.responseCode == '00'){
				alert('申请成功，请等待审核',function(){
					window.location.reload();
				});
			}
		});
	}
	
	function goUrl(url){
		alert('外部资源暂不开放');
	}

</script>
</@layout.layout>