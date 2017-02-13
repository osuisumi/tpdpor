<#import "/tpdpor/common/include/layout.ftl" as layout />
<#assign cssArray=['${ctx}/css/tpdpor/es/zTreeStyle/zTreeStyle.css']/>
<#assign jsArray=['/js/tpdpor/library/laypage/laypage.js','/js/tpdpor/textbook.js','${ctx}/js/common/ztree/js/jquery.ztree.core.min.js']/>
<@layout.layout jsArray=jsArray cssArray=cssArray>
<div class="g-frame">
	<div class="g-frame-mn">
		<div class="g-mn-tit">
			<h2 class="m-tit"><i class="u-ico-book"></i>课程案例</h2>
			<a href="javascript:;" class="m-slide hide" id="slideBtn">收起筛选<i class="u-ico-dp"></i></a>
		</div>
		<div class="g-mn-mod">
			<ul class="m-select-lst case" id="selectLst">
				<li>
					<span class="u-type">学段：</span>
					<div id="stageDiv" class="chk-lst">
						<#assign pstage = param_stage!''>
						<a name="stage" value="" href="javascript:;" class="<#if pstage=''>z-crt </#if>textBookBtn">全部</a>
						<#list TextBookUtils.getEntryList('STAGE') as stage>
							<a name="stage" class="<#if pstage=stage.textBookValue>z-crt </#if> textBookBtn" value="${(stage.textBookValue)!}" href="javascript:;">${(stage.textBookName)!}</a>
						</#list>
					</div>
					<a href="javascript:;" class="u-more"><i class="u-ico-dp"></i>更多</a>
				</li>
				<li>
					<span class="u-type">学科：</span>
					<div id="subjectDiv" class="chk-lst">
						<#assign psubject = param_subject!''>
						<a name="subject" value="" href="javascript:;" class="<#if psubject=''>z-crt </#if> textBookBtn">全部</a>
						<#list TextBookUtils.getEntryList(subjectTextBookParam!) as subject>
							<a name="subject" value="${(subject.textBookValue)!}" class="<#if psubject=subject.textBookValue>z-crt </#if>  textBookBtn" href="javascript:;">${(subject.textBookName)!}</a>
						</#list>
					</div>
					<a href="javascript:;" class="u-more"><i class="u-ico-dp"></i>更多</a>
				</li>
				<li>
					<span class="u-type">年级：</span>
					<div id="gradeDiv" class="chk-lst">
						<#assign pgrade = param_grade!''>
						<a name="grade" href="javascript:;" class="<#if pgrade=''>z-crt </#if> textBookBtn">全部</a>
						<#list TextBookUtils.getEntryList(gradeTextBookParam!) as grade>
							<a name="grade" value="${(grade.textBookValue)!}" class="<#if pgrade=grade.textBookValue>z-crt </#if>  textBookBtn" href="javascript:;">${(grade.textBookName)!}</a>
						</#list>
					</div>
					<a href="javascript:;" class="u-more"><i class="u-ico-dp"></i>更多</a>
				</li>
				<li>
					<span class="u-type">分类：</span>
					<div id="course_resource_type" class="chk-lst">
						<#assign extendType = param_resourceExtendType!''>
						<a href="javascript:;" class="<#if param_resourceExtendType=''>z-crt </#if>">全部</a>
							<a name="type" class="<#if extendType = 'package'>z-crt </#if>" value="package" href="javascript:;">资源包</a>
						<#list DictionaryUtils.getEntryList('COURSE_RESOURCE_TYPE') as ttype>
							<a name="type" class="<#if extendType = ttype.dictValue>z-crt </#if>" value="${(ttype.dictValue)!}" href="javascript:;">${(ttype.dictName)!}</a>
						</#list>
					</div>
					<a href="javascript:;" class="u-more"><i class="u-ico-dp"></i>更多</a>
				</li>
				<li class="last">
					<span class="u-type">教材版本：</span>
					<div id="versionDiv" class="chk-lst">
						<#assign pversion = param_version!''>
						<a name="version" href="javascript:;" class="<#if pversion=''>z-crt </#if> textBookBtn">全部</a>
						<#list TextBookUtils.getEntryList(versionTextBookParam!) as version>
							<a name="version" class="<#if pversion=version.textBookValue>z-crt </#if>  textBookBtn"  value="${(version.textBookValue)!}" href="javascript:;">${(version.textBookName)!}</a>
						</#list>
					</div>
					<a href="javascript:;" class="u-more"><i class="u-ico-dp"></i>更多</a>
				</li>
			</ul>
			<!-- begin g-resorce-lst -->
			<div class="g-resorce-lst">
				<div class="m-resorce-box">
					<#assign orders = param_orders!'CREATE_TIME.DESC' />
					<div class="m-type-tab">
						<a href="javascript:;" onclick="sort('CREATE_TIME.DESC')" <#if orders == 'CREATE_TIME.DESC'>class="z-crt"</#if> >上传时间</a>
						<a href="javascript:;" onclick="sort('DOWNLOAD_NUM.DESC')" <#if orders == 'DOWNLOAD_NUM.DESC'>class="z-crt"</#if> >下载量</a>
						<a href="javascript:;" onclick="sort('BROWSE_NUM.DESC')" <#if orders == 'BROWSE_NUM.DESC'>class="z-crt"</#if> >浏览量</a>
						<a href="javascript:;" onclick="sort('EVALUATE_RESULT.DESC')"  <#if orders == 'EVALUATE_RESULT.DESC'>class="z-crt"</#if> >评分</a>
					</div>
					<div class="m-con-tab" id="course_resource_div">
						<script>
							$(function(){
								$('#course_resource_div').load('${ctx}/course_resource?stage=${param_stage!}&subject=${param_subject!}&grade=${param_grade!}&version=${param_version!}&chapter=${param_chapter!}&section=${param_section!}&resourceExtendType=${param_resourceExtendType!}&orders=${param_orders!"CREATE_TIME.DESC"}');
							});
						</script>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="g-frame-sd spc">
		<div class="g-upload-btn">
			<a href="javascript:;" onclick="createCourseResource();" class="u-btn-upload"><b><i class="u-ico-upload"></i>上传我的课程</b>已有${(creatorNum)!0}名教师，贡献 ${(resourceNum)!0} 个课程</a>
		</div>
		<div class="g-sd-tit">
			<h3 class="m-tit"><i class="u-ico-search"></i>教材目录</h3>
		</div>
		<#import "/tpdpor/courseResource/section_tree.ftl" as s />
		<@s.sectionTree param=sectionTextBookParam! onclick="function(event,treeId,node){sectionTreeNodeClick(event,treeId,node)}" defaultNode=param_section!'' />
	</div>
