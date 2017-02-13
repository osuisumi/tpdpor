<#macro creativeContent id op relationId relationType type>
	<#import "/tpdpor/common/tags/image.ftl" as image/>
	<#assign hasCreativeManagerRole=SecurityUtils.getSubject().hasRole('creative_manager_'+(id)!)>
	<#assign days=0 >
	<@creativeData id=id op=op relationId=relationId relationType=relationType type=type updateBrowseNum=true getAttitudeStatForSupport=true getAdviceUser=true>
		<#if creativeModel??>
			<#assign creative=creativeModel> 
			<#if (creative.creativeRelations[0].collectTimePeriod.startTime)??>
				<#assign isStart='Y'>
				<#if (((creative.creativeRelations[0].collectTimePeriod.startTime)?long) + ((creative.creativeRelations[0].collectDays)*24*60*60*1000 )) gt (.now?long)>
					<#assign days=(((creative.creativeRelations[0].collectTimePeriod.startTime)?long) + (creative.creativeRelations[0].collectDays)*24*60*60*1000 - .now?long) /1000/60/60/24 >
				</#if>
			<#else>
				<#assign isStart='N'>
			</#if>
			<div class="g-cont-detail">
		        <div class="g-cont-detail-box">
		            <div class="g-cont-detailIn">
		                <div class="m-detail-hd">
		                    <div class="m-detail-tl">
		                        <h3>${(creative.title)!''}</h3>
		                        <#if ((creative.state)!'') ==  'excellent'>
		                        	<p class="tips ysh">恭喜您通过评优，获得奖励100积分，且用户下载一次您的资源，您即可获得20积分</p>
		                        <#elseif ((creative.state)!'') ==  'no_excellent'>
		                        	<p class="tips pyz">评优不通过，继续加油</p>
		                        <#elseif ((creative.state)!'') ==  'passed'>
		                        	<p class="tips ysh">恭喜您审核通过，学员下载一次您的资源，您即可获得10积分</p>
		                        <#elseif ((creative.state)!'') ==  'no_pass'>
		                        	<p class="tips pyz">审核不通过，继续加油</p>
		                        <#else>
		                        </#if>
		                        <a href="${ctx!}/creative?type=${(creative.type)!'teach'}">&lt;返回上一级</a>
		                    </div> 
		                    <div class="m-who-detail">
		                        <div class="who">
		                            <span class="img">
			                            <a href="javascript:;">
				                            <@image.imageFtl url=(creative.creator.avatar)! default="/images/tpdpor/${app_path}/defaultAvatar.jpg" />
				                            <ins>${creative.creator.realName }</ins>
			                            </a>
		                            </span>
		                            <span>发表于${TimeUtils.formatDate(creative.createTime, 'yyyy-MM-dd') }</span>
		                            <span class="u-see"><i></i>浏览${(creative.creativeRelations[0].browseNum)!0 }</span>
									<#if isStart! == 'Y'>
										<#if (days) gt 0>
											<span class="m-progress">
												<p>剩余<i>${days?string('0') }</i>天</p>
												<ins class="progress-bar" style="width:${(((creative.creativeRelations[0].collectDays) - days) / (creative.creativeRelations[0].collectDays)) * 100}%"></ins>
											</span>
										<#else>
											<span class="m-active-end">
			                            		已结束
	                                    	</span>
										</#if>
									</#if>
		                        </div>
		                        <#-- 
		                        <div class="share">
                                    <span>分享：</span>
                                    <div class="bdsharebuttonbox"><a href="" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></div>
                                </div>
                                -->
		                        <#if ((creative.state)!'') == 'excellent' >
			                        <div class='end-active-sign pass-active-sign'>
			                            <p>已评优</p>
			                        </div>
			                    <#elseif ((creative.state)!'') ==  'passed'>
			                    	<#if days gte 0 >
				                     	<div class='end-active-sign begin-active-sign'>
				                            <p>已审核</p>
				                        </div>
			                    	<#else>
			                    		<div class='end-active-sign begin-active-sign'>
				                            <p>评优中</p>
				                        </div>
			                    	</#if>
			                    <#elseif ((creative.state)!'') ==  'auditing'>
			                     	<div class='end-active-sign end-active-sign'>
			                            <p>审核中</p>
			                        </div>
		                        </#if>
		                    </div>
		                </div>
		                <ul class="m-some-welcome">
		                    <li class="hot"><i></i><p>热度(${(creative.creativeRelations[0].browseNum)!0 })</p></li>
		                    <li onclick="createAttitudeForCreative('${(creative.id)!}', 'creative', null, this)" class="praise"><i></i><p>赞(<ii class="supportNum">${(attitudeStatMapForSupport[creative.id].participateNum)!0 }</ii>)</p></li>
		                    <li onclick="goCreateAdvice(${days!});" class="see"><i></i><p>提建议(<ii class="viewAdviceCount">${creativeAdviceNum!0}</ii>)</p>
		                        <div class="border1"></div>
		                        <div class="border2"></div>
		                    </li>
		                </ul>
		                <ul class="m-detail-cont">
		                    <li class="m-detail-cont-list">
		                        <div class="m-tl">
		                            <h4 class="title">【创客想法】</h4>
		                            <ul class="u-desc-opt">
		                            	<#if ((creative.stage)!'') != ''>
		                                	<li>${TextBookUtils.getEntryName('STAGE', (creative.stage)!'') }</li>
		                                </#if>
		                                <#if ((creative.grade)!'') != ''>
		                                	<li>${TextBookUtils.getEntryName('GRADE', (creative.grade)!'') }</li>
		                                </#if>
		                                <#if ((creative.subject)!'') != ''>
		                                	<li>${TextBookUtils.getEntryName('SUBJECT', (creative.subject)!'') }</li>
		                                </#if>
		                            </ul>
		                        </div>
		                        <div class="m-think-detTxt">
		                            <p>${(JsonMapper.getJsonMapValue(creative.content, "content"))!}</p>
		                        </div>
		                    </li>
		                    <li class="m-detail-cont-list">
	                        	<div class="m-tl">
							        <h4 class="title">【成果展示】</h4>
							        <div class="resource-button">
							        <#if (days) gt 0>
								        <#if hasCreativeManagerRole>
								        	<a onclick="goCreateCreativeResource('${(creative.id)!}');" class='au-uploadFile au-fill-btn'><i class="au-uploadFile-ico"></i>上传资源</a>
								        </#if>
								        <a class="au-uploadSee au-fill-btn">查看全部&gt;</a>
							        </#if>
							        </div>
							    </div>
								<div id="listCreativeResourceDiv"></div>
		                        <#if ((creative.state)!'') == 'excellent'>
		                        	<p class="u-tips">浏览/下载所需积分：<b>20</b></p>
		                        <#else>	
		                        	<p class="u-tips">浏览/下载所需积分：<b>10</b></p>
		                        </#if>
		                    </li>
		                    <li class="m-detail-cont-list">
		                        <div class="m-tl">
		                            <h4 class="title">参与支持/建议成员：<span>${(adviceUserMap?size)!0}</span></h4>
		                        </div>
		                        <div class="m-wantSee-detTxt">                                
		                            <ul class="m-wantSee-who max-width">
		                            	<#if (adviceUserMap)??>
			                            	<#list adviceUserMap?keys as key>
			                                <li>
			                                    <a href="javascript:;">
			                                        <@image.imageFtl url=(adviceUserMap[key].avatar)! default="/images/tpdpor/${app_path}/defaultAvatar.jpg" />
			                                        <p class="name">${(adviceUserMap[key].realName)!}</p>
			                                    </a>
			                                </li>
			                                </#list>
			                        	</#if>
		                                
		                            </ul>
		                            <div class="m-more">
		                                <div class="u-more"><i class="down-icon"></i><i class="up-icon"></i></div>
		                                <p class="down-more">展开</p>
		                                <p class="up-more">收起</p>
		                            </div>
		                        </div>
		                    </li>
		                </ul>
		                <div class="m-other-cont">
		                    <a href="javascript:;" onclick="viewCreative('${creative.id}', 'createTimeGt')">上一篇</a>
		                    <span>|</span>
		                    <a href="javascript:;" onclick="viewCreative('${creative.id}', 'createTimeLt')">下一篇</a>
		                </div>
		            </div>
		            <div class="g-cont-discuss" id="adviceDiv">
		                <div class="m-discuss-hd">
		                    <div class='hd-txt'>
		                        <i class="u-discuss"></i>
		                        <strong>建议<span>共有<ii class="creativeAdviceNum">0</ii>条建议</span></strong>
		                    </div>
		                </div>
		                <div class="m-my-comment">
		                    <a href="javascript:;" class="myname">
		                    	<@image.imageFtl url="${(creative.creator.avatar)!}" default="/images/tpdpor/es/defaultAvatar.jpg" />
		                    </a>
		                    <div class="my-textarea">
		                        <textarea  id="adviceContent" placeholder="请输入你的评论"></textarea>
		                        <div class="am-cmtBtn-block f-cb">
		                        <#-- 
		                            <a href="javascript:void(0);" class="au-face"></a>
		                        -->
		                            <a onclick="saveCreativeAdvice('${(creative.id)!}');" href="javascript:void(0);" class="au-cmtPublish-btn au-confirm-btn1">发表</a>
		                        </div>                                    
		                    </div> 
		                </div>
		                <ul class="m-cont-discuss ag-cmt-lst-p" id="adviceListDiv">
		                	<script>
								$(function(){
									$('#adviceListDiv').load('${ctx!}/creative/advice?id=${(creative.id)!}');
								});
							</script>
		                </ul>
		            </div>
		        </div>
		    </div>
		<#else>
			<#import '/tpdpor/creative/creative_content.ftl' as mc>
			<@mc.creativeContent id=id op='' relationId=relationId relationType=relationType type=type/>
			<script>
				$(function(){
					if('${op!}' == 'createTimeGt'){
						alert('这是第一个项目');
					}else{
						alert('这是最后一个项目');
					}
				});
			</script>
		</#if>
		<script>
			$(function(){
				listCreativeResource();
				more_detail(".m-wantSee-detTxt .m-more",'.m-wantSee-who');
			});
			
			function listCreativeResource(){
				$('#listCreativeResourceDiv').load('/creative/resource', 'id=${(creative.id)!""}&queryType=resultShow&days=${days!0}');
			};
			
			function createAttitudeForCreative(relationId, type, attitude, obj){
				createAttitude(relationId, type, attitude, function(){
					alert('点赞成功'); 
			    	$(obj).find('.supportNum').text(parseInt($(obj).find('.supportNum').text()) + 1);
				});
		    };
		    
		    function goCreateAdvice(day){
		    	var isTimeout = 'N'; 
		    	if(day <= 0){
		    		isTimeout = 'Y';
		    	}
				if('${creative.creator.id}' == '${Session.loginer.id }'){
					alert('不能给自己提建议');
				}else{
					mylayerFn.open({
				        type: 2,
				        title: '提建议',
				        fix: true,
				        area: [600, 700],
				        shadeClose : true,
				        content: '${ctx!}/creative/creativeAdvice?id=${(creative.id)!}&isTimeout='+isTimeout
				    });
				}
			};
			
			function viewCreative(id, op){
				window.location.href = '${ctx!}/creative/'+id+'/view?op='+op+'&type=${type}';
			};
			
			//成员展示更多
			function more_detail(labelclick,udown){ 
			    var updown = true;
			    var who_width = $(udown).width();
			    if(who_width<870){
			        $(labelclick).addClass('unfind')
			    }
			    $(labelclick).on("click",function(){
			        if(updown==true){
			            $(this).siblings(udown).addClass('Heightauto');
			            $(this).find(".up-more").addClass('canfind').siblings('.down-more').addClass('notfind');
			            $(this).find(".up-icon").addClass('canfind').siblings('.down-icon').addClass('notfind');
			            updown=false;
			        }else if(updown==false){
			            $(this).siblings(udown).removeClass('Heightauto');
			            $(this).find(".up-more").removeClass('canfind').siblings('.down-more').removeClass('notfind');
			            $(this).find(".up-icon").removeClass('canfind').siblings('.down-icon').removeClass('notfind');
			            updown=true;
			        }
			    });
			};
			
			function saveCreativeAdvice(id){
				if('${(Session.loginer.id)!}' == ''){
					alert('请先登录!');
					return false;
				}
				var content = $('#adviceContent').val().trim(); 
				if(content == '' || content == undefined){
					return false;
				}
				if('${creative.creator.id}' == '${Session.loginer.id }'){
					alert('不能给自己提建议');
					return false;
				}
				$.post('${ctx!}/comment','relation.id='+id+'&relation.type=creative_advice&content='+content, function(data){
					if(data.responseCode == '00'){
						$('#adviceContent').val('');
						alert('发表成功!');
						$('#adviceListDiv').load('${ctx!}/creative/advice?id=${(creative.id)!}');
					}else{
						alert('发表失败!');
					}
				});
			};
		</script>
	</@creativeData>
</#macro>