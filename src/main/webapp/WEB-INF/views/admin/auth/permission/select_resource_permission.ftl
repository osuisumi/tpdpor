<#macro selectResourcePermission resourcePermissionTreeId="resourcePermissionTree" resourcePermissionInputId="resourcePermission" resourcePermissionInputName="permission" resourcePermissionContentId="resourcePermissionContent" onClick="onClick" selectedId="">
								<#nested/>
								<script>
                                	var ${resourcePermissionTreeId}_Setting = {
										async: {
											enable: true,
											url: '${ctx}/auth_resources',
											type: 'get',
											dataFilter: ${resourcePermissionTreeId}_zTreeAjaxDataFilter,
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
											onClick: ${onClick},
											onAsyncSuccess: ${resourcePermissionTreeId}_zTreeOnAsyncSuccess
										},
										view:{
											selectedMulti:false
										}
									};
									
									function showResourcePermission() {
										var resourceObj = $("#${resourcePermissionInputId}");
										var resourceOffset = $("#${resourcePermissionInputId}").offset();
										$("#${resourcePermissionContentId}").css({left:0 + "px", top: resourceObj.outerHeight() - 1 + "px"}).slideDown("fast");
										$("body").bind("mousedown", onBodyDown);
									}
									function hideResourcePermission() {
										$("#${resourcePermissionContentId}").fadeOut("fast");
										$("body").unbind("mousedown", onResourcePermissionBodyDown);
									}
									
									function onResourcePermissionBodyDown(event) {
										if (!(event.target.id == "${resourcePermissionInputId}" || event.target.id == "${resourcePermissionContentId}" || $(event.target).parents("#${resourcePermissionContentId}").length>0)) {
											hideResourcePermission();
										}
									}
									var selectedNode;
									
									function ${resourcePermissionTreeId}_zTreeAjaxDataFilter(treeId, parentNode, responseData) {
										var treeNodes=new Array();
										if (responseData) {
										  for(var i =0; i < responseData.length; i++) {
												  node = responseData[i];
												  var parentId = "";
												  if(node.parent!=undefined&&node.parent!=null){
													  parentId=node.parent.id
												  }
												  var treeNode = {id:node.id,name:node.name,pid:parentId};
												  treeNodes.push(treeNode);
												  if(node.permissions){
													  for(var j=0;j<node.permissions.length;j++){
														  permission = node.permissions[j];
														  var treePermissionNode = {id:permission.id,name:permission.name,pid:node.id};
														  treeNodes.push(treePermissionNode);
													  }
												  }
											 }
										}
										return treeNodes;
									};	
									
									function ${resourcePermissionTreeId}_zTreeOnAsyncSuccess(){
										if(selectedNode!=null&&selectedNode!=undefined){
											var zTree = $.fn.zTree.getZTreeObj("${resourcePermissionTreeId}"); 
											zTree.selectNode(selectedNode);
											zTree.updateNode(selectedNode);
										}
									}
									
                                	$(document).ready(function(){
										$.fn.zTree.init($("#${resourcePermissionTreeId}"), ${resourcePermissionTreeId}_Setting);
										//var treeObj = $.fn.zTree.getZTreeObj("${resourcePermissionTreeId}");
									});
                                </script>
                                
</#macro>