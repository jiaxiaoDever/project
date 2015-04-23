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
	<div id="tabs">
	    <ul>
	        <li><a href="#tabs1">一般模式1</a></li>
	        <li><a href="#tabs2">一般模式2</a></li>
	    </ul>
	    <div id="tabs1"></div>
	    <div id="tabs2"></div>
	</div>
</div>
	
<script type="text/javascript">
	YHUI.use( "yhLayout yhTabs", function() {
		$(document.body).yhLayout({	}); 
		$("#tabs").yhTabs({ 
			level: 2	//第2层级的tabs视觉弱化。让2个层级的tabs视觉易于区分。
		});
	});
</script> 

</body>
</html>
