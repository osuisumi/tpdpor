<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<meta http-equiv="Window-target" content="_top">
<link rel="Shortcut Icon" href="/images/tpdpor/${app_path}/favicon.ico">
<title>教师专业发展在线资源平台</title>
<link rel="stylesheet" href="${ctx}/css/tpdpor/${app_path}/neat.css">
<link rel="stylesheet" href="${ctx}/css/tpdpor/${app_path}/style.css">

<script type="text/javascript" src="${ctx}/js/common/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/common/echarts/echarts.common.min.js"></script>
<script type="text/javascript" src="${ctx}/js/tpdpor/sip-common.js"></script>
<script type="text/javascript" src="${ctx}/js/tpdpor/common.js"></script>
<link rel="stylesheet" href="${ctx }/js/common/mylayer/v1.0/skin/default/mylayer.css">
<script type="text/javascript" src="${ctx}/js/common/mylayer/v1.0/mylayer.js"></script>
</head>
<@tpoporStatisticsDirective page=(pageBounds.page)!1 limit=(pageBounds.limit)!8 orders=(param_orders)!'RESOURCE_NUM.DESC'>
<body>
<div id="wrap">
    <div class="g-hd" id="indexHeader">
        <div class="g-auto">
            <div class="m-logo">
                <h1><a href="${ctx}/tpdpor/index"><img src="${ctx}/images/tpdpor/${app_path}/logo.png" alt="教师专业发展在线资源平台"><span>教师专业发展在线资源平台</span></a></h1>
            </div>
            <div class="m-hd-opt">
            	<#if (Session.loginer.id)??>
                	<ul class="m-us-opt">
	                    <li class="u-uOpt">
	                        <a href="${ctx}/userCenter" class="u">
	                        	<#import "/tpdpor/common/tags/image.ftl" as image/>
								<@image.imageFtl url="${(Session.loginer.avatar)! }" default="/images/tpdpor/${app_path}/defaultAvatar.jpg" />
	                        	<span>${(Session.loginer.realName)!}</span><i class="u-trg1-ico"></i>
	                        </a>
	                        <div class="lst">
	                            <i class="trg"><i></i></i>
	                            <a href="${ctx}/userCenter/user_info/edit_my_user_info"><i class="u-user2-ico"></i>用户资料</a>
	                            <#if (Session.hasMenu)?? && Session.hasMenu>
									<a href="${ctx}/admin"><i class="u-user2-ico"></i>管理后台</a>	                            
	                            </#if>
	                            <a href="${ctx}/logout"><i class="u-exit2-ico"></i>退出登录</a>
	                        </div>
	                    </li>
	                </ul>
            	<#else>
            		<a href="javascript:;" class="u-login" onclick="login()" title="登录"><i class="u-login-ico"></i></a>
            	</#if>
            	<#--
                <span class="line"></span>
                <a href="javascript:;">帮助中心</a>
                <span class="line"></span>
                <a href="javascript:;">APP下载</a>
               -->
              	<#--   <span class="line"></span>
                <a href="activity-subject/index.html">最新活动</a>
                <div class="m-newA-layer" id="newActivityLayer">
                    <i class="trg"></i>
                    <h3 class="tt">广东省中小学优秀微课程（视频）作品展示活动</h3>
                    <p>活动时间：2016年06月19日 至2016年09月20日</p>
                    <p>活动要求：上传的课程案例包须包括教学视频、 教学设计、 教学课件、 教学素材、论文  ...等。</p>
                    <div class="btn-row"><button type="button" class="close">我知道了</button></div>
                </div>
                -->
            </div>
        </div>
    </div>
    <div class="g-index-bn">
        <div class="g-auto">
            <div class="m-search">
                <i class="u-srh-ico"></i>
                <input id="searchKeywords" type="text" placeholder="输入资源名称" class="ipt" value="">
                <input id="searchType" type="hidden">
                <div class="slt">
                    <strong><span>全库搜索</span><i class="ico"></i></strong>
                    <div class="lst">
                        <a value="" href="javascript:;" class="z-crt">全库搜索</a>
                        <a value="teach" href="javascript:;">教研资料</a>
                        <a value="course" href="javascript:;">课程案例</a>
                        <a value="train_resource" href="javascript:;">培训学习</a>
                        <a value="creative" href="javascript:;">教师创客</a>
                    </div>
                </div>
                <a href="javascript:;" onclick="doSearch()" class="submit">搜索</a>
            </div>
            <div class="m-index-nav">
                <a href="${ctx}/teach_resource/index" class="item">
                    <i class="ico ico1"></i>
                    <strong class="num">${(resourceTypeMap['teach'].num)!0}</strong>
                    <span class="txt">教研资料</span>
                </a>
                <span class="line"></span>
                <a href="${ctx}/course_resource/index" class="item">
                    <i class="ico ico2"></i>
                    <strong class="num">${(resourceTypeMap['course'].num)!0}</strong>
                    <span class="txt">课程案例</span>
                </a>
                <span class="line"></span>
                <a href="${ctx}/train_resource/index" class="item">
                    <i class="ico ico3"></i>
                    <strong class="num">${(resourceTypeMap['train_resource'].num)!0}</strong>
                    <span class="txt">培训学习</span>
                </a>
                <span class="line"></span>
                <a href="${ctx}/creative/index" class="item">
                    <i class="ico ico4"></i>
                    <strong class="num">${(resourceTypeMap['creative'].num)!0}</strong>
                    <span class="txt">教师创客</span>
                </a>
            </div>
        </div>
    </div>
    <div class="g-bd">
        <div id="indexPage">
            <div class="g-auto">
                <div class="g-layout">
                    <div class="g-tt nb">
                        <h2 class="tt tt1">资源统计<span class="sm">Resource statistics</span></h2>
                    </div>
                    <div class="g-layout-dt">
                        <div class="g-chart-wp">
                            <div class="g-chart-cont">
                                <div id="chartImg"></div>
                            </div>
                            <div class="g-chart-data">
                                <h3 class="tit">地区资源应用排行榜</h3>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="m-chart-table">
                                    <thead>
                                        <tr>
                                            <th width="25%">地区</th>
                                            <th width="25%">上传总量</th>
                                            <th width="25%">下载总量</th>
                                            <th width="25%">用户总数</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<#if (resourceStatistics)?size gt 0>
                                    		<#list resourceStatistics as rs>
		                                        <tr>
		                                            <td>${(rs.region.regionsName)!}</td>
		                                            <td>${(rs.resourceNum)!0}</td>
		                                            <td>${(rs.downloadNum)!0}</td>
		                                            <td>${(rs.userNum)!0}</td>
		                                        </tr>
	                                        </#list>
                                        </#if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="g-iFrame">
                    <div class="g-layout mr">
                        <div class="g-tt">
                            <h2 class="tt tt2">友情链接<span class="sm">Friendly Link</span></h2>
                        </div>
                        <div class="g-layout-dt">
                            <ul class="m-blogroll">
                                <li><a href="http://www.moe.gov.cn/" target="_blank" title="中国教育部"><img src="/images/tpdpor/${app_path}/blogroll-img1.jpg" alt="中国教育部"></a></li>
                                <li><a href="http://www.ncet.edu.cn/" target="_blank" title="中央电化教育馆"><img src="/images/tpdpor/${app_path}//blogroll-img2.jpg" alt="中央电化教育馆"></a></li>
                                <li><a href="http://www.ict.edu.cn/" target="_blank" title="中国教育信息化网"><img src="/images/tpdpor/${app_path}//blogroll-img3.jpg" alt="中国教育信息化网"></a></li>
                                <li><a href="http://jyjs.e21.edu.cn/e21web/" target="_blank" title="中国教育技术研究网"><img src="/images/tpdpor/${app_path}//blogroll-img4.jpg" alt="中国教育技术研究网"></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="g-layout">
                        <div class="g-tt">
                            <h2 class="tt tt3">快速通道<span class="sm">green channel</span></h2>
                        </div>
                        <div class="g-layout-dt">
                            <ul class="m-txts-lst">
                                <li><a href="http://www.gdei.edu.cn" target="_blank">广东第二师范学院</a></li>
                                <li><a href="http://www.gdjsgl.com.cn" target="_blank">广东省中小学教师继续教育网</a></li>
                                <li><a href="http://lib.gdei.edu.cn/" target="_blank">广东第二师范学院图书馆</a></li>
                                <li><a href="http://info.gdjsgl.com.cn/" target="_blank">广东省中小学教师信息技术应用能力提升工程</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
 	<#include "/tpdpor/common/include/footer.ftl"/>
