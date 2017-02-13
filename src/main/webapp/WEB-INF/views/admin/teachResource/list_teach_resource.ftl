<#import "/admin/common/include/layout.ftl" as lo>
<@lo.layout webuploader=true>
<#assign formId="usersForm"/>
<@resourcesDirective title=(param_title)! grade=(param_grade)! version=(param_version)! stage=(param_stage)! subject=(param_subject)! resourceExtendType=param_extendType!'' page=(param_page)!1 limit=(param_limit)!10 orders=param_orders!'CREATE_TIME.DESC' type="teach">
<div class="mis-index-wrap">
	<#import "/admin/common/include/form.ftl" as cf>
	<@cf.form id="${formId}" action="${ctx}/admin/teach_resource" method="get">
	<input type="hidden" name="menuTreeId" value="${menuTreeId!}">
	<div class="mis-mod">
		<div class="mis-mod-tt">
			<h2 class="tt t1"><span>教研资料管理</span></h2>
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
					<li class="item">
						<div class="mis-ipt-row">
							<div class="tl">
								<span>分类：</span>
							</div>
							<div class="tc">
								<div class="mis-select">
									<select name="extendType" id="">
										<option value="">请选择分类</option>
										${DictionaryUtils.getEntryOptionsSelected('TEACH_RESOURCE_TYPE',(param_extendType)!'')}
									</select>
								</div>
							</div>
						</div>
					</li>
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
						<a href="${ctx}/admin/teach_resource/create?menuTreeId=${menuTreeId!}" class="mis-btn mis-inverse-btn"><i class="mis-add-ico"></i>新建</a>
						<button type="button" class="mis-btn mis-inverse-btn disabled-btn  disabled" disabled="disabled" onclick="editForm();" >
							<i class="mis-alter-ico"></i>修改
						</button>
						<button type="button" onclick="deleteResource()" class="mis-btn mis-inverse-btn disabled-btn disabled" disabled="disabled">
							<i class="mis-detele-ico"></i>删除
						</button>
						<button type="button" onclick="importPreviewUrlResource()" class="mis-btn mis-inverse-btn">
							<i class="mis-detele-ico"></i>批量导入外部资源
						</button>
						<a href="${ctx}/admin/book_index/tree?menuTreeId=${menuTreeId!}" class="mis-btn mis-inverse-btn"><i class="mis-setting-ico"></i>索引管理</a>
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
								<th width="20%">标题</th>
								<th width="10%">作者</th>
								<th>出版社</th>
								<th>出版年</th>
								<th>学段</th>
								<th>学科</th>
								<th>年级</th>
								<th>类型</th>
								<!--<th width="10%">下载</th>-->
								<th>发布时间</th>
								<th>索引</th>
								<!--<th >来源</th>-->
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
								<td>${(resource.resourceExtend.author)!}</td>
								<td>${(resource.resourceExtend.source)!}</td>
								<td>
									<#if (resource.resourceExtend.issueDate)??>
										${resource.resourceExtend.issueDate?string('yyyy')}
									</#if>
								</td>
								<td>${TextBookUtils.getEntryName('STAGE',(resource.resourceExtend.stage)!'')}</td>
								<td>${TextBookUtils.getEntryName('SUBJECT',(resource.resourceExtend.subject)!'')}</td>
								<td>${TextBookUtils.getEntryName('GRADE',(resource.resourceExtend.grade)!'')}</td>
								<td>${DictionaryUtils.getEntryName('TEACH_RESOURCE_TYPE',(resource.resourceExtend.type)!'')!}</td>
								<!--<td>${(resource.resourceRelations[0].downloadNum)!}</td>-->
								<td>${TimeUtils.formatDate(resource.createTime,'yyyy-MM-dd')}</td>
								<td>${(resource.resourceExtend.bIndex)!}</td>
								<!--<td>来源</td>-->
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
			window.location.href = "${ctx}/admin/teach_resource/edit/"+value + "?menuTreeId=${menuTreeId!}";
		}
	}

	function deleteResource() {
		var value = getCheckedboxValues('${formId}', 'checkboxId');
		if (value != '') {
			confirm('确认要删除选中记录吗？', function(r) {
				$.ajaxDelete('${ctx}/admin/teach_resource/delete?id=' + value, "", function() {
					$("#${formId}").submit();
				});
			});
		}
	}

	function importPreviewUrlResource(){
		mylayerFn.open({
			id : "importPreviewUrlLayer",
			type : 2,
			title : '导入外部资源',
			content : '${ctx}/admin/teach_resource/go_import_preview_url',
			area : [700, 500],
			zIndex : 19999,
		});
	}

</script>
</@resourcesDirective>
</@lo.layout>