<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title>本地数据的第二种添加方式</title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
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
                { id: "10", name: "test10", date: "2013-03-18", sex: "male" }
            ];

            YHUI.use( "yhLayout yhGrid", function() {
                $( document.body ).yhLayout({
                    center__onresize: function() {
                       // grid.yhGrid( "refresh" );
                    }
                });

                var grid = $( "#list" ).yhGrid({
                    data: data,             // 数据源
                    datatype: "local",      // 数据类型。可选值有： "xml"， "xmlstring"， "json"， "local"， "javascript"， "clientSide" 。
                   // heightStyle: "fill",//为yhGrid定义属性
                    width:800,
                    height:250,
                    caption:"表格的标题",//表格的标题。如果为空，则不显示标题行。
                    hiddengrid: true,//当为true隐藏表格
                   // mtype：POST,请求的类型，"POST" 或者 "GET" 
                    //editurl:getdata.php,行编辑和表单编辑时的 url，用来保存修改的数据。
                    multiselect: true,
                    multikey:true,//当 multiselect 为 true 时，该参数才有效。按住什么键可以多选。可选值： shiftKey， altKey， ctrlKey 
                    multiboxonly:true,//当 multiselect 为 true 时，该参数才有效。multiselect 为 true，点击 行 的任意位置都能选中该行。multiboxonly 为 true 时，只有点击非当前行的复选框才能完成多选。
                    //sortorder:asc,//初始化时的排序方法，"asc" 或者 "desc" 。该值会被传到服务器端。 
                    sortname:name,//默认初始化排序的列名称，比如要让表格依据 colModel 中的 name 为 id 的列排序，那么设置为 "id" 。设置该值后，对应的列头中会出现箭头。 


                    colNames: [ "编号", "名称", "日期", "性别" ],
                    colModel: [
                        { name: "id" },
                        { name: "name" },
                        { name: "date" },
                        { name: "sex" }
                    ]
                    
                    //multiboxonly: true
                });

            });

        </script>
    </head>
    <body>
        <div class="ui-layout-center">
            <table id="list"></table>
        </div>
    </body>
</html>