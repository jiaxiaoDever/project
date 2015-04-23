<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title>本地数据</title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">
            YHUI.use( "yhLayout yhLoading yhGrid", function() {
                // 初始化布局
                $( document.body ).yhLayout({
                    center__onresize: function() {
                        grid.yhGrid( "refresh" );
                    }
                });

                // 初始化表格
                var grid = $( "#list" ).yhGrid({
                    datatype: "local",
                    heightStyle: "fill",
                    rowNum: 50,
                    colNames: [ "编号", "名称", "日期", "path" ],
                    colModel: [
                        { name: "id" },
                        { name: "name" },
                        { name: "date" },
                        { name: "path" }
                    ]
                });

                // 加载数据的时候 loading 效果
                var loading = $( "#main" ).yhLoading();

                $.getJSON( "${ctx}/jsp/jqGrid/handJsonData.jsp", { rowNum: 50 } )
                        .success(function( data ) {
                            // 给表格添加数据
                            grid.yhGrid( "addRowData", "id", data );
                        })
                        .error(function() {
                            $.yhui.log( "获取数据失败" );
                        })
                        .complete(function() {
                            loading.yhLoading( "destroy" );
                        });

            });

        </script>
    </head>
    <body>
        <div id="main" class="ui-layout-center">
            <table id="list"></table>
        </div>
    </body>
</html>