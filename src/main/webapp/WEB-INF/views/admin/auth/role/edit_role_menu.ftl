<#assign jsArray=["${ctx}/js/common/ztree/js/jquery.ztree.core.min.js","${ctx}/js/common/ztree/js/jquery.ztree.excheck.js"]/>
<#import "/admin/common/include/layout.ftl" as lo> 
<@lo.layout jsArray=jsArray>
		<div class="mis-index-wrap">
                <div class="mis-mod">
                    <div class="mis-mod-tt">
                        <h2 class="tt t1"><span>角色菜单授权</span></h2>
						<a href="javascript:saveRoleMenu()" class="mis-btn mis-main-btn f-rt"><i class="mis-save-ico"></i>保存授权</a>
                    </div>
                    <div class="mis-content">                        
                        <div class="zTreeDemoBackground left">
                            <ul id="roleMenuTree" class="ztree hasChk"></ul>
                        </div>
                    </div>  
                </div><!--end module layout -->
                <form id="roleMenuForm" method="put" action="${ctx}/auth_roles/${id}/grantMenuToRole">
                
                </form>
        </div><!--end index page -->
        
	<script>
                                	var	setting = {
                                		check: {
											enable: true,
											chkboxType: {"Y" : "ps", "N" : "ps"}
										},
										async: {
											enable: true,
											url: '${ctx}/auth_menus',
											type: 'get',
											dataFilter: zTreeAjaxDataFilter,
										},
										data: {
											key: {
												name: "name"
											},
											simpleData: {
												enable: true,
												idKey: "id",
												pIdKey: "pid",
												rootPId: null
											}
										},		
										callback: {
											onCheck: onCheck,
											onAsyncSuccess:onCheck
										}
									};
									 
									
									function onCheck(e, treeId, treeNode) {
										var zTree = $.fn.zTree.getZTreeObj("roleMenuTree"),
										nodes = zTree.getCheckedNodes(true);
										$("#roleMenuForm").empty();
										for (var i=0; i<nodes.length; i++) {
											$("#roleMenuForm").append("<input type='hidden' name='menus["+i+"].id' value='"+nodes[i].id+"' />");
										}
									}
									
									function zTreeAjaxDataFilter(treeId, parentNode, responseData) {
										var treeNodes=new Array();
										var checkedArray = ${menuIds};
										if (responseData) {
										   for(var i =0; i < responseData.length; i++) {
												  node = responseData[i];
												  var parentId = "";
												  if(node.parent!=undefined&&node.parent!=null){
													  parentId=node.parent.id
												  }
												  if($.inArray(node.id,checkedArray)>=0){
														var treeNode = {id:node.id,name:node.name,pid:parentId,checked:true};
												  		treeNodes.push(treeNode);	
												  }else{
														var treeNode = {id:node.id,name:node.name,pid:parentId};
												  		treeNodes.push(treeNode);	
												  }										  
											 }
										}
										return treeNodes;
									};
									
										
									
                                	$(document).ready(function(){
										$.fn.zTree.init($("#roleMenuTree"), setting);
										onCheck();
									});
									
									function saveRoleMenu(){
											var data = $.ajaxSubmit("roleMenuForm");
											var json = $.parseJSON(data);
											if (json.responseCode == '00') {
												 mylayerFn.msg('授权操作成功！',{icon: 0, time: 2000},function(){
											        reloadWindow();
											    });
											}
									}
                                </script>
</@lo.layout>