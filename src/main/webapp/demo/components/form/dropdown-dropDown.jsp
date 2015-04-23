<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Document</title>
<meta name="description" content="">
<meta name="keywords" content="">
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
</head>
<body>
    <form id = "field" class = "yhui-formfield" >
		<table>
			<tr>
				<td colspan = "4">普通下拉框：</td>
			</tr>
			<tr>
				<td>默认：</td>
				<td><input  type="text" id="text1"/>
                    <button id = "button1" style = "display: none;">点击异步置换节点</button></td>
				<td>可选父节点：</td>
				<td><input  type="text" id="text2"/> 华丽丽地拖拽放大</td>
			</tr>
			<tr>
				<td colspan = "4">复选框下拉框</td>
			</tr>
			<tr>
				<td>默认：</td>
				<td><input  type="text" id="text3"/></td>
				<td><button id = 'button'>控制禁用</button></td>
				<td><input type="text" id="text4" /></td>
			</tr>
			<tr><td>&nbsp;</td><td></td><td></td><td></td></tr>
			<tr>
				<td>列表：</td>
				<td><input type="text" id="text5" /></td>
				<td>顶层父节点唯一：</td>
				<td><input type="text" id="text6" /></td>
			</tr>
			<tr>
				<td colspan = "4">查看对应隐藏域的值：</td>
			</tr>
			<tr>
				<td><button id = 'btn1'>1</button></td>
				<td><input type="text" /></td>
				<td><button id = 'btn2'>2</button></td>
				<td><input type="text" /></td>
			</tr>
			<tr>
				<td><button id = 'btn3'>3</button></td>
				<td><input type="text" /></td>
				<td><button id = 'btn4'>4</button></td>
				<td><input type="text" /></td>
			</tr>
			<tr>
				<td><button id = 'btn5'>5</button></td>
				<td><input type="text" /></td>
				<td><button id = 'btn6'>6</button></td>
				<td><input type="text" /></td>
			</tr>
			<tr>
				<td colspan = "4">两级联动（单选）:</td>
			</tr>
			<tr>
				<td>一级：</td>
				<td><input type="text" id = "text7" /></td>
				<td>二级：</td>
				<td><input type="text" id = "text8" /></td>
			</tr>
			<tr>
				<td><button id = 'btn7'>7</button></td>
				<td><input type="text" /></td>
				<td><button id = 'btn8'>8</button></td>
				<td><input type="text" /></td>
			</tr>
		</table>
	</form>
	<script type="text/javascript">
		YHUI.use("yhLayout yhDropDown yhFormField zTree", function() {

			$("#text1").yhDropDown({
				url: "${ctx}/jsp/dropdown.jsp",     //获取json的路径，暂时只支持json格式。
				post: "id",                         //json中的id的值也会被传到后台
				postData: { test: "anhui" },        //可以把值设为 "guangdong" 试试
				noChild: true
			}).yhDropDown("parseDrop");
			
			$("#text2").yhDropDown({
				url: "treeData.txt",
                resizable: true,
				selectParent:true,                  //可以选择父节点
				post:"id"
			});
			
			$("#text3").yhDropDown({
				url: "treeData.txt",
				checkbox:true,                      //出现复选框
				autocomplete: true,
				post:"id",
				hiddenId:"hidden"                   //可以自定义隐藏域的id
			});
			
			//禁用状态的下拉框
			$("#text4").yhDropDown({
				url: "treeData.txt",
				checkbox:true,
				disable:true,                       //disable，设置为 true时， 初始化就禁用下拉框。默认false。
				post:"id",
				showPath: true
			});
			
			$("#text6").yhDropDown({
				url: "treeData.txt",
				checkbox:true,
				selectParent:true,
				post:"id"
            });

			$("#text5").yhDropDown({
				url: "treeData2.txt",
				checkbox:true,
				noChild:true,                           //没有子节点时设置
				selectAllSelected:true,                 //选中全选，selectAll为true时生效
				post:"id",
				width:250,                              //定制下拉 div 的宽度，noChild为true时生效。默认值……你懂的。
				inputWidth: 220                         //input 本身的宽度
			}).yhDropDown("parseDrop");
			
		
			
			//手写一些数据
			var firstLevel = [
					{ name:"广东", id : 0 },
					{ name:"安徽", id : 1 },
					{ name:"江西", id : 2 }
				],
				secondLevel = [
					{ name:"广州", id : 3, pId : 0 },
					{ name:"深圳", id : 4, pId : 0 },
					{ name:"东莞", id : 5, pId : 0 },
					{ name:"合肥", id : 6, pId : 1 },
					{ name:"芜湖", id : 7, pId : 1  },
					{ name:"安庆", id : 8, pId : 1  },
					{ name:"南昌", id : 9, pId : 2  },
					{ name:"九江", id : 10, pId : 2  },
					{ name:"赣州", id : 11, pId : 2  }
                ],
                nothing = [{ name: "先选上级", noCheck: true}],
                $text8 = $("#text8");
			
			$("#text7").yhDropDown({
				json:firstLevel,
				post:"id",
				noChild:true,
				onClick: function( e, yhui ) {
                    var nodes = $.grep( secondLevel, function( node ) { return node.pId === yhui.node.id; });
                    if ( !nodes.length ) nodes = nothing;
                    $text8.val("").yhDropDown({
                        customContent: "请选择",
                        json : nodes
                    });
                }
            });

            $text8.yhDropDown({
                json: nothing,
                customContent: "",                  // 单选情况下，自定义第一个节点的内容，默认值“请选择”
                post: "id",
                noChild: true
            });


            $("#field")
                    .yhFormField({
                        hoverable: true,
                        haveTitle: true
                    })
                    .on( "click", "button", function(e) {   // 利用事件委托对按钮的处理
                        switch ( this.id ) {
                            case "button":
                                    var $text4 = $("#text4");
                                    $text4.yhDropDown("option", "disable") ? $text4.yhDropDown( "enable" ) : $text4.yhDropDown( "disable" );
                                break;
                            case "button1":
                                    $("#text1" ).yhDropDown({
                                        postData: {
                                            test: "guangdong"
                                        }
                                    });
                                break;
                            default:
                                var $txt = $(this).parent().next().children(":text" ),
                                        $hidden = $( "#text" + this.id.match(/\d+$/) ).siblings(":hidden");
                                $txt.val( $hidden.val() !== "" ? $hidden.val() : "请选一个好吧！"  );
                        }
                    })
                    .on( "yhdropdownhide", ":yhui-yhdropdown", function() {
                        if ( this.id === "text1" ) {
                            $( "#button1" ).show();
                        }
                    })
                    .on( "submit", function() {
                        return false;
                    });
        });
	</script>
</body>
</html>
