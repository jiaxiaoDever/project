<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>上-下布局实例</title>
<link rel="stylesheet" type="text/css" href="../skins/yhui-structure.css"/>
<link rel="stylesheet" type="text/css" href="../skins/skinBlue/yhui-skin.css"/>
<script src="../js/base/yhHead.js" type="text/javascript"></script>
</head>
<body>
<div class ="ui-layout-north" >
  <form id="field" class = "yhui-formfield" >
    <table>
      <tr>
        <td>必填字段</td>
        <td><input type="text" id="text1" data-validation-engine = "required" /></td>
        <td>必填字段</td>
        <td><input type="text" id="text2"/></td>
        <td>必填字段</td>
        <td><input type="text" id="text3"/></td>
      </tr>
      <tr>
        <td>选填字段</td>
        <td><input type="text" id="text4"/></td>
        <td>必填字段</td>
        <td><input type="text" id="text5"/></td>
        <td>必填字段</td>
        <td><input type="text" id="text6"/></td>
      </tr>
    </table>
  </form>
</div>
<div class="ui-layout-center">
  <div id="toolbar" class="yhui-toolbar"></div>
  <div class="ui-layout-content" >
    <table id="list">
    </table>
    <div id="pager"></div>
  </div>
</div>
<script type="text/javascript">
		YHUI.use("yhLayout yhToolbar yhFormField yhDropDown yhGrid", function() {
			$("#field").yhFormField({});
			
			$('#text1').yhDropDown({
				url: "treeData.txt"
			});
			
			$('#text2').yhDropDown({
				url: "treeData.txt",
				beforeCreatedTree: function( e, data ) {
					//$.yhui.log( data );
				}
			});
			
			 var data = [
                { id: "1", name: "test1", date: "2013-03-18", sex: "male" },
                { id: "2", name: "test2", date: "2013-03-18", sex: "female" },
                { id: "3", name: "test3", date: "2013-03-18", sex: "male" },
                { id: "4", name: "test4", date: "2013-03-18", sex: "female" },
                { id: "5", name: "test5", date: "2013-03-18", sex: "male" },
                { id: "6", name: "test6", date: "2013-03-18", sex: "female" },
                { id: "7", name: "test7", date: "2013-03-18", sex: "male" },
                { id: "8", name: "test8", date: "2013-03-18", sex: "female" },
                { id: "9", name: "test9", date: "2013-03-18", sex: "male" },
                { id: "10", name: "test10", date: "2013-03-18", sex: "male" },
				{ id: "11", name: "test11", date: "2013-03-18", sex: "male" },
				{ id: "12", name: "test12", date: "2013-03-18", sex: "male" },
				{ id: "13", name: "test13", date: "2013-03-18", sex: "male" },
				{ id: "14", name: "test14", date: "2013-03-18", sex: "male" },
				{ id: "15", name: "test15", date: "2013-03-18", sex: "male" },
				{ id: "16", name: "test16", date: "2013-03-18", sex: "male" },
				{ id: "17", name: "test17", date: "2013-03-18", sex: "male" }
				
            ];
			
	
				
			// 布局
                $( document.body ).yhLayout({
                    center__onresize: function() {
                        grid.yhGrid( "refresh" );
                    }
                });
				// 初始化表格
                var grid = $( "#list" ).yhGrid({
                    datatype: "local",
                    heightStyle: "fill",					
					caption: "报表名称",
					rowNum: 10,
                    pager: "#pager",
                    viewrecords: true,
                    colNames: [ "编号", "名称", "日期", "性别" ],
                    colModel: [
                        { name: "id" },
                        { name: "name" },
                        { name: "date" },
                        { name: "sex" }
                    ]					
                });                
                // 方法 addRowData 用来给表格添加数据
                // 详情： https://github.com/jiangyuan/playjs/blob/master/docOfjqGrid/methods.md
                grid.yhGrid( "addRowData", "id", data );	

			
			$('#toolbar').yhToolbar({//toolbar改造自一个插件，所以挖掘的不是很深
				//items就是选项了，如新增、修改什么的。所有的都是可选的。
				items : [{
						type : 'button', 
						text : '查询',
						bodyStyle : 'search',//可以理解为图标
						useable : 'T',//是否禁用，T不禁用，F禁用
						handler : function () {//单击触发
							alert( this.innerHTML );
						}
						}, '-', {      //这里的小横线就是分隔
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
		});
	</script>
</body>
</html>