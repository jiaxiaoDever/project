<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> 自定义表单编辑 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">
            /*
             * 编辑数据
             * getGridParam 来获取选择行的 id
             * editGridRow 来编辑指定行
             * 详细：https://github.com/jiangyuan/playjs/blob/master/docOfjqGrid/编辑之二 表单编辑.md
             */

            YHUI.use( "yhToolbar yhDialogTip yhButton yhFormField yhLayout yhGrid", function() {
                var grid, $dialog, $form, rowId;

                $dialog = $( "#dialog" ).dialog({
                    autoOpen: false,
                    modal: true,
                    position: [ "center", "center-20%" ],
                    title: "编辑",
                    width: 350
                });

                $form = $dialog.find( "form" ).yhFormField();

                $( "#button" ).yhButton({
                    items: [
                        {
                            type: "save",
                            onClick: function( e, $form ) {
                                var data = $.yhui.mapForm( $form[0] );
                                if ( !data.id ) data.id = rowId;
                                $.post( "${ctx}/jsp/jqGrid/editRow.jsp", data )
                                        .success(function(response) {
                                            if ( response === "success" ) {
                                                grid.trigger( "reloadGrid" );
                                                $dialog.dialog( "close" );
                                                $.yhDialogTip.confirm( "修改已同步到数据库" );
                                            } else {
                                                $.yhDialogTip.alert( "记录没有保存，请重新尝试" );
                                            }
                                        });
                            }
                        },
                        {
                            type: "cancel",
                            onClick: function() {
                                $dialog.dialog( "close" );
                            }
                        }
                    ]
                });

                // 工具栏
                $( "#toolbar" ).yhToolbar({
                    items: [
                        {
                            type: "button",
                            text: "编辑",
                            bodyStyle: "edit",
                            handler: function(e) {
                                rowId = grid.yhGrid( "getGridParam", "selrow" );
                                if ( rowId ) {
                                    var rowData = grid.yhGrid( "getRowData", rowId );
                                    if ( rowData ) {
                                        var fields = $form[0].elements,
                                            len = fields.length,
                                            i = 0;
                                        for ( i; i < len; i++ ) {
                                            fields[i].value = rowData[ fields[i].name ];
                                        }
                                        $dialog.dialog( "open" );
                                    }
                                } else {
                                    $.yhDialogTip.alert( "请选择一行" );
                                }
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
                    url: "${ctx}/jsp/jqGrid/jsondata.jsp",
                    heightStyle: "fill",
                    rowNum: 50,
                    pager: "#pager",
                    viewrecords: true,
                    colModel:[
                        { name: "id", label: "编号", sortable: false },
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
        <div id="dialog">
            <form>
                <table>
                    <tr>
                        <td>机构名称</td>
                        <td><input type = "text" name="name"></td>
                    </tr>
                    <tr>
                        <td>ORG类型</td>
                        <td><input type = "text" name="org_type"></td>
                    </tr>
                    <tr>
                        <td>父机构ID</td>
                        <td><input type = "text" name="parent_id"></td>
                    </tr>
                    <tr>
                        <td>状态</td>
                        <td><input type = "text" name="state"></td>
                    </tr>
                    <tr>
                        <td>描述</td>
                        <td><input type = "text" name="description" /></td>
                    </tr>
                </table>
                <div id="button" class="yhui-button" style="margin-top: 10px;"></div>
            </form>
        </div>
        <div class="ui-layout-center">
            <div id="toolbar" class="yhui-toolbar"></div>
            <div class="ui-layout-content" ><table id="list"></table></div>
        </div>
    </body>
</html>