</div>

<#import '/tpdpor/common/tags/function.ftl' as f>
<@f.function/>

<script type="text/javascript">
$(function(){
    /*
    显示最近活动弹出框,
    如果传入毫秒数，则自动关闭
    不传入参数，则只能手动关闭
    */
    newActivityPopup();
    //搜索框下拉框
    searchSelect();

    //echarts（资源统计）
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('chartImg'));

    // 指定图表的配置项和数据
    var option = {
        tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b}: {c} ({d}%)'
        },
        series: [
            {
                name:'资源类型',
                type:'pie',
                radius: ['35%', '70%'],
                avoidLabelOverlap: false,
                color: ['#3164e6','#ffbf24','#3ba732','#e7582c'],
                label: {
                    normal: {
                        show: true,
                        position: 'outside'
                    },
                    emphasis: {
                        show: true,
                        textStyle: {
                            fontSize: '20',
                            fontWeight: 'bold'
                        }
                    }
                },
                labelLine: {
                    normal: {
                        show: true
                    }
                },
                data:[
                    {value:${(resourceTypeMap['course'].num)!0}, name:'课程案例'},
                    {value:${(resourceTypeMap['teach'].num)!0}, name:'教学研究'},
                    {value:${(resourceTypeMap['train_resource'].num)!0}, name:'培训资源'},
                    {value:${(resourceTypeMap['creative'].num)!0}, name:'教师创客'}
                ]
            }
        ]
    };
    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);

});

//显示最近活动弹出框
function newActivityPopup(closeTime){
    //获取layer框
    var $layers = $("#newActivityLayer");
    var autoOff = true;
    //弹出
    $layers.addClass('show');
    //判断是否传入自动关闭时间
    if(closeTime === '' || closeTime === 'undefined' || closeTime === undefined || closeTime === null) {
        //不传入参数，则不设置定时关闭
        autoOff = false;
    }
    //判断是否需要自动关闭
    if(autoOff){
        //定时关闭
        var times = setTimeout(function(){
            $layers.removeClass('show');
        },closeTime);
    }
    //点击关闭
    $layers.on("click",".close",function(){
        $layers.removeClass('show');
        //清除定时器
        if(autoOff){
            clearTimeout(times);
        }
    });
};

//搜索框下拉框
function searchSelect(){
    var $searchSelect = $(".m-search .slt");

    $searchSelect.stop().on({
        mouseenter : function(){
            $(this).children('.lst').slideDown(200);
        },
        mouseleave : function(){
            $(this).children('.lst').hide();
        }
    });
    $searchSelect.on('click','.lst a',function(){
        var $this = $(this);
        $('#searchType').val($this.attr('value'));
        $this.addClass('z-crt').siblings().removeClass('z-crt');
        $this.parent().hide().prevAll('strong').children('span').text($this.text());
    });
};
</script>
</body>
</@tpoporStatisticsDirective>
</html>
