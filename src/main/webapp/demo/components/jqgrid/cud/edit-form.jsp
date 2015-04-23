<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> 表单编辑 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">
            /*
             * 编辑数据
             * getGridParam 来获取选择行的 id
             * editGridRow 来编辑指定行
             * 详细：https://github.com/jiangyuan/playjs/blob/master/docOfjqGrid/编辑之二 表单编辑.md
             */

            YHUI.use( "yhToolbar yhDialogTip yhLayout yhGrid", function() {
                var grid;

                // 工具栏
                $( "#toolbar" ).yhToolbar({
                    items: [
                        {
                            type: "button",
                            text: "编辑",
                            bodyStyle: "edit",
                            handler: function(e) {
                                var rowId = grid.yhGrid( "getGridParam", "selrow" );
                                if ( rowId ) {
                                    grid.yhGrid( "editGridRow", rowId, {
                                        closeAfterEdit: true,
                                        afterComplete: function( xhr ) {
                                            if ( xhr.statusText === "OK" ) {
                                                $.yhDialogTip.confirm( "修改成功" );
                                            } else {
                                                $.yhDialogTip.alert( "修改失败" );
                                            }
                                        }
                                    });
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
                	url: ctx+"/system/user/queryUsersByPage",
                    editurl: ctx+"/system/user/save",     // editurl 编辑的关键属性之一，保存数据的 url
                    heightStyle: "fill",
                    rowNum: 50,
                    pager: "#pager",
                    viewrecords: true,
                    colModel:[
							  { name: "id", label: "ID", hidden:true, sortable:false, editable: true },
                              { name: "username", label: "用户ID", sortable:false, editable: true },
                              { name: "name", label: "机构名称", sortable: false,editable: true  },
                              { name: "sex", label: "性别", sortable: false,editable: true  },
                              { name: "organization_id", label: "父机构ID", sortable: false,editable: true  },
                              { name: "mobile_nbr", label: "手机", sortable: false,editable: true  },
                              { name: "email_addr", label: "邮箱地址", sortable: false,editable: true  },
                              { name: "password", label: "PASSWORD", hidden:true, sortable:false, editable: true }
                          ],
                    jsonReader : {
              				root : "result", // 对于json中数据列表
              				page : "currentPage",
              				total : "totalPage",
              				records : "totalCount",
              				repeatitems : false
              			}
                });
            });

        </script>
    </head>
    <body>
        <div class="ui-layout-center">
            <div id="toolbar" class="yhui-toolbar"></div>
            <div class="ui-layout-content" ><table id="list"></table></div>
        </div>
    </body>
</html>