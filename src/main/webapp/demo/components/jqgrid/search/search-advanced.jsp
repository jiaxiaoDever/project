<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> 高阶查询 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">
            /*
             * 高阶查询
             *
             * 用到的 jqGrid 方法
             * searchGrid
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
            YHUI.use( "yhLayout yhGrid yhDialogTip yhToolbar yhSelectmenu", function() {

                var grid, $toolbar;

                $toolbar = $( "#toolbar" ).yhToolbar({
                    items: [
                        {
                            text: "查询",
                            type: "button",
                            bodyStyle: "search",
                            handler: function() {
                                grid.yhGrid( "searchGrid", {
                                    closeAfterSearch: true,
                                    multipleSearch: true,
                                    sopt: [ "eq", "ne", "lt", "le", "gt", "ge", "bw",
                                        "bn", "ew", "en", "cn", "nc" ],
                                    onInitializeSearch: function( $search ) {
                                        // 加了段代码，让弹窗居中
                                        setTimeout(function() {
                                            var gridWidth = grid.width(),
                                                    $dialog = $search.closest("div.ui-jqdialog" ),
                                                    dialogWidth = $dialog.width();
                                            $dialog.css( "left", parseInt((gridWidth-dialogWidth)/2, 10) );

                                            $( "#fbox_list_reset" ).hide();
                                        }, 0 );
                                    },
                                    onSearch: function() {
                                        grid.yhGrid( "setGridParam", {
                                            url: "${ctx}/jsp/jqGrid/advancedSearch.jsp"
                                        });
                                        $toolbar.yhToolbar( "enable", 1 );
                                    }
                                });
                            }
                        },
                        {
                            text: "撤销查询",
                            type: "button",
                            bodyStyle: "cancel",
                            useable: "F",
                            handler: function() {
                                // grid.yhGrid( "setGridParam", {
                                //     url: "http://192.168.1.228:18081/BaseFrame/system/user/queryUsersByPage"
                                    
                                // }).trigger( "reloadGrid" );
                                //用URL方法
                                grid.yhGrid( "addRowData", "id", data ).trigger( "reloadGrid" );//用本地数据方法
                                $toolbar.yhToolbar( "disable", 1 );
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
                    data: data,             // 数据源
                    datatype: "local",
                    heightStyle: "fill",
                    emptyrecords: "没有所查数据",
                    rowNum: 30,
                    pager: "#pager",
                    sortname: "id",
                    viewrecords: true,
                    colModel:[
                        { name: "id", label: "编号", sortable:false },
                        { name: "name", label: "机构名称", sortable: false },
                        { name: "org_type", label: "ORG类型", sortable: false },
                        { name: "parent_id", label: "父机构ID", sortable: false },
                        { name: "state", label: "状态", sortable: false },
                        { name: "description", label: "描述", sortable: false }
                    ]
                });


            });
        </script>
    </head>
    <body>

        <div class="ui-layout-center">
            <div id="toolbar" class="yhui-toolbar"></div>
            <div class="ui-layout-content">
                <table id="list"></table>
                <div id="pager"></div>
                <div id="search"></div>
            </div>

        </div>
    </body>
</html>