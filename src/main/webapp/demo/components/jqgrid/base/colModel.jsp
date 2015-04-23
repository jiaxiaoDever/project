<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title>本地数据</title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <style type="text/css">
            .colorRed{color: red;}
        </style>
        <script type = "text/javascript">
        var data = [
                { id: "1", name: "test1", date: "2013-03-18", sex: "male",stock:"0" ,edittest1:"1",edittest2:"2",edittest3:"3"},
                 { id: "2", name: "test2", date: "2013-03-18", sex: "female",stock:"1",edittest1:"1",edittest2:"2",edittest3:"3"}
                
            ];
            YHUI.use( "yhLayout yhLoading yhGrid", function() {
                // 初始化布局
                $( document.body ).yhLayout({
                    center__onresize: function() {
                        grid.yhGrid( "refresh" );
                    }
                });



                // 初始化表格
                var grid = $( "#list" ).yhGrid({
                    data: data, 
                    datatype: "local",                    
                    heightStyle: "fill",
                    rowNum: 50,
                    cellEdit: true,
                    colNames: [ "编号", "名称", "日期", "path" ],
                     colNames: [ "编号", "名称", "日期", "性别","stock","edittest1","edittest2" ,"edittest3"  ],
                    colModel: [
                        { 
                            name: "id" ,
                            index:'id',
                            editable:true,
                            width:"150" //
                        },
                        { name: "name" ,
                        index:'name',
                        editable:true, 
                        editrules:{required:true},
                        width:"150",
                        formatter: 'showlink',
                        formatoptions:{baseLinkUrl:"save.action",idName: "id", addParam:"&name=123"} 
                    },
                        { name: "date" ,
                        index:'date',
                        editable:true,
                        width:"150", 
                        editrules:{
                          custom:true, 
                          custom_func:function(value, colname){     
                            if (value < 0 && value >20) 
                              return [false,"Please enter value between 0 and 20"];
                            else 
                            return [true,""];
                            }
                    	}
           },//    custom_func:传递给函数的值一个是需要验证value，另一个是定义在colModel中的name属性值。函数必须返回一个数组，一个是验证的结果，true或者false，另外一个是验证错误时候的提示字符串。形如[false,”Please enter valid value”]这样。
                        { name: "sex" ,index:'sex',editable:true,width:"150" },
                        {
                            name:'stock',
                            index:'stock', 
                            width:60, 
                            editable: true,
                            formatter: 'checkbox',
                            edittype:"checkbox",
                            editoptions: {value:"1:0"},
                            formatoptions:{disabled:false}
                        },
                        { 
                            name: "edittest1" ,
                            index:'edittest1',
                            editable:true,
                        classes:"colorRed" 
                    },
                        { name: "edittest2" ,index:'edittest2',editable:true },
                        { name: "edittest3" ,index:'edittest3',editable:true }
                       
                        
                    ]
                });

              
               })
        </script>
    </head>
    <body>
        <div id="main" class="ui-layout-center">
            <table id="list"></table>
        </div>
    </body>
</html>