<#macro paginationAjaxFtl formId divId paginator contentId>
	<input id="currentPage" type="hidden" name="page" value="${paginator.page!1}" />
	<script>
		$(function(){
			laypage({
			 	skin: "mySkin",
	            cont: '${divId}',
	            groups: 5,
	            pages: '${paginator.totalPages}', //通过后台拿到的总页数
	            curr: '${paginator.page}' || 1, //当前页
	            jump: function(obj, first){ //触发分页后的回调
	                if(!first){ //点击跳页触发函数自身，并传递当前页：obj.curr
	                    $('#currentPage').val(obj.curr);
	                	$.ajaxQuery('${formId}','${contentId}');
	                }
	            },
                prev: "<",
       			next: ">"
	        });
		});
	</script>
</#macro>