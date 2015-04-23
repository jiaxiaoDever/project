<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> 一次删除多条记录 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">
            /*
             *   删除多条记录
             *   主要用到两个方法
             *   delGridRow
             *   getGridParam
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
                                var rowId = grid.yhGrid( "getGridParam", "selarrrow" );

                                if ( rowId.length ) {
                                    // 给数组的每一项都加上单引号，防止在 sql 中出错
                                    rowId = $.map( rowId, function( item ) {
                                        return "'" + item + "'";
                                    });
                                } else {
                                    return $.yhDialogTip.alert( "请选择至少一行先" );
                                }
                                grid.yhGrid( "delGridRow", rowId, {
                                    closeAfterAdd: true,
                                    afterComplete: function( xhr ) {
                                        if ( xhr.responseText === "success" ) {
                                            $.yhDialogTip.confirm( "已同步到数据库" );
                                        }
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
                	url: ctx+"/system/user/queryUsersByPage",
                    editurl: ctx+"/system/user/deleteIn",   
                    multiselect: true,
                    multiboxonly: true,
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
            <div class="ui-layout-content" >
                <table id="list"></table>
                <div id="pager"></div>
            </div>
        </div>
    </body>
</html>