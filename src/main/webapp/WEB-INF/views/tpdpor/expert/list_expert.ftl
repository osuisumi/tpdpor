<#include "/tpdpor/common/include/layout.ftl"/>
<#import "/tpdpor/common/tags/image.ftl" as image/>

<#assign jsArray=['${ctx!}/js/common/laypage/laypage.js']/>
<#assign cssArray=[]/>
<#assign formId='list_expert_form' />
<@layout jsArray=jsArray cssArray=cssArray>
	<@expertsData realName=(expert.user.realName)! 
	page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders=(param_orders)!'CREATE_TIME.DESC'>
	<div class="g-frame">
		<form id="${formId!}" action="${ctx!}/expert" method="get">
		<input type="hidden" class="orderParam" name="orders" value="${(param_orders)!}">
	    <div class="g-mn-tit">
	        <h2 class="m-tit">专家列表</h2>
	        <label class="m-srh">
	            <input type="text" class="ipt" placeholder="专家名称" name="user.realName" value="${(expert.user.realName)!}">
	            <i onclick="$('#${formId!}').submit();" class="u-srh1-ico"></i>
	        </label>
	    </div>
	    <div class="g-mn-mod">
	        <div class="g-train-box">
	        <#--
	            <div class="m-type-tab" id="orderDiv">
	                <a order="" href="javascript:;" class="z-crt">默认</a>
	                <a order="DOWNLOAD_NUM.DESC" href="javascript:;">下载量</a>
	                <a order="EVALUATE_RESULT.DESC" href="javascript:;">评分</a>
	                <a order="CREATE_TIME.DESC" href="javascript:;">上传时间</a>
	            </div>
	             -->
	            <script>
	            	$(function(){
	            		var orders = '${(param_orders)!}';
	            		$('#orderDiv a').removeClass('z-crt');
	            		$('#orderDiv a').each(function(){
		            		if($(this).attr('order') == orders){
								$(this).addClass('z-crt');		            			
		            		}
	            		});
	            	});
	            </script>
	            <ul class="m-expert-list">
	            	<#if (experts)??>
	            		<#list experts as expert>
			                <li>
			                    <div class="m-expert-info">
			                        <span class="img" onclick="viewExpert('${(expert.id)!}');" >
			                       		<@image.imageFtl url="${(expert.user.avatar)!'' }" default="/images/tpdpor/${app_path}/defaultAvatar.jpg"/>
			                        </span>
			                        <div class="name" onclick="viewExpert('${(expert.id)!}');">
			                       		<b>${(expert.user.realName)!}</b>
			                       		<#if (expert.user.sex)! == '1'>
			                       			男
			                       		<#elseif (expert.user.sex)! == '2'>
			                       			女
			                       		<#else>
			                       		</#if>
			                        </div>
			                        <div class="m-btm">
			                            <span>
			                            	<i class="u-ico-user"></i>${(expert.professionalTitle)!}
			                            </span>
			                        </div>
			                        <#-- 
			                        <p class="u-tips">
			                            <span>共享资源数：0</span>
			                            <span>资源下载量：0</span>
			                            <span>浏览量：0</span>
			                        </p>
			                        -->
			                        <a href="${ctx!}/expert/${(expert.id)}/view" class="u-btn-theme" target="_blank" href="javascript:;">进入</a>
			                    </div>
			                </li>
	                	</#list>
	                </#if>
	            </ul>
	        </div>
		    <div class="g-res-page">
		        <span class="num">共<b>${(paginator.totalCount)!0}</b>个专家</span>
		        <div id="expert_page" class="m-page-jump res"></div>
				<#import '/tpdpor/common/tags/pagination.ftl' as p />
				<@p.paginationFtl formId=formId! divId="expert_page" paginator=paginator />
		    </div>
	    </div>
	    </form>
	</div>
	
	<script>
		$(function(){
			$('#orderDiv a').click(function(){
				changeOrderDiv(this);
				$("#${formId!}").submit();
			});
		});
		
		function changeOrderDiv(o){
			$('#orderDiv a').removeClass('crt');
			$(o).addClass('crt');
			$('#${formId!} .orderParam').remove();
			var order = $(o).attr('order');
			$('#${formId!}').append('<input type="hidden" class="orderParam" name="orders" value="'+order+'">');
		};
		
		function viewExpert(id) {
			window.open('${ctx}/expert/'+id+'/view');
		}
	</script>
	</@expertsData>
</@layout>