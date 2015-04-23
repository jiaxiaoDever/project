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
<div class="yhui-header ui-layout-north ui-helper-clearfix">头部区</div>
<div class="ui-layout-west">左侧栏</div>
<div class="ui-layout-center">中心区</div>
<script type="text/javascript">
	YHUI.use( "yhLayout", function(){			
		$(document.body).yhLayout();			
	});		
</script>
</body>
</html>
