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
    <button>点击</button> 点击以编程的方式(programmatically)打开第二个面板，并重复执行子页面上的方法
	<div id="yhSwitchPanel">
		<h3 data-type = "/yhuihtml/commom/text.html" ><a href="#">自动加载iframe1</a></h3>
		<div>
			
		</div>
		
		<h3 data-type = "/yhuihtml/commom/text.html"  ><a href="#">自动加载iframe2</a></h3>
		<div>
			
		</div>
		
		<h3 data-type = "/yhuihtml/commom/text.html" ><a href="#">异步加载html3</a></h3>
		<div>
			
		</div>
		
		<h3 data-type = "/yhuihtml/commom/text.html" ><a href="#">异步加载json并手动处理4</a></h3>
		<div>
			
		</div>
		
		<h3><a href="#">普通面板5</a></h3>
		<div>
			<p>
				Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet
				purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor
				velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In
				suscipit faucibus urna.
			</p>
			<p>
				Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet
				purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor
				velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In
				suscipit faucibus urna.
			</p>
		</div>
		
		<h3><a href="#">面板6</a></h3>
		<div>
			<p>
				Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet
				purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor
				velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In
				suscipit faucibus urna.
			</p>
			<p>
				Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet
				purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor
				velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In
				suscipit faucibus urna.
			</p>
		</div>
		
		<h3><a href="#">面板7</a></h3>
		<div>
			<p>
				Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet
				purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor
				velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In
				suscipit faucibus urna.
			</p>
			<p>
				Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet
				purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor
				velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In
				suscipit faucibus urna.
			</p>
		</div>
		
		<h3><a href="#">面板8</a></h3>
		<div>
			<p>
				Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet
				purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor
				velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In
				suscipit faucibus urna.
			</p>
			<p>
				Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet
				purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor
				velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In
				suscipit faucibus urna.
			</p>
		</div>
	</div>	
	<script type="text/javascript">
		YHUI.use( "yhSwitchPanel yhFormField", function() {
			//小小地谈谈 昱辉可开关的面板的用法
				//大家可以去掉注释看看
			$( "#yhSwitchPanel" ).yhSwitchPanel({
				active: 7,    //设置打开第几个面板，从0开始。可以传入一个数字，或者一个数组
				
				/*beforeActivate: function( e, yhui ) {  //回调函数，打开面板之前触发。当返回值为false时，将不会打开面板。
					if ( yhui.header.index( "h3" ) === 1 ) {  //这里是让第二个面板打不开。
						$.yhui.log( "no" );
						return false;
					}
				},
				activate: function( e, yhui ) {  //回调函数，打开面板之后触发。
					$.yhui.log( yhui );
				}
				beforeFold: function( e, yhui ) {  //回调函数，折叠面板之前触发。当返回值为false时，面板将不可折叠。
					$.yhui.log( yhui );
					return false;
				},
				fold: function( e, yhui ) {   //回调函数，折叠面板之后触发。
					$.yhui.log( yhui );
				}*/
				load: function( e, data ) {   //当面板内容为异步加载的html时，数据获取成功时触发。
					$("#switchPanel").yhFormField();  //将加载的html初始化为 formField。
				},
				
				//当面板内容为异步加载的json时，默认行为是将获取的字符串append进panel。
				//这个函数就是在 append 之前触发，返回值为false时，会阻止上述默认行为。
				beforeAppend: function( e, yhui ) {  
					$.yhui.createTable( yhui.panel, yhui.data );   //这里将json打印成一个表格并放入面板中。
					return false;
				},

				create: function( e, yhui ) {  //回调函数，组件初始化完成后立马执行。
					
					//两个方法 hideHeader 和 showHeader
					 //hideHeader
					 		//$().yhSwitchPanel( "hideHeader", index, removeFlag )
					 		 //三个参数
					 		 	//hideHeader，方法名
					 		 	//index 需要隐藏的标题栏索引值，可以是单个的数值，也可以是一个数组
					 		 	//removeFlag，布尔值，隐藏后是否删除dom结构。为true时，删除。可以省略。破坏性操作，不可恢复。
					 //showHeader
						 	//$().yhSwitchPanel( "hideHeader", index, removeFlag )
						 		 //三个参数
						 		 	//showHeader，方法名
						 		 	//index 需要显示的标题栏索引值，可以是单个的数值，也可以是一个数组
						 		 	//openPanelFlag，布尔值，显示出标题栏后是否打开对应的面板。可以省略。为true时，打开。
					
					//可以去除注释看看效果
					//$(this).yhSwitchPanel( "hideHeader", 1 );  

					
				}
			
			});

			$("button").on( "click", function() {
				$("#yhSwitchPanel").yhSwitchPanel( "showHeader", 1, true, function() {
					alert( "这个子页面上jquery的版本：" + this.contentWindow.$.fn.jquery );
					//$.yhui.log( this );
				});
				// $("#yhSwitchPanel").yhSwitchPanel( "activate", [1,2] );
			});
		});
	</script>
</body>
</html>
