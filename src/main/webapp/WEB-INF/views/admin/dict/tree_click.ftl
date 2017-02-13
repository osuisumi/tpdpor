<#macro dictTreeClick url='' dictTreeId="dictTree" onClick="onClick" selectedId="" beforeEditName="" beforeRemove="" onRename="">
								<#nested/>
								<script>
                                	var ${dictTreeId}_Setting = {
										async: {
											enable: true,
											url: '${url}',
											type: 'get',
											dataFilter: ${dictTreeId}_zTreeAjaxDataFilter,
										},
										data: {
											simpleData: {
												enable: true,
											}
										},		
										callback: {
											onClick: ${onClick},
											onAsyncSuccess: ${dictTreeId}_zTreeOnAsyncSuccess,
											beforeEditName : ${beforeEditName},
											beforeRemove: ${beforeRemove},
											onRename: ${onRename}
										},
										view:{
											selectedMulti:false
										},
										edit: {
									        enable: true,
									        renameTitle: '编辑',
						        			removeTitle: '删除'
									    }
									};
									
									var selectedNode;
									function ${dictTreeId}_zTreeAjaxDataFilter(treeId, parentNode, responseData) {
										var treeNodes=new Array();
										if (responseData) {
										  for(var i =0; i < responseData.length; i++) {
											  node = responseData[i];
											  var uri = "";
											  if(node.permission!=undefined&&node.permission!=null){
												  uri=node.permission.actionURI;
											  }
											  treeNodes[i]={id:node.id,name:node.dictName,value:node.dictValue,code:node.dictTypeCode};
											  if("${selectedId}"==node.id){
											  	selectedNode = treeNodes[i];
											  }
										  }
										}
										return treeNodes;
									};	
									
									function ${dictTreeId}_zTreeOnAsyncSuccess(){
										if(selectedNode!=null&&selectedNode!=undefined){
											var zTree = $.fn.zTree.getZTreeObj("${dictTreeId}"); 
											zTree.selectNode(selectedNode);
											zTree.updateNode(selectedNode);
										}
									}
									
                                	$(document).ready(function(){
										$.fn.zTree.init($("#${dictTreeId}"), ${dictTreeId}_Setting);
										var treeObj = $.fn.zTree.getZTreeObj("${dictTreeId}");
										treeObj.expandAll(true);
										$(".mis-shrink-tree").click();
									});
                                </script>
                                
</#macro>