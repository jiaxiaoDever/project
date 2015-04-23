<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> 列分组 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">
            /*
             * 列分组
             *
             * 相关方法：
             *
             * setGroupHeaders 方法
             *
             
             */
            YHUI.use( "yhLayout yhGrid", function() {
                var grid;

                $( document.body ).yhLayout({
                    center__onresize: function() {
                        grid.yhGrid( "refresh" );
                    }
                });

                grid = $( "#grid" ).yhGrid({
                    url: ctx+"/system/user/queryUsersByPage",
                    rowNum: 20,
                    pager: "#pager",
                    heightStyle: "fill",
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

                grid.yhGrid( "setGroupHeaders", {//分组设置
                    useColSpanStyle: false,
                    groupHeaders: [
                        { startColumnName: "username", numberOfColumns: 2, titleText: "第一组" },
                        { startColumnName: "sex", numberOfColumns: 2, titleText: "第二组" },
                        { startColumnName: "mobile_nbr", numberOfColumns: 2, titleText: "<strong>第三组</strong>" }
                    ]
                });
            });
        </script>
    </head>
    <body>
        <div class="ui-layout-center">
            <table id="grid"></table>
            <div id="pager"></div>
        </div>
    </body>
</html>