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
		#triggerTabs li{ padding:5px; margin:3px 0; background-color:#DDD; -moz-transition:0.5s; -webkit-transition:0.5s; transition:0.5s; }
		#triggerTabs li:hover{ background-color:#FFF; }
		.table td{ border:1px solid black; }
	</style>
</head>
<body>
    <div class="yhui-header ui-layout-north ui-helper-clearfix">		
		<!--#include virtual="/yhuihtml/commom/header.html" -->
	</div>
	<div class="ui-layout-west">
		<ul id = 'triggerTabs'>
			<li><a href="tabs.html"></a>1</li>
			<li><a href="tabs-scroll.html"></a>2</li>
			<li><a href="tabs-yhtabs-plain.html"></a>3</li>
			<li><a href="dialog.html"></a>4</li>
			<li><a href="yhwindow.html"></a>5</li>
		</ul>
	</div>
	<div class="ui-layout-center">
		<div class="yhui-tabs-header">
			<div class = "yhui-tabs-header-inner">
				<ul>
					<li><a href="#tabs-1">动态添加选项卡</a></li>
				</ul>
			</div>
		</div>
		<div class = "ui-layout-content">
			<div id="tabs-1">
				<p>动态添加选项卡</p>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var Addtab = {};     //创建ADDTAB对象，这样可以有些的避免变量的重名问题。
		Addtab.initTab = function( selector ){//挂一个方法，初始化昱辉选项卡。
			Addtab.tabs = $( selector ).eq(0).yhTabs({
				frame: true
			});
		};
		YHUI.use( "yhLayout yhTabs", function() { //引入对应的模块
			$(document.body).yhLayout({
				north: {
					size: 65,
					spacing_open: false
				},
				addBorder: true
			});
			
			Addtab.initTab( "div.ui-layout-center" );
			
			$( "#triggerTabs" ).on( "click", "li", function( e ){ //给添加选项卡的触发元素绑定事件
				var url = $( this.children[0] ).attr( "href" );//获取url
				//关键，调用yhTabs的addTab方法。 .yhTabs( "addTab", $dom, url, $parent );
					//参数四个，分别是：
					// 字符串"addTab"，yhTabs的addTab方法。大家应该和属性这种方法模式了。
					//$dom，所点击的dom元素jQuery对象，我这里是一个一个的 $( li ), 也就是$( this ）
					//$parent, 所点击的dom元素的父元素jQuery对象我这里是 li 的父元素， $( ul )
                Addtab.tabs.yhTabs( "addTab", $(this), url );
			});
		});
	</script>
</body>
</html>
