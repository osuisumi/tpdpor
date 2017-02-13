<#import "/tpdpor/common/tags/image.ftl" as image/>
<@commentsDirective relationId=(creative.id)!'' relationType='creative_advice' attitudeRelationType=attitudeRelationType[0]!'' page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders='CREATE_TIME.DESC'>
	<#if (comments)??>
		<#list (comments) as comment>
		    <li class="m-cont-discuss-li" id="${(comment.id)!}">
		        <div class="m-cont-discuss-txt">
		            <a href="javascript:;" class="myname">
		            	<@image.imageFtl url="${(comment.creator.avatar)!}" default="/images/tpdpor/es/defaultAvatar.jpg" />
		            </a>
		            <div class="other-comment">
		                <p class="name"><a href="javascript:;">${(comment.creator.realName)!''}</a></p>
		                <p class="txt">${(comment.content)!}</p>
		                <p class="time">${TimeUtils.prettyTime((comment.createTime)!)}</p>                                        
		            </div>
		            <div class="ag-opa">
		                <a href="javascript:;" class="au-praise"><i class="au-praise-ico"></i>赞(<ii class="supportCount">${(attitudeStatMapForSupport[comment.id].participateNum)!0}</ii>)</a>
		                <span class="line">|</span>
		                <a href="javascript:;" class="au-comment"><i class="au-comment-ico"></i>评论(<ii class="childAdviceCount">${(comment.childNum)!0}</ii>)</a>
		            </div>
		        </div>
		        <div class="ag-is-comment">
		            <i class="au-comment-trg"></i>
		            <ul class="aag-cmt-lst" page="1">
		            	<#-- 
		                <li class="am-cmt-block">
		                    <div class="c-info">
		                        <a href="#" class="au-cmt-headimg">
		                            <img src="../images/headImg4.jpg" alt="">
		                        </a>
		                        <p class="tp">
		                            <a href="#" class="name">崔园园</a>
		                            <span class="time">10分钟前</span>
		                            <span class="m-discuss-com">
		                                <a href="javascript:void(0);" class="au-alter au-editComment-btn">
		                                    <i class="au-alter-ico"></i>编辑
		                                </a>
		                                <i class="au-opa-dot"></i>
		                                <a href="javascript:void(0);" class="au-dlt dis-dlt">
		                                    <i class="au-dlt-ico"></i>删除
		                                </a>
		                            </span>
		                        </p>
		                        <p class="cmt-dt">我认为反思的助教应该是老师，老师在教学过程中，通过提问，测试，获得学生的学习效果。老师影视这个结果的主要反思着。若只有学生反思，老师的教学部发生改变，效果还是不能有好的提升。</p>
		                    </div>
		                </li>
		                -->
		            </ul>
		            <div class="am-unfold-block">
		                <a href="javascript:void(0);" class="au-unfold">
		                    展开全部建议<i class="au-ico"></i>
		                </a>
		            </div>
		            <div class="am-isComment-box am-ipt-mod">
		                <textarea id="" class="au-textarea" placeholder="我也说一句"></textarea>
		                <div class="am-cmtBtn-block f-cb">
		                    <#--<a class="au-face" href="javascript:void(0);"></a>-->
		                    <a href="javascript:void(0);" class="au-cmtPublish-btn au-confirm-btn1">发表</a>
		                </div>
		            </div>
		        </div>
		    </li>
	    </#list>
	    <form id="list_creative_advice_form" action="${ctx!}/creative/advice" method="get">
	    	<input type="hidden" name="id" value="${(creative.id)!}">
			<input type="hidden" name="attitudeRelationType" value="${attitudeRelationType[0]!}">
			<div class="g-res-page">
	            <span class="num">共<b id="creativeAdviceNum">${(paginator.totalCount)!0}</b>条建议</span>
	            <div id="creative_advice_page" class="m-page-jump res"></div>
	            <#import '/tpdpor/common/tags/pagination_ajax.ftl' as p />
				<@p.paginationAjaxFtl formId="list_creative_advice_form" divId="creative_advice_page" paginator=paginator! contentId='adviceListDiv' />
	        </div>
	    </form>
	</#if>
</@commentsDirective>

<li id="replyLiTemplet" class="am-cmt-block" style="display:none;">
    <div class="c-info">
        <a class="au-cmt-headimg">
            <img src="/images/tpdpor/${app_path}/defaultAvatar.jpg" alt="">
        </a>
        <p class="tp">
            <a href="#" class="name">崔园园</a>
            <span class="time">10分钟前</span>
            <span class="m-discuss-com">
                <a href="javascript:void(0);" class="au-alter au-editComment-btn">
                    <i class="au-alter-ico"></i>编辑
                </a>
                <i class="au-opa-dot"></i>
                <a href="javascript:void(0);" class="au-dlt dis-dlt">
                    <i class="au-dlt-ico"></i>删除
                </a>
            </span>
        </p>
        <p class="cmt-dt">111</p>
    </div>
</li>

