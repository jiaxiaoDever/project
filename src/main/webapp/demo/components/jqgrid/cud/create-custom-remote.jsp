<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> 自定义新增记录 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">
            /*
             * 小小的做了一个自定义的编辑数据，很简单
             * 思路：
             * 编辑按钮 → 包含表单的弹窗 → 回填数据 → 点击保存异步提交 → 数据库操作
             *
             * 做得更好一点的话，保存成功后，可以用 trigger(“reloadGrid”) 方法来重新加载表格
             * 方法文档： https://github.com/jiangyuan/playjs/blob/master/docOfjqGrid/methods.md
             */
            YHUI.use( "yhToolbar yhFormField yhButton yhLayout yhGrid yhDialogTip", function() {
                var grid;

                // 弹窗
                var $dialog = $( "#dialog" ).dialog({
                    autoOpen: false,
                    modal: true,
                    resizable: false,
                    position: [ "center", "center-15%" ],
                    open: function() {

                        $( this )
                            .find( "form" ).yhFormField()
                            .find( "div.yhui-button" ).yhButton({
                                    items: [
                                        {
                                            type: "save",
                                            onClick: function( e, $form ) {
                                                var data = $.yhui.mapForm( $form[0] );
                                                $.post( "${ctx}/jsp/jqGrid/addRow.jsp", data )
                                                        .success(function( response ) {
                                                            if ( response === "success" ) {
                                                                $.yhDialogTip.confirm( "数据已经保存到数据库！" );
                                                                grid.trigger( "reloadGrid" );
                                                            } else {
                                                                $.yhDialogTip.alert( "数据添加失败！" );
                                                            }
                                                        })
                                                        .complete(function() {
                                                            $dialog.dialog( "close" );
                                                        });
                                            }
                                        },
                                        {
                                            type: "cancel",
                                            onClick: function() {
                                                $dialog.dialog("close");
                                            }
                                        }
                                    ]
                                });
                    }
                });

                // 工具栏
                $( "#toolbar" ).yhToolbar({
                    items: [
                        {
                            type: "button",
                            text: "新增",
                            bodyStyle: "new",
                            handler: function(e) {
                                $dialog.dialog( "open" );
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
        <div id="dialog">
            <form>
                <table>
                    <tr>
                        <td>编号</td>
                        <td><input type = "text" name="id"></td>
                    </tr>
                    <tr>
                        <td>机构名称</td>
                        <td><input type = "text" name="name"></td>
                    </tr>
                    <tr>
                        <td>ORG 类型</td>
                        <td><input type = "text" name="org_type"></td>
                    </tr>
                    <tr>
                        <td>父机构ID</td>
                        <td><input type = "text" name="parent_id" ></td>
                    </tr>
                    <tr>
                        <td>状态</td>
                        <td><input type = "text" name="state" ></td>
                    </tr>
                    <tr>
                        <td>描述</td>
                        <td><input type = "text" name="description" ></td>
                    </tr>
                </table>
                <div class="yhui-button"></div>
            </form>
        </div>
        <div class="ui-layout-center">
            <div id="toolbar" class="yhui-toolbar"></div>
            <div class="ui-layout-content" >
                <table id="list"></table>
                <div id="pager"></div>
            </div>
        </div>
    </body>
</html>