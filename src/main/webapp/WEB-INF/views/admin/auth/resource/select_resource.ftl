<#macro selectResource resourceTreeId="resourceTree" resourceInputId="resource" resourceInputName="resources" resourceContentId="resourceContent" onClick="onClick" selectedId="">
								<#nested/>
								<script>
                                	var ${resourceTreeId}_setting = {
										async: {
											enable: true,
											url: '${ctx}/auth_resources',
											type: 'get',
											dataFilter: ${resourceTreeId}_zTreeAjaxDataFilter,
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
											onAsyncSuccess: ${resourceTreeId}_zTreeOnAsyncSuccess
										}
									};
									 
									
									function showResource() {
										var resourceObj = $("#${resourceInputId}");
										var resourceOffset = $("#${resourceInputId}").offset();
										$("#${resourceContentId}").css({left:0 + "px", top: resourceObj.outerHeight() - 1 + "px"}).slideDown("fast");
										$("body").bind("mousedown", onBodyDown);
									}
									function hideResource() {
										$("#${resourceContentId}").fadeOut("fast");
										$("body").unbind("mousedown", onBodyDown);
									}
									
									function onBodyDown(event) {
										if (!(event.target.id == "${resourceInputId}" || event.target.id == "${resourceContentId}" || $(event.target).parents("#${resourceContentId}").length>0)) {
											hideResource();
										}
									}
									var selectedNode;
									function ${resourceTreeId}_zTreeAjaxDataFilter(treeId, parentNode, responseData) {
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
									
                                	function ${resourceTreeId}_zTreeOnAsyncSuccess(){
										if(selectedNode!=null&&selectedNode!=undefined){
											var zTree = $.fn.zTree.getZTreeObj("${resourceTreeId}"); 
											//zTree.selectNode(selectedNode);
											//zTree.updateNode(selectedNode);
										}
									}
									
                                	$(document).ready(function(){
										$.fn.zTree.init($("#${resourceTreeId}"), ${resourceTreeId}_setting);
										
									});
                                </script>
</#macro>