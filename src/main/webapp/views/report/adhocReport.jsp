<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ include file="/common/taglibs.jsp"%>
<%
     String sql = (String)request.getAttribute("sql");
	 String json = (String)request.getAttribute("json");
	 System.out.println(json);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%@ include file="/common/meta.jsp" %>

<script type="text/javascript" src="${ctx}/views/report/adhoc.js"></script>
</head>
<body>
<div id="mainContent" class="ui-layout-center" >
	
	<div class="ui-layout-center">
		<table id="list"></table>
		<div id="pager"></div>
	</div>
	
	
</div>

<script type="text/javascript">
var sql='<%=sql%>';
var json='<%=json%>';
YHUI.use("yhFormField yhLayout yhGrid", function() {
$(document.body).yhLayout({
	//north__resizable: false
});


AdhocReport.initHeader();
AdhocReport.initGrid();
});
</script>
</body>
</html>