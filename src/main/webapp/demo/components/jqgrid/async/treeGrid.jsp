<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> jqGrid 树形表格 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">
            /*
             * 树形表格
             *
             * 看代码量就知道不难
             *
             * 主要属性
             * treeGrid， ExpandColumn， treeGridModel
             */
             YHUI.use( "yhLayout yhGrid", function() {
                var grid;

                $( document.body ).yhLayout({
                    center__onresize: function() {
                        grid.yhGrid( "refresh" );
                    }
                });

                grid = $( "#grid" ).yhGrid({
                    heightStyle: "fill",
                    url: ctx+"/system/user/queryUsersByPage",
                    colModel:[
							  { name: "id", label: "ID", hidden:true, sortable:false, editable: true },
                              { name: "username", label: "用户ID", sortable:false, editable: true },
                              { name: "name", label: "机构名称", sortable: false,editable: true  },
                              { name: "sex", label: "性别", sortable: false,editable: true  },
                              { name: "organizationId", label: "父机构ID", sortable: false,editable: true  },
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
              			},
                    treeGrid: true,             // 启用树形
                    ExpandColumn: "organizationId",       // name 列做为展开列
                    treeGridModel: "adjacency"  // 存储树形数据的模型
                });

            });
            
        </script>
    </head>
    <body>
        <div class="ui-layout-center">
            <table id="grid"></table>
        </div>
    </body>
</html>