<script>
	$(function(){
		activityJs.fn.init();
		more_detail(".m-wantSee-detTxt .m-more",'.m-wantSee-who');
		
		var creativeAdviceNum = $('#creativeAdviceNum').text();
		if(creativeAdviceNum == undefined){
			creativeAdviceNum = 0;
		}
		
		$('.creativeAdviceNum').text(creativeAdviceNum);
		
		$('.au-comment').on('click',function(){
			var _this = $(this);
			var _thisMainLi = _this.closest('li');
	        var _thisReplyUl = _thisMainLi.find('.aag-cmt-lst');
			
			if(_this.hasClass("z-crt")){
				if(_thisReplyUl.find('li').length <= 0){
					_thisReplyUl.attr('page',1);
					
					$.ajax({
						url: '${ctx!}/comment/api',
						type: 'GET',
						data: 'orders=CREATE_TIME.DESC&limit=10&page='+_thisReplyUl.attr("page")+'&paramMap[mainId]='+_thisMainLi.attr('id')+'&paramMap[parentId]='+_thisMainLi.attr('id'),
						success: function(data){
							
							$.each(data,function(i,c){
								var replyLiTemplet = $('#replyLiTemplet').clone();
								replyLiTemplet.show();
								replyLiTemplet.attr('id',c.id);
								if(c.creator.realName == ''){
									c.creator.avatar = '/images/tpdpor/${app_path}/defaultAvatar.jpg';
								}
								replyLiTemplet.find('.au-cmt-headimg img').attr('src',c.creator.avatar);
								replyLiTemplet.find('.tp .name').text(c.creator.realName);
								replyLiTemplet.find('.cmt-dt').text(c.content);
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
		$('.au-unfold').on('click',function(){
			var _this = $(this);
			var _thisMainLi = _this.closest('.ag-is-comment').parent('li');
			var _thisReplyUl = _thisMainLi.find('.aag-cmt-lst');
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
							if(c.creator.realName == ''){
								c.creator.avatar = '/images/tpdpor/${app_path}/defaultAvatar.jpg';
							}
							replyLiTemplet.find('.au-cmt-headimg img').attr('src',c.creator.avatar);
							replyLiTemplet.find('.tp .name').text(c.creator.realName);
							replyLiTemplet.find('.cmt-dt').text(c.content);
							var createTime = new Date(c.createTime);
							replyLiTemplet.find('.time').text(createTime.format('yyyy-MM-dd hh:mm:ss'));
							_thisReplyUl.append(replyLiTemplet);
			        	});
		        	}else{
		        		_this.closest('.am-unfold-block').hide();
		        	}
				}
			});
		});
		
		//子建议保存
		$('.au-cmtPublish-btn.au-confirm-btn1').on('click',function(){
			var _this = $(this);
			
			var content = _this.closest('.am-isComment-box.am-ipt-mod').find('textarea[class="au-textarea"]').val().trim();
			if(content == '' || content == undefined){
				alert('建议内容不能为空');
				return false;
			}
	
			var relationId = $('#list_creative_advice_form input[name="id"]').val();
			var relationType = 'creative_advice';
			var mainId = _this.closest('.ag-is-comment').parent('li').attr('id');
		
			$.post('/comment','relation.id='+relationId+'&relation.type='+relationType+'&mainId='+mainId+'&parentId='+mainId+'&content='+content, function(data){
				if(data.responseCode == '00'){
					var childAdviceCount = parseInt(_this.closest('.m-cont-discuss-li').find('.childAdviceCount').text());
					_this.closest('.m-cont-discuss-li').find('.childAdviceCount').text(childAdviceCount+1);
					var childAdvicdUl = _this.closest('.ag-is-comment').find('.aag-cmt-lst');
					$(childAdvicdUl).find('li').remove();
					$(childAdvicdUl).attr('page',1);
					_this.closest('.am-isComment-box.am-ipt-mod').find('textarea[class="au-textarea"]').val('');
					$.ajax({
						url: '${ctx!}/comment/api',
						type: 'GET',
						data: 'orders=CREATE_TIME.DESC&limit=10&page=1&paramMap[mainId]='+mainId+'&paramMap[parentId]='+mainId,
						success: function(data){
							$.each(data,function(i,c){
								var replyLiTemplet = $('#replyLiTemplet').clone();
								replyLiTemplet.show();
								replyLiTemplet.attr('id',c.id);
								if(c.creator.realName == ''){
									c.creator.avatar = '/images/tpdpor/es/defaultAvatar.jpg';
								}
								replyLiTemplet.find('.au-cmt-headimg img').attr('src',c.creator.avatar);
								replyLiTemplet.find('.tp .name').text(c.creator.realName);
								replyLiTemplet.find('.cmt-dt').text(c.content);
								var createTime = new Date(c.createTime);
								replyLiTemplet.find('.time').text(createTime.format('yyyy-MM-dd hh:mm:ss'));
								childAdvicdUl.append(replyLiTemplet);
				        	});
						}
					});
					var childAdviceCount = parseInt(_this.closest('.ag-is-comment').closest('.m-cont-discuss-txt').find('ii[class="childAdviceCount"]').text());
					_this.closest('.ag-is-comment').closest('.m-cont-discuss-txt').find('ii[class="childAdviceCount"]').text(childAdviceCount);
				}else{
					alert('提交失败！');
				}
			});
		});
		
		//点赞
		$('.au-praise').on('click',function(){
			var _this = $(this);
			
			var relationId = _this.closest('li').attr('id');
			var relationType = 'creative_advice';
			
			$.post('${ctx!}/attitudes',{
				'attitude':'support',
				'relation.id':relationId,
				'relation.type':relationType
			},function(response){
				if(response.responseCode == '00'){
					_this.find('ii[class="supportCount"]').text(parseInt(_this.find('ii[class="supportCount"]').text())+1);
					alert('点赞成功!');
				}else{
					alert('已经点过赞!');
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
		
		//展示更多
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
		
	});
</script>