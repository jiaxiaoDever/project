<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> 预定义格式化 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">

            /*
             * 内置的自定义单元格内容
             *
             * 没有什么特别的，主要属性：
             * formatter
             *
             * 详情：
             * https://github.com/jiangyuan/playjs/blob/master/docOfjqGrid/自定义单元格内容之一%  20预定义.md
             *
             */
            YHUI.use( "yhLayout yhGrid", function() {
                var list;


                $( document.body ).yhLayout({
                    south__size: 0.4,
                    center__onresize: function() {
                        list.yhGrid( "refresh" );
                    }
                });

                $( window ).on( "unload", function() {
                    alert(1);
                });

                list = $( "#list" ).yhGrid({
                    url: "${ctx}/jsp/jqGrid/linkage.jsp",
                    heightStyle: "fill",
                    colModel:[
                        { name: "id", label: "编号", sortable:false },
                        { name: "name", label: "机构名称", sortable: false, formatter: "link" },
                        { name: "org_type", label: "ORG类型", sortable: false },
                        { name: "parent_id", label: "父机构ID", sortable: false },
                        { name: "state", label: "状态", sortable: false },
                        { name: "description", label: "描述", sortable: false }
                    ],
                    gridComplete: function() {
                        $( this ).on( "click", "a", function(e) {
                            e.preventDefault();
                            var link = "${ctx}/Components/jqGrid/others/formatterServer.jsp#"
                                        + $( this ).closest( "tr" ).attr( "id" );
                            if ( parent !== window ) {
                                parent.$( "#main" ).yhTabs( "addTab", $(this), link );
                            } else {
                                window.open( link, "_blank" );
                            }
                        });
                    }
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