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
<style type = "text/css">
    html, body, .ui-layout-center, .ui-layout-center .ui-layout-content { overflow: hidden; }
</style>
</head>
<body>
    <div class="yhui-header ui-layout-north ui-helper-clearfix">        
    <%@ include file="/demo/commom/header.jsp"%>
    <ul class="yhmenu" id="menu1"></ul>
    </div>
    <div class="ui-layout-west">
            <div id="toolbar-left" class="yhToolbar"></div> 
            <div class="ui-layout-content">
                <ul id="tree" class="ztree"></ul>
            </div>         
    </div>
   <!--  <div class="ui-layout-west">
        <div class="yhui-west-header">
            <div id = "bar" class="yhui-searchbox"></div>
        </div>
        <div class="yhui-west-content">
            <ul id="tree" class="ztree"></ul>
        </div> 

    </div>-->

    <div id="mainContent" class="ui-layout-center">           
        <div class="ui-layout-center">
            <form id = "field" class = 'yhui-formfield noborder'>
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
            <div id = 'toolbar' class = "yhToolbar"></div>
            <div class="ui-layout-content">
                <table id="sub"></table>
                <!-- <div id="pager"></div> -->
            </div>            
        </div>
        <div class="ui-layout-south">
            <div id = 'toolbar' class = "yhToolbar"></div>
            <div class="ui-layout-content">
                <table id="sup"></table>
               <!--  <div id="pager1"></div> -->
            </div>            
        </div>
    </div>
    <script type="text/javascript">
    YHUI.use("yhLayout yhTreemenu yhMenu yhFormField yhToolbar yhGrid",function(){ 
        $(document.body).yhLayout({
                north: {
                    size: 65,
                    spacing_open: 0,
                    spacing_closed: 0
                },
                addBorder: true
            });

            $("#mainContent").yhLayout({
                north: {
                    size: 68,
                    spacing_open: 0,
                    spacing_closed: 0
                },
                south:{ 
                    size:.5,
                },
                center__onresize: function() {
                	grid.yhGrid( "refresh" );
                       // sup.yhGrid( "refresh" );
                    }

            });  


        // $( "#treeMenu" ).yhTreemenu({
        //             source: "/yhuihtml/demo.json"
        //         });
         $.getJSON( "treeData.txt" )
                .done(function( node ) {

                    // init tree and get zTree object
                    var tree = $("#tree").yhTree( {}, node ).yhTree( "getTree" );

                    // expand first level node
                    for ( var i = 0, nodes = tree.getNodes(), l = nodes.length; i < l; i ++ ) {
                        tree.expandNode( nodes[i], true );
                    }

                    //init searchbox, just pass the zTreeObj
                    //$("#bar").yhSearchBox({
                        //tree: tree
                   // });
                });

        /*yhFormField*/
        $('#field').yhFormField();

        /*yhToolbar*/
        $('#toolbar-left,#toolbar').yhToolbar({
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
         var grid = $( "#sub,#sup" ).yhGrid({
                    datatype: "local",
                    heightStyle: "fill",
                   // pager: "#pager",
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
