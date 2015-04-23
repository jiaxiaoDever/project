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
<div class="ui-layout-center">
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


<script type="text/javascript">
	YHUI.use( "yhLayout yhLoading", function() {
		$(document.body).yhLayout({

		});			

		$("div.ui-layout-center").eq(0).tabs({
            level: 2
        });
	});
</script> 
</body>
</html>
