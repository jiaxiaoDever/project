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
                    url: ctx+"/system/user/queryUsersByPage",
                    heightStyle: "fill",
                    rowNum: 50,
                    pager: "#pager",
                    sortname: 'id',
                    viewrecords: true,
                    contextmenu: true,//右键菜单设置
                    colModel:[
                              { name: "username", label: "用户ID", sortable:false },
                              { name: "name", label: "机构名称", sortable: false },
                              { name: "sex", label: "性别", sortable: false },
                              { name: "organization_id", label: "父机构ID", sortable: false },
                              { name: "mobile_nbr", label: "手机", sortable: false },
                              { name: "email_addr", label: "邮箱地址", sortable: false }
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
            <table id="list"></table>
            <div id="pager"></div>
        </div>
    </body>
</html>