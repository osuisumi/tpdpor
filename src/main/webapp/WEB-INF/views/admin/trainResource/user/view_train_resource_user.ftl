<@trainResourceUserData id=(trainResourceUser.id)!> 
	<#assign trainResourceUser=(trainResourceUserModel)!/>
</@trainResourceUserData>
<div class="g-layer-box">
		   	<ul class="mis-ipt-lst">
				<li class="item">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>申请人：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="mis-ipt-mod">
	                            ${(trainResourceUser.user.realName)!}
	                        </div>
	                    </div>
	                </div>
	            </li>
				<li class="item">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>身份证：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="mis-ipt-mod">
	                           ${(trainResourceUser.user.paperworkNo)!}
	                        </div>
	                    </div>
	                </div>
	            </li>
				<li class="item">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>工作单位：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="mis-ipt-mod">
	                           ${(trainResourceUser.user.department.deptName)!}
	                        </div>
	                    </div>
	                </div>
	            </li>
				<li class="item">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>申请查看内容：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="mis-ipt-mod">
	                           		《${(trainResourceUser.trainResource.resource.title)!}》
	                        </div>
	                    </div>
	                </div>
	            </li>
				<li class="item">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>申请内容类型：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="mis-ipt-mod">
		                    	<#if (trainResourceUser.trainResource.resource.type)! == 'curriculum'>
									课程
								<#elseif (trainResourceUser.trainResource.resource.type)! == 'case'>
									案例
								<#elseif (trainResourceUser.trainResource.resource.type)! == 'material'>
									素材
								<#elseif (trainResourceUser.trainResource.resource.type)! == 'other'>
									其他
								<#else>
									----
								</#if>
	                        </div>
	                    </div>
	                </div>
	            </li>
				<li class="item">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>申请内容简介：</span>
	                    </div>
	                    <div class="tc">
	                        <div class="mis-ipt-mod">
								${(trainResourceUser.resource.summary)!}
	                        </div>
	                    </div>
	                </div>
	            </li>
		    </ul>
		</div>
		<div class="mis-btn-row indent1">
			<button class="mis-btn mis-main-btn" onclick="updateTrainResourceUserState('passed');" type="button">审核通过</button>
			<button class="mis-btn mis-main-btn" onclick="updateTrainResourceUserState('nopass');" type="button">审核不通过</button>
		</div>
	         
<script type="text/javascript">
	
	function updateTrainResourceUserState(state){
		var content = '';
		if(state == 'passed'){
			content = '确定审核通过？';
		}
		if(state == 'nopass'){
			content = '确定审核不通过？';
		}
		mylayerFn.confirm({
	        content: content,
	        icon: 3,
	        yesFn: function(){
	        	$.ajaxPut('${ctx!}/admin/resource_apply_record', '&id=${(trainResourceUser.id)!}&applyState='+state, function(){
	        		window.location.reload();
				})
	        }
	    });
	};
	
	function viewTrainResource(){
		window.open('${ctx!}/train_resource/${(trainResourceUser.trainResource.resource.id)!}/view');
	};
	
</script>