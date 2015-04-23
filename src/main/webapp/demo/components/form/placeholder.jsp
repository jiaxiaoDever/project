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
<div style="margin:20px;">
	<input id="holder" type="text" class="yhui-form-text" placeholder="初始化的默认文本">
</div>

<script type="text/javascript">
	YHUI.use( "yhPlaceholder", function() {
		$( "#holder" ).yhPlaceholder();		
	});
</script>
</body>
</html>
