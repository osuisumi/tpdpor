<#import "/admin/common/include/layout.ftl" as lo>
<#assign jsArray = ['${ctx!}/js/common/ueditorUtils.js','${ctx!}/js/common/ueditor/ueditor.config.js','${ctx!}/js/common/ueditor/ueditor.all.min.js'] />
<#assign cssArray = []>
<@lo.layout jsArray=jsArray cssArray=cssArray validate=true>
<#assign formId="saveExpertForm"/>

<#import "/admin/common/include/form.ftl" as fl>
<div class="mis-inner-wrap">
	<div class="mis-mod">
		<div class="mis-crm">
			<div class="crm">
				<a href="${ctx}/tpdpor/admin/expert?menuTreeId=${menuTreeId!}">专家管理</a>
				<span class="trg">&gt;</span>
				<a href="javascript:;"><#if (expert.id)??>修改专家<#else>新增专家</#if></a>
			</div>
		</div>
		<div class="mis-mod">
			<@fl.form id="${formId!}" action="${ctx!}/tpdpor/admin/expert" method="post" saveCallback="function(){location.href='${ctx!}/tpdpor/admin/expert?menuTreeId=${menuTreeId!}'}" saveValidate="function(){return saveValidate();}" saveError="function(){alert('该用户已经是专家');}">
				<#if (expert.id)??>
					<script>
						$(function(){
							$('#${formId!}').attr('method','put');
							$('#${formId!}').attr('action','${ctx!}/tpdpor/admin/expert/${(expert.id)!}');
						});
					</script>
					<input type="hidden" name="user.id" value="${(expert.user.id)!}">
					<input type="hidden" name="account.id" value="${(expert.account.id)!}">
				<#else>
				</#if>
				<script>
					var ue = initProduceEditor('editor', '${(expert.researchResult)!}', '${(Session.loginer.id)!}');
					var ue1 = initProduceEditor('editor1', '${(expert.trainExperience)!}', '${(Session.loginer.id)!}');
					var ue2 = initProduceEditor('editor2', '${(expert.contributeResource)!}', '${(Session.loginer.id)!}');
					
					function saveValidate(){
						
						var realName = $('#realName').val();
						if(realName == null || realName == '' || realName == undefined){
							alert("请输入姓名!");
							return false;
						}
						<#if (expert.id)??>
						<#else>
						
						var userName = $('#userName').val();
						if(userName == null || userName == '' || userName == undefined){
							alert("请输入用户名!");
							return false;
						}
						
						var password = $('#password').val();
						if(password == null || password == '' || password == undefined){
							alert("请输入密码!");
							return false;
						}
						
						</#if>
						
						var departmentId = $('#${formId!}').find("input[name='user.department.id']").val();
						if(departmentId == null || departmentId == '' || departmentId == undefined){
							alert("请选择机构!");
							return false;
						}
						
						var content = ue.getContent();
						var content1 = ue1.getContent();
						var content2 = ue2.getContent();
						$('#researchResult').val(content);
						$('#trainExperience').val(content1);
						$('#contributeResource').val(content2);
						
						return true;
					};
				</script>
				<div class="mis-srh-layout">
					<ul class="mis-ipt-lst">
						<li class="item">
							<div class="mis-ipt-row">
								<div class="tl">
									<span>姓名：</span>
								</div>
								<div class="tc">
									<div class="mis-ipt-mod">
										<input id="realName" type="text" name="user.realName" value="${(expert.user.realName)!}" placeholder="请输入姓名" class="mis-ipt required">
									</div>
								</div>
							</div>
						</li>
						<#if (expert.id)??>
						<#else>
						<li class="item">
							<div class="mis-ipt-row">
								<div class="tl">
									<span>用户名：</span>
								</div>
								<div class="tc">
									<div class="mis-ipt-mod">
										<input id="userName" type="text" name="account.userName" value="" placeholder="请输入用户名" class="mis-ipt required">
									</div>
								</div>
							</div>
						</li>
						<li class="item">
							<div class="mis-ipt-row">
								<div class="tl">
									<span>密码：</span>
								</div>
								<div class="tc">
									<div class="mis-ipt-mod">
										<input id="password" type="password" name="account.password" value="${(expert.account.password)!}" placeholder="请输入密码" class="mis-ipt required">
									</div>
								</div>
							</div>
						</li>
						<li class="item">
							<div class="mis-ipt-row">
								<div class="tl">
									<span>确认密码：</span>
								</div>
								<div class="tc">
									<div class="mis-ipt-mod">
										<input id="password" type="password" name="repassword" value="${(expert.account.password)!}" placeholder="请再次输入密码" class="mis-ipt required">
									</div>
								</div>
							</div>
						</li>
						</#if>
						<li class="item">
							<div class="mis-ipt-row">
								<div class="tl">
									<span>身份证号：</span>
								</div>
								<div class="tc">
									<div class="mis-ipt-mod">
										<input id="paperworkNo" type="text" name="user.paperworkNo" value="${(expert.user.paperworkNo)!}" placeholder="请输入身份证号" class="mis-ipt">
									</div>
								</div>
							</div>
						</li>
						<li class="item">
							<div class="mis-ipt-row">
								<div class="tl">
									<span>所在机构：</span>
								</div>
								<div class="tc">
									<div class="mis-treeSelect">
										<div class="mis-ipt-mod">
											<input type="text" id="department" class="mis-ipt" onclick="showTree();" placeholder="请输入机构名称" value="${(expert.user.department.deptName)!}"/>
											<input type="hidden" name="user.department.id" value="${(expert.user.department.id)!}" />
											<a id="" href="javascript:;" class="selectBtn" onclick="showTree(); return false;">请选择</a>
										</div>
										<div id="departmentTreeContent" class="menuZtreeContent">
											<ul id="departmentTree" class="ztree selectTree"></ul>
										</div>
									</div>
								</div>
							</div>
						</li>
						<li class="item">
				            <div class="mis-ipt-row">
				                <div class="tl">
				                    <span>性别：</span>
				                </div>
				                <div class="tc">
				                    <div class="mis-select">
				                        <select name="user.sex" id="">
				                        	<option class="static" value="1" <#if (expert.user.sex)! == '1'> selected="selected"</#if> >男</option>
				                        	<option class="static" value="2" <#if (expert.user.sex)! == '2'> selected="selected"</#if> >女</option>
				                        </select>
				                    </div>
				                </div>
				            </div>
				        </li>
						<li class="item">
							<div class="mis-ipt-row">
								<div class="tl">
									<span>联系电话：</span>
								</div>
								<div class="tc">
									<div class="mis-ipt-mod">
										<input type="text" name="user.phone" value="${(expert.user.phone)!}" placeholder="请输入联系电话" class="mis-ipt">
									</div>
								</div>
							</div>
						</li>
						<li class="item">
							<div class="mis-ipt-row">
								<div class="tl">
									<span>邮箱：</span>
								</div>
								<div class="tc">
									<div class="mis-ipt-mod">
										<input type="text" name="user.email" value="${(expert.user.email)!}" placeholder="请输入邮箱" class="mis-ipt">
									</div>
								</div>
							</div>
						</li>
				        <li class="item">
			                <div class="mis-ipt-row">
			                    <div class="tl">
			                        <span>职位：</span>
			                    </div>
			                    <div class="tc">
									<div class="mis-ipt-mod">
										<input type="text" name="position" value="${(expert.position)!}" placeholder="请输入职位" class="mis-ipt">
									</div>
								</div>
			                </div>
			            </li>
			            <li class="item">
			                <div class="mis-ipt-row">
			                    <div class="tl">
			                        <span>专业：</span>
			                    </div>
			                    <div class="tc">
									<div class="mis-ipt-mod">
										<input type="text" name="specialty" value="${(expert.specialty)!}" placeholder="请输入专业" class="mis-ipt">
									</div>
								</div>
			                </div>
			            </li>
			            <li class="item">
			                <div class="mis-ipt-row">
			                    <div class="tl">
			                        <span>职称：</span>
			                    </div>
			                    <div class="tc">
									<div class="mis-ipt-mod">
										<input type="text" name="professionalTitle" value="${(expert.professionalTitle)!}" placeholder="请输入职称" class="mis-ipt">
									</div>
								</div>
			                </div>
			            </li>
			            <li class="item w1">
			                <div class="mis-ipt-row">
			                    <div class="tl">
			                        <span>研究主题与成果：</span>
			                    </div>
			                    <div class="tc">
				                    <div class="mis-ipt-mod">
				                        <script id="editor" type="text/plain" style="width:100%; height:370px;"></script>
										<input id="researchResult" name="researchResult" type="hidden">
				                    </div>
				                </div>
			                </div>
			            </li>
			            <li class="item w1">
			                <div class="mis-ipt-row">
			                    <div class="tl">
			                        <span>培训项目经验：</span>
			                    </div>
			                    <div class="tc">
				                    <div class="mis-ipt-mod">
				                        <script id="editor1" type="text/plain" style="width:100%; height:370px;"></script>
										<input id="trainExperience" name="trainExperience" type="hidden">
				                    </div>
				                </div>
			                </div>
			            </li>
			            <li class="item w1">
			                <div class="mis-ipt-row">
			                    <div class="tl">
			                        <span>贡献资源：</span>
			                    </div>
			                    <div class="tc">
				                    <div class="mis-ipt-mod">
				                        <script id="editor2" type="text/plain" style="width:100%; height:370px;"></script>
										<input id="contributeResource" name="contributeResource" type="hidden">
				                    </div>
				                </div>
			                </div>
			            </li>
		            </ul>
				</@fl.form>
	    	</div>
		</div>
	</div>
