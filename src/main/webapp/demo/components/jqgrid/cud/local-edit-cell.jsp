<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "utf-8"/>
        <title> 新增记录并同步到数据库 </title>
        <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
        <script type = "text/javascript">

            /*
             * 工具栏过滤
             * 关键方法 filterToolbar
             * 参见
             */
            var data = [
                { id: "1", name: "test1", date: "2013-03-18", sex: "male",stock:"0" ,edittest1:"1",edittest2:"2",edittest3:"3",edittest4:"4",edittest5:"5",edittest6:"6",edittest7:"7",edittest8:"8",edittest9:"9",edittest10:"10"},
                { id: "2", name: "test2", date: "2013-03-18", sex: "female",stock:"1",edittest1:"1",edittest2:"2",edittest3:"3",edittest4:"4",edittest5:"5",edittest6:"6",edittest7:"7",edittest8:"8",edittest9:"9",edittest10:"10"},
                { id: "3", name: "test3", date: "2013-03-18", sex: "male",stock:"1" ,edittest1:"1",edittest2:"2",edittest3:"3",edittest4:"4",edittest5:"5",edittest6:"6",edittest7:"7",edittest8:"8",edittest9:"9",edittest10:"10"},
                { id: "4", name: "test4", date: "2013-03-18", sex: "female",stock:"1",edittest1:"1",edittest2:"2",edittest3:"3",edittest4:"4",edittest5:"5",edittest6:"6",edittest7:"7",edittest8:"8",edittest9:"9",edittest10:"10"},
                { id: "5", name: "test5", date: "2013-03-18", sex: "male" ,stock:"1",edittest1:"1",edittest2:"2",edittest3:"3",edittest4:"4",edittest5:"5",edittest6:"6",edittest7:"7",edittest8:"8",edittest9:"9",edittest10:"10"},
                { id: "6", name: "test6", date: "2013-03-18", sex: "female" ,stock:"0",edittest1:"1",edittest2:"2",edittest3:"3",edittest4:"4",edittest5:"5",edittest6:"6",edittest7:"7",edittest8:"8",edittest9:"9",edittest10:"10"},
                { id: "7", name: "test7", date: "2013-03-18", sex: "male" ,stock:"1",edittest1:"1",edittest2:"2",edittest3:"3",edittest4:"4",edittest5:"5",edittest6:"6",edittest7:"7",edittest8:"8",edittest9:"9",edittest10:"10"},
                { id: "8", name: "test8", date: "2013-03-18", sex: "female" ,stock:"1",edittest1:"1",edittest2:"2",edittest3:"3",edittest4:"4",edittest5:"5",edittest6:"6",edittest7:"7",edittest8:"8",edittest9:"9",edittest10:"10"},
                { id: "9", name: "test9", date: "2013-03-18", sex: "male" ,stock:"1",edittest1:"1",edittest2:"2",edittest3:"3",edittest4:"4",edittest5:"5",edittest6:"6",edittest7:"7",edittest8:"8",edittest9:"9",edittest10:"10"},
                { id: "10", name: "test10", date: "2013-03-18", sex: "male",stock:"0" ,edittest1:"1",edittest2:"2",edittest3:"3",edittest4:"4",edittest5:"5",edittest6:"6",edittest7:"7",edittest8:"8",edittest9:"9",edittest10:"10"},
                { id: "11", name: "test10", date: "2013-03-18", sex: "male" ,stock:"1",edittest1:"1",edittest2:"2",edittest3:"3",edittest4:"4",edittest5:"5",edittest6:"6",edittest7:"7",edittest8:"8",edittest9:"9",edittest10:"10"},
                { id: "12", name: "test10", date: "2013-03-18", sex: "male" ,stock:"1",edittest1:"1",edittest2:"2",edittest3:"3",edittest4:"4",edittest5:"5",edittest6:"6",edittest7:"7",edittest8:"8",edittest9:"9",edittest10:"10"}
            ];

            YHUI.use( "yhLayout yhGrid yhDatePicker yhDropDown yhLoading yhDialogTip", function() {
                $( document.body ).yhLayout({
                   north: {
                    size: 0,
                    spacing_open: 0,
                    spacing_closed: 0
                },
                center:{
                    left:"20px",
                },
                addBorder: false
            });

         
    jQuery("#celltbl").jqGrid({
                    data: data, 
                    datatype: "local",      // 必须设为 local
                   // heightStyle: "fill",
                    width:1200,
                    height:300,
                    colNames: [ "编号", "名称", "日期", "性别","stock","edittest1","edittest2" ,"edittest3" ,"edittest4" ,"edittest5" ,"edittest6" ,"edittest7" ,"edittest8" ,"edittest9" ,"edittest10"  ],
                    colModel: [
                        { name: "id" ,index:'id',editable:true,width:"150" },
                        { name: "name" ,index:'name',editable:true, editrules:{required:true},width:"150",formatter: 'showlink',formatoptions:{baseLinkUrl:"save.action",idName: "id", addParam:"&name=123"} },//定义超链接
                        { name: "date" ,index:'date',editable:true,width:"150", editrules:{
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
                        {name:'stock',index:'stock', width:60, editable: true,formatter: 'checkbox',
edittype:"checkbox",editoptions: {value:"1:0"},formatoptions:{disabled:false}},//对checkbox属性进行定义
                        { name: "edittest1" ,index:'edittest1',editable:true },
                        { name: "edittest2" ,index:'edittest2',editable:true },
                        { name: "edittest3" ,index:'edittest3',editable:true },
                        { name: "edittest4" ,index:'edittest4',editable:true },
                        { name: "edittest5" ,index:'edittest5',editable:true },
                        { name: "edittest6" ,index:'edittest6',editable:true },
                        { name: "edittest7" ,index:'edittest7',editable:true },
                        { name: "edittest8" ,index:'edittest8',editable:true },
                        { name: "edittest9" ,index:'edittest9',editable:true },
                        { name: "edittest10" ,index:'edittest10',editable:true },
                    ],
                   // rowNum:20,
                   // rowList:[10,20,30],
                    pager: '#pcelltbl',
                    sortname: 'id',
                     multiselect: false,
                  //  hiddengrid: true,
                     pgbuttons:false,
                    pginput:false,
                   // viewrecords:false,
                    sortorder: "asc",
                    caption:"Cell Edit Example",
                    forceFit : true,
                    cellEdit: true,
                    cellurl:"server.php",
                    cellsubmit: 'remote',
                    
                  
                    afterEditCell: function (id,name,val,iRow,iCol){
                        var $date,$name;
                         $date=$("#"+iRow+"_date");
                         $name=$("#"+iRow+"_name");
                        var tempdate= $date.val();
                        var tempname= $name.val();
                        console.log(iCol);
                 
                        if(name=="stock"){
                          
                          $("#"+iRow+"_stock").attr("checked",true);
                        };
                        if(name=='date') {
                            jQuery("#"+iRow+"_date").yhDatePicker().val(tempdate);
                        };
                        if(name=='name') {
                            jQuery("#"+iRow+"_name").yhDropDown({
                                            url: ctx + "/system/org/getTree",
                                            resizable: true,
                                            selectParent:true,                  //可以选择父节点
                                            post:"id",
                                           // width: 250 

                                        } ).val(tempname);;
                        }
                    }
                   
});
    //重写了新增和保存按钮的功能
jQuery("#celltbl").jqGrid('navGrid','#pcelltbl',{addfunc:function(){
                        allId=jQuery('#celltbl').jqGrid('getDataIDs').length;
                        tempId=allId+1;
                        var datarow =  { id: tempId, name: "", date: "", sex: "" ,stock:""};
                        var su=jQuery("#celltbl").jqGrid('addRowData',tempId,datarow);
                        tempId++;
                    },edit: false,delfunc: function(){
                      var gr = jQuery("#celltbl").jqGrid('getGridParam','selrow');
                       if( gr != null ) {$.post("server.php", { rowId: gr },function(){
                        jQuery("#celltbl").trigger("reloadGrid")
                       } );}
                        else alert("请选择要删除的行!");
                    },search:false,refresh:false});
                    
                    
		var allId,tempId;
//对input选择时进入编辑状态
         $("#celltbl input:checkbox").click(function(){
                var iRow=$(this).parents("tr").attr("id");
                //console.log($(this).parent());
                $("#celltbl").editCell(iRow, 4, true);
           });
//多表保存时的验证功能
jQuery("#Button").click( function(){
    var rowids=jQuery("#celltbl").jqGrid('getGridParam',"selrow");
    var rowData=jQuery('#celltbl').jqGrid('getRowData',rowids);

    var allId=jQuery('#celltbl').jqGrid('getDataIDs');
    outer:
    for(var rId=0; rId<allId.length; rId++){
      var rData=jQuery('#celltbl').jqGrid('getRowData',allId[rId]);
      var len=0,aEmp=[];
      for(e in rData){
        if (rowData.hasOwnProperty(e)) {
              var rowda=rData[e].replace(/"/g,"");
              if(rData[e].search(/div/i)==1){
                    inputId=$(rData[e]).find("input").eq(0).attr("id");
                }else {
                    inputId=$(rData[e]).attr("id");
                }
              if(e!="stock"){
                len++;//console.log($("#"+inputId).val());
               
                  if(rData[e]!="" && $("#"+inputId).val()!="" ){
                   aEmp.push(rData[e]);
                }
                 console.log(aEmp.length);
              };
           }   
      }
      if(aEmp.length>1 &&aEmp.length!=len){
           $.yhDialogTip.error( "必填项不能为空！","提示");
            break outer;
        }
    }


//最后编辑时没有触发保存事件，在点击外部保存按钮时手动提交保存
   //  var col="",colinput="",val ="",inputId="";
   //  for(x in rowData){//console.log(rowData[x]);//alert(rowData[x]);
   //    if (rowData.hasOwnProperty(x)) {
   //        var rowda=rowData[x].replace(/"/g,"");
   //        //rowda=rowda.string().tolocaleLowerCase();
   //        if(rowda.search(/input/i)==1||rowda.search(/div/i)==1){
   //        col=x;  //获得编辑行name值
   //        colinput=rowData[x];//获得编辑行的内容
         
   //        }
        
   //        // val = jQuery('#celltbl').getCell(rowids,col);//获得编辑行的内容
   //      }
   //        if(col!=""){
   //         val=colinput.replace(/"/g,"");//console.log(val);
   //          if(val.search(/div/i)==1){
   //              inputId=$(colinput).find("input").eq(0).attr("id");
   //          }else {
   //              inputId=$(colinput).attr("id");
   //          }
   //        }
   //        else if(x=="stock"){inputId=$("#"+rowids).find("input").attr("id");}//为复选框时用
   //     }
     
       
   
   //  console.log(inputId);
   
   //  var inputVa=$("#"+inputId).val();
   //  // if(inputVa==""){
   //  //     $.yhDialogTip.error( "不能为空！","提示");
   //  //     return false;
   //  // }
    
   // console.log(inputVa);//$(val).attr("id")
});
// var rowids=jQuery("#celltbl").jqGrid('getGridParam',"selrow");
// var inputId=$("#"+rowids).find("input").attr("id");alert(inputId);
// $("#"+inputId).click(function(){
//   if($("#"+inputId).attr("checked")){
  
// };
// })


jQuery("#Button2").click( function(){
     allId=jQuery('#celltbl').jqGrid('getDataIDs').length;
     tempId=allId+1;
     var datarow =  { id: tempId, name: " ", date: " ", sex: " " ,stock:" "};
     var su=jQuery("#celltbl").jqGrid('addRowData',tempId,datarow);
     tempId++;
});
//删除行
/*var gr = jQuery("#celltbl").jqGrid('getGridParam','selrow');//alert(gr);
                       if( gr != null ) {jQuery("#celltbl").jqGrid('delRowData',gr,{reloadAfterSubmit:false});}
                        else alert("请选择要删除的行!");
            });*/
 });
// 修改单元格的值 
// 前台语法： 
//    第一步：设置colmodel中editable:true, 
//    第二步：在jqGrid中设置cellurl:url和cellEdit:true; 
//       第三步：并且在jqGrid中设置cellsubmit:’remote’或者cellsubmit:clientArray前者为
// 可以与后台提交。后则为不能提交到后台。 
//       第四步： 重新为cellurl赋值。并且提交于后台。 
//       onCellSelect:function(rowid,celname,value,irow,icol){  
//      $("#listxianshi").jqGrid('setGridParam', 
// {cellurl:url+"?oper=3&scenid="+rowid}); 
// }, 关于后台： 
//      可直接接收传过去的id。还有通过request.getParamter(“colmodel中的
// name”)得到改变后的值。
 //设置全选checkbox title
            // var rowIds = jQuery("#plsfList").jqGrid('getDataIDs');
            // for(var k=0; k<rowIds.length; k++) {
            //    var curRowData = jQuery("#plsfList").jqGrid('getRowData', rowIds[k]);
            //    var curChk = $("#"+rowIds[k]+"").find(":checkbox");
            //    //curChk.attr('title', curRowData.modeName);   //给checkbox赋予额外的属性值
            // }
// 删除行
//{reloadAfterSubmit:false}
//             $("#dedata").click(function(){
//               var gr = jQuery("#delgrid").jqGrid('getGridParam','selrow');
//               if( gr != null ) jQuery("#delgrid").jqGrid('delGridRow',gr,{reloadAfterSubmit:false});
//               else alert("Please Select Row to delete!");
//             });
        </script>
    </head>
    <body>
        <div class="ui-layout-north">

        </div>
        <div  class="ui-layout-center">  
            <div class="centerBox">  
                    <table id="celltbl" >
            
                    </table> 

                    <div id="pcelltbl"></div>
              
                 <!--  <input id="Button2" type="button" value="增加行" />  <input id="Button" type="button" value="保存" />-->  
              </div >
        </div>
    </body>
</html>