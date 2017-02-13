<#macro selectMenu menuTreeId="menuTree" menuInputId="menu" menuInputName="menus" menuContentId="menuContent" onClick="onClick" selectedId="">
								<#nested/>
								<script>
                                	var ${menuTreeId}_setting = {
										async: {
											enable: true,
											url: '${ctx}/auth_menus',
											type: 'get',
											dataFilter: ${menuTreeId}_zTreeAjaxDataFilter,
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
											onAsyncSuccess: ${menuTreeId}_zTreeOnAsyncSuccess
										}
									};
									 
									
									function showMenu() {
										var menuObj = $("#${menuInputId}");
										var menuOffset = $("#${menuInputId}").offset();
										$("#${menuContentId}").css({left:0 + "px", top: menuObj.outerHeight() - 1 + "px"}).slideDown("fast");
										$("body").bind("mousedown", onBodyDown);
									}
									function hideMenu() {
										$("#${menuContentId}").fadeOut("fast");
										$("body").unbind("mousedown", onBodyDown);
									}
									
									function onBodyDown(event) {
										if (!(event.target.id == "${menuInputId}" || event.target.id == "${menuContentId}" || $(event.target).parents("#${menuContentId}").length>0)) {
											hideMenu();
										}
									}
									var selectedNode;
									function ${menuTreeId}_zTreeAjaxDataFilter(treeId, parentNode, responseData) {
										var treeNodes=new Array();
										if (responseData) {
										  for(var i =0; i < responseData.length; i++) {
											  node = responseData[i];
											  var parentId = "";
											  if(node.parent!=undefined&&node.parent!=null){
												  parentId=node.parent.id
											  }
											  treeNodes[i]={id:node.id,name:node.name,pid:parentId};
											  if("${selectedId}"==node.id){
											  	selectedNode = treeNodes[i];
											  }
										  }
										}
										return treeNodes;
									};		
									
                                	function ${menuTreeId}_zTreeOnAsyncSuccess(){
										if(selectedNode!=null&&selectedNode!=undefined){
											var zTree = $.fn.zTree.getZTreeObj("${menuTreeId}"); 
											zTree.selectNode(selectedNode);
											//zTree.updateNode(selectedNode);
										}
									}
									
                                	$(document).ready(function(){
										$.fn.zTree.init($("#${menuTreeId}"), ${menuTreeId}_setting);
										
									});
                                </script>
</#macro>