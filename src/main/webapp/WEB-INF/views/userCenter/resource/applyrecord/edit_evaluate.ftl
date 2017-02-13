<body>
<@commentsDirective relationId=(param_resourceId)! relationType=(param_relationType)!'teach_resource_evaluate'>
	<#if (comments)??>
		<#assign comment = comments[0]!>
	</#if>
</@commentsDirective>
<form id="editRecordForm" action="${ctx}/userCenter/resource_read_record/saveEvaluate">
	<input type="hidden" id="resourceId" value="${param_resourceId!}" >
	<input type="hidden" id="relationType" value="${param_relationType!'teach_resource_evaluate'}" >
	<div class="g-comment g-want-see">
	    <div class="m-tit">
	        <h4 class="u-tt">您的评价</h4>                                    
	        <div class="m-stars">
	        	<#if (comment.evaluateScore) gt 0 ><i class="u-star null z-in"></i><#else><i class="u-star null"></i></#if>
	            <#if (comment.evaluateScore) gt 1 ><i class="u-star null z-in"></i><#else><i class="u-star null"></i></#if>
	            <#if (comment.evaluateScore) gt 2 ><i class="u-star null z-in"></i><#else><i class="u-star null"></i></#if>
	            <#if (comment.evaluateScore) gt 3 ><i class="u-star null z-in"></i><#else><i class="u-star null"></i></#if>
	            <#if (comment.evaluateScore) gt 4 ><i class="u-star null z-in"></i><#else><i class="u-star null"></i></#if>
	        </div>
	    </div>
	    <div class="m-pj-box">
	        <div class="m-comment-lst my-comment">
	            <div class="m-comment-box">
	                <textarea name="evaluateContent" id="rrContent" required placeholder="说一句吧~">${(comment.content)!}</textarea>
	            </div>
	        </div>
	    </div>
	    <div class="m-addElement-btn">
	        <a href="javascript:;" class="btn u-main-btn" onclick="saveEvaluate()">确定</a>
	        <a href="javascript:;" class="btn u-inverse-btn u-cancelLayer-btn" onclick="mylayerFn.closelayer($('#editRecordForm'))">取消</a>
	    </div>
	</div>
</form>

<script>
	$(function(){
		commonJs.fn.evaluateStat();//用户星星评价		
	});
	
	function saveEvaluate(){
		if(!$('#editRecordForm').validate().form()){
			return false;
		}
		var content = $('#rrContent').val();
		var resourceId = $('#resourceId').val();
		var relationType = $('#relationType').val();
		var score = $('#editRecordForm .m-stars .u-star.z-in').size();
		
		if('${(comment.id)}' != ''){
			$.post('${ctx}/comment/${(comment.id)!}',{
				'_method':'PUT',
				'content':content,
				'evaluateScore':score
			},function(response){
				if(response.responseCode == '00'){
					alert('操作成功',function(){
						mylayerFn.closelayer($('#editRecordForm'));
					});
				}
			});
		}else{			
			$.post('${ctx}/comment',{
				'relation.id':resourceId,
				'relation.type':relationType,
				'content':content,
				'evaluateScore':score
			},function(response){
				if(response.responseCode == '00'){
					alert('操作成功',function(){
						mylayerFn.closelayer($('#editRecordForm'));
					});
				}
			});
		}
	}
</script>
</body>