<#include "/tpdpor/common/include/layout.ftl"/>
<#import "/tpdpor/common/tags/image.ftl" as image/>
<#assign jsArray=['${ctx!}/js/tpdpor/library/laypage/laypage.js']/>
<#assign cssArray=[]/>
<@layout jsArray=jsArray cssArray=cssArray mylayer=true>

<@trainResourceViewData id=(trainResource.id)!'' getApplyRecord=true getAttitudeStatForSupport=true>	
	<#assign trainRsource=trainRsourceModel/>
	<#assign attitudeStatMapForSupport=attitudeStatMapForSupport!/>
	<#assign applyRecordMap=applyRecordMap!/>
	<div class="g-crm">
	    <span class="txt">您当前的位置：</span>
	    <a href="${ctx!}/tpdpor/index" class="u-goHome" title="首页"><i class="u-home-ico"></i></a>
	    <span class="trg">&gt;</span>
	    <a href="${ctx!}/train_resource/index">培训学习</a>
	    <span class="trg">&gt;</span>
	    <a href="${ctx!}/train_resource/${(trainRsource.id)!}/view">${(trainRsource.resource.title)!}</a>
	</div>
	<div class="g-frame case-detail">
	    <div class="g-frame-mn">
	        <div class="g-case-detail">
	            <div class="m-case-tit train">
	                <h2 class="u-tt">《${(trainRsource.resource.title)!''}》</h2>
	                <div class="u-info">
	                   <#--  <div class="u-stars">
		                    <#if (trainRsource.resource.resourceExtend.evaluateResult) gte 0 >
	                    		<#list 0..4 as i>
	                    			<#if (trainRsource.resource.resourceExtend.evaluateResult) gte i>
	                    				<i class="u-small-star full"></i>
	                    			<#else>
	                    				<i class="u-small-star null"></i>
	                    			</#if>
	                    		</#list>
	                    	<#else>
	                    		<#list 0..5 as i>
	                    			<i class="u-small-star null"></i>
	                    		</#list>
	                        </#if>
	                    </div> 
	                    -->
	                    <span class="txt">(0人评价)<i class="u-line">|</i>${(trainRsource.participateNum)!0}人参加学习<i class="u-line">|</i>上传于 ${TimeUtils.formatDate((trainRsource.resource.createTime)!0, 'yyyy-MM-dd HH:mm') }</span>
	                </div>
	            </div>
	            <div class="g-ppt-view package" id="viewContent">
                    <div class="m-res">
	                    <ul class="m-resource-lst">
	                    	<#if (trainRsource.resource.fileInfos)??>
	                        	<#list (trainRsource.resource.fileInfos) as file>
			                        <li class="${FileTypeUtils.getFileTypeClass((file.fileName)!'', 'suffix') }" fileId="${(file.id)!''}">
			                            <h4 class="u-tit"><i class="u-ico"></i><a class="fileName">${(file.fileName)!''}</a></h4>
			                            <#if ((trainRsource.resource.privilege)!'')?contains('free') || ((trainRsource.resource.privilege)!'')?contains((Session.loginer.roleCode)!'-')>
			                            	<a href="javascript:;" class="btn u-btn-theme btn-preview viewFile"><i class="u-ico-eyes"></i>预览</a>
			                            	<a href="javascript:;" class="btn u-btn-minor" onclick="downloadFile('${(file.id)!}','${(file.fileName)!}');"><i class="u-ico-dld"></i>下载</a>
						                <#else>
						                	<#if ((applyRecordMap[trainRsource.resource.id].applyState)!'') == 'passed' >
							                	<a href="javascript:;" class="btn u-btn-theme btn-preview viewFile"><i class="u-ico-eyes"></i>预览</a>
			                            		<a href="javascript:;" class="btn u-btn-minor" onclick="downloadFile('${(file.id)!}','${(file.fileName)!}');"><i class="u-ico-dld"></i>下载</a>
							                </#if>
			                            </#if>
			                        </li>
	                        	</#list>
                            </#if>
	                    </ul>
	                </div>
                    <div class="m-share">
                        <div class="u-lt">
                        <#-- 
                            <span>分享到：</span>
                            <div class="share-wrap">
                                <div class="bdsharebuttonbox share-con"><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></div>
                            </div>
                        -->    
                        </div>
                        <div class="u-rt">
                            <a href="javascript:;" class="u-collection">收藏</a>
                            <a href="javascript:;" class="u-zan" id="uZan">
                                <i class="u-ico-zan"></i>
                                <span class="num">${(attitudeStatMapForSupport[trainResource.id].participateNum)!0}</span>
                                <span class="addNum">+1</span>
                                <span class="tips">来点个赞吧，这个发现更多人知道。</span>
                            </a>
                        </div>
                    </div>
                </div>
                <#import "/tpdpor/common/tags/comment.ftl" as comment />
				<@comment.comment relationId=(trainRsource.resource.id)!'' relationType="train_resource_evaluate" attitudeRelationType="train_resource_comment" />
	        </div>
	    </div>
	    <@expertsData userId=(trainRsource.resource.creator.id)!>
	    	<#if (experts)??>
	    		<#assign expert=experts[0]! />
	    	</#if>
	    </@expertsData>
	    <div class="g-frame-sd spc">
	        <div class="g-sd-mod">
	            <div class="g-upload-info">
	                <div class="m-user">
	                    <a href="javascript:;" class="img">
	                        <@image.imageFtl url="${(trainRsource.resource.creator.avatar)!}" default="/images/tpdpor/${app_path}/defaultAvatar.jpg" />
	                    </a>
	                    <a href="javascript:;" class="name">${(trainRsource.resource.creator.realName)!''}</a>
	                    <p>${(expert.professionalTitle)!}</p>
	                    <#-- 
	                    <a href="javascript:;" class="u-btn-theme">订阅</a>
	                    -->
	                </div>
	                <div class="m-info train">
	                    <p class="spc"><span>资源数量：</span>
	                    	<#if (trainRsource.resource.fileInfos)?? >
		                    	${(trainRsource.resource.fileInfos)?size}	                    		
	                    	<#else>
	                    		0
	                    	</#if>
	                    </p>
	                    <p>
	                    	<span>类别：</span>
	                    	<#if (trainRsource.resource.type)! == 'curriculum' >
								课程
							<#elseif (trainRsource.resource.type)! == 'case'>
								案例
							<#elseif (trainRsource.resource.type)! == 'material'>
								素材
							<#elseif (trainRsource.resource.type)! == 'other'>
								其他
							<#else>
								----
							</#if>
	                    </p>
	                    <p><span>概述：</span>${(trainRsource.resource.summary)!}</p>
	                </div>
	                <#if ((trainRsource.resource.privilege)!'')?contains('free')>
	                	<a href="javascript:;" class="u-btn-upload "><b>加入学习</b></a>
	                <#elseif ((trainRsource.resource.privilege)!'')?contains((Session.loginer.roleCode)!'-')>
                   		<#if ((applyRecordMap[trainRsource.resource.id].applyState)!'') == 'apply' >
		                	<a class="u-btn-upload takecar" href="javascript:;"><b>申请中</b></a>
		                <#elseif ((applyRecordMap[trainRsource.resource.id].applyState)!'') == 'passed'>
			                <a href="javascript:;" class="u-btn-upload "><b>加入学习</b></a>
		                <#elseif ((applyRecordMap[trainRsource.resource.id].applyState)!'') == 'nopass'>
		                	<a class="u-btn-upload takecar" href="javascript:;"><b>申请失败</b></a>
		                <#else>	                
			                <a onclick="applyStudy('${(trainRsource.train.id)!}','${(trainRsource.resource.id)!}');" href="javascript:;" class="u-btn-upload takecar"><b>申请学习</b></a>
		                </#if>
                   	<#else>	
	                </#if>
	            </div>
	        </div>
	    </div>
	    <div class="g-frame-sd">
	        <div class="g-sd-tit">
	            <h3 class="m-tit1">相关推荐</h3>
	            <a class="change"><i class="u-ico-turn"></i>换一批</a>
	        </div>
	        <div id="train_resource_recommend_div" class="g-sd-mod spc">
	            <script>
					$(function(){
						$('#train_resource_recommend_div').load('${ctx!}/train_resource/recommendResource?type=${(trainRsource.resource.type)!}');
					});
				</script>
	        </div>
	    </div>
	</div>

	<script>
		$(function(){
			commonJs.fn.evaluateStat();
			commonJs.fn.sup();
			
			$('.viewFile').on('click',function(){
				var _this = $(this);
				var fileInfoId = _this.closest('li').attr('fileid');
				
				previewFile(fileInfoId);
			});
			
			//点赞
		    $(".u-ico-zan").on("click",function(){
		   	 	var _this = $(this);
		    	$.post('${ctx!}/attitudes',{
					'attitude':'support',
					'relation.id':'${(trainRsource.id)!}',
					'relation.type':'train_resource',
				},function(response){
					if(response.responseCode == '00'){
						_this.closest('span').text(parseInt(_this.closest('span').text()) + 1);
					}else{
					};
				});
		    });
		    
		    //收藏
		    $(".u-collection").on("click",function(){
		    	createFollow('${(trainRsource.resource.id)!}','train_resource',function(){alert('收藏成功！');},function(){alert('您已经收藏过！');});
			});
			
			//相关推荐换一批
		    $(".change").on("click",function(){
				var page = parseInt($('#listResorceRecommendForm').find('input[name="page"]').val()) + 1;
				
				if($('#train_resource_recommend_div li').size() <= 0){
					page = 1;
				}
				
				$('#listResorceRecommendForm').find('input[name="page"]').val(page);
				$.ajaxQuery('listResorceRecommendForm','train_resource_recommend_div');
			});
			
		});
		
		function applyStudy(trainId,resourceId){
			if(trainId == '' || trainId == null || trainId == undefined){
				return false;
			}
			if(resourceId == '' || resourceId == null || resourceId == undefined){
				return false;
			}
			<#-- 
			mylayerFn.open({
		        type: 2,
		        title: '温馨提示',
		        fix: false,
		        area: [400, 250],
		        offset : [$(document).scrollTop(), 'auto'],
				shadeClose : true,
		        content: '${ctx!}/train_resource/applyStudy',
		    });
			-->

			confirm('是否确定申请学习?',function(){
				$.post('${ctx}/resource_apply_record' ,{
					'_method' : 'POST',
					'userInfo.id':'${Session.loginer.id}',
					'resource.id':resourceId,
					'applyState':'apply'
	 			},function(response){
	 				if(response.responseCode == '00'){
						window.location.reload();
					}else{
						alert('申请失败!');
					};
	 			});
			});
			
		};
		
		function viewResourceFile(trainId,resourceId,fileId){
			window.open('${ctx!}/train_resource/'+trainId+'/viewFile?resource.id='+resourceId+'&fileInfos[0].id='+fileId);
		};
		
    </script>
</@trainResourceViewData>
</@layout>
