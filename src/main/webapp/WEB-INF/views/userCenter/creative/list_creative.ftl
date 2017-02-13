<#import "/userCenter/common/include/layout.ftl" as lo>
<#assign jsArray = ['${ctx!}/js/common/laypage/laypage.js'] />
<#assign cssArray = ['${ctx!}/js/common/laypage/skin/laypage.css']>
<@lo.layout jsArray=jsArray cssArray=cssArray mylayer=true menu='jsck'>
<#assign formId="listCreativeForm"/>
<@creativesData getCreativeUser=true getAdviceUserNum=true state='my' userId=(Session.loginer.id)!
	page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders=(param_orders)!'CREATE_TIME.DESC'>
	<#import "/userCenter/common/include/form.ftl" as cf>
	<@cf.form id="${formId!}" action="${ctx!}/userCenter/creative" method="get">
	<div class="g-EduResc-tab">
	    <ul class="m-subscribe-tab">
	        <li class="crt"><a href="javascript:;">全部(${(paginator.totalCount)!0})</a></li>
	       <#-- 
	        <li><a href="javascript:;">上传(0)</a></li>
	        <li><a href="javascript:;">收藏(0)</a></li>
	        -->
	    </ul>   
	    <#--    
	    <div class="chk-lst">
	        <div class="m-slt-block1 mid">
	            <a href="javascript:;" class="show-txt">
	                <span class="txt">按项目名称筛选</span>
	                <i class="trg"></i>
	            </a>
	            <dl class="lst">
	                <dd><a href="javascript:;" class="z-crt">按项目名称筛选</a></dd>
	                <dd><a href="javascript:;">按状态筛选</a></dd>
	            </dl>
	        </div>
	    </div>
	    -->
	</div>
	<div class="m-EduResc-cont">
	    <table class="m-tb-resorce">
	        <thead>
	            <th width="26%">项目名称</th>
	            <th width="20%">管理人</th>
	            <th width="20%">
	            	<span class="txt">
		            	状态
		            	<i class="u-ico-sort up add"></i>
						<i class="u-ico-sort down blur"></i>
					</span>
	            </th>
	            <th width="16%">项目截止时间</th>
	            <th width="12%">参加人数</th>
	        </thead>
	        <tbody>
	        	<#if creatives??>
					<#list creatives as creative>
			            <tr>
			                <td class="book-name"><a href="${ctx}/creative/${(creative.id)!}/view" target="_blank">${(creative.title)!}</a></td>
			                <td>${(creativeUserMap[creative.id].user.realName)!'----'}</td>
			                <td>
			                	<#if (creative.creativeRelations[0].collectTimePeriod.startTime)??>
									<#if (creative.state)! == 'auditing'>
										审核中
									<#elseif (creative.state)! == 'passed'>
										审核通过
									<#elseif (creative.state)! == 'no_pass'>
										审核不通过
									<#elseif (creative.state)! == 'excellent'>
										评优通过
									<#elseif (creative.state)! == 'no_excellent'>
										评优不通过
									<#else>
										----
									</#if>
								<#else>
									未认领	
								</#if>
			                </td>
			                <td>
			                	<#if (creative.creativeRelations[0].collectTimePeriod.startTime)??>
									${TimeUtils.formatDate(creative.creativeRelations[0].collectTimePeriod.startTime, 'yyyy-MM-dd')! }
									~
									${TimeUtils.formatDate(creative.creativeRelations[0].collectTimePeriod.endTime, 'yyyy-MM-dd')! }
								<#else>
									----	
								</#if>
			                </td>
			                <td>${(adviceUserNumMap[creative.id])!0}</td>
			            </tr>
	            	</#list>
            	</#if>
	        </tbody>
	    </table>
	    <div class="m-btm-opa">
	    	<#-- 
        	<div class="u-lt">
                <label><input onclick="checkAllBox('${formId!}',this);" type="checkbox">全选</label>
                <a onclick="deleteCreative();" href="javascript:;">批量删除</a>
            </div>
            -->
            <div class="u-rt">
                <div class="m-laypage" id="listCreativeFormPage"></div>
                <span class="num">找到<b>${(paginator.totalCount)!0}</b>条数据</span>
                <#import '/userCenter/common/tags/pagination.ftl' as p />
				<@p.paginationFtl formId="${(formId)!}" divId="listCreativeFormPage" paginator=paginator! />
            </div>
        </div>
	</div>
	</@cf.form>
<script>
	$(function(){
		up_dowm(".u-ico-sort.up");
	    up_dowm(".u-ico-sort.down");
	    if('${(param_orders)!}' == 'STATE.DESC'){
	    	$('.u-ico-sort.up').addClass('add').removeClass('blur').siblings().removeClass('add').addClass('blur');
	    }
	    if('${(param_orders)!}' == 'STATE.ASC'){
	    	$('.u-ico-sort.down').addClass('add').removeClass('blur').siblings().removeClass('add').addClass('blur');
	    }
	});

	//三角排序
	function up_dowm(downup){ 
	    $('.u-ico-sort.down').removeClass('add').addClass('blur').siblings().addClass('add').removeClass('blur');
	    $(downup).on("click",function(){
	        $(this).addClass('add').removeClass('blur');
	        $(this).siblings().removeClass('add').addClass('blur');
	        
	        console.log($(this).hasClass('up'));
	        if($(this).hasClass('up')){
	        	$('.orderParam').remove();
	        	$('input[name="page"]').val(1);
	        	$('#${(formId)!}').append('<input type="hidden" class="orderParam" name="orders" value="STATE.DESC"></input>');
	        	$('#${(formId)!}').submit();
	        }
			if($(this).hasClass('down')){
				$('.orderParam').remove();
				$('input[name="page"]').val(1);
				$('#${(formId)!}').append('<input type="hidden" class="orderParam" name="orders" value="STATE.ASC"></input>');
				$('#${(formId)!}').submit();
	        }
	    });
	};
	
	function deleteCreative(){
		var ids = '';
		$("input[name='checkboxId']:checked").each(function(){
			ids = ids + $(this).val() + ',';		
		});
		
		if(ids != ''){
			confirm('是否确定删除?',function(){
				$.post('${ctx!}/userCenter/creative/batch' ,{
					'_method' : 'DELETE',
					'id' : ids
	 			},function(response){
	 				if(response.responseCode == '00'){
						window.location.reload();
						alert('删除成功!');
					}else{
						alert('删除失败!');
					};
	 			});
			});
		}
		
	};
</script>
</@creativesData>
</@lo.layout>