</div>

<script>
	$(function(){
		$("#${(formId)!}").validate({
			rules : {
				"account.userName" : {
					required : true,
					remote : {
						url :  '${ctx!}/admin/accounts/countForValidUserNameIsExist?id=${(expert.account.id)!""}', 
	                    type : "get", 
	                    dataType : "text",
						data :  {
							userName : function() {  
								return $("#userName").val() ;   
			                }
						},
						dataFilter : function (result,type) {
							return parseInt(result) > 0 ? false : true;
						} 
					}
				},
				"user.paperworkNo" : {
					required : true,
					remote : {
						url : '${ctx!}/users/countForValidpaperworkNoIsExist?id=${(expert.user.id)!}', 
	                    type : "get", 
	                    dataType : "text",
						data : {
							paperworkNo : function() {   
			                    return $("#paperworkNo").val() ;   
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
				"account.userName" : {
					required : '必填',
					remote : '用户名已存在'
				},
				"user.paperworkNo" : {
					required : '必填',
					remote : '身份证已存在'
				},
				repassword : {
					required : '必填',
					equalTo: "两次密码输入不一致"
				}
			}
		});
		
	});
</script>

<#import "/admin/common/tags/select_tree.ftl" as t>
<@t.selectTree url='${ctx}/tpdpor/admin/department/entities' treeId="departmentTree" treeInputId="department" treeContentId="departmentTreeContent" onClick="onClickDepartment" selectedId="" showTree="showTree" >
	<script>
		var	selectedNode;
		function onClickDepartment(e, treeId, treeNode) {
			$("input[name='user.department.id']").remove();
			$("#department").after("<input type='hidden' name='user.department.id' value='" + treeNode.id + "' />");
			$("#department").val(treeNode.name);
		};
		
		function departmentTree_ajaxDataFilter(treeId, parentNode, responseData){
			var treeNodes=new Array();
			if (responseData) {
				for(var i =0; i < responseData.length; i++) {
					node = responseData[i];
					treeNodes[i]={id:node.id,name:node.deptName};
					if("${(expert.user.department.id)!}"==node.id){
						selectedNode = treeNodes[i];
					}
				}
			}
			return treeNodes;
		};

	</script>
</@t.selectTree>
</@lo.layout>