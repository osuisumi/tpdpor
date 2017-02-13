<#macro form id="layerForm" method="post" action="" confirmTxt="保存" onConfirm="saveForm()"	cancelTxt="取消" showBtn=true>
<div class="g-layer-box">
    <div class="m-lg">
        <form id="${id}" method="${method}" action="${action}">
		 <#nested/>
		 <#if showBtn && (method=='put'||method="PUT"||method=='post'||method="POST")>
			 <div class="mis-btn-row indent1">
				 <button  type="button" onClick="${onConfirm}" class="mis-btn mis-main-btn">${confirmTxt}</button>
		         <button type="button"  class="mis-btn mis-default-btn mylayer-cancel">${cancelTxt}</button>
	             <#if buttons??>
					<#list buttons as button>
						${button}
					</#list>
				</#if>
	         </div>
         </#if>
		</form>        
    </div>
</div>
<script>
		$(document).ready(function(){
			<#if method == "get">
			$('#${id} input[type=checkbox]').click(function(){
					if($("input[name='checkboxId']:checked").length >0)
					{
							$(".mis-btn.disabled-btn").removeAttr("disabled");
							$(".mis-btn.disabled-btn").removeClass("disabled");
					}else{
							$(".mis-btn.disabled-btn").attr("disabled","disabled");
							$(".mis-btn.disabled-btn").addClass("disabled");
					}
			});
			</#if>
		});
		
		function saveForm(callback){
				var data = $.ajaxSubmit("${id}");
				var json = $.parseJSON(data);
				if (json.responseCode == '00') {
					 mylayerFn.msg('操作成功！',{icon: 0, time: 2000},function(){
				        if(callback!=''&&callback!=undefined){
							var $callback = callback;
							if (! $.isFunction($callback)){ 
								$callback = eval('(' + callback + ')');
								$callback();
							}
						}else{
							reloadWindow();
						}
				    });
				}
		}
</script>
</#macro>
