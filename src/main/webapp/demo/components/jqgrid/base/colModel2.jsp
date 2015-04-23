<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> 表头可排序 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">
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
                    rowNum: 50,
                    pager: "#pager",
                    viewrecords: true,
                    colModel:[//如果属性 colNames 是空的，那么列头的名称就是用这个值。如果 colNames 和该值都是空的，那么就将 name 设为列头的名称。
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
            <h5 style="padding:10px;">如果属性 colNames 是空的，那么列头的名称就是用这个值。如果 colNames 和该值都是空的，那么就将 name 设为列头的名称。</h5>
            <table id="list"></table>
            <div id="pager"></div>
        </div>
    </body>
</html>