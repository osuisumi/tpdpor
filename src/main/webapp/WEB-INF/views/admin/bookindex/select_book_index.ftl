<#macro selectBookIndex bookIndexTreeId="bookIndexTree" bookIndexInputId="bookIndex" bookIndexInputName="parent" bookIndexContentId="bookIndexContent" onClick="onClick" selectedId="">
		<#nested/>
				<script>
                	var ${bookIndexTreeId}_setting = {
						async: {
							enable: true,
							url: '${ctx}/admin/book_index/entities',
							type: 'get',
							dataFilter: ${bookIndexTreeId}_zTreeAjaxDataFilter,
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
							onAsyncSuccess: ${bookIndexTreeId}_zTreeOnAsyncSuccess
						}
					};
					 
					
					function showMenu() {
						var menuObj = $("#${bookIndexInputId}");
						var menuOffset = $("#${bookIndexInputId}").offset();
						$("#${bookIndexContentId}").css({left:0 + "px", top: menuObj.outerHeight() - 1 + "px"}).slideDown("fast");
						$("body").bind("mousedown", onBodyDown);
					}
					function hideMenu() {
						$("#${bookIndexContentId}").fadeOut("fast");
						$("body").unbind("mousedown", onBodyDown);
					}
					
					function onBodyDown(event) {
						if (!(event.target.id == "${bookIndexInputId}" || event.target.id == "${bookIndexContentId}" || $(event.target).parents("#${bookIndexContentId}").length>0)) {
							hideMenu();
						}
					}
					var selectedNode;
					function ${bookIndexTreeId}_zTreeAjaxDataFilter(treeId, parentNode, responseData) {
						var treeNodes=new Array();
						if (responseData) {
						  for(var i =0; i < responseData.length; i++) {
							  node = responseData[i];
							  var parentId = "";
							  if(node.parent!=undefined&&node.parent!=null){
								  parentId=node.parent.id;
							  }
							  treeNodes[i]={id:node.id,name:node.bIndex + '   ' + node.name,pid:parentId,bIndex:node.bIndex};
							  if("${selectedId}"==node.id){
							  	selectedNode = treeNodes[i];
							  }
						  }
						}
						return treeNodes;
					};		
					
                	function ${bookIndexTreeId}_zTreeOnAsyncSuccess(){
						if(selectedNode!=null&&selectedNode!=undefined){
							var zTree = $.fn.zTree.getZTreeObj("${bookIndexTreeId}"); 
							zTree.selectNode(selectedNode);
							//zTree.updateNode(selectedNode);
						}
					}
					
                	$(document).ready(function(){
						$.fn.zTree.init($("#${bookIndexTreeId}"), ${bookIndexTreeId}_setting);
						
					});
                </script>
</#macro>