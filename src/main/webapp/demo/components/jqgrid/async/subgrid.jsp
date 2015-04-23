<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> jqGrid 子表格 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>

        <script type = "text/javascript">
            /*
             * 看这个代码量就知道很简单
             * 主要是多了几个属性
             * 详细 https://github.com/jiangyuan/playjs/blob/master/docOfjqGrid/subGrid.md
             */
            YHUI.use( "yhGrid yhLayout", function() {

                var grid;

                $( document.body ).yhLayout({
                    center__onresize: function() {
                        grid.yhGrid( "refresh" );
                    }
                });

                grid = $( "#grid" ).yhGrid({
                    heightStyle: "fill",
                    url: ctx+"/system/user/queryUsersByPage",
                    sortname: "id",
                    colModel:[
							  { name: "id", label: "ID", hidden:true, sortable:false, editable: true },
                              { name: "username", label: "用户ID", sortable:false, editable: true },
                              { name: "name", label: "机构名称", sortable: false,editable: true  },
                              { name: "sex", label: "性别", sortable: false,editable: true  },
                              { name: "organizationId", label: "父机构ID", sortable: false,editable: true  },
                              { name: "mobileNbr", label: "手机", sortable: false,editable: true  },
                              { name: "emailAddr", label: "邮箱地址", sortable: false,editable: true  },
                              { name: "password", label: "PASSWORD", hidden:true, sortable:false, editable: true }
                          ],
                    jsonReader : {
              				root : "result", // 对于json中数据列表
              				page : "currentPage",
              				total : "totalPage",
              				records : "totalCount",
              				repeatitems : false,
              				subgrid: {
              					root : "result", // 对于json中数据列表
                  				page : "currentPage",
                  				total : "totalPage",
                  				records : "totalCount",
                  				repeatitems : false 
              			        //cell: "cell"
              			    }
              			},
                    subGrid: true,
                    subGridUrl: ctx+"/system/user/queryUsersByPage",
                    subGridModel: [
                                  {
                         //name: [ "id","state","stateDate", "name", "symbol", "roleLevel", "description"],
                         name: [ "username","name", "sex", "organizationId", "emailAddr"],
                         width: [ 100, 150,150,150, 100, 100, 200 ]
                    }
                    ],
                    subGridOptions: {
                        reloadOnExpand: true//如果设为 false ，那么只在第一次展开子表时发送请求获得数据
                    },
                    serializeSubGridData: function( data ) {
                    	//console.log(data);
                        data.subgrid = "yes";
                        data.page=0;
                        data.rows=5;
                        return data;
                    }
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