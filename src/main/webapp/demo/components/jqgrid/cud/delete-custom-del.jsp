<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> 自定义删除记录的方式 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">
            /*
             *   删除指定行
             *   主要用到两个方法
             *   delRowData
             *   getGridParam
             *   思路：
             *   获取选择行 id → 传递到数据库，成功 → 在客户端删除行
             */

            YHUI.use( "yhToolbar yhLayout yhGrid yhDialogTip", function() {
                var grid;

                // 工具栏
                $( "#toolbar" ).yhToolbar({
                    items: [
                        {
                            type: "button",
                            text: "删除",
                            bodyStyle: "delete",
                            handler: function(e) {

                                var rowId = grid.yhGrid( "getGridParam", "selrow" );
                                if ( !rowId ) return $.yhDialogTip.alert( "请选择一行先" );

                                $.yhDialogTip.alert({
                                    message: "确定删除该记录？",
                                    cancelButton: true,
                                    ok: function() {
                                        $.post( "${ctx}/jsp/jqGrid/deleteRow.jsp", { id: rowId } )
                                                .success(function( response ) {
                                                    if ( response === "success" ) {
                                                        grid.yhGrid( "delRowData", rowId );
                                                        $.yhDialogTip.confirm( "删除数据成功" );
                                                    }
                                                })
                                                .error(function() {
                                                    $.yhDialogTip.alert("删除数据失败");
                                                });
                                    }
                                });
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
                    url: "${ctx}/jsp/jqGrid/jsondata.jsp",
                    heightStyle: "fill",
                    rowNum: 50,
                    pager: "#pager",
                    viewrecords: true,
                    colModel:[
                        { name: "id", label: "编号", sortable:false, editable: true },
                        { name: "name", label: "机构名称", sortable: false, editable: true },
                        { name: "org_type", label: "ORG类型", sortable: false, editable: true },
                        { name: "parent_id", label: "父机构ID", sortable: false, editable: true },
                        { name: "state", label: "状态", sortable: false, editable: true },
                        { name: "description", label: "描述", sortable: false, editable: true }
                    ]
                });
            });
        </script>
    </head>
    <body>
        <div class="ui-layout-center">
            <div id="toolbar" class="yhui-toolbar"></div>
            <div class="ui-layout-content" >
                <table id="list"></table>
                <div id="pager"></div>
            </div>
        </div>
    </body>
</html>