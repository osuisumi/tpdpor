<#import "/admin/common/include/form_layer.ftl" as fl>
		<@fl.form id="saveAccountForm" action="${ctx!}/admin/accounts" method="post" onConfirm="saveAccount()">
			<#if (account.id)??>
				<input id="id" type="hidden" name="id" value="${(account.id)!}">
				<input id="userid" type="hidden" name="user.id" value="${(account.user.id)!}">
				<script>
					$('#saveAccountForm').attr('action', '${ctx!}/admin/accounts');
					$('#saveAccountForm').attr('method', 'put');
				</script>
			</#if>
		<ul class="mis-ipt-lst">
            <li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>姓名：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-ipt-mod">
                            <input type="text" name="user.realName" value="${(account.user.realName)!}" placeholder="请输入姓名..." class="mis-ipt required">
                        </div>
                    </div>
                </div>
            </li>
            
            <li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>用户名：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-ipt-mod">
                           <input type="text" id="userName" name="userName" value="${(account.userName)!}" placeholder="请输入用户名..." class="mis-ipt required">
                        </div>
                    </div>
                </div>
            </li>
            <li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>帐号类型：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-selectbox">
                            <strong><span class="simulateSelect-text">请选择</span><i class="trg"></i></strong>
                            <select name="roleCode">
                        		<#list DictionaryUtils.getEntryList('ACCOUNT_ROLE_CODE') as entry>
                        			<option <#if ((account.roleCode)!) == entry.dictValue>selected="selected"</#if> value="${entry.dictValue}">${(entry.dictName)!}</option>
                        		</#list>
                            </select>
                        </div>
                    </div>
                </div>
            </li>
			<li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>所属机构：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-selectbox">
                            <strong><span class="simulateSelect-text">请选择</span><i class="trg"></i></strong>
                            <select name="user.department.id">
                                <option value="" >请选择</option>
                                <@departmentsDataDirective>
                                	<#if departments??>
                                		<#list departments as d>
                                			<option <#if ((account.user.department.id)!) == d.id>selected="selected"</#if> value="${d.id}">${(d.deptName)!}</option>
                                		</#list>
                                	</#if>
                                </@departmentsDataDirective>
                            </select>
                        </div>
                    </div>
                </div>
            </li>
            <#if !(account.id)??>
            <li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>密码：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-ipt-mod">
                            <input type="password" id="password" name="password" placeholder="请输入密码..." class="mis-ipt required">
                        </div>
                    </div>
                </div>
            </li>
            <li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>重复密码：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-ipt-mod">
                            <input type="password" name="repassword" placeholder="请输入密码..." class="mis-ipt required">
                        </div>
                    </div>
                </div>
            </li>
            </#if>
 		</ul>
</@fl.form>

<script>
	$(function(){
		$(".mis-selectbox select").simulateSelectBox();
	});

	$(function(){
		$('#saveAccountForm').validate({
			rules : {
				userName : {
					required : true,
					remote : {
						url :  $('#ctx').val() + '/admin/accounts/countForValidUserNameIsExist?id=${(account.id)!""}', 
	                    type : "get", 
	                    dataType : "text",
						data :  {
							userName : function() {   
			                    return $("#userName").val();   
			                }
						},
						dataFilter : function (result,type) {
							return parseInt(result) > 0 ? false : true;
						} 
					}
				},
				repassword : {
					required: true,
			        minlength: 6,
			        equalTo: "#password"
				}
			},
			messages : {
				userName : {
					required : '必填',
					remote : '用户名已存在'
				},
				repassword : {
					required : '必填',
					equalTo: "两次密码输入不一致"
				}
			}
		});
	});
	
	function saveAccount() {
		if(!$('#saveAccountForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('saveAccountForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			alert('操作成功',function(){
				$('#listAccountForm').submit();
			});
		}
	}
	
</script>