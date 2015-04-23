<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> 导航栏之翻页区 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">
            /*
             * 导航栏之翻页区
             *
             * 注意代码中的几个关键属性
             *
             * 详情：
         
             */
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
                { id: "11", name: "test10", date: "2013-03-18", sex: "male" },
                { id: "12", name: "test10", date: "2013-03-18", sex: "male" }
            ];
            YHUI
            YHUI.use( "yhLayout yhGrid", function() {

                $( document.body ).yhLayout({
                    center__onresize: function() {
                        grid.yhGrid( "refresh" );
                    }
                });

                var grid = $( "#list" ).yhGrid({
                    data: data,             // 数据源
                    datatype: "local", 
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
                        { name: "date", index: "org_type", label: "ORG类型" },
                        { name: "sex", index: "parent_id", label: "父机构ID" },
                    ]
                });
            });
        </script>
    </head>
    <body>
        <div class="ui-layout-center">
            <table id="list"></table>
            <div id="pager"></div>
        </div>
    </body>
</html>