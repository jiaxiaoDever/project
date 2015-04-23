<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ include file="/common/meta.jsp"%>
</head>
<body>
	<div id="mainContent" class="ui-layout-center">
		<div class="ui-layout-center noscroll">
			<form id="searchForm" class="yhui-formfield noborder">
				<input type="hidden" id="rpt_type" />
				<table>
					<tr>
						<td>报表名称：</td>
						<td><input type="text" id="name" /></td>
					</tr>
					<tr>
						<td>显示方式：</td>
						<td><input type="text" id="rpt_show" /></td>
					</tr>
					<tr>
						<td>所属目录：</td>
						<td><input type="text" id="rpt_type_name" disabled /> 
						<input type="button" id="btn" class="yhui-btn" value="更改" /></td>
					</tr>

					<tr>
						<td>是否有效：</td>
						<td>
						<input type="text" id="state"  />
						 </td>
					</tr>

				</table>
			</form>
		</div>
	</div>
	<div id="dialog-form" title="更改报表目录">

		<ul id="reportDirTree" class="ztree"></ul>
	</div>

	<script type="text/javascript">
		YHUI.use("yhFormField yhLayout zTree yhDropDown", function() {
			$(document.body).yhLayout({});
			$("#searchForm").yhFormField({});
			//初始化数据
			$("#name").val('${param.name}');
			$("#rpt_type").val('${param.rpt_type}');
			$("#rpt_type_name").val('${param.rpt_type_name}');

			var treeObj = null;

			var setting = {
				data : {
					key : {
						title : "t"
					},
					simpleData : {
						enable : true
					}
				},
				callback : {
					//展开树节点方法
					beforeExpand : function(treeId, treeNode) {
						//判断是否有子节点，如果没有子节点，则进行手动添加子节点
						if (treeNode.children && treeNode.children.length > 0) {
							return true;
						} else {
							//从本地数据中加载它的子节点
							if (allTreeData && allTreeData.length > 0) {
								var tempChildNodes = new Array();
								for (var i = 0, len = allTreeData.length; i < len; i++) {
									var temp = allTreeData[i];
									if (temp.PARENT_ID != treeNode.id) {
										continue;
									}
									//转化成ztree node节点
									var tmpNode = {
										id : temp.ID,
										name : temp.NAME,
										pId : temp.PARENT_ID,
										t : temp.DESCRIPTION,
										isParent : true
									};
									tempChildNodes.push(tmpNode);
								}
								if (tempChildNodes.length > 0) {
									treeObj.addNodes(treeNode, tempChildNodes);
									return false;//不需要去触法onExpand事件了。直接展开了。
								}
							}
							return true;
						}

					},
					onClick : function(event, treeId, treeNode, clickFlag) {

					}
				}
			};

			var zNodes = [ {
				id : 'root',
				pId : -1,
				name : "报表分类",
				t : "报表分类目录",
				isParent : true
			} ];

			var allTreeData = null;

			$("#dialog-form").dialog({
				autoOpen : false,
				height : 300,
				width : 350,
				modal : true,
				buttons : {
					"确定" : function() {
						var nodes = treeObj.getSelectedNodes();
						if (!nodes || nodes.length != 1) {
							alert('请选择一个目录');
							return;
						}
						var node = nodes[0];
						//设置表单隐藏的值
						$("#rpt_type").val(node.id);
						$("#rpt_type_name").val(node.name);

						$(this).dialog("close");
					},
					"取消" : function() {
						$(this).dialog("close");
					}
				},
				open : function() {
					//后台加载报表目录
					if (!allTreeData || allTreeData.length == 0) {
						$.post(ctx + "/report/getReportTypeTreeJson", {}, function(res) {
							treeObj = $.fn.zTree.init($("#reportDirTree"), setting, zNodes);
							allTreeData = res;

						});

					}

				},
				close : function() {
					//$( this ).dialog( "close" );
				}
			});
			

			$("#btn").bind("click", function() {
				$("#dialog-form").dialog("open");
			});
			
			var shlist = [ { name: "PC", id: 1 },{ name: "PC&手机端", id: 3 },{ name: "手机端", id: 2 }];
			$("#rpt_show").yhDropDown({
				hiddenId:"rpt_show",
				post : "id",
				json : shlist,
				noChild : true
			}).yhDropDown("parseDrop");
			$("#rpt_show").yhDropDown("setValue","${param.rpt_show}");

			var stlist = [{ name: "有效", id: '1' },{ name: "无效", id: '-1'}];
	       
			$("#state").yhDropDown({
				hiddenId : "state",
				post : "id",
				json : stlist,
				noChild : true
			}).yhDropDown("parseDrop");
			$("#state").yhDropDown("setValue", "${param.state}");
		});
	</script>
</body>
</html>