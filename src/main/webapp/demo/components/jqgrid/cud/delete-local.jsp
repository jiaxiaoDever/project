<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title>本地删除记录</title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">
            /*
             * 删除一条记录
             * getGridParam
             * delRowData
             */
            // 本地数据
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

            YHUI.use( "yhLayout yhToolbar yhDialogTip yhGrid", function() {
                var grid;
                
                $( "#toolbar" ).yhToolbar({
                    items: [
                        {
                            text: "删除",
                            bodyStyle: "delete",
                            type: "button",
                            handler: function() {
                                var rowId = grid.yhGrid( "getGridParam", "selrow" );
                                if ( rowId ) {
                                    $.yhDialogTip.alert({
                                        message: "确定要删除这行？",
                                        cancelButton: true,
                                        ok: function() {
                                            grid.yhGrid( "delRowData", rowId );
                                            $.yhDialogTip.confirm( "已删除" );
                                        }
                                    });
                                } else {
                                    $.yhDialogTip.alert( "请选中一行" );
                                }

                            }
                        }
                    ]
                });
                
                
                $( document.body ).yhLayout({
                    center__onresize: function() {
                        grid.yhGrid( "refresh" );
                    }
                });


                grid = $( "#list" ).yhGrid({
                    data: data,             // 数据源
                    datatype: "local",      // 必须设为 local
                    heightStyle: "fill",
                    colNames: [ "编号", "名称", "日期", "性别" ],
                    colModel: [
                        { name: "id" },
                        { name: "name" },
                        { name: "date" },
                        { name: "sex" }
                    ]
                });
            });

        </script>
    </head>
    <body>
        <div class="ui-layout-center">
            <div id="toolbar" class="yhui-toolbar"></div>
            <div class="ui-layout-content"><table id="list"></table></div>
        </div>
    </body>
</html>