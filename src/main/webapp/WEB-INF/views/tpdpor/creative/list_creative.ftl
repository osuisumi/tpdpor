<#include "/tpdpor/common/include/layout.ftl"/>
<#import "/tpdpor/common/tags/image.ftl" as image/>
<#global relationId='tpdpor'>
<#assign relationType='creative'>
<#assign state=(creative.state)!''>
<#assign jsArray=['${ctx!}/js/common/ueditorUtils.js','${ctx!}/js/common/ueditor/ueditor.config.js',
	'${ctx!}/js/common/ueditor/ueditor.all.js','${ctx!}/js/common/laypage/laypage.js']/>
<#assign cssArray=[]/>
<@layout jsArray=jsArray cssArray=cssArray mylayer=true validate=true>
	
	<#if (Session.loginer.id)?? >
		<#import "/tpdpor/common/tags/sign_frame.ftl" as sf />
		<@sf.signFrameFtl relationId=relationId relationType=relationType/>
	</#if>
	<form id="listCreativeForm" action="/creative">
		<div class="g-study-speak">
		    <div class="g-fixed-nav-box">
		        <div class="g-StuSpeak-nav">
		            	<ul class="m-StuSpeak-nav">
		            		<#list DictionaryUtils.getEntryList('CREATIVE_TYPE') as t>
		            			<li class="z-crt" item="${(t.dictValue)!}">
						            <a href="${ctx!}/creative?type=${(t.dictValue)!}">${(t.dictName)!}</a>
						        </li>
		            		</#list>
					    </ul>
					<#if (Session.loginer.id)?? >
		            	<div class="m-go-speak" onclick="goCreateCreative();"><i class="u-speak"></i>发起创客项目</div>        
		            </#if>             
		        </div>
		        	<input type="hidden" name="type" value="${(creative.type)!'teach'}">                        
			        <div class="m-StuSpeak-contNav">
			        	<@creativeNumData relationId=relationId relationType=relationType type=(creative.type)!'teach'>
			            	<ul id="secItemUl" class="m-contNav-box">
				                <li class="crt"><a href="javascript:;" item="">全部（${allNum!0 }）</a></li>
				                <#if (Session.loginer.id)?? >
				                	<li><a href="javascript:;" item="my">我的（${myNum!0 }）</a></li>
				                	<li class="line">|</li>
				                </#if>
			                    <li><a href="javascript:;" item="in_progress">进行中（${inProgressNum!0 }）</a></li>   
			                    <li class="line">|</li>
			                    <li><a href="javascript:;" item="chosen">已结束（${endNum!0 }）</a></li>                               
			                </ul>
		                </@creativeNumData>
		                <div class="m-addElement-item">
		                    <div class="ltxt">排序：</div>
		                    <div class="center">
		                        <div class="m-slt-row m-active-grade">
		                            <div class="block">
		                                <div class="m-selectbox style1">
		                                    <strong><span class="simulateSelect-text">按最新排序</span><i class="trg"></i></strong>
		                                    <select id="orderSelect" name="orders" onchange="changeOrder(this)">
		                                        <option value="CREATE_TIME.DESC" selected="selected">按最新排序</option>
		                                        <option value="CREATE_TIME.ASC" >按最旧排序</option>
		                                        <option value="BROWSE_NUM.DESC">按热度排序</option>
		                                    </select>
		                                </div>
		                            </div>
		                        </div>
		                    </div>
		                </div>
			        </div>
		    </div>
		    <div class="g-StuSpeak-cont">
		    	<#if (creative.state)! == 'my'>
		    		<#assign states=[]>
		    	<#else>
			    	<#assign states=['passed','excellent','no_excellent']>
		    	</#if>
	    	
		    	<@creativesData states=states! getStatus=true getAttitudeStatForSupport=true getCreativeAdviceNum=true type=(creative.type)!'teach' relationId=relationId relationType=relationType state=(creative.state)! page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders='TOP_DAYS,${(orders[0])!"CREATE_TIME.DESC"}'>
			        <#if (creatives?size > 0)>
				        <ul class="g-buildCourse-contlist">
				        	<#list creatives as creative>
				        		<#if (((creative.claimType)!'') == 'claim') && (((creative.claimState)!'') == 'claiming')>
				        			<li class="m-buildCourse-contlist">
		                                <div class="m-contlist-box">
		                                    <div class="cont-l">
		                                        <h3>
			                                        <a href="javascript:;" onclick="viewCreative('${(creative.id)!}')">${(creative.title)!''}</a>
		                                        </h3>
		                                        <p class="txt">${(JsonMapper.getJsonMapValue(creative.content, 'text'))!}</p>
		                                        <div class="who">
		                                            <a href="javascript:;">
														<@image.imageFtl url="${(creative.creator.avatar)!'' }" default="/images/tpdpor/${app_path}/defaultAvatar.jpg"/>
		                                                <span class="name">${(creative.creator.realName)!"" }</span>
		                                            </a>
		                                            <span class="time">发表于${TimeUtils.formatDate(creative.createTime, 'yyyy/MM/dd') }</span>
		                                        </div>
		                                    </div>
		                                    <div class="cont-r">
		                                        <a onclick="goClaimCreative('${(creative.id)!}');" class="u-btn-theme u-btn-rl">认领项目</a>
		                                        <p class="tips">
			                                        <span>征集时间：<b>${(creative.creativeRelations[0].collectDays)!0}</b>天</span>
			                                        <span>可认领对象：
				                                        <b>
			                                        		<#if ((creative.claimRole)!'') == '2'>
			                                        			在校老师
			                                        		<#elseif ((creative.claimRole)!'') == '3'>
			                                        			在校学生
			                                        		<#elseif ((creative.claimRole)!'') == 'member'>
			                                        			认证会员
			                                        		</#if>
			                                        	</b>
			                                        </span>
		                                        </p>
		                                    </div>
		                                </div>
		                            </li>
				        		<#else>
					        		<#if (((creative.creativeRelations[0].collectTimePeriod.startTime)?long) + ((creative.creativeRelations[0].collectDays)*24*60*60*1000 )) gt (.now?long)>
										<#assign days=(((creative.creativeRelations[0].collectTimePeriod.startTime)?long) + (creative.creativeRelations[0].collectDays)*24*60*60*1000 - .now?long) /1000/60/60/24 >
									<#else>
										<#assign days=0 >
									</#if>
								
						            <li class="m-buildCourse-contlist <#if (days) == 0>m-end</#if>">
						                <div class="m-contlist-box">
						                    <div class="cont-l">
						                        <h3>
						                            <a href="javascript:;" onclick="viewCreative('${(creative.id)!}')">${(creative.title)!''}</a>
						                            <#if 0 != ((statusMap[creative.id].top.days)!0)>
						                            	<span class="u-com-top"><i></i>顶</span>
						                            </#if>
						                            <#if 0 != ((statusMap[creative.id].official.days)!0)>
							                            <span class="u-com-web">官</span> 
							                        </#if>
							                        <#if 0 != ((statusMap[creative.id].hot.days)!0)>
								                        <span class="u-com-hot"><i></i>热</span>
								                    </#if> 
							                      	<#if 0 != ((statusMap[creative.id].essence.days)!0)>
			                                            <span class="u-com-best"><i></i>精</span>  
		                                            </#if> 
		                                            <#if ((creative.state)!'') == 'excellent'>
			                                            <span class="bc-tip begin-bc-tip">已评优</span>
		                                            </#if>
		                                            <#if ((creative.state)!'') == 'passed'>
							                            <span class="bc-tip pass-bc-tip">已审核</span>
		                                            </#if>
		                                            <#if ((creative.state)!'') == 'no_pass'>
							                            <span class="bc-tip un-bc-tip">审核未通过</span>                                           
		                                            </#if>                                        
						                        </h3>
						                        <p class="txt">${(JsonMapper.getJsonMapValue(creative.content, 'text'))!}</p>
						                        <div class="who">
						                            <a href="javascript:;">
						                                <@image.imageFtl url="${(creative.creator.avatar)!'' }" default="/images/tpdpor/${app_path}/defaultAvatar.jpg" class="img"/>
						                                <span class="name">${(creative.creator.realName)!"" }</span>
						                            </a>
						                            <span class="time">发表于${TimeUtils.formatDate(creative.createTime, 'yyyy/MM/dd') }</span>
						                        </div>
						                    </div>
						                    <div class="cont-r">
						                        <ul class="m-situation">
						                            <li>
						                                <strong class="hot">${(creative.creativeRelations[0].browseNum)!0 }</strong>
						                                <a href="javascript:;" class="u-hot"><i></i>热度</a>
						                            </li>
						                            <li>
						                                <strong class="praise">${(attitudeStatMapForSupport[creative.id].participateNum)!0 }</strong>
						                                <a href="javascript:;" class="u-praise"><i></i>点赞</a>
						                            </li> 
						                            <li>
						                                <strong class="see">${(creativeAdviceNumMap[creative.id])!0 }</strong>
						                                <a href="javascript:;" class="u-see"><i></i>提意见</a>
						                            </li>                                                                                 
						                        </ul>
						                        <div class='m-progress'>
						                            <p>剩余<span>${days?string('0') }</span>天</p>
						                            <div class="progress-bar" style="width: ${(((creative.creativeRelations[0].collectDays) - days) / (creative.creativeRelations[0].collectDays)) * 100}%"></div>
						                        </div>
						                    </div>                                                                        
						                </div>
						                <#if state == 'my'>
							                <div class="m-get-other">
		                                        <p class="advise"><i class="u-advise"></i>你共收到<ins>${(creativeAdviceNumMap[creative.id])!0 }</ins>条建议<a onclick="viewCreative('${(creative.id)!}','adviceDiv');">查看建议&gt;</a></p>
		                                        <p class="time"><i class="u-time"></i>剩余<ins>${days?string('0') }</ins>天，请努力完善想法<a onclick="goCreateCreativeResource('${(creative.id)!}');" href="javascript:;">上传资源&gt;</a></p>
		                                        <span  onclick="deleteCreative('${(creative.id)!}');" class="m-del">删除</span>
		                                        <span class="btn-modIcon" onclick="updateCreative('${(creative.id)!}');"><i class="u-modIcon"></i>修改</span> 
		                                    </div>
	                                    </#if>
						                <div class="u-end">已结束</div>
						            </li>
				        		</#if>
				            </#list>
				        </ul>
				        <div id="listCreativeFormPage" class="m-laypage">
				        </div>
				    	<#import '/tpdpor/common/tags/pagination.ftl' as p />
						<@p.paginationFtl formId="listCreativeForm" divId="listCreativeFormPage" paginator=paginator />
					<#else>	
						<div class="m-no-resorce">
	                    	<p>还没有创客哦~</p>
	                    </div>
			        </#if>
				</@creativesData>
		    </div>                   
		</div>
	</form>
	<script>
		$(function(){
			lightMenu('${(creative.type)}');
			
			$('#orderSelect').simulateSelectBox({
			     byValue: '${(orders[0])!"CREATE_TIME.DESC"}'
			});	
			
			changeItem($('#secItemUl li a[item="${(item[0])!""}"]'));
			$('#secItemUl li a').click(function(){
				changeItem(this);
				$('#listCreativeForm').submit();
			});
			
		});
		
		function lightMenu(item){
    		$('.m-StuSpeak-nav li').removeClass('z-crt');
    		if(item == '' || item == null || item == undefined){
    			$('.m-StuSpeak-nav li:eq(0)').addClass('z-crt');
    		}else{
		    	$('.m-StuSpeak-nav li[item='+item+']').addClass('z-crt');
		    }
    	};
				    	
		function changeOrder(obj){
			$('#listCreativeForm').submit();
		};
		
		function changeItem(obj){
			$('#secItemUl li').removeClass('crt');
			$(obj).parent().addClass('crt');
			$('#listCreativeForm .itemParam').remove();
			var item = $(obj).attr('item');
			$('#listCreativeForm').append('<input type="hidden" class="itemParam" name="item" value="'+item+'">');
			if(item == 'my'){
				$('#listCreativeForm').append('<input type="hidden" class="itemParam" name="creator.id" value="${Session.loginer.id}">');
				$('#listCreativeForm').append('<input type="hidden" class="itemParam" name="state" value="my">');
			}else if(item == 'in_progress'){
				$('#listCreativeForm').append('<input type="hidden" class="itemParam" name="state" value="in_progress">');
			}else if(item == 'chosen'){
				$('#listCreativeForm').append('<input type="hidden" class="itemParam" name="state" value="chosen">');
			}
		};
		
		function goCreateCreative(){
			mylayerFn.open({
		        type: 2,
		        title: '发表创客项目',
		        fix: false,
		        area: [900, 900],
		        offset : [$(document).scrollTop()],
				shadeClose : true,
		        content: '${ctx}/creative/create?creativeRelations[0].relation.id=${relationId}&creativeRelations[0].relation.type=${relationType}&type=${(creative.type)!}'
		    });
		};
		
		function viewCreative(id,location){
			if(location == null || location == '' || location == undefined){
				window.open('${ctx}/creative/'+id+'/view?type=${(creative.type)!'teach'}');
			}else{
				window.open('${ctx}/creative/'+id+'/view?type=${(creative.type)!'teach'}#'+location);
			}
		};
		
		function goClaimCreative(id){
			if('${(Session.loginer.id)!}' == ''){
				alert('请先登录!');
				return false;
			}
			
			mylayerFn.open({
		        type: 2,
		        title: '认领项目',
		        fix: false,
		        area: [900, 500],
		        offset : [$(document).scrollTop()],
				shadeClose : true,
		        content: '${ctx}/creative/claim?id='+id
		    });
		};
		
		function updateCreative(id){
			mylayerFn.open({
				id : '999',
				type : 2,
				title : '修改创客',
				content : '${ctx!}/creative/'+id+'/edit',
				area : [900, 900],
				offset:[$(document).scrollTop()],
				fix : false,
				shadeClose : true,
			});	
		};
		
		function goCreateCreativeResource(id){			
			window.location.href = '${ctx!}/creative/resource/create?id='+id;
		};
		
		function deleteCreative(id){
			var $this = $(this);
			confirm('是否确定删除?',function(){
				$.post('${ctx!}/creative/'+id ,{
					'_method' : 'DELETE',
	 			},function(response){
	 				if(response.responseCode == '00'){
						window.location.reload();
						alert('删除成功!');
					}else{
						alert('删除失败!');
					};
	 			});
			});
		};
	</script>
</@layout>