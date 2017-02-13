<#import "/admin/common/include/form_layer.ftl" as fl>
<@fl.form id="createBookIndexForm"  onConfirm="saveBookIndex()" action="${ctx}/admin/book_index" method="post">

<#if (bookIndex.id)??>
	<input type="hidden" name="id" value="${(bookIndex.id)!}">
	<script>
		$(function(){
			$('#createBookIndexForm').attr('method','put');			
		});
	</script>
</#if>
<ul class="mis-ipt-lst">
	<li class="item">
		<div class="mis-ipt-row">
			<div class="tl">
				<span>索引名称：</span>
			</div>
			<div class="tc">
				<div class="mis-ipt-mod">
					<input type="text" name="name" value="${(bookIndex.name)!}" class="mis-ipt">
				</div>
			</div>
		</div>
	</li>
	<li class="item">
		<div class="mis-ipt-row">
			<div class="tl">
				<span>索引号：</span>
			</div>
			<div class="tc">
				<div class="mis-ipt-mod">
					<input type="text" required name="bIndex" value="${(bookIndex.bIndex)!}" class="mis-ipt">
				</div>
			</div>
		</div>
	</li>
	
	<li class="item">
		<div class="mis-ipt-row">
			<div class="tl">
				<span>上级索引：</span>
			</div>
			<div class="tc">
				<div class="mis-treeSelect">
					<div class="mis-ipt-mod">
						<#if (bookIndex.parent.id)??>
							<@bookIndexDirective id=bookIndex.parent.id resultName='parent'>
								<#assign parent=parent />
							</@bookIndexDirective>
						</#if>
						<input type="text" id="bookIndexParent" readonly  class="mis-ipt"  value="${(parent.bIndex)!}"  onclick="showMenu();"/>
						<a id="selectMenuBtn" href="javascript:;" class="selectBtn" onclick="showMenu(); return false;">请选择</a>
						<a  href="javascript:;" class="" onclick="setParentNull()">清除</a>
					</div>
					<div id="bookIndexZtreeContent" class="menuZtreeContent">
						<ul id="parentBookIndexTree" class="ztree selectTree"></ul>
					</div>
				</div>
			</div>
		</div>
	</li>
	<li class="item">
		<div class="mis-ipt-row">
			<div class="tl">
				<span>顺序号：</span>
			</div>
			<div class="tc">
				<div class="mis-ipt-mod">
					<input type="text" name="sortNo" value="${(bookIndex.sortNo)!}" class="mis-ipt">
				</div>
			</div>
		</div>
	</li>
</ul>
</@fl.form>

<#import "/admin/bookindex/select_book_index.ftl" as sbi>
<@sbi.selectBookIndex bookIndexTreeId="parentBookIndexTree" onClick="selectParentMenu" bookIndexInputId="bookIndexParent" bookIndexInputName="parent" bookIndexContentId="bookIndexZtreeContent" selectedId=pid!''>
<script>
	function selectParentMenu(e, treeId, treeNode) {
		$("input[name^='parent']").remove();
		$("#bookIndexParent").append("<input type='hidden' name='parent.id' value='" + treeNode.id + "' />");
		$("#bookIndexParent").val(treeNode.name);
		hideMenu();
	}
</script>
</@sbi.selectBookIndex>

<script>
	function setParentNull(){
		$("input[name^='parent']").remove();
		$("#bookIndexParent").append("<input type='hidden' name='parent.id' value='' />");
		$("#bookIndexParent").val('');
	}
	
	function saveBookIndex(){
		if(!$('#createBookIndexForm').validate().form()){
			return false;
		}
		
		var data = $.ajaxSubmit("createBookIndexForm");
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			 mylayerFn.msg('操作成功！',{icon: 0, time: 2000},function(){
			 	reloadWindow();
		   	 });
		}else{
			if(json.responseMsg == 'error index'){
				alert('索引号必须以上级索引开头');
			}
		}
	}
</script>
