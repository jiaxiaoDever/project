<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Document</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
<style>
	.ui-layout-north,.ui-layout-center{ overflow: hidden;}
</style>
</head>
<body>
<div class="yhui-header ui-layout-north ui-helper-clearfix">头部区</div>
<div class = "ui-layout-west">
    <ul id = "treeMenu" class = "ztree"></ul>
</div>
<div id="mainContent" class="ui-layout-center" >
	<div class="ui-layout-north">
		<form id="searchForm" class="yhui-formfield noborder">
			<table>
				<tr>
					<td>用户账号：</td>
					<td><input type="text" name="username" /></td>
					<td>用户姓名：</td>
					<td><input type="text" name="name"/></td>					
				</tr>
			</table>
		</form>
		<div id = 'toolbar' class = 'yhToolbar'></div>
	</div>	
	<div class="ui-layout-center">		
			<table id="list"></table>
            <div id="pager"></div>	
	</div>
</div>
<script type = "text/javascript">
YHUI.use( "yhLayout yhToolbar  zTree yhFormField yhGrid", function(){
	//布局必须使用
	$(document.body ).yhLayout({ }); 

	//嵌套布局时使用
	$("#mainContent").yhLayout({
				north:{ 
					size:54,
					spacing_open: 			0,
					spacing_closed:  		0,
				},
				center:{
					size:400
				},	
                center__onresize: function() {
                    grid.yhGrid( "refresh" );
                }
            }); 

	//表单必须引用
	$("#searchForm").yhFormField({});


	//tree
	$.getJSON("../../json/treeData.txt", function(data){
				$("#treeMenu").yhTree({}, data);
			});
	
	//工具栏
	$('#toolbar').yhToolbar({
		items : [{
				type : 'button', 
				text : '新增',
				bodyStyle : 'new',//可以理解为图标
				useable : 'T',//是否禁用，T不禁用，F禁用
				handler : function () {//单击触发
					alert( this.innerHTML );
				}
			}, {
				type : 'button',
				text : '修改',
				bodyStyle : 'edit',
				useable : 'T',
				handler : function () {
					alert( this.innerHTML );
				}
			}, {
				type : 'button',
				text : '删除',
				bodyStyle : 'delete',
				useable : 'T',
				handler : function () {
					alert( this.innerHTML );
				}
			}
		]
	});	

	//grid
	var grid = $( "#list" ).yhGrid({
                url: "${ctx}/jsp/jqGrid/jsondata.jsp",
                heightStyle: "fill",
                rowNum: 30,                 /*       ↑       */
                rowList: [ 30, 40, 50 ],    /*       ↑       */
                pagerpos: "left",           /* pager 相关属性 */
                recordpos: "center",        /*       ↓       */
                pager: "#pager",            /*       ↓       */
                viewrecords: true,         /*        ↓       */
                colModel: [
                    { name: "id", index: "id", label: "编号" },
                    { name: "name", index: "name", label: "机构名称" },
                    { name: "org_type", index: "org_type", label: "ORG类型" },
                    { name: "parent_id", index: "parent_id", label: "父机构ID" },
                    { name: "state", index: "state", label: "状态" },
                    { name: "description", index: "description", label: "描述" }
                ]
            });	




});
</script>		
</body>
</html>