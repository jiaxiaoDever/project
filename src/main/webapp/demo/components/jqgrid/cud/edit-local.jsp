<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> 本地编辑 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">
            /*
             * 编辑数据
             * getGridParam 来获取选择行的 id
             * editRow 来指定行
             * 详细：https://github.com/jiangyuan/playjs/blob/master/docOfjqGrid/编辑之三 行内编辑.md
             */


            // 表格数据
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
                { id: "10", name: "test10", date: "2013-03-18", sex: "male" }
            ];

            YHUI.use( "yhToolbar yhDialogTip yhLayout yhGrid", function() {
                var grid;

                // 工具栏
                $( "#toolbar" ).yhToolbar({
                    items: [
                        {
                            type: "button",
                            text: "编辑",
                            bodyStyle: "edit",
                            handler: function(e) {
                                var rowId = grid.yhGrid( "getGridParam", "selrow" );
                                if ( rowId ) {
                                    grid.yhGrid( "editRow", rowId, true );
                                } else {
                                    $.yhDialogTip.alert( "请选择一行" );
                                }
                            }
                        }
                    ]
                });

                // 布局
                $( document.body ).yhLayout({
                    center__onresize: function() {
                        grid.yhGrid( "refresh" );
                    }
                });

                // 初始化表格
                grid = $( "#list" ).yhGrid({
                    data: data,
                    datatype: "local",
                    editurl: "clientArray",     // editurl 编辑的关键属性之一，保存数据的 url
                    heightStyle: "fill",
                    colNames: [ "编号", "名称", "日期", "性别" ],
                    colModel: [
                        { name: "id" },
                        { name: "name", editable: true },   // 注意这个 editable ，是表单可编辑的关键之一
                        { name: "date", editable: true },
                        { name: "sex", editable: true }
                    ]
                });
            });

        </script>
    </head>
    <body>
        <div class="ui-layout-center">
            <div id="toolbar" class="yhui-toolbar"></div>
            <div class="ui-layout-content" ><table id="list"></table></div>
        </div>
    </body>
</html>