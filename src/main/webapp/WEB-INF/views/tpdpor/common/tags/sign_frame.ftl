<#macro signFrameFtl relationId relationType>
<@creativeSignStatDirective creator=Session.loginer.id relationId=relationId relationType=relationType>
	<#assign signStat=(signStatModel)!>
	<#assign creativeNum=(creativeNum)!0>
	<#assign score=(score)!0>
	<#assign creativeAdviceNum=(creativeAdviceNum)!0>
</@creativeSignStatDirective>	
<@signStatCountDirective relationId=relationId lastSignTime=(.now?string('yyyy-MM-dd')?date)>
	<#assign signCount=(count)!0>
</@signStatCountDirective>
<div class="g-COMbd-frame">
	<div class="COM-bd-navbox">
	    <div class="m-COMbd-nav">
	        <div class="m-COMbd-navL">
	        	<#if (signStat.lastSignTime)?? && ((signStat.lastSignTime?string('yyyy-MM-dd'))!'') == (.now?date?string('yyyy-MM-dd'))>
	        		<span class="m-signIn z-crt"><i class="u-signIn"></i>已签到</span>
	        	<#else>
	            	<span class="m-signIn" onclick="createSignUser()"><i class="u-signIn"></i>签到</span>
	            </#if>
	            <p class="signIn-people">已签到总人数：
		            <strong>
						${signCount!0}
		            </strong> 
		           	 人
	            </p>
	        </div>
	        <ul class="m-COMbd-navR">
	            <li>
	                <a href="javascript:;">
	                    <strong>${(signStat.signLastNum)!0 }</strong>
	                    <p class="txt"><i class="unstop-times"></i>连续签到(天)</p>
	
	                </a>
	            </li>
	            <li>
	                <a href="javascript:;">
	                    <strong>${(signStat.signNum)!0 }</strong>
	                    <p class="txt"><i class="u-all-times"></i>总天数(天)</p>
	                </a>
	            </li>
	            <li>
                    <a href="javascript:;">
                        <strong>${(creativeNum)!0}</strong>
                        <p class="txt"><i class="u-thinking"></i>发起创客</p>
                    </a>
                </li>
                <li>
                    <a href="javascript:;">
                        <strong>${(creativeAdviceNum)!0}</strong>
                        <p class="txt"><i class="u-active"></i>参与建议</p>

                    </a>
                </li>       
	            <li>
	                <a href="javascript:;">
	                    <strong>${(score)!0 }</strong>
	                    <p class="txt"><i class="u-score"></i>获得积分</p>
	                </a>
	            </li>                                                
	        </ul> 
	        <div class="m-COMbd-who">
	            <a href="javascript:;"> 
	                <#import "/tpdpor/common/tags/image.ftl" as image/>
					<@image.imageFtl url="${Session.loginer.avatar! }" default="/images/tpdpor/${app_path}/defaultAvatar.jpg" class="imgwho" />
	                <span class="name">${Session.loginer.realName }</span>
	            </a>
	            <span class="who-icon"></span>
	        </div>
	        <#-- 
	        <div class="weixin-icon">
	            <div class="u-weixin-icon">
	                <div class="u-weixin"></div>
	            </div>
	            <span class="u-coverafter"></span>
	        </div>       
			-->
	    </div>
	</div>
	</div>
<script>
	function createSignUser(){
		$.post('/sign/user','relationId=${relationId}', function(){
			window.location.reload();
		});
	}
</script>
</#macro>