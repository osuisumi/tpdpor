<#import "/userCenter/common/include/layout.ftl" as lo>
<#assign jsArray = ['${ctx!}/js/common/laypage/laypage.js'] />
<#assign cssArray = []>
<@lo.layout jsArray=jsArray cssArray=cssArray menu='wdjf'>
<#assign formId="listPointRecordForm"/>
<@ucPointRecordsTpdporDataDirective getScore=true getExpendScore=true userId=(Session.loginer.id)! relationId='tpdpor' 
	page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders=(param_orders)!'CREATE_TIME.DESC'>
<#import "/userCenter/common/include/form.ftl" as cf>
<@cf.form id="${formId!}" action="${ctx!}/userCenter/pointRecord" method="get">
<div class="g-EduResc-tab">
    <ul class="m-subscribe-tab">
        <li class="crt"><a href="javascript:;">全部(${(paginator.totalCount)!0})</a></li>
    </ul>  
    <div class="m-score">
        <span class="all">当前积分：<b>${score!0}</b></span>
        <span class="reduce">消耗积分：<b>${(expendScore)!0}</b></span>
    </div>
    <!--    
    <div class="chk-lst">
        <div class="m-slt-block1 mid">
            <a href="javascript:;" class="show-txt">
                <span class="txt">按消耗积分筛选</span>
                <i class="trg"></i>
            </a>
            <dl class="lst">
                <dd><a href="javascript:;" class="z-crt">按消耗积分筛选</a></dd>
                <dd><a href="javascript:;">按消耗积分筛选</a></dd>
                <dd><a href="javascript:;">按消耗积分筛选</a></dd>
                <dd><a href="javascript:;">按消耗积分筛选</a></dd>
                <dd><a href="javascript:;">按消耗积分筛选</a></dd>
            </dl>
        </div>
    </div>
    -->
</div>
<div class="m-EduResc-cont">
    <table class="m-tb-resorce">
        <thead>
            <th width="6%"><input type="checkbox" name="allcheck"></th>
            <th width="30%">题名</th>
            <th width="14%">
                <span class="txt">资源类型</span>
            </th> 
            <th width="14%">积分</th>
            <th width="18%">积分来源</th>
            <th width="18%">时间</th>
        </thead>
        <tbody>
			<#assign resourceIds = [] />
			<#assign creativeIds = []/>
        	<#if (pointRecords)??>
        		<#list pointRecords as pointRecord>
        			<#if PointEntityType.getEntityType((pointRecord.pointStrategy.type)!'') == 'creative'>
        				<#assign creativeIds = creativeIds + [(pointRecord.entityId)!'']/>
        			<#elseif PointEntityType.getEntityType((pointRecord.pointStrategy.type)!'') == 'creative_resource'>
        				<#assign resourceIds = resourceIds + [(pointRecord.entityId)!'']/>
        			<#elseif PointEntityType.getEntityType((pointRecord.pointStrategy.type)!'') == 'course_resource'>
        				<#assign resourceIds = resourceIds + [(pointRecord.entityId)!'']/>
        			</#if>
        		</#list>
        		<#if (resourceIds?size>0)>
        			<@resourceIdKeyMapDirective ids=resourceIds>
        				<#assign resourceIdKeyMap=resourceIdKeyMap!/>
        			</@resourceIdKeyMapDirective>
        		</#if>
        		<#if (creativeIds?size>0)>
        			<@creativeIdKeyMapDirective ids=creativeIds>
        				<#assign creativeIdKeyMap=creativeIdKeyMap!/>
        			</@creativeIdKeyMapDirective>
        		</#if>
        		<#list pointRecords as pointRecord>
		            <tr>
		                <td><input type="checkbox"></td>
		                <td class="book-name">
		        			<#if PointEntityType.getEntityType((pointRecord.pointStrategy.type)!'') == 'creative'>
		        				<a href="${ctx}/creative/${(creativeIdKeyMap[pointRecord.entityId].id)!}/view" target="_blank">${(creativeIdKeyMap[pointRecord.entityId].title)!'-'}</a>
		        			<#elseif PointEntityType.getEntityType((pointRecord.pointStrategy.type)!'') == 'creative_resource'>
		        				<a href="${ctx}/creative/resource/${(resourceIdKeyMap[pointRecord.entityId].id)!}/view" target="_blank">${(resourceIdKeyMap[pointRecord.entityId].title)!'-'}</a>
		        			<#elseif PointEntityType.getEntityType((pointRecord.pointStrategy.type)!'') == 'course_resource'>
		        				<#if (resourceIdKeyMap[pointRecord.entityId])??>
		        					<a href="${ctx}/course_resource/view/${resourceIdKeyMap[pointRecord.entityId].id}">${(resourceIdKeyMap[pointRecord.entityId].title)!}</a>
		        				<#else>
		        					<a href="javascript:;">-(该资源已被删除)</a>
		        				</#if>
		        			</#if>
		                </td>
		                <td>
		        			<#if PointEntityType.getEntityType((pointRecord.pointStrategy.type)!'') == 'creative'>
		        				创客项目
		        			<#elseif PointEntityType.getEntityType((pointRecord.pointStrategy.type)!'') == 'creative_resource'>
		        				创课资源类型
		        			<#elseif PointEntityType.getEntityType((pointRecord.pointStrategy.type)!'') == 'course_resource'>
		        				${DictionaryUtils.getEntryName('COURSE_RESOURCE_TYPE',(resourceIdKeyMap[pointRecord.entityId].resourceExtend.type)!'')}
		        			</#if>
		                </td>
		                <td><span class="operate">${(pointRecord.pointStrategy.point)!}</span></td>
		                <td>
    	        			${(pointRecord.pointStrategy.summary)!}
		                </td>
		                <td>${TimeUtils.formatDate(pointRecord.createTime,'yyyy-MM-dd')}</td>
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
               <div class="m-page-jump" id="listPointRecordFormPage"></div>
               <span class="num">找到<b>${(paginator.totalCount)!0}</b>条数据</span>
               <#import '/userCenter/common/tags/pagination.ftl' as p />
			<@p.paginationFtl formId="${(formId)!}" divId="listPointRecordFormPage" paginator=paginator! />
           </div>
       </div>
</div>
</@cf.form>
</@ucPointRecordsTpdporDataDirective>

<script>
	$(function(){
		allCheckbox();
	});
	
	function allCheckbox(){
	    $("input[name='allcheck']").on("click",function(){
	        var TF = $(this).prop("checked");
	        if(TF==false){
	             $("td input[type='checkbox']").prop("checked",false);
	        }else if(TF==true){
	            $("td input[type='checkbox']").prop("checked",true);
	        }        
	    });
	};
</script>
</@lo.layout>