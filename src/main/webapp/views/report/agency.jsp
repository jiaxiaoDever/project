<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/meta.jsp"%>
<title>待办信息</title>
<script type="text/javascript"
	src="${ctx}/views/report/${__fileName }.js"></script>
</head>
<body>


	<div id="mainContent" class="ui-layout-center">
		<ul>
			<li><a href="#tabs-1">我的待办</a></li>
			<li><a href="#tabs-2">我的已办</a></li>
		</ul>
		<div id="tabs-1">
			<div id="toolbar" class="yhui-toolbar"></div>
			<table id="list"></table>
			<div id="pager"></div>
		</div>
		<div id="tabs-2">
			<table id="list1"></table>
			<div id="pager1"></div>
		</div>

	</div>
	<div id="editForm"></div>
</body>
</html>