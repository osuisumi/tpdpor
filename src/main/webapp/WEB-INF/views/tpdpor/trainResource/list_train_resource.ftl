<#import "/tpdpor/common/tags/image.ftl" as image/>
<div class="g-mn-tit">
	<form id="listTrainReourceForm" action="/train_resource">
	    <div id="trainTypeDiv" class="train-type-tab">
	        <a href="javascript:;" type="" class="z-crt">全部</a>
	        <span class="line">|</span>
	        <a href="javascript:;" type="curriculum">课程</a>
	        <span class="line">|</span>
	        <a href="javascript:;" type="case">案例</a>
	        <span class="line">|</span>
	        <a href="javascript:;" type="material">素材</a>
	        <span class="line">|</span>
	        <a href="javascript:;" type="other">其他</a>
	    </div>
	    <div id="orderDiv" class="sort-type-tab">
	        <a href="javascript:;" order="" class="z-crt">默认</a>
	        <span class="line">|</span>
	        <a href="javascript:;" order="DOWNLOAD_NUM.DESC" >下载量</a>
	        <span class="line">|</span>
	        <#-- <a href="javascript:;" order="EVALUATE_RESULT.DESC" >评分</a>
	        <span class="line">|</span> -->
	        <a href="javascript:;" order="CREATE_TIME.DESC" >上传时间</a>
	    </div>
	</form>
</div>

<#if (Session.loginer.id)??>
	<#assign getApplyRecord=true />
<#else>
	<#assign getApplyRecord=false />
</#if>

<@trainResourcesData resourceRelationType='train_resource' getApplyRecord=getApplyRecord  type=(param_type)! stage=(param_stage)! subject=(param_subject)!
	post=(param_post)! topic=(param_topic)! belong=(param_belong)!
	page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders=(param_order)!'CREATE_TIME.DESC'>
	<div class="g-mn-mod">
	    <div class="g-train-box">
	        <ul class="m-train-lst">
	        	<#if trainResources?size gt 0>
		        	<#list trainResources as tr>
			            <li>
			                <div href="javascript:;" class="block">
			                    <a href="javascript:;" onclick="viewTrainResource('${(tr.resource.id)!}');" class="img train">
			                    	<#if ((tr.resource.resourceExtend.coverUrl)!'') != ''>
			                    		<@image.imageFtl url="${(tr.resource.resourceExtend.coverUrl)!'' }" default="/images/tpdpor/${app_path}/train.jpg"/>
			                    	</#if>
			                    </a>
			                    <div class="m-case-info">
			                        <h3 class="u-tit"><a href="javascript:;" onclick="viewTrainResource('${(tr.resource.id)!}');">${(tr.resource.title)!''}</a></h3>
			                        <p class="u-txt">${(tr.resource.summary)!''}</p>
			                        <div class="u-btm">
			                            <span class="name">${(tr.resource.creator.realName)!"" }</span>上传于${TimeUtils.formatDate((tr.resource.createTime)!0, 'yyyy-MM-dd HH:mm:ss') } <span class="line">|</span>参加人数：${(tr.participateNum)!0}
			                           <#--  <div class="m-stars">
			                            	<#if (tr.resource.resourceExtend.evaluateResult) gt 0 >
			                            		<#list 1..5 as i>
			                            			<#if (tr.resource.resourceExtend.evaluateResult) gte i>
			                            				<i class="u-star full"></i>
			                            			<#else>
			                            				<i class="u-star null"></i>
			                            			</#if>
			                            		</#list>
			                            	<#else>
			                            		<#list 0..4 as i>
			                            			<i class="u-star null"></i>
			                            		</#list>
			                                </#if>
			                            </div> -->
			                        </div>
			                    </div>
			                    <div class="m-rt">
			                        <div class="mid">
			                        	<#if ((tr.resource.privilege)!'')?contains('free') || ((tr.resource.privilege)!'')?contains((Session.loginer.roleCode)!'-')>
			                        		<a onclick="viewTrainResource('${(tr.resource.id)!}');" href="javascript:;" class="u-btn-theme">加入学习</a>
			                        	<#else>	
			                        		<#if ((applyRecordMap[tr.resource.id].applyState)!'') == 'apply' >
					                            <a class="u-btn-theme applying" href="javascript:;">申请中</a>
											<#elseif ((applyRecordMap[tr.resource.id].applyState)!'') == 'passed'>											                        		
					                            <a onclick="viewTrainResource('${(tr.resource.id)!}');" href="javascript:;" class="u-btn-theme">加入学习</a>
					                        <#elseif ((applyRecordMap[tr.resource.id].applyState)!'') == 'nopass'>											                        		
					                            <a class="u-btn-theme fail" href="javascript:;">申请失败</a>
					                        <#else>
					                            <a onclick="applyStudy('${(tr.train.id)!}','${(tr.resource.id)!}');" class="u-btn-theme apply" href="javascript:;">申请学习</a>
				                        	</#if>
			                        	</#if>
			                        	
			                        </div>
			                    </div>
			                </div>
			            </li>
	            	</#list>
            	<#else>
            		<div class="m-no-resorce">
                    	<p>还没有培训学习哦~</p>
                    </div>
            	</#if>
	        </ul>
	    </div>
	    <form id="list_train_resource_form" action="${ctx!}/train_resource" method="get">
			<input type="hidden" name="type" value="${(param_type)!}">
			<input type="hidden" name="order" value="${(param_order)!'CREATE_TIME.DESC'}">
			<input type="hidden" name="post" value="${(param_post)!}">
			<input type="hidden" name="topic" value="${(param_topic)!}">
			<input type="hidden" name="stage" value="${(param_stage)!}">
			<input type="hidden" name="subject" value="${(param_subject)!}">
			<input type="hidden" name="belong" value="${(param_belong)!}">
		    <div class="g-res-page">
		        <span class="num">共<b>${(paginator.totalCount)!0}</b>个课程</span>
		        <div id="train_resource_page" class="m-page-jump res"></div>
		        <#import '/tpdpor/common/tags/pagination_ajax.ftl' as p />
				<@p.paginationAjaxFtl formId="list_train_resource_form" divId="train_resource_page" paginator=paginator contentId='train_resource_div' />
		    </div>
	    </form>
	</div>
