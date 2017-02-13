<#macro adminPage formId divId paginator>     
	<div class="mis-select-tabNum">
            <span>每页显示条数:</span>
            <select name="limit" id="" onchange='javascript:$("#${formId}").submit();'>
        	<#assign limitArray = [10,20,50]>
			<#list limitArray as limit>
             <option value="${limit}" <#if limit==paginator.limit>selected</#if>>${limit}条</option>
			</#list>
        	</select>
    </div>                                       
	<div class="mis-trun-page">
        <a href="javascript:;" class="first" title="第一页"></a>
        <a href="javascript:;" class="prev" title="上一页"></a>
        <span>第<input type="text" name="page" value="${paginator.page}" class="ipt" />页，
        <#assign startRow=0/>
        <#assign endRow=0/>	                                               
        <#if paginator.totalCount lte 0|| paginator.limit lte  0>
			 <#assign totalPages=0/>													 
		<#else>
			<#assign totalPages=paginator.totalCount/paginator.limit />
			<#if paginator.totalCount%paginator.limit &gt; 0>
				<#assign totalPages=totalPages+1/>	
			</#if>
         	<#if paginator.page gt 0>
		    	 <#assign startRow=(paginator.page-1)*paginator.limit+1/>	
		    	 <#assign endRow=paginator.page*paginator.limit/>	
		    	 <#if paginator.totalCount lte endRow>
		    	 	<#assign endRow=paginator.totalCount/>
		    	 </#if>
			</#if> 
		</#if> 												
       		 共${totalPages?floor}页
		</span>
        <a href="javascript:;" class="next" title="下一页"></a>
        <a href="javascript:;" class="last" title="最后一页"></a>
    </div>                                          
    <span class="page-num">第<strong>${startRow}-${endRow}</strong>条，共<strong>${paginator.totalCount}</strong>条</span>
    <script>
	$(document).ready(function(){
		var $page = $("#${formId} input[name=page]");
		$("#${formId} .first").click(function(){
			if($page.val()<="1"){
				return;
			}
			$page.val("1");
			$("#${formId}").submit();
		});
		
		$("#${formId} .prev").click(function(){
			if($page.val()=="1"){
				return;
			}
			$page.val(parseInt($page.val())-1);
			$("#${formId}").submit();
		});
		
		$("#${formId} .next").click(function(){
			if($page.val()>=${totalPages?floor}){
				return;
			}
			$page.val(parseInt($page.val())+1);
			$("#${formId}").submit();
		});
		
		$("#${formId} .last").click(function(){
			if($page.val()>=${totalPages?floor}){
				return;
			}
			$page.val("${totalPages?floor}");
			$("#${formId}").submit();
		});
	});
	</script>
</#macro>