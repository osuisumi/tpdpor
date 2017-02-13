<#assign jsArray=["${ctx!}/js/common/ztree/js/jquery.ztree.core.min.js","${ctx!}/js/common/ztree/js/jquery.ztree.exedit.min.js"]/>
<#import "/admin/common/include/layout.ftl" as lo> 
<@lo.layout jsArray=jsArray>
		<div class="mis-index-wrap">
			<div class="mis-column-innerBox mis-block-cont">
                        <div class="mis-column-innerL">
		                    <div class="mis-mod-tt">
                                <h2 class="tt t1">
                                    <span>培训板块</span>
                                </h2>  
                                <div class="mis-go-shrink">
			                    	<i onclick="goCreateDict('post');" class="mis-add-ico"></i>
			                	</div>
                            </div> 
                            <div class="mis-ztree">
                                <ul id="misZtree" class="ztree"></ul>
                            </div>                    
             			</div>
					<#assign formId="listTopicForm"/>
					<div class="mis-column-innerR">
                            <div class="mis-mod-tt">
                                <h2 class="tt t1">
                                    <span>主题操作管理</span>
                                </h2>                                
                            </div>
                            <div class="mis-content" style="padding-left:10px;" id="topicContent">
                            <#if ((postValue)!'') != '' >
							<@adminDictsDirective dictTypeCode='TRAIN_RESOURCE_TOPIC' parentValue=(param_postValue)! page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders=(orders[0])!'SORT_NO'>
							<#import "/admin/common/include/form.ftl" as cf>
							<@cf.form id="${formId}" action="${ctx!}/tpdpor/admin/dict/post_topic/${postValue!}?postValue=${postValue!}&page=${(pageBounds.page)!1}&limit=${(pageBounds.limit)!10}&orders=${(orders[0])!'SORT_NO'}" method="get">
			                    <div class="mis-srh-layout">
			                    </div>
			                    <div class="mis-table-layout">
			                    	<div class="mis-table-srhTl">
			                                <i class="mis-srh-result"></i>
			                                <span>搜索结果</span>
			                        </div>
			                        <div class="mis-opt-row">
			                            <div class="mis-opt-mod fl">
			                                <button type="button" class="mis-btn mis-inverse-btn" onclick="goCreateDict('topic');" ><i class="mis-add-ico"></i>新建</button>
			                                <button type="button" class="mis-btn mis-inverse-btn disabled-btn  disabled" disabled="disabled" onclick="goUpdateDict();" ><i class="mis-alter-ico"></i>修改</button>
			                                <button type="button" onclick="deleteDict();" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled"><i class="mis-detele-ico"></i>删除</button>                                
			                            </div>
			                            <div class="selectedNum fr">
			                                  <span>已选中<strong class="num">0</strong>条记录</span>
			                             </div>
			                        </div>
			                        <div class="mis-table-mod">
			                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
			                                <thead>
			                                    <tr>
			                                        <th width="2%"></th>
													<th width="25%">名称</th>
			                                    </tr>
			                                </thead>
			                                <tfoot>
			                                    <tr>
			                                        <td colspan="4">
			                                            <#import "/admin/common/include/pagination.ftl" as page/>
														<@page.adminPage formId="${formId}" divId="" paginator=paginator/>
			                                        </td>
			                                    </tr>
			                                </tfoot>
			                                <tbody>
												<#if dictEntries??>
												<#list dictEntries as d>
			                                    <tr>
			                                        <td>
				                                        <label class="mis-checkbox">
				                                               <strong>
				                                                    <i class="ico"></i>
				                                                    <input type="checkbox" name="checkboxId" class="checkRow" value="${d.id}">
				                                               </strong>
				                                        </label>
			                                        </td>
													<td>${d.dictName}</td>
			                                    </tr> 
			                                    </#list>
			                                    </#if>                                  
			                                </tbody>
			                            </table>
			                        </div>
			                    </div>
			                </@cf.form>
			                </@adminDictsDirective>
			                </#if>
			            </div>
			    	</div>
				</div>
						<script type="text/javascript">
						
								function goCreateDict(type){
									if(type == 'post'){
										var title = '新增板块';
										var dictTypeCode = 'TRAIN_RESOURCE_POST';
									}
									if(type == 'topic'){
										var title = '新增主题';
										var dictTypeCode = 'TRAIN_RESOURCE_TOPIC';
									}
									 mylayerFn.open({
							            id: "createDict",
							            type: 2,
							            title: title,
							            content: '${ctx!}/tpdpor/admin/dict/create?parentValue=${(param_postValue)!}&dictTypeCode='+dictTypeCode,
										area: [600,400],
							            zIndex: 19999,
							            offset : [$(document).scrollTop()],
										fix : false,
										shadeClose : true,
							        });
								};
								
								function goUpdateDict(){
									var id = getCheckedboxValues('${formId!}', 'checkboxId',1);
									if(id != ''){
										mylayerFn.open({
								            id: 12345,
								            type: 2,
								            title: '修改主题',
								            content: '${ctx!}/tpdpor/admin/dict/'+id+'/edit?dictTypeCode=TRAIN_RESOURCE_TOPIC',
											area: [600,400],
								            zIndex: 19999,
								            offset : [$(document).scrollTop()],
											fix : false,
											shadeClose : true,
							        	});
									}else{
										alert("请选择一条记录！");
										return false;
									}
								};
								
								function deleteDict(){
									var id = getCheckedboxValues('${formId}','checkboxId',1);
									if(id != ''){
										confirm('确认要删除选中记录吗？',function(r){
											$.ajaxDelete('${ctx!}/tpdpor/admin/dict/'+id, "dictTypeCode=TRAIN_RESOURCE_TOPIC", function(){
										    	$("#${formId!}").submit();
											});
										});
									} 
								};
						</script>
			            
						<script>
							function onClick(event, treeId, treeNode, clickFlag) {
								window.location.href="${ctx!}/tpdpor/admin/dict/post_topic/"+treeNode.id+"?menuTreeId=${menuTreeId!}&postValue="+treeNode.value;
							};
							function beforeEditName(treeId, treeNode){
								if(treeNode.value == '01'){
									alert("中小学教师不允许修改");
									return false;
								}
								return true;
							};
							function beforeRemove(treeId, treeNode){
								if(treeNode.value == '01'){
									alert("中小学教师不允许删除");
									return false;
								}
								var r = false;
								confirm("确认删除 板块 -- " + treeNode.name + " 吗？",function(){    
							    	$.ajaxDelete("${ctx!}/tpdpor/admin/dict/" + treeNode.id,"",function(response){
										if(response.responseCode == '00'){
											alert('操作成功');
											var treeObj = $.fn.zTree.getZTreeObj("misZtree");
											treeObj.removeNode(treeNode);
											return true;
										}else{
											return false;
										}
									});
								});
								return r;
							};
							function onRename(event, treeId, treeNode, isCancel){
								$.ajaxPut('${ctx}/tpdpor/admin/dict/'+treeNode.id, "dictName="+treeNode.name+"&dictTypeCode=TRAIN_RESOURCE_POST", function(response){
									if(response.responseCode == '00'){
										alert("修改成功");
										var treeObj = $.fn.zTree.getZTreeObj("misZtree");
										treeObj.reAsyncChildNodes(null, "refresh");
									}else{
										alert("修改失败");
									}
								});
							};
						</script>
						<#import "/admin/dict/tree_click.ftl" as tc> 
						<@tc.dictTreeClick dictTreeId="misZtree" url="${ctx!}/dict/getEntryList?dictTypeCode=TRAIN_RESOURCE_POST" beforeEditName="beforeEditName" beforeRemove="beforeRemove" onRename="onRename">
						</@tc.dictTreeClick>
</@lo.layout>