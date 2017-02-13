<#macro selectTree url='' treeId="treeId" treeInputId="" treeContentId="menuContent" onClick="onClick" selectedId="" showTree="showTree" ajaxDataFilter=treeId+"_ajaxDataFilter">
	<#nested/>
	<script>
		/* var selectedNode; */
		
    	var ${treeId}_setting = {
			async: {
				enable: true,
				url: '${url}',
				type: 'get',
				dataFilter: ${ajaxDataFilter},
			},
			data: {
				simpleData: {
		            enable: true,
					idKey: "id",
					pIdKey: "pid",
					rootPId: 0
		        }
			},		
			callback: {
				onClick: ${onClick},
				onAsyncSuccess: ${treeId}_zTreeOnAsyncSuccess,
			},
		    view: {
		        dblClickExpand: false,
		        showLine: false
		    }
		};
		
		function ${showTree}() {
			var obj = $("#${treeInputId}");
			var offset = $("#${treeInputId}").offset();
			$("#${treeContentId}").css({left:0 + "px", top: obj.outerHeight() - 1 + "px"}).slideDown("fast");
			$("body").bind("mousedown", ${showTree}_onBodyDown);
		}
		
		function ${showTree}_hideTree() {
			$("#${treeContentId}").fadeOut("fast");
			$("body").unbind("mousedown", ${showTree}_onBodyDown);
		}
		
		function ${showTree}_onBodyDown(event) {
			if (!(event.target.id == "${treeInputId}" || event.target.id == "${treeContentId}" || $(event.target).parents("#${treeContentId}").length>0)) {
				${showTree}_hideTree();
			}
		}
		
	/* 	function ${ajaxDataFilter}(treeId, parentNode, responseData) {
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
			console.log(responseData);
			console.log(treeNodes);
			return treeNodes;
		};		 */
		
    	function ${treeId}_zTreeOnAsyncSuccess(event, treeId, treeNode, msg){
			if(selectedNode!=null&&selectedNode!=undefined){
				var zTree = $.fn.zTree.getZTreeObj("${treeId}"); 
				zTree.selectNode(selectedNode);
			}
		}
		
    	$(document).ready(function(){
			$.fn.zTree.init($("#${treeId}"), ${treeId}_setting);
			
			//$('#${treeId}').before('<form id="${treeId}Form"></form>');
			
			$('#${treeInputId}').on('keyup',function(){
				var treeInputVal = $('#${treeInputId}').val();
				var setting = ${treeId}_setting;
				setting.async.url = '${url}' + treeInputVal;
				
				$.fn.zTree.init($("#${treeId}"), setting);
				
			});
			
		});
    </script>
</#macro>