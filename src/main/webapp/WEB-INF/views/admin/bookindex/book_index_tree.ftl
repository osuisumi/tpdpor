<#assign jsArray=["${ctx}/js/common/ztree/js/jquery.ztree.core.min.js","${ctx}/js/common/ztree/js/jquery.ztree.exedit.min.js"]/>
<#import "/admin/common/include/layout.ftl" as lo> 
<@lo.layout jsArray=jsArray validate=true>
		<div class="mis-index-wrap">
            <div class="mis-mod">
				<div class="mis-crm">
					<div class="crm">
						<a href="${ctx}/admin/teach_resource?menuTreeId=${menuTreeId}">教研资料</a>
						<span class="trg">&gt;</span>
						<a href="javascript:;">索引管理</a>
					</div>
				</div>
                <div class="mis-mod-tt">
                    <h2 class="tt t1"><span>索引管理</span></h2>
                </div>
                <div class="mis-opt-row">
                    <div class="mis-opt-mod fl">
                        <a href="javascript:;" onclick="addBIndex()" class="mis-btn mis-new-btn"><i class="mis-add-ico"></i>新建</a>
                    </div>
                </div>
                <div class="mis-content">                        
                    <div class="zTreeDemoBackground left">
                        <ul id="bookIndexTree" class="ztree"></ul>
                    </div>
                </div>  
            </div>
        </div>
<script type="text/javascript">
		var setting = {
	    view: {
	        //addHoverDom: addHoverDom,
	        removeHoverDom: removeHoverDom,
	        selectedMulti: false,
	        showLine: false
	    },
	    async: {
			enable: true,
			url: '${ctx}/book_index/entities',
			type: 'get',
			dataFilter: zTreeAjaxDataFilter,
		},
	    edit: {
	        enable: true,
	        editNameSelectAll: true,
	        showRemoveBtn: showRemoveBtn,
	        showRenameBtn: showRenameBtn,
	        renameTitle: "编辑索引",
	        removeTitle: "删除索引"
	    },
	    data: {
	        simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid",
				rootPId: null
			}
	    },
	    callback: {
	        beforeDrag: beforeDrag,
	        beforeEditName: beforeEditName,
	        beforeRemove: beforeRemove,
	       // beforeRename: beforeRename,
	        onRemove: onRemove,
	       // onRename: onRename
	    }
	};
	
	var log, className = "dark";
	function beforeDrag(treeId, treeNodes) {
	    return false;
	}
	function beforeEditName(treeId, treeNode) {
	    className = (className === "dark" ? "":"dark");
	    var zTree = $.fn.zTree.getZTreeObj("bookIndexTree");
	    zTree.selectNode(treeNode);
	    mylayerFn.open({
	            id: "editChannel",
	            type: 2,
	            title: '修改索引',
	            content: '${ctx}/admin/book_index/edit/'+treeNode.id,
				area: [600,600],
	            zIndex: 19999
	        });
	   // return confirm("进入节点 -- " + treeNode.name + " 的编辑状态吗？");
	}
	function beforeRemove(treeId, treeNode) {
	    className = (className === "dark" ? "":"dark");
	    showLog("[ "+getTime()+" beforeRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
	    var zTree = $.fn.zTree.getZTreeObj("bookIndexTree");
	    zTree.selectNode(treeNode);
    	confirm("确认删除 " + treeNode.name + "及其子索引 吗？",function(){
    		$.ajaxDelete("${ctx}/admin/book_index/"+treeNode.id,"",function(data){
				if (data.responseCode == '00') {
					 mylayerFn.msg('操作成功！',{icon: 0, time: 1000},function(){
				        window.location.reload();
				    });
				}else{
					alert("操作失败!"+json.responseMsg);
				}
    		});
    	});
    	return false;
	}
	function onRemove(e, treeId, treeNode) {

	}
	function beforeRename(treeId, treeNode, newName, isCancel) {
	    className = (className === "dark" ? "":"dark");	    
	    if (newName.length == 0) {
	        alert("节点名称不能为空.");
	        var zTree = $.fn.zTree.getZTreeObj("bookIndexTree");
	        setTimeout(function(){zTree.editName(treeNode)}, 10);
	        return false;
	    }
	    return true;
	}
	function onRename(e, treeId, treeNode, isCancel) {
		 
	   // showLog((isCancel ? "<span style='color:red'>":"") + "[ "+getTime()+" onRename ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name + (isCancel ? "</span>":""));
	}
	function showRemoveBtn(treeId, treeNode) {
	   // return !treeNode.isFirstNode;
	   return true;
	}
	function showRenameBtn(treeId, treeNode) {
	   // return !treeNode.isLastNode;
	   return true;
	}
	function showLog(str) {
	   
	}
	function getTime() {
	    var now= new Date(),
	    h=now.getHours(),
	    m=now.getMinutes(),
	    s=now.getSeconds(),
	    ms=now.getMilliseconds();
	    return (h+":"+m+":"+s+ " " +ms);
	}
	
	var newCount = 1;
	function addHoverDom(treeId, treeNode) {
	    var sObj = $("#" + treeNode.tId + "_span");
	    if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
	    var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
	        + "' title='新增索引' onfocus='this.blur();'></span>";
	    sObj.after(addStr);
	    var btn = $("#addBtn_"+treeNode.tId);
	    if (btn) btn.bind("click", function(){
	        var zTree = $.fn.zTree.getZTreeObj("bookIndexTree");
	        mylayerFn.open({
	            id: 'editBookIndex',
	            type: 2,
	            title: '新增索引',
	            content: '${ctx}/admin/book_index/create?pid='+treeNode.id,
				area: [600,600],
	            zIndex: 19999
	        });
	        return false;
	    });
	};
	function removeHoverDom(treeId, treeNode) {
	    $("#addBtn_"+treeNode.tId).unbind().remove();
	};
	
	function zTreeAjaxDataFilter(treeId, parentNode, responseData) {
			var treeNodes=new Array();
			if (responseData) {
				for(var i =0; i < responseData.length; i++) {
					node = responseData[i];
					var parentId = "";
					if(node.parent!=undefined&&node.parent!=null){
						parentId=node.parent.id;
					}
					if(parentId!=""){
						treeNodes[i]={id:node.id,name:node.bIndex + '   ' + node.name,pid:parentId,bIndex:node.bIndex};
					}else{
						treeNodes[i]={id:node.id,name:node.bIndex + '   ' + node.name,pid:parentId,bIndex:node.bIndex};
					}
				}
			}
			return treeNodes;
	};	
	$(function(){	
	    $.fn.zTree.init($("#bookIndexTree"), setting);
	    var treeObj = $.fn.zTree.getZTreeObj("bookIndexTree");
		treeObj.expandAll(true);
	});
	
	function addBIndex(){
        mylayerFn.open({
            id: 'editBookIndex',
            type: 2,
            title: '新增索引',
            content: '${ctx}/admin/book_index/create',
			area: [600,600],
            zIndex: 19999
        });
	}
</script>
</@lo.layout>