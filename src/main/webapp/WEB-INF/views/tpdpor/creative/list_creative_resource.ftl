<#assign hasCreativeManagerRole=SecurityUtils.getSubject().hasRole('creative_manager_'+(creative.id)!)>
<#assign days=(days[0])!>
<#if (queryType[0])! == 'resultShow' >
	<@resourcesDirective relationId=(creative.id)!'' page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders=(orders[0])!'CREATE_TIME.DESC' getFile=true>
	    <#if (resources?size gt 0)>
	    <ul class="m-resouce-list">
	    	<#list resources as r>
	    		<#if (r.fileInfos)??>
	    			<#list (r.fileInfos) as file>
				        <li fileId="${(file.id)!''}">
				            <a href="javascript:;" onclick="viewResourceFile('${(r.id)!}','${(file.id)!}');" class="u-file-type ${FileTypeUtils.getFileTypeClass(file.fileName, 'suffix') }"></a>
				            <div class='m-res-listTxt'>
				                <p class="fill-tl"><a href="javascript:;" onclick="viewResourceFile('${(r.id)!}','${(file.id)!}');">${(file.fileName)!''}</a></p>
				                <p class="who-up">${(file.creator.realName)!''}<span>上传于</span>${TimeUtils.formatDate(file.createTime, 'yyyy/MM/dd')}</p>
				                <#if days gt 0>
				               		<#if hasCreativeManagerRole || SecurityUtils.getSubject().hasRole('creative_resource_'+(r.id)!)>	
					                	<a onclick="downloadFile('${file.id}', '${(file.fileName)!}','creative','${(r.id)!}')" href="javascript:;" class="up-times"><i></i>${(file.fileRelations[0].downloadNum)!0}</a>
					              	<#else>
					                	<a onclick="goPayCreativeResource('${(r.id)!}','${file.id}')" class="up-times" href="javascript:;"><i></i>${(file.fileRelations[0].downloadNum)!0}</a>
					                </#if>
					                <#if hasCreativeManagerRole>
					              		<a onclick="goUpdateCreativeResource('${(r.id)!}');" class="btn-modIcon" href="javascript:;"><i class="u-modIcon"></i>修改</a>
					                	<a onclick="deleteCreativeResource(this,'${(r.id)!}');" class="btn-delIcon" href="javascript:;"><i class="u-delIcon"></i>删除</a>
					                </#if>
				                </#if>
				            </div>
				        </li>
	    			</#list> 
	    		</#if>
	        </#list>                                    
	    </ul>
	    </#if>
	</@resourcesDirective>
	<script>	
		//查看全部资源
	    $(".resource-button .au-uploadSee").on("click",function(){
	    	mylayerFn.open({
	        	id: 'listAllCreativeFileLayer',
	            type: 2,
	            title: '课程资源',
	            fix: false,
	            area: [1000, 800],
		        offset : [$(document).scrollTop()],
				shadeClose : true,
	            content: '${ctx!}/creative/resource?id=${(creative.id)!}'
	        });
	    });
		
		function goCreateCreativeResource(id){			
			window.open('${ctx!}/creative/resource/create?id='+id);
		};
		
		function viewResourceFile(resourceId,fileId){
			window.open('${ctx!}/creative/${(creative.id)!}/resource/'+resourceId+'/view?resources[0].fileInfos[0].id='+fileId+'&type=${(creative.type)!'teach'}');
		};
		
		function goUpdateCreativeResource(resourceId){
			window.open('${ctx!}/creative/${(creative.id)!}/resource/'+resourceId+'/edit');
		};
		
		function deleteCreativeResource(o,resourceId){
			var _this = $(o);
			confirm('确定要删除这个创客资源吗?', function(){
				$.post("${ctx!}/creative/${(creative.id)!}/resource/"+resourceId,{
					"_method":'delete'
				},function(response){
					if(response.responseCode == '00'){
						_this.closest('li').remove();
					}else{
						alert('删除失败');
					}
				})
			});
		};
		
		function goPayCreativeResource(resourceId,fileInfoId){
			mylayerFn.open({
	        	id: 'payCreativeResourceLayer',
	            type: 2,
	            title: '温馨提示',
	            fix: false,
	            area: [600, 300],
		        offset : [$(document).scrollTop()],
				shadeClose : true,
	            content: '${ctx!}/creative/${(creative.id)!}/resource/'+resourceId+'/goPay?resources[0].fileInfos[0].id='+fileInfoId,
	        });
		};
	</script>
