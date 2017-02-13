<#import "/admin/common/include/form_layer.ftl" as fl>
<@fl.form id="updateMenuForm" action="${ctx}/auth_menus/${authMenu.id}" method="put">
<ul class="mis-ipt-lst">
	<li class="item">
		<div class="mis-ipt-row">
			<div class="tl">
				<span>菜单名称：</span>
			</div>
			<div class="tc">
				<div class="mis-ipt-mod">
					<input type="text" name="name" value="${authMenu.name!}" class="mis-ipt">
				</div>
			</div>
		</div>
	</li>
	<li class="item">
		<div class="mis-ipt-row">
			<div class="tl">
				<span>上级菜单：</span>
			</div>
			<div class="tc">
				<div class="mis-treeSelect">
					<div class="mis-ipt-mod">
						<input type="text" id="menuParent" readonly  class="mis-ipt"   onclick="showMenu();"/>
						<a id="selectMenuBtn" href="javascript:;" class="selectBtn" onclick="showMenu(); return false;">请选择</a>
					</div>
					<div id="menuZtreeContent" class="menuZtreeContent">
						<ul id="parentMenuTree" class="ztree selectTree"></ul>
					</div>
				</div>
			</div>
		</div>
	</li>
	<li class="item">
		<div class="mis-ipt-row">
			<div class="tl">
				<span>顺序号：</span>
			</div>
			<div class="tc">
				<div class="mis-ipt-mod">
					<input type="text" name="orderNo" value="${authMenu.orderNo!}" class="mis-ipt">
				</div>
			</div>
		</div>
	</li>
	<li class="item">
		<div class="mis-ipt-row">
			<div class="tl">
				<span>权限链接：</span>
			</div>
			<div class="tc">
				<div class="mis-treeSelect">
					<div class="mis-ipt-mod">
						<input type="text" id="resourcePermission" readonly  class="mis-ipt"   onclick="showResourcePermission();"/>
						<a id="selectPermissionBtn" href="javascript:;" class="selectBtn" onclick="showResourcePermission(); return false;">请选择</a>
					</div>
					<div id="resourcePermissionZtreeContent" class="menuZtreeContent">
						<ul id="resourcePermissionTree" class="ztree selectTree"></ul>
					</div>
				</div>
			</div>
		</div>
	</li>
</ul>
</@fl.form>
<#import "/admin/auth/menu/select_menu.ftl" as sm>
<@sm.selectMenu menuTreeId="parentMenuTree" onClick="selectParentMenu" menuInputId="menuParent" menuInputName="parent" menuContentId="menuZtreeContent" selectedId=pid!''>
<script>
	function selectParentMenu(e, treeId, treeNode) {
		$("input[name^='parent']").remove();
		$("#menuParent").append("<input type='hidden' name='parent.id' value='" + treeNode.id + "' />");
		$("#menuParent").val(treeNode.name);
	}
</script>
</@sm.selectMenu>
<#import "/admin/auth/permission/select_resource_permission.ftl" as srp>
<@srp.selectResourcePermission  onClick="selectResourcePermission" resourcePermissionInputId="resourcePermission" resourcePermissionInputName="permission" resourcePermissionContentId="resourcePermissionZtreeContent" selectedId=authMenu.permission.id!''>
<script>
	function selectResourcePermission(e, treeId, treeNode) {
		$("input[name^='permission']").remove();
		$("#resourcePermission").append("<input type='hidden' name='permission.id' value='" + treeNode.id + "' />");
		$("#resourcePermission").val(treeNode.name);
	}
</script>
</@srp.selectResourcePermission>