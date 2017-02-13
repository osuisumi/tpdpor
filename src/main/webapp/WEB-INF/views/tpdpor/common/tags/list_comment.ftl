<#import "/tpdpor/common/tags/image.ftl" as image/>
<@commentsDirective relationId=relationId[0]!'' relationType=relationType[0]!'' getAttitude=true attitudeRelationType=attitudeRelationType[0]!'' page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders='CREATE_TIME.DESC'>
	<#if (comments)??>
		<ul class="m-comment-lst tab-box z-crt" id="commentLst">
			<#list (comments) as comment>
				<li class="mainCommentLi" id="${(comment.id)!}">
					<a href="javascript:;" class="img">
						<@image.imageFtl url="${(comment.creator.avatar)!}" default="/images/tpdpor/es/defaultAvatar.jpg" />
					</a>
					<div class="u-top">
						<a href="javascript:;" class="name">${(comment.creator.realName)!''}</a>
						<span class="time">${TimeUtils.prettyTime((comment.createTime)!)}</span>
						<#--<div class="u-stars">
							<#if (comment.evaluateScore) gt 0>
								<#list 1..5 as i>
		                			<#if (comment.evaluateScore) gte i>
		                				<i class="u-small-star full"></i>
		                			<#else>
		                				<i class="u-small-star null"></i>
		                			</#if>
		                		</#list>
		                	<#else>
		                		<#list 0..4 as i>
		                			<i class="u-star null"></i>
		                		</#list>
							</#if>
						</div>-->
					</div>
					<div class="u-btm">
						<p class="txt">
							${(comment.content)!}
						</p>
						<div class="pro">
							<#if (attitudeUserMap[comment.id].attitude)! == 'support'>
								<a class="agree z-crt" href="javascript:;"><i class="u-ico-agree"></i><ii name="text">已赞同</ii>（<ii name="count">${(attitudeNumMap[comment.id].participateNum)!0}</ii>）</a>
							<#else>
								<a class="agree" href="javascript:;"><i class="u-ico-agree"></i><ii name="text">赞同</ii>（<ii name="count">${(attitudeNumMap[comment.id].participateNum)!0}</ii>）</a>
							</#if>
							<span class="line">|</span>
							<a href="javascript:;" class="reply"><i class="u-ico-reply"></i>（<ii>${(commentChildNumMap[comment.id])!0}</ii>）</a>
						</div>
					</div>
					<div class="g-reply">
						<ul class="m-comment-lst" page="1">
							<#-- 
							<li>
								<a href="javascript:;" class="img"> <img src="" alt=""> </a>
								<div class="u-top">
									<a href="javascript:;" class="name">崔圆圆</a>
									<span class="time">10分钟前</span>
								</div>
								<div class="u-btm">
									<p class="txt">
										很受益
									</p>
								</div>
							</li>
							-->
						</ul>
						<a href="javascript:;" class="m-more" <#if ((commentChildNumMap[comment.id])!0) gt 10><#else> style="display:none;"</#if>>加载更多</a>
						<div class="m-comment-box">
							<textarea name="" id="" placeholder="说一句吧~"></textarea>
							<div class="u-btm">
								<span class="user"> 
									<@image.imageFtl url="${(Session.loginer.avatar)!}" default="/images/tpdpor/es/defaultAvatar.jpg" />
									<span>${(Session.loginer.realName)!}</span> 
								</span>
								<a onclick="saveChildComment(this);" class="u-btn-theme">提交</a>
							</div>
						</div>
					</div>
				</li>
			</#list>
			<form id="list_comment_form" action="${ctx!}/tpdpor/comment" method="get">
				<input type="hidden" name="relationId" value="${relationId[0]!}">
				<input type="hidden" name="relationType" value="${(relationType[0])!}">
				<input type="hidden" name="attitudeRelationType" value="${attitudeRelationType[0]!}">
				<div class="g-res-page">
		            <span class="num">共<b>${(paginator.totalCount)!0}</b>条评论</span>
		            <div id="comment_page" class="m-page-jump res"></div>
		            <#import '/tpdpor/common/tags/pagination_ajax.ftl' as p />
					<@p.paginationAjaxFtl formId="list_comment_form" divId="comment_page" paginator=paginator! contentId='commentDiv' />
		        </div>
		    </form>
		</ul>
	</#if>