<#else>
	<#assign creative=(creative)!>
	<@creativeData id=(creative.id)!>
		<#if (creativeModel)??>
			<#assign creative=creativeModel>
		</#if>
	</@creativeData>
	<@resourcesDirective relationId=(creative.id)!'' page=(pageBounds.page)!1 limit=(pageBounds.limit)!12 orders=(orders[0])!'CREATE_TIME.DESC' getFile=true>
		<div class="g-see-resource">        
		    <div class="m-see-resourceHd">
		        <div class="l">
		        	<#if hasCreativeManagerRole>
		            	<a onclick="goCreateCreativeResource('${(creative.id)!}');" class='au-uploadFile au-fill-btn' href="javascript:;"><i class="au-uploadFile-ico"></i>上传资源</a>
			        	<a onclick="deleteCreativeResources('${(creative.id)!}');" class="btn-delIcon" href="javascript:;"><i class="u-delIcon"></i>删除</a>
			        </#if>
		        </div>
		        <div class="r">
		            <a id="blockDisplay" onclick="changeDisplay('block');" class="across crt" href="javascript:;"><i></i></a>
		            <a id="listDisplay" onclick="changeDisplay('list');" class="list" href="javascript:;"><i></i></a>
		        </div>
		    </div>
		    <div class="m-detail-cont">
				<ul class="m-resouce-list" id="resourceList">
				    <#if (resources?size gt 0)>
				    	<#list resources as r>
				    		<#if (r.fileInfos)??>
					        	<#list (r.fileInfos) as file>
						            <li fileId="${(file.id)!''}" class="blockResource" resourceId="${(r.id)!}">
						                <a href="javascript:;" class="u-file-type ${FileTypeUtils.getFileTypeClass(file.fileName, 'suffix') }"></a>
						                <div class='m-res-listTxt'>
						                    <p class="fill-tl"><a href="javascript:;">${(file.fileName)!''}</a></p>
						                    <p class="who-up">${(file.creator.realName)!''}<span>上传于</span>${TimeUtils.formatDate(file.createTime, 'yyyy/MM/dd')}</p>
						                    <label class="m-checkbox-tick">
						                        <strong>
						                            <i class="ico"></i>
						                            <input type="checkbox">
						                        </strong>
						                    </label>
						                </div>
						            </li>
						            <li fileId="${(file.id)!}" style="display:none;" class="listResource" resourceId="${(r.id)!}">
					                    <div class="m-fill-cont">
					                        <a href="javascript:;" class="u-fill-${FileTypeUtils.getFileTypeClass(file.fileName, 'suffix') } u-file-type"></a>
					                        <p><a href="javascript:;">${(file.fileName)!''}</a></p>                                        
					                    </div>
					                    <div class="m-fill-load">
					                        <p><span><a href="javascrip:;">${(file.creator.realName)!''}</a></span>创建于<ins class="time">${TimeUtils.formatDate(file.createTime, 'yyyy-MM-dd')}</ins><ins class="time">${TimeUtils.formatDate(file.createTime, 'HH:mm:SS')}</ins><i class="line">|</i>类型：课件 <i class="line">|</i>下载量：${(file.fileRelations[0].downloadNum)!0}<i class="line">|</i>浏览量：8</p>
					                    </div>
					                    <div class="m-fill-litterBtn">
					                    	<#if hasCreativeManagerRole || SecurityUtils.getSubject().hasRole('creative_resource_'+(r.id)!)>
					                    		<a onclick="downloadFile('${file.id}', '${file.fileName }','creative','${(r.id)!}')" href="javascript:;" class="u-load-resc"><i></i>下载资源</a>
					                    	<#else>
						                        <a onclick="goPayCreativeResource('${(r.id)!}','${file.id}');" class="u-load-resc" href="javascript:;"><i></i>下载资源</a>             
					                    	</#if> 
					                        <#if hasCreativeManagerRole>                       
					                        	<a onclick="goUpdateCreativeResource('${(r.id)!}');" href="javascript:;" class="btn-modIcon"><i class="u-modIcon"></i>修改</a>
					                        	<a onclick="deleteCreativeResource(this,'${(r.id)!}');" href="javascript:;" class="btn-delIcon"><i class="u-delIcon"></i>删除</a>                         
					                        </#if>
					                    </div>
					                </li>
					            </#list>
					        </#if>
				        </#list>
				    </#if>           
				</ul> 
		    </div>
		    <form id="listFileResourcesForm" method="GET" action="${ctx!}/creative/resource" >	
				<input class="limit" type="hidden" name="limit" value="12" >
				<input type="hidden" name="id" value="${(creative.id)!}" >
				<input id="showType" type="hidden" name="showType" value="${(showType[0])!'block'}">
				<input type="hidden" name="resources[0].relation.id" value="${(creative.id)!''}" >
			    <div id="myCoursePage" class="m-laypage"></div>
			    <#if paginator??>
			 		<#import '/tpdpor/common/tags/pagination_layer.ftl' as p />
					<@p.paginationLayerFtl formId="listFileResourcesForm" divId="myCoursePage" paginator=paginator refreshDivId="listAllCreativeFileLayer"/>
				</#if>
			</form>
		</div>
	</@resourcesDirective>
	<script>
		$(function(){
			$.ajaxSetup({
		 		cache:false
		 	});
		 	
		 	changeDisplay("${(showType[0])!'block'}");
			$("input[type='checkbox']").bindCheckboxRadioSimulate();
		});
		
		//显示模式 
		function changeDisplay(type){
			$('.r').find('a').removeClass('crt');
			if(type == 'list'){
				$('#resourceList').attr('class','am-file-list');
				$('#listDisplay').addClass('crt');
				$('.listResource').show();
				$('.blockResource').hide();
			}
			if(type == 'block'){
				$('#resourceList').attr('class','m-resouce-list');
				$('#blockDisplay').addClass('crt');
				$('.blockResource').show();
				$('.listResource').hide();
			}
			$('#listFileResourcesForm input[name=showType]').val(type);
		};
		
		//删除资源
		function deleteCreativeResources(relationId){
			var checkboxArray = $('.blockResource input[type="checkbox"]:checked'); 
			var id = '';
			$.each(checkboxArray,function(i,v){
				var resourceId = $(this).closest('li').attr('resourceId');
				if(resourceId != null && resourceId != undefined && resourceId != ''){				
					id = id + ',' + resourceId;
				}
			});
			
			if(id == ''){
				alert('请勾选资源');
				return false;
			}
			confirm('确定要删除?', function(){
				$.ajaxDelete('${ctx!}/creative/${(creative.id)!}/resource/'+id,'' , function(data){
					if(data.responseCode == '00'){
						alert('删除成功');
						mylayerFn.refresh({
				            id: 'listAllCreativeFileLayer',
				            content: $('#listFileResourcesForm').attr('action') + '?' + $('#listFileResourcesForm').serialize()
				        });
					}	
				});
			});			
		};
		
		function goCreateCreativeResource(id){			
			window.open('${ctx!}/creative/resource/create?id='+id);
		};
		
		function goUpdateCreativeResource(resourceId){
			window.open('${ctx!}/creative/${(creative.id)!}/resource/'+resourceId+'/edit');
		};
		
		function deleteCreativeResource(o,resourceId){
			confirm('确定要删除这个创客资源吗?', function(){
				$.post("${ctx!}/creative/${(creative.id)!}/resource/"+resourceId,{
					"_method":'delete'
				},function(response){
					if(response.responseCode == '00'){
						mylayerFn.refresh({
				            id: 'listAllCreativeFileLayer',
				            content: $('#listFileResourcesForm').attr('action') + '?' + $('#listFileResourcesForm').serialize()
				        });
					}else{
						alert('删除失败');
					}
				})
			});
		};
		
		function goPayCreativeResource(resourceId,fileInfoId){
			mylayerFn.open({
	        	id: 'payCreativeResourceLayer',
	            type: 2,
	            title: '温馨提示',
	            fix: false,
	            area: [600, 300],
		        offset : [$(document).scrollTop()],
				shadeClose : true,
	            content: '${ctx!}/creative/${(creative.id)!}/resource/'+resourceId+'/goPay?resources[0].fileInfos[0].id='+fileInfoId,
	        });
		};
	</script>
</#if>