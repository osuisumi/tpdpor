<#macro form id="saveForm" method="post" action="" onsubmit="true" buttons=[] saveCallback="function(){}" saveValidate="function(){return true}" saveError="function(){}" isLayer=false>
	<form id="${id}" method="${method}" action="${action}">
		 <#nested/>
		 <#if method=='put'||method="PUT"||method=='post'||method="POST">
			 <div class="mis-btn-row indent1">
	               <button  type="button" onclick="if(${onsubmit}){saveForm('${id}'<#if (saveCallback?? )&& saveCallback!=''>,${saveCallback}</#if><#if saveValidate!=''>,${saveValidate}</#if><#if saveError!=''>,${saveError}</#if>)}"  class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
	               <button type="reset"  class="mis-btn mis-default-btn"><i class="mis-refresh-ico"></i>重置</button>
	               <#if buttons??>
						<#list buttons as button>
							${button}
						</#list>
					</#if>
	         </div>
         </#if>
	</form>
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
		
		
		function saveForm(formId,callback,validate,saveError){
	       		if(validate!=''&&validate!=undefined){
					var $validate = validate;
					if (! $.isFunction($validate)) $validate = eval('(' + validate + ')');
					var flg = $validate();
					if(flg != true){
						return false;
					}
				}
				
				var data = $("#"+formId).serialize();
				var method = $("#"+formId).attr("method");
				if (method == 'delete' || method == 'DELETE' || method == 'put' || method == 'PUT') {
					data = '_method='+method+'&'+data;
				}
				$.ajax({
					url:$("#"+formId).attr("action"),
					data:data,
					type:'post',
					async:true,
					beforeSend:function(){
						ajaxLoading();
					},
					success:function(data){
						var json = data;
						if (json.responseCode == '00') {
							 mylayerFn.msg('操作成功！',{icon: 0, time: 2000},function(){
						        if(callback!=''&&callback!=undefined){
									var $callback = callback;
									if (! $.isFunction($callback)) $callback = eval('(' + callback + ')');
									$callback();
								}
						    });
						}else{
					        if(saveError!=''&&saveError!=undefined){
								var $saveError = saveError;
								if (! $.isFunction($saveError)) $saveError = eval('(' + saveError + ')');
								$saveError();
							}
						}
					},
					complete:function(){
						ajaxEnd();
					}
				});
		}
	</script>
</#macro>