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
   	<div id="toolbar" class = "yhToolbar"></div>
   	<br> <br>
	<div id="yhButton"></div>
	<br>
	<div class="button_temp"><button>启用重置</button></div>
	<br>
    <div id="toolbar2" class="yhToolbar"></div>
    <script type="text/javascript">
		YHUI.use("yhToolbar yhButton yhDialogTip", function() {
			
			$("#toolbar").yhToolbar({//toolbar改造自一个插件，所以挖掘的不是很深
				//items就是选项了，如新增、修改什么的。注意，都是可选的。
				items : [{
						type : 'button',
						text : '新增',
						bodyStyle : 'new',//可以理解为图标
						useable : 'T',//是否禁用，T不禁用，F禁用
						handler : function () {//单击触发
							alert( this.innerHTML );
						}
					}, {
						type : 'button',
						text : '修改',
						bodyStyle : 'edit',
						useable : 'T',
						handler : function () {}
					}, {
						type : 'button',
						text : '删除',
						bodyStyle : 'delete',
						useable : 'T',
						handler : function () {}
					}, '-', {      //这里的小横线就是分隔符
						type : 'button',
						text : '保存',
						bodyStyle : 'save',
						useable : 'T'
					}, {
						type : 'button',
						text : '另存',
						bodyStyle : 'saveAs',
						useable : 'T'
					}, '-', {
						type : 'button',
						text : '刷新',
						bodyStyle : 'refresh',
						useable : 'F'
					}, {
						type : 'button',
						text : '撤销',
						bodyStyle : 'cancel',
						useable : 'T'
					}, '-', {
						type : 'button',
						text : '后退',
						bodyStyle : 'back',
						useable : 'T'
					},{
						type : 'button',
						text : '前进',
						bodyStyle : 'next',
						useable : 'T'
					},'-',{
						type : 'button',
						text : '导入',
						bodyStyle : 'import',
						useable : 'T'
					},{
						type : 'button',
						text : '导出',
						bodyStyle : 'export',
						useable : 'T'
					},{
						type : 'button',
						text : '打印',
						bodyStyle : 'print',
						useable : 'T'
					},'-',{
						type : 'button',
						text : '查询',
						bodyStyle : 'search'
					}
				]
			});
			
			var $btn = $("#yhButton").yhButton({
				align:"left+100",  //按钮的对齐方式，默认居中。可选值left, right
				//space: 100,		//数值型，不要写成字符串。 控制按钮之间的距离，不推荐使用这个参数。 
				items: [  //目前为止提供八种按钮，应该够用了吧。
					{
						type: "submit",  //类型，不解释。
						onClick: function( e, form, holderDiv, btnObj ) { //回调函数，单击按钮时触发。
							//三个参数
								// e, 事件对象，不解释。
								// form, 包含按钮的 form 元素。
								// holderDiv, 包含按钮的div容器。
								// btnObj, 实例化的按钮对象
							//可以取消下面的注释打印看看。	
							//$.yhui.log( e );
							//$.yhui.log( form );	
							//$.yhui.log( holderDiv );	
							//$.yhui.log( btnOjb );	
							$.yhDialogTip.confirm( this.lastChild.data, "click触发" );

							//this.lastChild.data 的解释
								//这里的this是a元素。他的lastChild是一个文本节点，文本节点有一个data属性，包含着文本字符串。
						}
					},
					//重置按钮有点特殊，它自带一个click事件。
						//假如初始化事没有属性“onClick”，那么就会促发默认事件，将表单重置。
						//如果有属性“onClick”，就像下面这种情况，会覆盖默认事件。
					{
						type: "reset",
						disabled: true	//初始化的时候生成但禁用按钮，onClick不会执行。
						/*onClick: function( e, form, holderDiv, btnObj ) {
							$.yhDialogTip.confirm( this.lastChild.nodeValue, "click触发" );
						}*/
					},
					{
						type: "cancel",
						onClick: function( e, form, holderDiv, btnObj ) {
							$.yhDialogTip.confirm( this.lastChild.nodeValue, "click触发" );
						}
					},
					{
						type: "confirm",
						onClick: function( e, form, holderDiv, btnObj ) {
							//$.yhDialogTip.confirm( this.lastChild.nodeValue, "click触发" );
							//$.yhui.log( holderDiv );
							$.yhui.log( "百度" );
							parent.Homepage.tabs.yhTabs( "addTab", $(this), "http://www.baidu.com", holderDiv );
						}
					},
					{
						type: "save",
						onClick: function( e, form, holderDiv, btnObj ) {
							$.yhDialogTip.confirm( this.lastChild.nodeValue, "click触发" );
						}
					},
					{
						type: "close",
						onClick: function( e, form, holderDiv, btnObj ) {
							$.yhDialogTip.confirm( this.lastChild.nodeValue, "click触发" );
						}
					},
					{
						type: "search",
						onClick: function( e, form, holderDiv, btnObj ) {
							$.yhDialogTip.confirm( this.lastChild.nodeValue, "click触发" );
						}
					},
					{
						type: "back",
						onClick: function( e, form, holderDiv, btnObj ) {
							$.yhDialogTip.confirm( this.lastChild.nodeValue, "click触发" );
						}
					}
				]
			});
			
			//$btn.yhButton( "option", "align", "center-200");    //可以动态改变align
			//$btn.yhButton( "option", "space", 100 ); //可以动态改变space
			//$.yhui.log( $btn.yhButton( "isDisable", "reset" ) );  //可以随时判断对应的按钮是否可用
			//$.yhui.log( $btn.yhButton( "isDisable", "submit" ) );

			$( "button:first" ).on( "click", function( e ) {
				if ( this.innerHTML === "启用重置" ) {
					$btn.yhButton( "enable", "reset" );  //enable方法
					this.innerHTML = "禁用重置";
				} else {
					$btn.yhButton( "disable", "reset" );
					this.innerHTML = "启用重置";
				}
			});


            $( "#toolbar2").yhToolbar({
                items: [
                    {
                        type : "button",
                        text : "查找",
                        bodyStyle : "search"

                    }
                ],
                //这个函数的作用，是用来自定义dom的。
                //下面是在工具栏的右侧加一个“采数时间”的表格。
                customDom: function( $div ) {
                    $div.css( "position", "relative" );
                    $("<table class = 'toolBarTable' ><tr><td>采数时间9:00</td><td>下次采数11:00</td></tr></table>").css({
                        position: "absolute",
                        right:0,
                        top:"8px"
                    }).appendTo( $div );
                }
            });
		});
	</script> 
</body>
</html>
