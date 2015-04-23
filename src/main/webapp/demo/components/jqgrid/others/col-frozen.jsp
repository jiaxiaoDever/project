<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> 冻结列 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">
            /*
             * 冻结列
             *
             * 相关属性和方法：
             *
             * frozen 属性
             * setFrozenColumns 方法
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
                    shrinkToFit: false,//此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条。
               
                colModel:[
                          { name: "username", label: "用户ID", sortable:false,width: 300, frozen: true },//frozen当其为true时表示要锁定该列，默认为false。
                          { name: "name", label: "机构名称", sortable: false,width: 300, },
                          { name: "sex", label: "性别", width: 300,sortable: false },
                          { name: "organization_id", label: "父机构ID",width: 300, sortable: false },
                          { name: "mobile_nbr", label: "手机",width: 300, sortable: false },
                          { name: "email_addr", label: "邮箱地址", width: 300,sortable: false }
                      ],
                jsonReader : {
          				root : "result", // 对于json中数据列表
          				page : "currentPage",
          				total : "totalPage",
          				records : "totalCount",
          				repeatitems : false
          			}
                });

                grid.yhGrid( "setFrozenColumns" );
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