<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> 表头可排序 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">

            YHUI.use( "yhLayout yhGrid", function() {

                $( document.body ).yhLayout({
                    center__onresize: function() {
                        grid.yhGrid( "refresh" );
                    }
                });

                var grid = $( "#list" ).yhGrid({
                    url: "${ctx}/jsp/jqGrid/jsondata.jsp",
                    heightStyle: "fill",
                    rowNum: 50,
                    pager: "#pager",
                    viewrecords: true,
                    colModel:[
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
    </head>
    <body>
        <div class="ui-layout-center">
            <table id="list"></table>
            <div id="pager"></div>
        </div>
    </body>
</html>