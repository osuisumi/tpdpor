<#import "/admin/common/include/layout.ftl" as lo>
<#assign jsArray = [] />
<#assign cssArray = []>
<@lo.layout jsArray=jsArray cssArray=cssArray validate=true>
<#import "/admin/common/include/form.ftl" as fl>
<#assign formId="createDepartmentForm"/>
	<div class="mis-mod">
		<div class="mis-srh-layout">
		<@fl.form id="${(formId)!}" action="${ctx!}/tpdpor/admin/department" method="post" saveValidate="function(){return $('#createDepartmentForm').validate().form()}" saveCallback="function(){location.href='${ctx!}/tpdpor/admin/department?menuTreeId=${menuTreeId}'}">
			<#if (department.id)??>
				<script>
					$(function(){
						$('#${(formId)!}').attr('method', 'put');
						$('#${(formId)!}').attr('action', '${ctx!}/tpdpor/admin/department/${(department.id)!}');
					});
				</script>
			</#if>
			<ul class="mis-ipt-lst">
				<li class="item ">
					<div class="mis-ipt-row">
		                <div class="tl">
		                    <span>机构名称：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-ipt-mod">
		                        <input type="text" id="deptName" name="deptName" value="${(department.deptName)!}" placeholder="请输入机构名称..." class="mis-ipt required">
		                    </div>
		                </div>
		            </div>
				</li>
				<!--
				<li class="item">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>机构代码：</span>
	                    </div>
	                    <div class="tc">
		                    <div class="mis-ipt-mod">
		                        <input type="text" id="deptCode" name="deptCode" value="${(department.deptCode)!}" placeholder="请输入机构代码..." class="mis-ipt required">
		                    </div>
		                </div>
	                </div>
	            </li>
	           
				<li class="item">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>机构类型：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-select">
		                        <select name="deptType" id="deptTypeSelect" >
									<option value="1" >行政机构</option>  
								    <option value="2" >学校机构</option>  
								    <option value="3" >个人用户</option> 
		                        </select> 
		                        <script>
		                        	$(function(){
		                        		$('#deptTypeSelect option').each(function(i){
		                        			var _this = $(this);
		                        			if(_this.attr('value') == '${(department.deptType)!}'){
		                        				_this.attr('selected',true);
		                        			}
		                        		});
		                        		
		                        	});
		                        </script>
		                    </div>
		                </div>
		            </div>
		        </li>
		        -->
		        <li class="item">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>省：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-select">
		                        <select name="province.regionsCode" id="province">
									<option class="static" value="">请选择省</option>
                                   	${RegionsUtils.getEntryOptionsSelected('1', (province.regionsCode)!'')}
		                        </select>
		                    </div>
		                </div>
		            </div>
		        </li>
		        <li class="item">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>市：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-select">
		                        <select name="city.regionsCode" id="city">
		                        	<option class="static" value="">请选择市</option>
		                        	<#if (department.province)??>
										<#list RegionsUtils.getEntryList('2', (department.province.regionsCode)!'') as entry>
	                                   		<option class="cityOption" value="${entry.regionsCode}">${entry.regionsName}</option>
	                                   	</#list> 
                                   	</#if>
		                        </select>
		                    </div>
		                </div>
		            </div>
		        </li>
		        <li class="item">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>区：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-select">
		                        <select name="county.regionsCode" id="county">
		                        	<option class="static" value="">请选择区</option>
		                        	<#if (department.city)??>
										<#list RegionsUtils.getEntryList('3', (department.city.regionsCode)!'') as entry>
	                                   		<option class="countyOption" value="${entry.regionsCode}">${entry.regionsName}</option>
	                                   	</#list> 
                                   	</#if>
		                        </select>
		                    </div>
		                </div>
		            </div>
		        </li>
			</ul>
		</@fl.form>
		</div>
	</div>

<script type="text/javascript">
	$(function(){
		
		$("#province").simulateSelectBox({
	    	byValue: '${(department.province.regionsCode)!""}'
	    });
	    $("#city").simulateSelectBox({
	    	byValue: '${(department.city.regionsCode)!""}'
	    });
	    $("#county").simulateSelectBox({
	    	byValue: '${(department.county.regionsCode)!""}'
	    });
	    
	  	//省市区联动
	    $('#province').on('change',function(){
	    	var _this = $(this);
	    	$.get('${ctx}/regions/entities',{
	    		"level":'2',
	    		"parentCode":_this.val(),
	    	},function(regions){
	    		$('#city .cityOption').remove();
	    		$('#city .static').attr('selected','selected');
	    		$('#city').trigger('change');
	    		$.each(regions,function(i,n){
	    			$('#city').append('<option class="cityOption" value="'+n.regionsCode+'" >'+n.regionsName+'</option>');
	    		});
	    	});
	    });
	    
	    $('#city').on('change',function(){
	    	var _this = $(this);
	    	$.get('${ctx}/regions/entities',{
	    		"level":'3',
	    		"parentCode":_this.val(),
	    	},function(regions){
	    		$('#county .countyOption').remove();
	    		$('#county .static').attr('selected','selected');
	    		$.each(regions,function(i,n){
	    			$('#county').append('<option class="countyOption" value="'+n.regionsCode+'" >'+n.regionsName+'</option>');
	    		});
	    	});
	    });
	
		$("#${(formId)!}").validate({
			rules : {
				deptName : {
					required : true,
					remote : {
						url :  '${ctx!}/tpdpor/admin/department/countForValidDeptNameIsExist?id=${(department.id)!""}', 
	                    type : "get", 
	                    dataType : "text",
						data :  {
							deptName : function() {  
								return $("#deptName").val() ;   
			                }
						},
						dataFilter : function (result,type) {
							return parseInt(result) > 0 ? false : true;
						} 
					}
				},
				deptCode : {
					required : true,
					remote : {
						url : '${ctx!}/tpdpor/admin/department/ValidDeptCodeIsExist?id=${(department.id)!""}', 
	                    type : "get", 
	                    dataType : "text",
						data : {
							deptCode : function() {   
			                    return $("#deptCode").val() ;   
			                }
						},
						dataFilter : function (result,type) {
							return parseInt(result) > 0 ? false : true;
						} 
					}
				}
			},
			messages : {
				deptName : {
					required : '必填',
					remote : '机构名称已存在'
				},
				deptCode : {
					required : '必填',
					remote : '组织机构代码已存在'
				}
			}
		});
	
	});

</script>
</@lo.layout>
