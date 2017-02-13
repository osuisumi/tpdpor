<#macro resourceTreeClick resourceTreeId="resourceTree" onClick="onClick" selectedId="">
								<#nested/>
								<script>
                                	var ${resourceTreeId}_Setting = {
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
										},
										view:{
											selectedMulti:false
										}
									};
									
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
											  var uri = "";
											  if(node.permission!=undefined&&node.permission!=null){
												  uri=node.permission.actionURI;
											  }
											  if(parentId!=""){
											  	treeNodes[i]={id:node.id,name:node.name,pid:parentId};
											  }else{
											  	treeNodes[i]={id:node.id,name:node.name,pid:parentId,open:true};
											  }
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
											zTree.selectNode(selectedNode);
											zTree.updateNode(selectedNode);
										}
									}
									
                                	$(document).ready(function(){
										$.fn.zTree.init($("#${resourceTreeId}"), ${resourceTreeId}_Setting);
										var treeObj = $.fn.zTree.getZTreeObj("${resourceTreeId}");
										treeObj.expandAll(true);
										$(".mis-shrink-tree").click();
									});
                                </script>
                                
</#macro>