<#import "/userCenter/common/include/layout.ftl" as lo>
<#assign jsArray = ["${ctx!}/js/common/laypage/laypage.js","${ctx!}/js/common/webuploader/webuploader.min.js","${ctx}/js/tpdpor/uploadFile.js"] />
<#assign cssArray = ["${ctx!}/js/common/laypage/skin/laypage.css","${ctx!}/js/common/webuploader/webuploader.css"] />
<@lo.layout jsArray=jsArray cssArray=cssArray validate=true mylayer=true menu='pxxx'>
<#assign formId="listTrainResourceForm"/>
	<@ucTrainResourcesData queryType=(param_queryType)!'all' getFollow=true
		page=(pageBounds.page)!1 limit=(pageBounds.limit)!10 orders=(param_orders)!'CREATE_TIME.DESC'>
	<#import "/userCenter/common/include/form.ftl" as cf>
	<@cf.form id="${formId!}" action="${ctx!}/userCenter/train_resource" method="get">
	<input type="hidden" name="queryType" value="${(param_queryType)!'all'}">
	<div class="g-EduResc-tab">
	    <ul class="m-subscribe-tab">
	    	<#assign getMyUpload=false/>
	    	<#if SecurityUtils.getSubject().hasRole('expert')>
	    		<#assign getMyUpload=true/>
	    	</#if>
	    	<@ucTrainResourceNumData getMyUpload=getMyUpload!>
		        <li class="<#if ((param_queryType)!"all") == 'all'>crt</#if>"><a href="${ctx!}/userCenter/train_resource?queryType=all" >全部(${(allNum)!0})</a></li>
		        <#if SecurityUtils.getSubject().hasRole('expert')>
		        	<li class="<#if (param_queryType)! == 'myUpload'>crt</#if>"><a href="${ctx!}/userCenter/train_resource?queryType=myUpload" >上传(${(myUploadNum)!0})</a></li>
		        </#if>
		        <li class="<#if (param_queryType)! == 'apply'>crt</#if>"><a href="${ctx!}/userCenter/train_resource?queryType=apply" >申请(${(applyNum)!0})</a></li>     
		        <li class="<#if (param_queryType)! == 'follow'>crt</#if>"><a href="${ctx!}/userCenter/train_resource?queryType=follow" >收藏(${(followNum)!0})</a></li>
	        </@ucTrainResourceNumData>
	    </ul>    
	    <#--   
	    <div class="chk-lst">
	        <div class="m-slt-block1 mid">
	            <a href="javascript:;" class="show-txt">
	                <span class="txt">按年限筛选</span>
	                <i class="trg"></i>
	            </a>
	            <dl class="lst">
	                <dd><a href="javascript:;" class="z-crt">按年限筛选</a></dd>
	                <dd><a href="javascript:;">按分类筛选</a></dd>
	                <dd><a href="javascript:;">按年限筛选</a></dd>
	                <dd><a href="javascript:;">按大小筛选</a></dd>
	                <dd><a href="javascript:;">按年限筛选</a></dd>
	            </dl>
	        </div>
	    </div>
	    -->
	</div>
	<div class="m-EduResc-cont">
		<div class="am-line-block">
			<#if (SecurityUtils.getSubject().hasRole('expert'))>
		    	<div class="l">
			        <a href="javascript:void(0);" class="au-uploadFile au-default-btn" onclick="goCreateTrainResource();">
			            <i class="au-uploadFile-ico" ></i>上传培训资源
			        </a>
			    </div>                            
			</#if>
			<#if (param_queryType)! == 'myUpload' >
				<div class="l">
			        <a href="javascript:void(0);" class="au-uploadFile au-default-btn" onclick="goUpdateTrainResource();">
			        	<i class="au-uploadFile-ico" ></i>修改培训资源
			        </a>
			    </div> 
			</#if>
		</div>
	    <table class="m-tb-resorce">
	        <thead>
	        	<#if (param_queryType)! == 'myUpload' >
	        	<th width="6%"><input type="checkbox" name="allcheck" onclick="checkAllBox('${formId!}',this);"></th>
	        	</#if>
	            <th width="30%">题名</th>
	            <th width="18%">创立者</th>
	            <th width="22%">来源</th>
	            <th width="12%">
	                <span class="txt">资源类型</span>
	            </th>
	            <th width="12%">状态</th>
	        </thead>
	        <tbody>
	        	<#list trainResources as tr>
		            <tr>
		            	<#if (param_queryType)! == 'myUpload' >
		            	<td><input type="checkbox" name="checkboxId" value="${(tr.resource.id)!}"></td>
		            	</#if>
		                <td class="book-name"><a href="${ctx}/train_resource/${(tr.resource.id)!}/view" target="_blank">${(tr.resource.title)!}</a></td>
		                <td>${(tr.resource.creator.realName)!"" }</td>
		                <td>${(tr.train.project.name)!}</td>
		                <td>
			                <span class=""><i></i>
			                	<#if (tr.resource.type)! == 'curriculum'>
			                		课程
			                	<#elseif (tr.resource.type)! == 'case'>
			                		案例
			                	<#elseif (tr.resource.type)! == 'material'>
			                		素材
			                	<#elseif (tr.resource.type)! == 'other'>
			                		其他
			                	</#if>			                
			                </span>
		                </td>
		                <td>
		                	<#if (followMap[tr.resource.id])??>
		                		<a onclick="deleteFollow('${(followMap[tr.resource.id].id)!}',this);" href="javascript:;" class="operate">取消收藏</a>
		                	<#else>
		                	</#if>
		                	<#if (followMap[tr.resource.id])??>
		                		<br/>
		                	</#if>
		                	<#if (resourceApplyRecordMap[tr.resource.id])??>
		                		<#if resourceApplyRecordMap[tr.resource.id].applyState == 'apply'>
		                			<a class="operate unpay" href="javascript:;">待审核</a>
		                		<#elseif resourceApplyRecordMap[tr.resource.id].applyState == 'passed'>	
		                			<a class="operate" href="javascript:;">审核通过</a>
		                		<#elseif resourceApplyRecordMap[tr.resource.id].applyState == 'nopass'>	
		                			<a class="operate" href="javascript:;">审核未通过</a>
		                		</#if>
		                	</#if>
		                </td>
		            </tr>
	            </#list>
	        </tbody>
	    </table>
	    <div class="m-btm-opa">
	    <#-- 
	        <div class="u-lt">
	            <label><input onclick="checkAllBox('${formId!}',this);" type="checkbox">全选</label>
	            <a onclick="deleteTrainResource();" href="javascript:;">批量删除</a>
	        </div>
	        -->
	        <div class="u-rt">
	            <div class="m-laypage" id="listTrainResourceFormPage"></div>
                <span class="num">找到<b>${(paginator.totalCount)!0}</b>条数据</span>
                <#import '/userCenter/common/tags/pagination.ftl' as p />
				<@p.paginationFtl formId="${(formId)!}" divId="listTrainResourceFormPage" paginator=paginator! />
	        </div>
	    </div>
	</div>
	</@cf.form>
	<script>
		function deleteTrainResource(){
			var ids = '';
			$("input[name='checkboxId']:checked").each(function(){
				ids = ids + $(this).val() + ',';		
			});
			
			if(ids != ''){
				confirm('是否确定删除?',function(){
					$.post('${ctx!}/userCenter/train_resource/batch' ,{
						'_method' : 'DELETE',
						'id' : ids
		 			},function(response){
		 				if(response.responseCode == '00'){
							window.location.reload();
							alert('删除成功!');
						}else{
							alert('删除失败!');
						};
		 			});
				});
			}
			
		};
		
		function deleteFollow(id,o){
			var _this = $(o);
			$.post("/follows/"+id,{
				"_method":"DELETE",
			},function(response){
				if(response.responseCode == '00'){
					alert('取消收藏成功！');
					_this.remove();
				}else{
					alert('取消收藏成功！');
				}
			})
		};
		
		function goCreateTrainResource (){
			mylayerFn.open({
		        type: 2,
		        title: '上传培训学习资源 ',
		        fix: false,
		        area: [900, 900],
		        offset : [$(document).scrollTop()],
				shadeClose : true,
		        content: '${ctx!}/userCenter/train_resource/create'
		    });
		};
		
		function goUpdateTrainResource (){
			var id = '';
			if(($("input[name='checkboxId']:checked").length > 1) || ($("input[name='checkboxId']:checked").length < 1)){
				alert("请只选择一行记录！");
				return false;
			};
			id = $("input[name='checkboxId']:checked").val();
			
			mylayerFn.open({
		        type: 2,
		        title: '修改培训学习资源 ',
		        fix: false,
		        area: [900, 900],
		        offset : [$(document).scrollTop()],
				shadeClose : true,
		        content: '${ctx!}/userCenter/train_resource/'+id+'/edit'
		    });
		};
	</script>
	</@ucTrainResourcesData>
</@lo.layout>