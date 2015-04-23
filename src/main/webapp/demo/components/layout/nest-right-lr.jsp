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
<div class="yhui-header ui-layout-north ui-helper-clearfix">头部区</div>
<div class="ui-layout-west">左侧栏</div>
<div id="mainContent" class="ui-layout-center" >
	<div class="ui-layout-west">
		嵌套-左
	</div>
	<div class="ui-layout-center">
		嵌套-右
	</div>
</div>
<script type="text/javascript">
	YHUI.use( "yhLayout yhToolbar zTree", function(){
		$(document.body).yhLayout({
			north__resizable: false
		});
		$("#mainContent").yhLayout({
			west: {
				size: 0.4
			}
		});	
	});
</script>
</body>
</html>