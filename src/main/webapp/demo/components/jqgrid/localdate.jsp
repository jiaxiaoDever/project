<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset = "utf-8"/>
<title>本地数据</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
</head>
<body>
<div class="ui-layout-center">
  <table id="list">
  </table>
  <div id="pager"></div>
</div>
<script type = "text/javascript">

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
				{ id: "11", name: "test11", date: "2013-03-18", sex: "male" },
				{ id: "12", name: "test12", date: "2013-03-18", sex: "male" },
				{ id: "13", name: "test13", date: "2013-03-18", sex: "male" },
				{ id: "14", name: "test14", date: "2013-03-18", sex: "male" },
				{ id: "15", name: "test15", date: "2013-03-18", sex: "male" },
				{ id: "16", name: "test16", date: "2013-03-18", sex: "male" },
				{ id: "17", name: "test17", date: "2013-03-18", sex: "male" }
				
            ];

            YHUI.use( "yhLayout yhGrid", function() {
                $( document.body ).yhLayout({
                    center__onresize: function() {
                        grid.yhGrid( "refresh" );
                    }
                });
                var grid = $( "#list" ).yhGrid({
                    datatype: "local",
                    heightStyle: "fill",
					caption: "报表名称",
					rowNum: 10,
                    pager: "#pager",
                    viewrecords: true,
                    colNames: [ "编号", "名称", "日期", "性别" ],
                    colModel: [
                        { name: "id" },
                        { name: "name" },
                        { name: "date" },
                        { name: "sex" }
                    ]
                });
                
                // 方法 addRowData 用来给表格添加数据
                // 详情： https://github.com/jiangyuan/playjs/blob/master/docOfjqGrid/methods.md
                grid.yhGrid( "addRowData", "id", data );
            });

        </script>
</body>
</html>