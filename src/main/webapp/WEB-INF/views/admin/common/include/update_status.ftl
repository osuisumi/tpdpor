<#import "/admin/common/include/form_layer.ftl" as fl>
	<@fl.form id="updateStatusForm" action="${ctx!}/status" method="put" confirmTxt="保存" onConfirm="saveForm()"	cancelTxt="取消" showBtn=true>
	<input type="hidden" name="relation.id" value="${(status.relation.id)!}">
	<input type="hidden" name="relation.type" value="${(status.relation.type)!}"> 
	<input type="hidden" name="state" value="${(status.state)!}">
	<div class="mis-srh-layout">
    	<ul class="mis-ipt-lst">
    		<li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>置顶天数：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="days" value="" placeholder="请输入置顶天数..." class="mis-ipt {required:true, number:true, }">
	                    </div>
	                </div>
	            </div>
	        </li>
	    </ul>
	</div>

<script type="text/javascript">
	function updateStatus() {
		if(!$('#updateStatusForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('updateStatusForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			
		}
	};
	
	function cancle(){
		$('.mylayer-wrap').remove();
	};
</script>

</@fl.form>