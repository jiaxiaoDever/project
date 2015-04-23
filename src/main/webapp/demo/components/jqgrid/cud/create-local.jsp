<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> 不同步到服务器的添加数据 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">
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

            YHUI.use( "yhToolbar yhLayout yhGrid", function() {
                var grid;

                // 工具栏
                $( "#toolbar" ).yhToolbar({
                    items: [
                        {
                            type: "button",
                            text: "新增",
                            bodyStyle: "new",
                            handler: function(e) {
                                grid.yhGrid( "editGridRow", "new", {
                                    closeAfterAdd: true,
                                    reloadAfterSubmit: false,
                                    onclickSubmitLocal: function( options, postdata ) {
                                        options.processing = true;  // 关键，这句代码忽略 ajax 请求
                                        return {};
                                    }
                                });
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
                    datatype: "local",
                    editurl: "local.html",
                    heightStyle: "fill",
                    colNames: [ "编号", "名称", "日期", "性别" ],
                    colModel: [
                        { name: "id" },
                        { name: "name", editable: true },   // 注意这个 editable ，是表单可编辑的关键
                        { name: "date", editable: true },
                        { name: "sex", editable: true }
                    ]
                });
                // 添加数据
                grid.yhGrid( "addRowData", "id", data );


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