</div>
</@layout.layout>

<script>
	$(function(){
		dropDown();
   		
		textBookUtils.execute({
			entrys:'stage,subject,grade,version',
			warp:$('#selectLst'),
			reload:function(params){
				$.each(params,function(i,param){
					var formParam = $('#list_course_resource_form input[name='+param.name+']');
					if(formParam.size()>0){
						formParam.val(param.value);
					}
				});
				$('#list_course_resource_form input[name="page"]').val(1);
				window.location.href = "${ctx}/course_resource/index?" + $('#list_course_resource_form').serialize();
			}
		});
		
		//点击节查询数据
		$('#resTree').on('click','a.chapter',function(){
			$('#list_course_resource_form input[name="section"]').val($(this).attr('value'));
			window.location.href = "${ctx}/course_resource/index?" + $('#list_course_resource_form').serialize();
		});
		
		$('#course_resource_type').on('click','a',function(){
			$('#course_resource_type a').removeClass('z-crt');
			$(this).addClass('z-crt');
			$('#list_course_resource_form input[name="resourceExtendType"]').val($(this).attr('value'));
			window.location.href = "${ctx}/course_resource/index?" + $('#list_course_resource_form').serialize();
		});
		
	});
	
	//资源列表伸缩

		function dropDown() {
			var lst_ul = $("#selectLst"), lst_li = lst_ul.find("li"), lst_li_h = lst_li.height(), btn_more = lst_li.find(".u-more"), btn_slide = $("#slideBtn");

			//判断资源列表高度，如果超过一行，则显示 更多按钮
			lst_li.each(function() {
				var _ts = $(this), lst_chk = _ts.find(".chk-lst"), btn_more = _ts.find(".u-more");
				if (lst_chk.height() > _ts.height()) {
					btn_more.show();
				}
			});

			//点击更多，显示全部资源列表
			btn_more.on("click", function() {
				var par = $(this).parents("li");
				$(this).toggleClass("on");
				if (par.height() == lst_li_h) {
					par.height("auto");
				} else {
					par.height(lst_li_h);
				}
			});

			//点击收起筛选按钮，资源列表收起
			btn_slide.on("click", function() {
				var _ts = $(this);
				//lst_li.height(lst_li_h);
				if (_ts.hasClass("hide")) {
					_ts.html("展开筛选<i class='u-ico-dp'></i>").removeClass("hide");
					lst_ul.stop().slideUp();
				} else {
					_ts.html("收起筛选<i class='u-ico-dp'></i>").addClass("hide");
					lst_ul.stop().slideDown();
				}
			});

		}
		
		//目录检索资源树
		function sectionTreeNodeClick(event,treeId,node){
			$('#list_course_resource_form input[name="section"]').val(node.id);
			window.location.href = "${ctx}/course_resource/index?" + $('#list_course_resource_form').serialize();
		}
		
		function sort(orders){
			$('#list_course_resource_form input[name="orders"]').val(orders);
			window.location.href = "${ctx}/course_resource/index?" + $('#list_course_resource_form').serialize();
		}
		
		function createCourseResource(){
			var loginId = '${(Session.loginer.id)!""}';
			if(loginId == ''){
				alert('您尚未登录,不能进行该操作!');
				return false;
			}
			window.location.href = '${ctx}/course_resource/create';
		}
</script>