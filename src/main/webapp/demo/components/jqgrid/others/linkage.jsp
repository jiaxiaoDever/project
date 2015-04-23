<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> 表格联动 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">

            /*
             * 两级联动
             *
             * 没有什么特别的，主要是几个事件:
             * gridComplete, onSelectRow
             * 详情：
             *
             *
             * 用到的方法：
             * getDataIDs, setSelection, getRowData, setCaption, setGridParam
            
             *
             */
            YHUI.use( "yhLayout yhGrid", function() {
                var sup, sub, selRowId;

                $( document.body ).yhLayout({
                    south__size: 0.6,
                    center__onresize: function() {
                        sup.yhGrid( "refresh" );
                        sub.yhGrid( "refresh" );
                    }
                });

                sup = $( "#sup" ).yhGrid({
                    url: ctx+"/system/user/queryUsersByPage",
                    heightStyle: "fill",
                    sortname: "id",
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
                    gridComplete: function() {
                        var $this = $(this);
                        var firstRowId = $this.yhGrid( "getDataIDs" )[0];
                        $this.yhGrid( "setSelection", firstRowId, true );
                    },
                    onSelectRow: function( rowid ) {
                        var name = $( this ).yhGrid( "getRowData", rowid ).name;
                        var organizationId = $( this ).yhGrid( "getRowData", rowid ).organizationId;
                        if ( !sub ) {
                            sub = $( "#sub" ).yhGrid({
                                url: ctx+"/system/user/queryUsersByPage",
                                heightStyle: "fill",
                                caption: name + "下辖机构",
                                postData: {
                                	organizationId: organizationId,
                                    subgrid: "yes"
                                },
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
                          			}
                            });
                        } else if ( selRowId !== rowid ) {
                            sub.yhGrid( "setCaption", name + "下辖机构" )
                               .yhGrid( "setGridParam", {
                                    postData: {
                                        supId: rowid
                                    }
                                }).trigger( "reloadGrid" );
                        }
                        selRowId = rowid;
                    }
                });


            });
        </script>
    </head>
    <body>
        <div class = "ui-layout-center">
            <table id="sup"></table>
        </div>
        <div class = "ui-layout-south">
            <table id="sub"></table>
        </div>
    </body>
</html>