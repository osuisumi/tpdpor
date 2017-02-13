<li name="topic">
	<span class="u-type">主题：</span>
	<div class="chk-lst">
		<a href="javascript:;" class="<#if (param_topic!'') == ''>z-crt </#if>">全部</a>
		<#list DictionaryUtils.getEntryList('TRAIN_RESOURCE_TOPIC','${(param_post)!}') as dic>
			<a name="topic" href="javascript:;" class="item1 <#if ((param_topic!'') == dic.dictValue)> z-crt </#if>" value="${(dic.dictValue)!}">${(dic.dictName)!}</a>
		</#list>
	</div>
	<a href="javascript:;" class="u-more"><i class="u-ico-dp"></i>更多</a>
</li>
<#if (param_post)! == '01' >
<li name="stage">
	<span class="u-type">学段：</span>
	<div class="chk-lst">
		<a name="stage" class="z-crt">全部</a>
		<#list TextBookUtils.getEntryList('STAGE') as stage>
			<a name="stage" class="textBookBtn" value="${(stage.textBookValue)!}" href="javascript:;">${(stage.textBookName)!}</a>
		</#list>
	</div>
	<a href="javascript:;" class="u-more"><i class="u-ico-dp"></i>更多</a>
</li>
<li name="subject">
	<span class="u-type">学科：</span>
	<div class="chk-lst">
		<a name="subject" class="z-crt subject">全部</a>
		<#list TextBookUtils.getEntryList('SUBJECT') as subject>
			<a name="subject" class="textBookBtn" value="${(subject.textBookValue)!}" href="javascript:;">${(subject.textBookName)!}</a>
		</#list>
	</div>
	<a href="javascript:;" class="u-more"><i class="u-ico-dp"></i>更多</a>
</li>
</#if>

<script>
	$(function(){
		
		dropDown();
		
		$('#selectLst .chk-lst a').on('click',function(){
			var _this = $(this);
			var v = _this.attr('value');
			var attr = _this.closest('li').attr('name');
			$('#list_train_resource_form input[name="' + attr + '"]').val(v);
			
			if(attr == 'stage'){
				$('#list_train_resource_form input[name="subject"]').val(v);
				$.post('${ctx}/textBook/getEntryListByEntity',{
					textBookTypeCode:'SUBJECT',
					stage:v
				},function(entrys){
					$('#selectLst li[name="subject"]').find('.chk-lst a').remove();
					$('#selectLst li[name="subject"]').find('.chk-lst').append('<a class="z-crt subject" name="subject">全部</a>');
					$.each(entrys,function(i,entry){
						if(entry.textBookTypeCode == 'SUBJECT'){
							$('#selectLst li[name="subject"]').find('.chk-lst').append('<a name="subject" href="javascript:;" value="'+entry.textBookValue+'" class="textBookBtn" name="subject">'+entry.textBookName+'</a>');
						}
					});
					$('#selectLst li[name="subject"]').find('.chk-lst a').on('click',function(){
						var _this = $(this);
						var v = _this.attr('value');
						var attr = _this.closest('li').attr('name');
						$('#list_train_resource_form input[name="' + attr + '"]').val(v);
						_this.closest('li').find('a').removeClass('z-crt');
						_this.addClass('z-crt');
						
						$('#list_train_resource_form').find('input[name="page"]').val(1);
						$.ajaxQuery('list_train_resource_form','train_resource_div');
					});
				});
			}
			
			_this.closest('li').find('a').removeClass('z-crt');
			_this.addClass('z-crt');
			
			$('#list_train_resource_form').find('input[name="page"]').val(1);
			$.ajaxQuery('list_train_resource_form','train_resource_div');
		});
	});
</script>