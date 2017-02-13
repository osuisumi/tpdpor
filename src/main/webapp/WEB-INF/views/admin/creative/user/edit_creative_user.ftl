<#import "/admin/common/include/form_layer.ftl" as fl>
	<#assign formId="updateCreativeUserForm"/>
	<@fl.form id="${formId!}" action="${ctx!}/tpdpor/admin/creative/user/typeManagerAndExpert?type=${(param_type)!}" method="put" confirmTxt="保存" onConfirm="saveForm()"	cancelTxt="取消" showBtn=true>
	<div class="mis-srh-layout">
    	<ul class="mis-ipt-lst">
	        <li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>管理员：</span>
					</div>
					<div class="tc">
						<div class="mis-treeSelect">
							<div class="mis-ipt-mod">
								<input type="text" id="user" class="mis-ipt" onclick="showTree();" placeholder="请输入姓名"/>
								<a id="" href="javascript:;" class="selectBtn" onclick="showTree(); return false;">请选择</a>
							</div>
							<div id="userTreeContent" class="menuZtreeContent">
								<ul id="userTree" class="ztree selectTree"></ul>
							</div>
						</div>
					</div>
				</div>
			</li>
			<li class="item">
				<div class="mis-ipt-row">
					<div class="tl">
						<span>项目评优专家：</span>
					</div>
					<div class="tc">
						<div class="mis-treeSelect">
							<div class="mis-ipt-mod">
								<input type="text" id="expert" class="mis-ipt" onclick="showTree1();" placeholder="请输入姓名"/>
								<a id="" href="javascript:;" class="selectBtn" onclick="showTree1(); return false;">请选择</a>
							</div>
							<div id="expertTreeContent" class="menuZtreeContent">
								<ul id="expertTree" class="ztree selectTree"></ul>
								<form id="">
								</form>
							</div>
						</div>
					</div>
				</div>
			</li>
	    </ul>
	</div>
</@fl.form>

<#import "/admin/common/tags/select_user.ftl" as sut>
<@sut.selectUserTree treeId="userTree" treeInputId="user" treeContentId="userTreeContent" onClick="onClickUser" selectedId="" showTree="showTree" >
	<script>
		function onClickUser(e, treeId, treeNode) {
			$("input[name='typeManagerUserId']").remove();
			$("#user").after("<input type='hidden' name='typeManagerUserId' value='" + treeNode.id + "' />");
			$("#user").val(treeNode.name);
		};
	</script>
</@sut.selectUserTree>

<#import "/admin/common/tags/select_user.ftl" as sut1>
<@sut1.selectUserTree treeId="expertTree" treeInputId="expert" treeContentId="expertTreeContent" onClick="onClickOnExpert" selectedId="" showTree="showTree1" >
	<script>
		function onClickOnExpert(e, treeId, treeNode) {
			$("input[name='expertUserId']").remove();
			$("#expert").after("<input type='hidden' name='expertUserId' value='" + treeNode.id + "' />");
			$("#expert").val(treeNode.name);
		};
	</script>
</@sut1.selectUserTree>
