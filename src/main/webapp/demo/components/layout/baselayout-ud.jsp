<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>		
	<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
</head>
<body>
	<div class="yhui-header ui-layout-north ui-helper-clearfix">
		头部区
	</div>
	<div class = 'ui-layout-center' >		
		<div class="ui-layout-content">
			内容区
		</div>
	</div>
	<script type="text/javascript">
		YHUI.use("yhLayout", function() {
			$(document.body).yhLayout();			
		});
	</script>
</body>
</html>