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
<style type = "text/css">
        #tabs-east-1, #tabs-east-2 { padding: 0; }
        #tabs-east-2 { width: 100%; }
</style>
</head>
<body>
   <div class="ui-layout-west">
		<ul>
			<li><a href="#tabs-1">标题一</a></li>
			<li><a href="#tabs-2">标题二</a></li>
			<li><a href="#tabs-3">标题三</a></li>
		</ul>
		<div id="tabs-1">
			<p>面板一</p>
		</div>
		<div id="tabs-2">
            <p>面板二</p>
		</div>
		<div id="tabs-3">
            <p>面板三</p>
		</div>
	</div>
	
	<div class="ui-layout-center">
		<ul>
			<li><a href="#tabs-center-1">标题一</a></li>
			<li><a href="#tabs-center-2">标题二</a></li>
		</ul>
		<div id="tabs-center-1">
			<!--#include virtual="/yhuihtml/commom/text.html" -->
		</div>
		<div id="tabs-center-2">
            <p>内容二</p>
		</div>
	</div>
	
	<div class="ui-layout-east">
		<div id = "fillSpace">
			<ul>
				<li><a href="#tabs-east-1">标题一</a></li>
				<li><a href="#tabs-east-2">loading 效果</a></li>
			</ul>
			<div id = "tabs-east-1">
				自动改变高宽充满容器，就是那么简单。
				<br /> 和中间的选项卡对比才能明白自适应高宽的效果是什么样的。
				<!--#include virtual="/yhuihtml/commom/text.html" -->
			</div>
			<iframe id="tabs-east-2"  frameborder="0"></iframe>            
		</div>
	</div>
	<script type="text/javascript">
		YHUI.use( "yhLayout yhLoading", function() {
			$(document.body).yhLayout({
				east: {
					size: .33
				},
				west: {
					size: .33
				},
				center: {
					onresize: function() {
						$("#fillSpace").tabs( "refresh" );
					}
				}
			});
			
			$("div.ui-layout-center").eq(0).tabs({
                level: 2    // 嵌套在主页面中，加个层级
            });//普通选项卡
			$("div.ui-layout-west").eq(0).tabs({
                level: 2
            });
			$("#fillSpace").tabs({
                level: 2,
				heightStyle: "fill",//充满父容器。这个的Dom结构有些不同，注意了。
                create: function() {
                    $( this ).yhLoading({
                        autoOpen: false
                    });
                },
                activate: function( e, ui ) {
                    if ( ui.newPanel[0].id === "tabs-east-2" && !ui.newPanel.attr("src") ) {
                        var that = $( this ).yhLoading("open");
                        ui.newPanel
                            .attr("src", "/yhuihtml/commom/text.html" )
                            .on( "load", function() {
                                that.yhLoading( "destroy" );
                            });
                    }
                }
			});  
		});
	</script> 
</body>
</html>
