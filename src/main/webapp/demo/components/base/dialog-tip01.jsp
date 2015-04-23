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
<style type="text/css">
		#feedback { font-size: 1.4em; }
		#selectable .ui-selecting { background: #FECA40; }
		#selectable .ui-selected { background: #F39814; color: white; }
		#selectable { list-style-type: none; margin: 0; padding: 0; width: 60%; }
		#selectable li { margin: 3px; padding: 0.4em; font-size: 1.4em; height: 18px; }
        .info h1 { font-size: 20px; }
        .info h1, .info p { margin: 10px 30px; }
        .info p { text-indent: 2em; }
	</style>
</head>
<body>
    <div class="info">
        <h1>状态对话框 ( yhDialogTip )</h1>
        <p>这是一个静态方法，无需任何 html 结构就可以在页面生成“确认、错误、警告”三种状态对话框。</p>
        <p>下面是一般用法，更高级的配置可以参见<a href="dialog-tip02.html">这里</a>。</p>
        <p>本 demo 所在路径， Components/base/yhDialogTip.jsp ， 使用文档。</p>
    </div>
	<div class="button_temp">
		标题默认：警告，确认，错误。<br>
		<button>警告</button>
		<button>确认</button>
		<button>错误</button><br />

		<br>
		标题可自定义<br>
		<button>警告2</button>
		<button>确认2</button>
		<button>错误2</button><br />

		<br><br>
		此按钮结合下面列表操作<br>
		<button>删除选中</button>
	</div>
	<div>
		<ol id="selectable">
			<li class="ui-widget-content">Item 1</li>
			<li class="ui-widget-content">Item 2</li>
			<li class="ui-widget-content">Item 3</li>
			<li class="ui-widget-content">Item 4</li>
			<li class="ui-widget-content">Item 5</li>
			<li class="ui-widget-content">Item 6</li>
			<li class="ui-widget-content">Item 7</li>
		</ol>
	</div>
<script type="text/javascript">
YHUI.use( "yhDialogTip", function() {	
	//语法很简单，我就不多说了。
	//alert，error和confirm
	$( document.body ).on("click", "button", function(){
		$(this).index("button") == 0 && $.yhDialogTip.alert( "抱歉！提交失败，请稍后重试或联系管理员。" );
		$(this).index("button") == 1 && $.yhDialogTip.confirm( "恭喜您！提交成功。" );
		$(this).index("button") == 2 && $.yhDialogTip.error( "确定删除？删除后将不能恢复。" );
		//下面都是传入两个参数，第二个是标题
		$(this).index("button") == 3 && $.yhDialogTip.alert( "抱歉！提交失败，请稍后重试或联系管理员。" , "提示" );
		$(this).index("button") == 4 && $.yhDialogTip.confirm( "恭喜您！提交成功。", "标题可自定义" );
		$(this).index("button") == 5 && $.yhDialogTip.error( "确定删除？删除后将不能恢复。", "删除" );
		
		//做一个复杂点的例子
		if ( $(this).index("button") == 6 ) {
			var $li = $("#selectable > li.ui-selected");
			if ( !$li.length ) return $.yhDialogTip.alert( "请“选择行”进行删除。","提示" );
			
			//这里的第二个参数是个函数，就不会做为标题了，而是关闭时执行的回调函数。
				//当然，也可以传入三个参数 $.yhDialog.alert( string, string, fun );
			$.yhDialogTip.alert( "确认删除？删除后将不能恢复。","提示", function( e ) {
				$li.remove();
				$( "#selectable" ).selectable( "refresh" );
				//setTimeout(function(  ) {$(this).dialog( "close" )},3000);
               // $.yhDialogTip.confirm( "恭喜您！删除成功。" ,"提示"); //嵌套使用
               $.yhDialogTip.confirm("恭喜您！删除成功。" ,"提示", function( e ){ 
               		$( this ).dialog( "close" );
               		});                
			});

		}
	});	
	
	$( "#selectable" ).selectable();


});
</script>
</body>
</html>


