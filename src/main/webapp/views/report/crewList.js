var Crewlist = {
	code : "Crewlist",
	url : ctx + "/system/user/",
	/**
	 * 初始化布局
	 */
	initLayout : function() {
		var me = this ;
		$(document.body).yhLayout({ 
	            west: {
	                size: 240
	            },
	            center: {
	                onresize: function() {
	                    //yhTabs.yhTabs("update");
	                }
	            }
            });
		if($("#vali").val() != "" && $("#vali").val() != null){
				$yhsdata = $( "#CrewSelector" ).yhSelector({
					leftDataUrl: Crewlist.url + "queryUsersByPageN?page=1&rows=2000",
					rightData  : eval($("#vali").val())
				});
		}else{
			$yhsdata = $( "#CrewSelector" ).yhSelector({
					leftDataUrl: Crewlist.url + "queryUsersByPageN?page=1&rows=2000"
				});
		}
		 $( "#rolesubBtn" ).bind("click", function() {
			 	var data = $yhsdata.yhSelector( "getSelected" ), 
			 	crewList ="",
				arr = [],
				l = data.length;
				if ( l ) {
					//arr.push("[");
					for(i = 0 ; i < l; i ++ ) {
						//arr.push( "{name:'", data[i].name, "',", "id:'", data[i].id, "'}" );
						arr.push(data[i].id);
						crewList += data[i].name;
						if(i < l-1){
							arr.push(",");
							crewList += ",";
						}
						
					}
					//arr.push("]");
				}
				$("#vali").val(arr.join(""));
				$("#crewList").val(crewList);
		 	});
		  $("#userNameBtn").click(function(o){
			  var username = $("#userName").val();
			  $yhsdata.yhSelector( "replaceList", Crewlist.url + "queryUsersByPageN?name="+encodeURIComponent(username)+"&page=1&rows=2000", true );
		   });
	},
	initLoadData : function() {
		var _this = this;
		var setting = {
				async : {
					enable : true,// 异步获取数据
					url : _this.url + "getOrgTree",
					autoParam : [ "id", "parentId" ],
					contentType :"application/json"
				},
			

				edit : {
					enable : true,// 允许编辑拖拽
					showRemoveBtn : false,
					showRenameBtn : false,
					drag : {
						prev : true,
						next : true,
						inner : function dropInner(treeId, nodes, targetNode) {
							// 目标节点为按钮时，不允许转换成父节点
							if (targetNode && targetNode.type === 2) {
								return false;
							}
							return true;
						}
					}
				},
				callback : {
					onClick : function(event, treeId, treeNode, clickFlag) {
						$yhsdata.yhSelector( "replaceList", Crewlist.url+ "queryUsersByPageN?organizationId="+treeNode.id+"&page=1&rows=2000", true );
					}
				}
			};
			$.fn.zTree.init($("#crewListTree"), setting);
}
};

/**
 * 初始化时layout要放在form/toolbar/button之后，loaddata之前
 */
YHUI.use("yhFormField yhLayout yhDropDown yhGrid yhToolbar yhButton yhDialogTip zTree  yhValidate  yhWindow yhSearchBox yhDatePicker yhSelector", function() {
	Crewlist.initLayout();
	Crewlist.initLoadData();
});