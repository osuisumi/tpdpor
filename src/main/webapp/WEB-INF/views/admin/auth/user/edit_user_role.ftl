<#assign jsArray=["${ctx}/js/common/ztree/js/jquery.ztree.core.min.js","${ctx}/js/common/ztree/js/jquery.ztree.excheck.js"]/>
<#import "/admin/common/include/layout.ftl" as lo> 
<@lo.layout jsArray=jsArray>
		<div class="mis-index-wrap">
                <div class="mis-mod">
        			<div class="mis-crm">
						<div class="crm">
							<a href="${ctx}/admin/account?menuTreeId=${menuTreeId}">用户管理</a>
							<span class="trg">&gt;</span>
							<a href="javascript:;">分配角色</a>
						</div>
					</div>
                    <div class="mis-mod-tt">
                        <h2 class="tt t1"><span>分配用户角色</span></h2>
						<a href="javascript:saveUserRole()" class="mis-btn mis-main-btn f-rt"><i class="mis-save-ico"></i>保存分配</a>                   </div>
                    <div class="mis-content">                        
                        <div class="zTreeDemoBackground left">
                            <ul id="userRoleTree" class="ztree hasChk"></ul>
                        </div>
                    </div>  
                </div><!--end module layout -->
                <form id="userRoleForm" method="put" action="${ctx}/auth_users/${id}/grantRoleToUser">
                
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
											url: '${ctx}/auth_roles',
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
										var zTree = $.fn.zTree.getZTreeObj("userRoleTree"),
										nodes = zTree.getCheckedNodes(true);
										$("#userRoleForm").empty();
										for (var i=0; i<nodes.length; i++) {
											$("#userRoleForm").append("<input type='hidden' name='roles["+i+"].id' value='"+nodes[i].id+"' />");
										}
										//relationId
										$("#userRoleForm").append("<input type='hidden' name='relationId' value='es' />");
									}
									
									function zTreeAjaxDataFilter(treeId, parentNode, responseData) {
										var treeNodes=new Array();
										var checkedArray = ${roleIds};
										if (responseData) {
										   for(var i =0; i < responseData.length; i++) {
												  node = responseData[i];
												  var parentId = "";
												  if(node.code != 'admin'){
  													  if($.inArray(node.id,checkedArray)>=0){
													  	var treeNode = {id:node.id,name:node.name,pid:parentId,checked:true};
													  	treeNodes.push(treeNode);
													  }else{
													  	var treeNode = {id:node.id,name:node.name,pid:parentId};
													  	treeNodes.push(treeNode);
													  }
												  }
											 }
										}
										return treeNodes;
									};
									
										
									
                                	$(document).ready(function(){
										$.fn.zTree.init($("#userRoleTree"), setting);
										onCheck();
									});
									
									function saveUserRole(){
											var data = $.ajaxSubmit("userRoleForm");
											var json = $.parseJSON(data);
											if (json.responseCode == '00') {
												 mylayerFn.msg('授权操作成功！',{icon: 0, time: 2000},function(){
											        reloadWindow();
											    });
											}
									}
                                </script>
</@lo.layout>