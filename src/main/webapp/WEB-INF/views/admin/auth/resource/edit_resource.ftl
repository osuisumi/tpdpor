<#import "/admin/common/include/form_layer.ftl" as fl>
<@fl.form id="updateResourceForm" action="${ctx}/auth_resources/${authResource.id}" method="put">
<ul class="mis-ipt-lst">
	<li class="item">
		<div class="mis-ipt-row">
			<div class="tl">
				<span>资源名称：</span>
			</div>
			<div class="tc">
				<div class="mis-ipt-mod">
					<input type="text" name="name" value="${authResource.name!}" class="mis-ipt">
				</div>
			</div>
		</div>
	</li>
	<li class="item">
		<div class="mis-ipt-row">
			<div class="tl">
				<span>资源编码：</span>
			</div>
			<div class="tc">
				<div class="mis-ipt-mod">
					<input type="text" name="code" value="${authResource.code!}" class="mis-ipt">
				</div>
			</div>
		</div>
	</li>
	<li class="item">
		<div class="mis-ipt-row">
			<div class="tl">
				<span>上级资源：</span>
			</div>
			<div class="tc">
				<div class="mis-treeSelect">
					<div class="mis-ipt-mod">
						<input type="text" id="resourceParent" readonly  class="mis-ipt"   onclick="showResource();"/>
						<a id="selectResourceBtn" href="javascript:;" class="selectBtn" onclick="showResource(); return false;">请选择</a>
					</div>
					<div id="resourceZtreeContent" class="menuZtreeContent">
						<ul id="parentResourceTree" class="ztree selectTree"></ul>
					</div>
				</div>
			</div>
		</div>
	</li>

</ul>
</@fl.form>
<#import "/admin/auth/resource/select_resource.ftl" as sm>
<@sm.selectResource resourceTreeId="parentResourceTree" onClick="selectParentResource" resourceInputId="resourceParent" resourceInputName="parent" resourceContentId="resourceZtreeContent" selectedId=(authResource.parent.id)!''>
<script>
	function selectParentResource(e, treeId, treeNode) {
		$("input[name^='parent']").remove();
		$("#resourceParent").append("<input type='hidden' name='parent.id' value='" + treeNode.id + "' />");
		$("#resourceParent").val(treeNode.name);
	}
</script>
</@sm.selectResource>