<#macro sectionTree param onclick='function(){}' defaultNode=''>
<div class="g-sd-mod tree">
    <ul id="tree" class="ztree" style="width:100%; overflow:auto;"></ul>
</div>
<SCRIPT type="text/javascript" >
    var zTree;
    var demoIframe;

    var setting = {
        view: {
            dblClickExpand: false,
            showLine: false,
            selectedMulti: false,
            showIcon: false,
            nameIsHTML: true
        },
        data: {
            simpleData: {
                enable:true,
                idKey: "id",
                pIdKey: "pid",
                rootPId: ""
            }
        },
        callback: {
            /*beforeClick: function(treeId, treeNode) {
                var zTree = $.fn.zTree.getZTreeObj("tree");
                if (treeNode.isParent) {
                    zTree.expandNode(treeNode);
                    return false;
                } else {
                    demoIframe.attr("src",treeNode.file + ".html");
                    return true;
                }
            }*/
           onClick:function(event, treeId, treeNode){
				var $onclick = '${onclick}';
				if (! $.isFunction($onclick)){ 
					$onclick = eval('(' + $onclick + ')');
					$onclick(event,treeId,treeNode);
				}
           },
           onAsyncSuccess:function(event, treeId, treeNode, msg){
   		        var zTree = $.fn.zTree.getZTreeObj("tree");
   		        var defaultNodeId = "${(defaultNode)!}";
		        var node  = zTree.getNodeByParam("id", defaultNodeId);
		        if(node){
		        	zTree.selectNode(node);
		        }
           }
        }
    };

    var zNodes =[
    <#list TextBookUtils.getEntryList(sectionTextBookParam!) as section>
    	{id:'${section.textBookValue}', pid:'${section.parentValue}', name:'${section.textBookName}'},
    	<#if (section.childTextBookEntrys)??>
    		<#list section.childTextBookEntrys as chapter>
    			{id:'${chapter.textBookValue}', pid:'${chapter.parentValue}', name:'${chapter.textBookName}'},
    		</#list>
    	</#if>
    </#list>
    ];

    $(document).ready(function(){
        var t = $("#tree");
        t = $.fn.zTree.init(t, setting, zNodes);
        //$.fn.zTree.init($("#tree"), setting);
        demoIframe = $("#testIframe");
        demoIframe.bind("load", loadReady);
        var zTree = $.fn.zTree.getZTreeObj("tree");
        //var node  = zTree.getNodes();
        //console.log(node);
        var defaultNode = "${(defaultNode)!''}";
        if(defaultNode != ''){
        	zTree.selectNode(zTree.getNodeByParam("id", defaultNode));
        }
    });

    function loadReady() {
        var bodyH = demoIframe.contents().find("body").get(0).scrollHeight,
        htmlH = demoIframe.contents().find("html").get(0).scrollHeight,
        maxH = Math.max(bodyH, htmlH), minH = Math.min(bodyH, htmlH),
        h = demoIframe.height() >= maxH ? minH:maxH ;
        if (h < 530) h = 530;
        demoIframe.height(h);
    }
    
	function zTreeAjaxDataFilter(treeId, parentNode, responseData) {
		var treeNodes=new Array();
		if (responseData) {
			for(var i =0; i < responseData.length; i++) {
				node = responseData[i];
				var parentId = "";
				if(node.parent!=undefined&&node.parent!=null){
					parentId=node.parent.id;
				}
				if(parentId!=""){
					treeNodes[i]={id:node.id,name:node.bIndex + '　' + node.name,pid:parentId,bIndex:node.bIndex};
				}else{
					treeNodes[i]={id:node.id,name:'<b>'+node.bIndex+'</b>　'+node.name,pid:parentId,bIndex:node.bIndex};
				}
			}
		}
		return treeNodes;
	};

  </SCRIPT>
  </#macro>