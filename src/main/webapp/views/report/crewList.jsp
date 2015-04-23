<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!doctype html>
<html>
<head>
<title>项目管理</title>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript" src="${ctx}/views/report/crewList.js"></script>
<style type="text/css">
#mainContent{padding:10px;}
#userName{margin:0 10px; vertical-align:middle;}
#userNameBtn{vertical-align:middle;}
#CrewSelector{margin:0 10px;}
</style>
</head>
<body>
<div class="ui-layout-west">
		<div class="yhui-west-content">
			<ul id="crewListTree" class="ztree"></ul> 
		</div>
</div>
<div id="mainContent" class="ui-layout-center" >
		<div style="padding:10px;">用户账号:<input id="userName"  class="yhui-form-text"/><button id="userNameBtn" class="yhui-btn">查找</button></div>
		<div id="CrewSelector" class="example"></div>
		<div style="display: none;"><button id="rolesubBtn">提交</button></div>
</div>
<input id="vali" type="hidden" name="vali" value="${param.vali}"/>
<input id="crewList" type="hidden" name="crewList"/>
</body>
</html>