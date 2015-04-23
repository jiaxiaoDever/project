<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> 新增记录并同步到数据库 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">

            YHUI.use( "yhToolbar yhLayout yhGrid yhDialogTip", function() {
                var grid;

                // 工具栏
                $( "#toolbar" ).yhToolbar({
                    items: [
                        {
                            type: "button",
                            text: "新增",
                            bodyStyle: "new",
                            handler: function(e) {
                                grid.yhGrid( "editGridRow", "new", {
                                    closeAfterAdd: true,
                                    afterComplete: function( xhr ) {
                                        if ( xhr.responseText === "success" ) {
                                            $.yhDialogTip.confirm("恭喜您！数据提交成功。");
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
                    editurl: ctx+"/system/user/save",//保存路径
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