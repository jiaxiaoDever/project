<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> jqGrid 的 json 数据格式 </title>
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
                        { name: "id", label: "编号", sortable:false },
                        { name: "name", label: "机构名称", sortable: false },
                        { name: "org_type", label: "ORG类型", sortable: false },
                        { name: "parent_id", label: "父机构ID", sortable: false },
                        { name: "state", label: "状态", sortable: false },
                        { name: "description", label: "描述", sortable: false }
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