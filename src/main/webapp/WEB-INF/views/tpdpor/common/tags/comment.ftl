<#macro comment relationId relationType attitudeRelationType canComment=true>
<#import "/tpdpor/common/tags/image.ftl" as image/>
<div class="g-comment">	
<#if canComment>
	<div class="m-tit">
        <h4 class="u-tt">您的评论</h4>
        <#--                                    
        <div class="m-stars">
            <i class="u-star null"></i>
            <i class="u-star null"></i>
            <i class="u-star null"></i>
            <i class="u-star null"></i>
            <i class="u-star null"></i>
        </div>
       -->
    </div>
    <#if (Session.loginer.id)! == ''>    	
	    <div class="m-login">您需要登录后方可评论，请<a onclick="login();" href="javascript:;">登录</a></div>
    <#else>
    	<div class="m-comment-lst my-comment">
            <div class="m-comment-box">
                <textarea name="" id="trianResourceContent" placeholder="说一句吧~"></textarea>
                <div class="u-btm">
                    <span class="user">
                        <@image.imageFtl url="${(Session.loginer.avatar)!}" default="/images/tpdpor/es/defaultAvatar.jpg" />
                        <span>${(Session.loginer.realName)!}</span>
                    </span>
                    <a onclick="saveComment();" href="javascript:;" class="u-btn-theme">提交</a>
                    <script>
                    	function saveComment(){
							var content = $('#trianResourceContent').val().trim();
							if(content == '' || content == null || content == undefined){
								alert('写点评论内容吧');
								return false;
							}
							var evaluateScore = 0;
							/*$('.m-tit').find('.m-stars').find('i').each(function(i,e){
								if($(e).hasClass('z-in')){
									evaluateScore++;
								}
							});*/
							
                    		$.post('/comment','relation.id=${(relationId)!}&relation.type=${(relationType)!}&content='+content+'&evaluateScore='+evaluateScore,function(data){
                    			if(data.responseCode == '00'){
                    				$('#trianResourceContent').val('');
                    				$('#commentDiv').load('${ctx!}/tpdpor/comment?relationId=${(relationId)!}&relationType=${(relationType)!}&attitudeRelationType=${(attitudeRelationType)!}');
                    			}
                    		
                    		});
                    	};
                    </script>
                </div>
            </div>
        </div>
    </#if>
</#if>
	<div class="m-comment">
		<div class="m-tit-tab">
			<a href="javascript:;" class="u-tit z-crt">用户评论<span>（${(paginator.totalCount)!0}）</span></a>
		</div>
		<div class="m-con-tab" id="commentDiv">
			<script>
				$(function(){
					$('#commentDiv').load('${ctx!}/tpdpor/comment?relationId=${(relationId)!}&relationType=${(relationType)!}&attitudeRelationType=${(attitudeRelationType)!}');
				});
			</script>
		</div>
	</div>
</div>
</#macro>