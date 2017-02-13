<#import "/admin/common/include/layout.ftl" as lo>
<@lo.layout>
<#assign formId="usersForm"/>
<@resourcesDirective title=(param_title)! grade=(param_grade)! version=(param_version)! stage=(param_stage)! subject=(param_subject)! resourceExtendType=param_extendType!'' page=(param_page)!1 limit=(param_limit)!10 orders=param_orders!'CREATE_TIME.DESC' type="course">
<div class="mis-index-wrap">
	<#import "/admin/common/include/form.ftl" as cf>
	<@cf.form id="${formId}" action="${ctx}/admin/course_resource" method="get">
	<input type="hidden" name="menuTreeId" value="${menuTreeId!}">
	<div class="mis-mod">
		<div class="mis-mod-tt">
			<h2 class="tt t1"><span>课程案例管理</span></h2>
		</div>
		<div class="mis-content">
			<div class="mis-srh-layout">
				<ul class="mis-ipt-lst">
					<li class="item">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>学段：</span>
							</div>
							<div class="tc">
								<div class="mis-select">
									<select name="stage" id="">
										<option value="">请选择学段</option>
										${TextBookUtils.getEntryOptionsSelected('STAGE',(param_stage)!'')}
									</select>
								</div>
							</div>
						</div>
					</li>
					<li class="item">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>学科：</span>
							</div>
							<div class="tc">
								<div class="mis-select">
									<select name="subject" id="">
										<option value="">请选择学科</option>
										${TextBookUtils.getEntryOptionsSelected('SUBJECT',(param_subject)!'')}
									</select>
								</div>
							</div>
						</div>
					</li>
					<li class="item">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>年级：</span>
							</div>
							<div class="tc">
								<div class="mis-select">
									<select name="grade" id="">
										<option value="">请选择年级</option>
										${TextBookUtils.getEntryOptionsSelected('GRADE',(param_grade)!'')}
									</select>
								</div>
							</div>
						</div>
					</li>
					<!--
					<li class="item">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>教材：</span>
							</div>
							<div class="tc">
								<div class="mis-select">
									<select name="version" id="">
										<option value="">请选择教材</option>
										${TextBookUtils.getEntryOptionsSelected('VERSION',(param_version)!'')}
									</select>
								</div>
							</div>
						</div>
					</li>
					-->
					<li class="item">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>分类：</span>
							</div>
							<div class="tc">
								<div class="mis-select">
									<select name="extendType" id="">
										<option value="">请选择分类</option>
										<option value="package" <#if ((param_extendType)!'') == 'package'>selected="selected"</#if> >资源包</option>
										${DictionaryUtils.getEntryOptionsSelected('COURSE_RESOURCE_TYPE',(param_extendType)!'')}
									</select>
								</div>
							</div>
						</div>
					</li>
					<!--
					<li class="item">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>审核情况：</span>
							</div>
							<div class="tc">
								<div class="mis-select">
									<select name="state" id="">
										<option value="">请选择审核情况</option>
									</select>
								</div>
							</div>
						</div>
					</li>
					-->
					<li class="item">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>标题：</span>
							</div>
							<div class="tc">
								<div class="mis-ipt-mod">
									<input type="text" name="title" value="${param_title!""}" placeholder="请输入标题" class="mis-ipt">
								</div>
							</div>
						</div>
					</li>
				</ul>
				<div class="mis-btn-row indent1">
					<button type="submit" class="mis-btn mis-main-btn">
						<i class="mis-srh-ico"></i>查询
					</button>
					<button type="reset" class="mis-btn mis-default-btn">
						<i class="mis-refresh-ico"></i>重置
					</button>
				</div>
			</div>
			<div class="mis-table-layout">
				<div class="mis-opt-row">
					<div class="mis-opt-mod fl">
						<a href="${ctx}/admin/course_resource/create?menuTreeId=${(menuTreeId)!}"  class="mis-btn mis-inverse-btn"><i class="mis-add-ico"></i>上传资源</a>
						<a href="${ctx}/admin/course_resource/create_muti?menuTreeId=${menuTreeId!}"  class="mis-btn mis-inverse-btn"><i class="mis-add-ico"></i>上传资源包</a>
						<button type="button" class="mis-btn mis-inverse-btn disabled-btn  disabled" disabled="disabled" onclick="editForm();" >
							<i class="mis-alter-ico"></i>修改
						</button>
						<button type="button" onclick="deleteCourseResource()" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
							<i class="mis-detele-ico"></i>删除
						</button>
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
								<th>标题</th>
								<th>学段</th>
								<th>学科</th>
								<th>年级</th>
								<th>教材</th>
								<th>分类</th>
								<th>定价</th>
								<th>上传者</th>
								<th>发布时间</th>
								<!--<th width="10%">置顶</th>-->
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="99"> <#import "/admin/common/include/pagination.ftl" as page/>
								<@page.adminPage formId="${formId}" divId="" paginator=paginator/> </td>
							</tr>
						</tfoot>
						<tbody>
							<#if resources??>
							<#list resources as resource>
							<tr>
								<td>
								<input class="checkRow" type="checkbox" name="checkboxId" value="${(resource.id)!}">
								</td>
								<td>${(resource.title)!}</td>
								<td>${TextBookUtils.getEntryName('STAGE',(resource.resourceExtend.stage)!'')}</td>
								<td>${TextBookUtils.getEntryName('SUBJECT',(resource.resourceExtend.subject)!'')}</td>
								<td>${TextBookUtils.getEntryName('GRADE',(resource.resourceExtend.grade)!'')}</td>
								<td>${TextBookUtils.getEntryName('VERSION',(resource.resourceExtend.tbVersion)!'')}</td>
								<td>
									<#if (resource.resourceExtend.type)??>
										<#if resource.resourceExtend.type == 'package'>
											资源包
										<#else>
											${DictionaryUtils.getEntryName('COURSE_RESOURCE_TYPE',resource.resourceExtend.type)}
										</#if>
									</#if>
								</td>
								<td>${(resource.resourceExtend.price)!0}</td>
								<td>${(resource.creator.realName)!}</td>
								<td>${TimeUtils.formatDate(resource.createTime,'yyyy-MM-dd')}</td>
								<!--<td>置顶</td>-->
							</tr>
							</#list>
							</#if>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div><!--end module layout -->
	</@cf.form>
</div><!--end inner page -->
<script type="text/javascript">
	$(document).ready(function() {
		$('input[type=checkbox]').click(function() {
			if ($("input[name='checkboxId']:checked").length > 0) {
				$(".mis-btn.disabled-btn").removeAttr("disabled");
				$(".mis-btn.disabled-btn").removeClass("disabled");
			} else {
				$(".mis-btn.disabled-btn").attr("disabled", "disabled");
				$(".mis-btn.disabled-btn").addClass("disabled");
			}
		});
	});
	
	

	function editForm() {
		var value = getCheckedboxValues('${formId}', 'checkboxId', 1);
		if (value != '') {
			window.location.href = '${ctx}/admin/course_resource/edit/'+value + '?menuTreeId=${menuTreeId!}';
		}
	}

	function deleteCourseResource() {
		var value = getCheckedboxValues('${formId}', 'checkboxId');
		if (value != '') {
			confirm('确认要删除选中记录吗？', function(r) {
				$.ajaxDelete('${ctx}/admin/course_resource/delete?id=' + value, "", function() {
					$("#${formId}").submit();
				});
			});
		}
	}

</script>
</@resourcesDirective>
</@lo.layout>