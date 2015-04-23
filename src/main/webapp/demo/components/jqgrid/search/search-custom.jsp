<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> 自定义查询 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">
            /*
             * 务必注意： 此处的自定义查询和 jqGrid 自动的自定义查询不同
             *
             * 看到这个页面结构，相信大家都精神一阵，自定义查询应该是用的最多的，没有之一
             * jqGrid 中的自定义查询极其简单
             * 思路：
             * "查询"按钮 → 设定 jqGrid 的参数和需要 post 的数据 → 重新加载表格 → 启用"撤销查询"按钮
             * "撤销"查询 → 将 url 还原 → 重新加载表格 → 禁用"撤销查询"按钮
             *
             * 用到的 jqGrid 方法
             * setGridParam
             * trigger( "reloadGrid" )
             *
             */
  
            YHUI.use( "yhLayout yhGrid yhFormField yhDialogTip yhToolbar", function() {

                var grid, $form, $toolbar;

                $toolbar = $( "#toolbar" ).yhToolbar({
                    items: [
                        {
                            text: "查询",
                            type: "button",
                            bodyStyle: "search",
                            handler: function() {
                                var value = $form.find( "input" ).val();
                                
                                if ( !value ) return $.yhDialogTip.alert( "请输入编号！" );
                                grid.yhGrid( "setGridParam", {
                                    url:  ctx + "/system/user/queryUsersByPage",
                                    postData: {
                                    	username: value
                                    },
                                    search: true
                                }).trigger( "reloadGrid" );

                                $toolbar.yhToolbar( "enable", 1 );
                            }
                        }
                       /* ,
                        {
                            text: "撤销查询",
                            type: "button",
                            bodyStyle: "cancel",
                            useable: "F",
                            handler: function() {
                                grid.yhGrid( "setGridParam", {
                                    url:  ctx+"/system/user/queryUsersByPage",
                                    search: false
                                }).trigger( "reloadGrid" );//用URL方法
                               

                                $toolbar.yhToolbar( "disable", 1 );
                            }
                        }*/
                    ]
                });

                $form = $( "#condition" ).yhFormField();

                $( document.body ).yhLayout({
                    north: {
                        size: 60,
                        resizable: false,
                        spacing_open: 0
                    },
                    center__onresize: function() {
                        grid.yhGrid( "refresh" );
                    }
                });

                grid = $( "#list" ).yhGrid({
                   // data: data,             // 数据源
                    //datatype: "local",
                    url: ctx+"/system/user/queryUsersByPage",
                    heightStyle: "fill",
                    rowNum: 50,
                    pager: "#pager",
                    sortname: "id",
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
        <div class="ui-layout-north">
            <form id="condition">
                <table>
                    <tr>
                        <td><label for="id">编号</label></td>
                        <td><input id="id" name="id" type = "text"></td>
                    </tr>
                </table>
            </form>
        </div>
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