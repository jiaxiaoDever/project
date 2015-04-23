<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!doctype html>
<html>
<head>
<title>机构管理</title>
<%@ include file="/common/meta.jsp"%>
<script type = "text/javascript" src="${ctx}/static/common/DefaultView.js"></script>
<script type="text/javascript" src="${ctx}/views/system/js/${__fileName }.js"></script>
</head>
<body>

	<div class="ui-layout-west">
		<div class="yhui-west-header">
			<div id = "bar" class="yhui-searchbox"></div>
		</div>
		<div class="yhui-west-content">
			<ul id="leftTree" class="ztree"></ul> 
		</div>
	</div>

    <div id="mainContent" class="ui-layout-center" >
		<!--  <div class="ui-layout-north">
			<form id="searchForm" class="yhui-formfield noborder">
				<table>
					<tr>
						<td>机构名称：</td>
						<td><input type="text" name="name"/></td>
					</tr>
				</table>
			</form>
		</div>-->
		
		<div class="ui-layout-center">
			<div id="toolbar" class="yhui-toolbar"></div>
			<div class="ui-layout-content" id="editForm">
			</div>
		</div>
	</div>
</body>
</html>