</@trainResourcesData>
<script>
	$(function(){
		lightTrainTypeMenu('${(param_type)!}');
		lightOrderMenu('${(param_order)!}');
		
		changeTrainTypeDiv($('#trainTypeDiv a[type="${(param_type)!""}"]'));
		$('#trainTypeDiv a').click(function(){
			changeTrainTypeDiv(this);
			$('#train_resource_div').load('${ctx!}/train_resource?'+$('#list_train_resource_form').serialize());
		});
		
		changeOrderDiv($('#orderDiv a[order="${(param_order)!}"]'));
		$('#orderDiv a').click(function(){
			changeOrderDiv(this);
			$('#train_resource_div').load('${ctx}/train_resource?'+$('#list_train_resource_form').serialize());
		});
		
		$(document).off('mouseenter','.m-stars i');
		$(document).off('mouseleave','.m-stars');
		$(document).off('click','.m-stars i');
	});
	
	function changeTrainTypeDiv(o){
		$('#trainTypeDiv a').removeClass('crt');
		$(o).addClass('crt');
		var type = $(o).attr('type');
		$('#list_train_resource_form').find('input[name="type"]').val(type);
	};
	
	function changeOrderDiv(o){
		$('#orderDiv a').removeClass('crt');
		$(o).addClass('crt');
		var order = $(o).attr('order');
		$('#list_train_resource_form').find('input[name="order"]').val(order);
	};
	
	function lightTrainTypeMenu(item){
		$('#trainTypeDiv a').removeClass('z-crt');
		if(item == '' || item == null || item == undefined){
			$('#trainTypeDiv a:eq(0)').addClass('z-crt');
		}else{
	    	$('#trainTypeDiv a[type='+item+']').addClass('z-crt');
	    }
	};
	
	function lightOrderMenu(item){
		$('#orderDiv a').removeClass('z-crt');
		if(item == '' || item == null || item == undefined){
			$('#orderDiv a:eq(0)').addClass('z-crt');
		}else{
	    	$('#orderDiv a[order="'+item+'"]').addClass('z-crt');
	    }
	};
	
	function applyStudy(trainId,resourceId){
		if('${(Session.loginer.id)!}' == ''){
			alert('请先登录!');
			return false;
		}
		
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
				'relation.id':trainId,
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
	
	function viewTrainResource(id){
		window.open('${ctx!}/train_resource/'+id+'/view');
	};
</script>