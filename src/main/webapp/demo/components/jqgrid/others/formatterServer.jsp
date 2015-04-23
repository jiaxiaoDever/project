<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> 预定义格式化 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">
            YHUI.use( "yhLayout yhGrid", function() {
                var list,
                    supId = location.hash.substring( 1 );

                $( document.body ).yhLayout({
                    south__size: 0.4,
                    center__onresize: function() {
                        list.yhGrid( "refresh" );
                    }
                });

                list = $( "#list" ).yhGrid({
                    url: "${ctx}/jsp/jqGrid/linkage.jsp",
                    heightStyle: "fill",
                    postData: {
                        subgrid: "yes",
                        supId: supId
                    },
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
        </div>
    </body>
</html>