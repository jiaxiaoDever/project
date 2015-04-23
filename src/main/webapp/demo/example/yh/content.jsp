<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Document</title>
<meta name="description" content="">
<meta name="keywords" content="">
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
</head>
<body>
<div class="ui-layout-west">
	<ul id="tree" class="ztree"></ul>
</div>
<div id="mainContent" class="ui-layout-center">   
        <div class="ui-layout-north">
            <form id = "field" class = 'yhui-formfield'>
                <table>
                <tr>
                    <td>必填字段</td>
                    <td><input type="text" id="text1" data-validation-engine = "required" /></td>
                    <td>必填字段</td>
                    <td><input type="text" id="text2"/></td>
                    <td>必填字段</td>
                    <td><input type="text" id="text3"/></td>
                </tr>
            </table>
            </form>  
        </div>
        <div class="ui-layout-center">
            <div id = 'toolbar' class = "yhToolbar"></div>
            <div class="ui-layout-content" style="overflow:hidden;">
                <table id="list"></table>
                <div id="pager"></div>
            </div>           
        </div>
</div>


<script type="text/javascript">
    YHUI.use("yhLayout yhTreemenu yhFormField yhToolbar yhGrid",function(){ 
        $(document.body).yhLayout({
            });

            $("#mainContent").yhLayout({
                north: {
                    size: 32,
                    spacing_open: 0,
                    spacing_closed: 0
                },
                center__onresize: function() {
                        grid.yhGrid( "refresh" );
                    }
            });          

        $( "#treeMenu" ).yhTreemenu({
                    source: "/yhuihtml/demo.json"
                });

        /*yhFormField*/
        $('#field').yhFormField();

        /*yhToolbar*/
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
                    }, '-',
                    {
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

        /*yhGrid*/
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
                { id: "12", name: "test12", date: "2013-03-18", sex: "female" },
                { id: "13", name: "test3", date: "2013-03-18", sex: "male" },
                { id: "14", name: "test4", date: "2013-03-18", sex: "female" },
                { id: "15", name: "test5", date: "2013-03-18", sex: "male" },
                { id: "16", name: "test6", date: "2013-03-18", sex: "female" },
                { id: "17", name: "test7", date: "2013-03-18", sex: "male" },
                { id: "18", name: "test8", date: "2013-03-18", sex: "female" },
                { id: "19", name: "test9", date: "2013-03-18", sex: "male" },
                { id: "20", name: "test10", date: "2013-03-18", sex: "male" },
                { id: "21", name: "test1", date: "2013-03-18", sex: "male" },
                { id: "22", name: "test2", date: "2013-03-18", sex: "female" },
                { id: "23", name: "test3", date: "2013-03-18", sex: "male" },
                { id: "24", name: "test4", date: "2013-03-18", sex: "female" },
                { id: "25", name: "test5", date: "2013-03-18", sex: "male" },
                { id: "26", name: "test6", date: "2013-03-18", sex: "female" },
            ];
         var grid = $( "#list" ).yhGrid({
                    datatype: "local",
                    heightStyle: "fill",
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
    });
    </script>
</body>
</html>
