<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> 工具栏同步到数据库的过滤 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">
            /*
             * 同步到数据库
             * 当 按 enter 键时，会向属性 url 所指的服务端发送一个请求，传送如下数据
             * _search: true            // 判断是初始化还是查询
             * id: 222                  // id 列的文本框中输入了 222，没有输入值的文本框忽略
             * ...
             * nd: 1364797717279        // 发送请求的时间戳
             * page: 1                  // 页数
             * rows: 30                 // 一次显示的行数
             * sidx: id                 // 派序列
             * sord: asc                // 排序方式
             *
             * 拿到上面的数据后就很容易过滤并返回数据了
             */
              var data = [
                { id: "1", name: "test1", date: "2013-03-18", sex: "male",stock:"0" ,edittest1:"1"},
                { id: "2", name: "test2", date: "2013-03-18", sex: "female",stock:"1",edittest1:"1"}
                
            ];

            YHUI.use( "yhLayout yhGrid", function() {

                $( document.body ).yhLayout({
                    center__onresize: function() {
                        grid.yhGrid( "refresh" );
                    }
                });

                var grid = $( "#list" ).yhGrid({
                      data: data, 
                    datatype: "local",    
                    heightStyle: "fill",
                    rowNum: 30,
                    pager: "#pager",
                    viewrecords: true,
                    sortname: "id",
                    colModel:[
                        { name: "id", index: "id", label: "编号", sortable: false },
                        { name: "name", index: "name", label: "机构名称", sortable: false },
                        { name: "date", index: "date", label: "ORG类型", sortable: false },
                        { name: "sex", index: "sex", label: "父机构ID", sortable: false },
                        { name: "stock", index: "stock", label: "状态", sortable: false },
                        { name: "edittest1", index: "edittest1", label: "描述", sortable: false }
                    ]
                });

                grid.yhGrid( "filterToolbar" );
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