</@commentsDirective>

<li id="replyLiTemplet" style="display:none;">
	<a href="javascript:;" class="img"> <img src="/images/tpdpor/es/defaultAvatar.jpg" alt=""> </a>
	<div class="u-top">
		<a href="javascript:;" class="name"></a>
		<span class="time">片刻之前</span>
	</div>
	<div class="u-btm">
		<p class="txt">
		</p>
	</div>
</li>	
	
<script>
	$(function(){
		
		//展开用户评论
		$("#commentLst .reply").click(function(){
	        var _this = $(this);
	        var _thisMainLi = _this.closest('li');
	        var _thisReplyUl = _this.closest('li').find('.g-reply .m-comment-lst');
	        if(_this.hasClass("z-crt")){
	            _this.removeClass("z-crt");
	            _thisMainLi.find('.g-reply').hide();
	        }else{
	            _this.addClass("z-crt");
	            _thisMainLi.find('.g-reply').show();
	        }
	        
	        if(_this.hasClass("z-crt")){
	        	if(_thisMainLi.find('.g-reply .m-comment-lst li').length <= 0){
	        		_thisMainLi.find('.g-reply .m-comment-lst').attr('page','1');

	        		$.ajax({
						url: '${ctx!}/comment/api',
						type: 'GET',
						data: 'orders=CREATE_TIME.DESC&limit=10&page='+_thisMainLi.find('.g-reply .m-comment-lst').attr('page')+'&paramMap[mainId]='+_thisMainLi.attr('id')+'&paramMap[parentId]='+_thisMainLi.attr('id'),
						success: function(data){
							$.each(data,function(i,c){
								var replyLiTemplet = $('#replyLiTemplet').clone();
								replyLiTemplet.show();
								replyLiTemplet.attr('id',c.id);
								if(c.creator.avatar == '' || c.creator.avatar == null || c.creator.avatar == undefined){
									c.creator.avatar = '/images/tpdpor/es/defaultAvatar.jpg';
								}
								console.log(c.creator.avatar);
								console.log(replyLiTemplet.find('a[class="img"]').find('img'));
								replyLiTemplet.find('a[class="img"]').find('img').attr('src',c.creator.avatar);
								replyLiTemplet.find('.name').text(c.creator.realName);
								replyLiTemplet.find('.u-btm p').text(c.content);
								var createTime = new Date(c.createTime);
								replyLiTemplet.find('.time').text(createTime.format('yyyy-MM-dd hh:mm:ss'));
								_thisReplyUl.append(replyLiTemplet);
				        	});
						}
					});
	        	}
	        }
        });
        
        //加载更多
		$('.m-comment-lst .m-more').on('click',function(){
			var _this = $(this);
			var _thisMainLi = _this.closest('.g-reply').parent('li');
			var _thisReplyUl = _this.closest('.g-reply').find('.m-comment-lst');
			var page = parseInt(_thisReplyUl.attr('page'));
			
			$.ajax({
				url: '${ctx!}/comment/api',
				type: 'GET',
				data: 'orders=CREATE_TIME.DESC&limit=10&page='+(page+1)+'&paramMap[mainId]='+_thisMainLi.attr('id')+'&paramMap[parentId]='+_thisMainLi.attr('id'),
				success: function(data){
					
					if(data.length > 0){
						_thisReplyUl.attr('page',page+1);
						
						$.each(data,function(i,c){
							var replyLiTemplet = $('#replyLiTemplet').clone();
							replyLiTemplet.show();
							replyLiTemplet.attr('id',c.id);
							if(c.creator.avatar == '' || c.creator.avatar == null || c.creator.avatar == undefined){
								c.creator.avatar = '/images/tpdpor/es/defaultAvatar.jpg';
							}
							replyLiTemplet.find('a[class="img"]').find('img').attr('src',c.creator.avatar);
							replyLiTemplet.find('.name').text(c.creator.realName);
							replyLiTemplet.find('.u-btm p').text(c.content);
							var createTime = new Date(c.createTime);
							replyLiTemplet.find('.time').text(createTime.format('yyyy-MM-dd hh:mm:ss'));
							_thisReplyUl.append(replyLiTemplet);
			        	});
		        	}else{
		        		_this.hide();
		        	}
				}
			});
		});
		
		//点赞
		$('.pro .agree').on('click',function(){
			var _this = $(this);
			var hadSupport = _this.hasClass('z-crt');
			var relationId = _this.closest('.mainCommentLi').attr('id');
			var relationType = '${(attitudeRelationType[0])!}';
			
			if(hadSupport){
				<#-- 
				//取消点赞
				$.post('${ctx!}/attitudes',{
	 				'attitude':'support',
					'relationId':relationId,
					'_method':'DELETE' 
	 			},function(response){
	 				if(response.responseCode == '00'){
						_this.removeClass('z-crt');
						_this.find('ii[name="text"]').text('赞同');
						_this.find('ii[name="count"]').text(parseInt(_this.find('ii[name="count"]').text())-1);
						alert('点赞已取消!');
					}
	 			});
				-->
			}else{
				//点赞
				$.post('${ctx!}/attitudes',{
					'attitude':'support',
					'relation.id':relationId,
					'relation.type':relationType
				},function(response){
					if(response.responseCode == '00'){
						_this.addClass('z-crt');
						_this.find('ii[name="text"]').text('已赞同');
						_this.find('ii[name="count"]').text(parseInt(_this.find('ii[name="count"]').text())+1);
						alert('点赞成功!');
					}
				});
			}
		});
	});
	
	//日期格式化
	Date.prototype.format = function(format){
		var o = {
		"M+" : this.getMonth()+1, //month
		"d+" : this.getDate(), //day
		"h+" : this.getHours(), //hour
		"m+" : this.getMinutes(), //minute
		"s+" : this.getSeconds(), //second
		"q+" : Math.floor((this.getMonth()+3)/3), //quarter
		"S" : this.getMilliseconds() //millisecond
		}
		
		if(/(y+)/.test(format)) {
		format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
		}
		
		for(var k in o) {
		if(new RegExp("("+ k +")").test(format)) {
		format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length));
		}
		}
		return format;
	};
	
	function saveChildComment(o){
		var relationId = $('#list_comment_form input[name="relationId"]').val();
		var relationType = $('#list_comment_form input[name="relationType"]').val();
		var mainId = $(o).closest('.mainCommentLi').attr('id');
		var content = $(o).closest('.m-comment-box').find('textarea').val().trim();
		
		if(content == '' || content == undefined){
			alert('评论内容不为空');
			return false;
		}
		
		$.post('/comment','relation.id='+relationId+'&relation.type='+relationType+'&mainId='+mainId+'&parentId='+mainId+'&content='+content, function(data){
			if(data.responseCode == '00'){
				$(o).closest('.g-reply').find('.m-comment-lst').find('li').remove();
				$(o).closest('.g-reply').find('.m-comment-lst').attr('page',1);
				$(o).closest('.m-comment-box').find('textarea').val('');
				$.ajax({
					url: '${ctx!}/comment/api',
					type: 'GET',
					data: 'orders=CREATE_TIME.DESC&limit=10&page=1&paramMap[mainId]='+mainId+'&paramMap[parentId]='+mainId,
					success: function(data){
						$.each(data,function(i,c){
							var replyLiTemplet = $('#replyLiTemplet').clone();
							replyLiTemplet.show();
							replyLiTemplet.attr('id',c.id);
							if(c.creator.avatar == '' || c.creator.avatar == null || c.creator.avatar == undefined){
								c.creator.avatar = '/images/tpdpor/es/defaultAvatar.jpg';
							}
							replyLiTemplet.find('a[class="img"]').find('img').attr('src',c.creator.avatar);
							replyLiTemplet.find('.name').text(c.creator.realName);
							replyLiTemplet.find('.u-btm p').text(c.content);
							var createTime = new Date(c.createTime);
							replyLiTemplet.find('.time').text(createTime.format('yyyy-MM-dd hh:mm:ss'));
							
							$(o).closest('.g-reply').find('.m-comment-lst').append(replyLiTemplet);
			        	});
					}
				});
				$(o).closest('.mainCommentLi').find('.u-btm').find('.reply ii').text(parseInt($(o).closest('.mainCommentLi').find('.u-btm').find('.reply ii').text())+1);
			}else{
				alert('提交失败！');
			}
		});
	};
</script>