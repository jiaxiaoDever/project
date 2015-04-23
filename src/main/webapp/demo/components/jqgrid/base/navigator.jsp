<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> 导航栏之翻页区 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">
            /*
             * 导航栏之功能区
             *
             * 关键方法：
             *      navGrid
             *
         
             */
               var data = [
                { id: "1", name: "test1", date: "2013-03-18", sex: "male" },
                { id: "2", name: "test2", date: "2013-03-18", sex: "female" },
                { id: "3", name: "test3", date: "2013-03-18", sex: "male" },
                { id: "4", name: "test4", date: "2013-03-18", sex: "female" },
                { id: "5", name: "test5", date: "2013-03-18", sex: "male" },
                { id: "6", name: "test6", date: "2013-03-18", sex: "female" },
                { id: "7", name: "test7", date: "2013-03-18", sex: "male" },
                { id: "8", name: "test8", date: "2013-03-18", sex: "female" },
                { id: "9", name: "test9", date: "2013-03-18", sex: "male" },
                { id: "10", name: "test10", date: "2013-03-18", sex: "male" },
                { id: "11", name: "test10", date: "2013-03-18", sex: "male" },
                { id: "12", name: "test10", date: "2013-03-18", sex: "male" }
            ];
            YHUI.use( "yhLayout yhGrid", function() {

                $( document.body ).yhLayout({
                    center__onresize: function() {
                        grid.yhGrid( "refresh" );
                    }
                });

                var grid = $( "#list" ).yhGrid({
                    //data: data,             // 数据源
                    //datatype: "local",
                    url: ctx+"/system/user/queryUsersByPage",
                    heightStyle: "fill",
                    rowNum: 30,
                    rowList: [ 30, 40, 50 ],
                    pager: "#pager",
                    viewrecords: true,
                    editurl:ctx+"/system/user/save", 
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
                })
                jQuery("#list").jqGrid('navGrid','#pager',{add:true,edit: true,del: false,search:true,refresh:true});
                // .yhGrid( "navGrid", "#pager", {},
                //         {
                //             closeAfterEdit: true,
                //             url: "${ctx}/jsp/jqGrid/editRow.jsp"
                //         },
                //         {
                //             closeAfterAdd: true,
                //             url: "${ctx}/jsp/jqGrid/addRow.jsp"
                //         },
                //         {
                //             closeAfterAdd: true,
                //             url: "${ctx}/jsp/jqGrid/deleteRow.jsp"
                //         },
                //         {
                //             multipleSearch: true,
                //             onSearch: function() {
                //                 grid.yhGrid( "setGridParam", {
                //                     url: "${ctx}/jsp/jqGrid/advancedSearch.jsp"
                //                 });
                //             },
                //             onReset: function() {
                //                 grid.yhGrid( "setGridParam", {
                //                     url: "${ctx}/jsp/jqGrid/jsondata.jsp"
                //                 });
                //             },
                //             onClose: function() {
                //                 grid.yhGrid( "setGridParam", {
                //                     url: "${ctx}/jsp/jqGrid/jsondata.jsp"
                //                 });
                //             }
                //         }
                // );
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