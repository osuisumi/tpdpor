<#macro bIndexTree onclick='function(){}' defaultNode=''>
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
    	async: {
			enable: true,
			url: '${ctx}/book_index/entities',
			type: 'get',
			dataFilter: zTreeAjaxDataFilter,
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
        {id:1, pId:0, name:"<b>G40</b>　教育学", open:true},
        {id:101, pId:1, name:"G40-1　教育学1"},
        {id:102, pId:1, name:"G40-2　教育学2"},
        {id:103, pId:1, name:"G40-3　教育学3"},
        {id:104, pId:1, name:"G40-4　教育学4"},

        {id:2, pId:0, name:"<b>G41</b>　思想政治教育、德育", open:false},
        {id:22, pId:2, name:"G42-1　教育学1"},
        {id:222, pId:22, name:"G42-1　教育学1"},
        {id:222, pId:22, name:"G42-1　教育学1"},
        {id:201, pId:2, name:"G41-1　思想政治教育、德育1"},
        {id:202, pId:2, name:"G41-2　思想政治教育、德育2"},
        {id:203, pId:2, name:"G41-3　思想政治教育、德育3"},
        
        {id:3, pId:0, name:"<b>G42</b>　教育学", open:false},
        {id:301, pId:3, name:"G42-1　教育学1"},
        {id:302, pId:3, name:"G42-2　教育学2"},
        {id:303, pId:3, name:"G42-3　教育学3"},
        {id:304, pId:3, name:"G42-4　教育学4"},

        {id:4, pId:0, name:"<b>G43</b>　思想政治教育、德育", open:false},
        {id:401, pId:4, name:"G43-1　思想政治教育、德育1"},
        {id:404, pId:4, name:"G43-2　思想政治教育、德育2"},
        {id:403, pId:4, name:"G43-3　思想政治教育、德育3"},

        {id:5, pId:0, name:"<b>G44</b>　教育学", open:false},
        {id:501, pId:5, name:"G44-1　教育学1"},
        {id:502, pId:5, name:"G44-2　教育学2"},
        {id:503, pId:5, name:"G44-3　教育学3"},
        {id:504, pId:5, name:"G44-4　教育学4"},
    ];

    $(document).ready(function(){
        var t = $("#tree");
        //t = $.fn.zTree.init(t, setting, zNodes);
        $.fn.zTree.init($("#tree"), setting);
        demoIframe = $("#testIframe");
        demoIframe.bind("load", loadReady);
        //var zTree = $.fn.zTree.getZTreeObj("tree");
        //var node  = zTree.getNodes();
        //console.log(node);
        //zTree.selectNode(zTree.getNodeByParam("id", '91a1391a0927473fafb1e9191b6643fe'));

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