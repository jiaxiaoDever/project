<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>内嵌iframe 上-左-上下布局实例</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
</head>
<body>
<div class="yhui-header ui-layout-north ui-helper-clearfix">
	头部区
</div>
<div class="ui-layout-west">		
	<iframe src="" frameborder="0" class="ui-layout-content"></iframe>
</div>
<div id="mainContent" class="ui-layout-center" >
	<div class="ui-layout-center" style = 'overflow:hidden;'>
		<iframe src="" frameborder="0" class="ui-layout-content"></iframe>				
	</div>
	<div class="ui-layout-south">
		<iframe src="" frameborder="0" class="ui-layout-content"></iframe>
	</div>
</div>
<script type="text/javascript">
	YHUI.use( "yhLayout", function(){
		$(document.body).yhLayout({
			north: {
				size: 65,
				spacing_open: 0,
				spacing_closed: 0
			},
			west: {
				size: 240
			},
			addBorder: true
		});

		$("#mainContent").yhLayout({
			south: {
				size: 0.5
			}
		});
		
		$("iframe.ui-layout-content").css("width", "100%").eq(1).attr( "src", "base-content.jsp" ).end()
										.eq(0).attr( "src", "base-content.jsp" ).end()
										.eq(2).attr( "src", "base-content.jsp" );
	});
</script>
</body>
</html>