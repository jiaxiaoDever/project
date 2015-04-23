<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> 新增记录并同步到数据库 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">

            YHUI.use( "yhLayout yhGrid yhDatePicker yhDropDown", function() {
                var grid;

                // 工具栏
             
                $( document.body ).yhLayout({
                    center__onresize: function() {
                        grid.yhGrid( "refresh" );
                    }
                });

                grid = $( "#list" ).yhGrid({
                    url: ctx+"/system/user/queryUsersByPage",
                    editurl: ctx+"/system/user/save",//保存路径
                    heightStyle: "fill",
                    rowNum: 50,
                    pager: "#pager",
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
              			},
              			 ondblClickRow:function(rowid,status){//此事件发生在行点击后
                             
                             var $date,$name,lastsel;

                             if(rowid && rowid!==lastsel){
                                 jQuery('#list').jqGrid('saveRow',lastsel); //把一行处于编辑状态的行变成非编辑状态,不能保存
                                 var aa=jQuery('#list').jqGrid('editRow',rowid);
                                 $("#list_iledit").addClass("ui-state-disabled");
                                 $("#list_ilsave").removeClass("ui-state-disabled");
                                 //把选中行变为编辑状态
                                 lastsel=rowid;
                                  $date=$("#"+rowid+"_date");
                                  $name=$("#"+rowid+"_name");
                                 var tempdate= $date.val();
                                 var tempname= $name.val();
                             }else{
                                  $date=$("#"+rowid+"_date");
                                  $name=$("#"+rowid+"_name");
                             }
                             $date.yhDatePicker().val(tempdate);
                             $name.yhDropDown({
                                 url: ctx + "/system/org/getTree",
                                 resizable: true,
                                 selectParent:true,                  //可以选择父节点
                                 post:"id",
                                 width: 250 

                             }

                                 ).val(tempname);
                         }
                });
                grid.jqGrid('navGrid',"#pager",{edit:false,add:false,del:false});
                grid.jqGrid('inlineNav',"#pager");
            });
        </script>
    </head>
    <body>
        <div class="ui-layout-center">
            
            <div class="ui-layout-content" >
                <table id="list"></table>
                <div id="pager"></div>
            </div>
        </div>
    </body>
</html>