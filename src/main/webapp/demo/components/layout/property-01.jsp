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
<style>
	.ui-layout-toggler{background-color: #54bfdf;}
	.ui-layout-north,.ui-layout-center{ overflow: hidden;}
	.block{padding:20px;}
	.block p{padding:4px;}
</style>
</head>
<body>
<div class="yhui-header ui-layout-north ui-helper-clearfix">头部区</div>
<div class="ui-layout-west">左侧栏</div>
<div class="ui-layout-center">
	<div class="ui-layout-content">
	<div class="block">
		<h2>属性</h2>
		<p>请不要认为此页面展示怪异或丑陋。</p>
		<p>此页面夸张地设置了所有属性。</p>	
		<pre class="brush:js">
		$(document.body).yhLayout({ 
			west: {
		        closable: false,     // 左侧面板不可关闭
		        initClosed: false,   // 左侧面板初始化就是打开的
		        maxSize: 300,     	// 左侧面板最大 300px
		        minSize: 100,     	// 左侧面板最大 100px
		        resizable: true,    // 左侧面板可以拖动改变大小
		        size: 200,     		// 左侧面板初始化的 size 为 200px
		        slidable: false,    // 左侧面板没有滑动效果
		    },
		    east: {
		        slidable: true,    // 左侧面板没有滑动效果
		        spacing_closed:50,	//左右伸缩栏关闭时的尺寸
		        spacing_open:20,	//左右伸缩栏打开时的尺寸
		        togglerLength_closed:50,	//上下伸缩栏关闭时的尺寸
		        togglerLength_open:20,		//上下伸缩栏打开时的尺寸
		    }
		});		
		</pre>
	</div>
	<div class="block">
		<h2>方法</h2>
		<button id="closeleft">关闭左侧面板</button>
		<button id="openleft">打开左侧面板</button>
		<button id="toggle">展开/关闭左侧面板</button>
		<pre class="brush:js">
		var $body=$(document.body).yhLayout({ 
			...
		});
		$("#closeleft").on( "click", function() {
		    	$body.yhLayout( "close", "west" );      //  点击按钮关闭左侧面板,若west设置了closable为false，则此方法无效。
			});	
		$("#openleft").on( "click", function() {
		    	$body.yhLayout( "open", "west" );      //  点击按钮展开左侧面板。
			});
		$("#toggle").on( "click", function() {
		    	$body.yhLayout( "toggle", "west" );      //  点击按钮展开左侧面板。
			});
		</pre>
	</div>	
	</div>	
</div>
<div class="ui-layout-east">右侧栏</div>
<script type="text/javascript">
YHUI.use( "yhLayout", function(){			
	var $body=$(document.body).yhLayout({ 
			west: {
		        // closable: false,   // 左侧面板不可关闭
		        initClosed: false,   // 左侧面板初始化就是打开的
		        maxSize: 300,     	// 左侧面板最大 300px
		        minSize: 100,     	// 左侧面板最大 100px
		        resizable: true,    // 左侧面板可以拖动改变大小
		        size: 200,     		// 左侧面板初始化的 size 为 200px
		        slidable: false,    // 左侧面板没有滑动效果
		    },
		    east: {
		        slidable: true,    // 左侧面板没有滑动效果
		        spacing_closed:50,	//左右伸缩栏关闭时的尺寸
		        spacing_open:20,	//左右伸缩栏打开时的尺寸
		        togglerLength_closed:50,	//上下伸缩栏关闭时的尺寸
		        togglerLength_open:20,		//上下伸缩栏打开时的尺寸
		    }		   
		});
	$("#closeleft").on( "click", function() {
	    	$body.yhLayout( "close", "west" );      //  点击按钮关闭左侧面板,若west设置了closable为false，则此方法无效。
		});	
	$("#openleft").on( "click", function() {
	    	$body.yhLayout( "open", "west" );      //  点击按钮展开左侧面板。
		});
	$("#toggle").on( "click", function() {
	    	$body.yhLayout( "toggle", "west" );      //  点击按钮展开左侧面板。
		});
 });	
	
</script>
</body>
</html>
