<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!doctype html>
<html>
<head>
<title>个人信息</title>
<%@ include file="/common/meta.jsp"%>
<script type="text/javascript" src="${ctx}/views/system/js/${__fileName}.js"></script>
</head>
<body >
	<div id="mainContent" class="ui-layout-center" >
	<div class="ui-layout-north"></div>
	<div class="ui-layout-center">
		<!-- <div id="form_toolbar" class="yhToolbar"></div> -->
		<div class="ui-layout-content" id="editForm">
		  <form id="userform" action="${ctx}/system/user/save" method="post" class="yhui-formfield yhui-formbody" onsubmit="return false;">
		    <input type="hidden" id="userId" name="id" value="${user.id}">
			<table>
				<colgroup><col/><col/></colgroup>
				<tr>
					<td>账号名称：</td>
					<td><input type="text" id="username" name="username" value="${user.username}" disabled="disabled"/></td>
				</tr>
				<tr>
					<td>用户姓名：</td>
					<td><input type="text" id="name" name="name" value="${user.name}"/></td>
				</tr>
				<tr>
					<td>所属机构：</td>
					<td><input type="text" id="organizationName" value="" disabled="disabled"/>
					<input type="hidden" id="organizationId" value="${user.organizationId}" disabled="disabled"/>
					</td>
				</tr>
				<tr>
					<td>系统角色：</td>
					<td>
						<input type="hidden" name="roleids" value="<c:forEach var='role' items='${user.roles}'>${role.id },</c:forEach>"/>
						<input type="text" id="rolenames" name="rolenames" value="<c:forEach var='role' items='${user.roles}'>${role.name }&nbsp;&nbsp;</c:forEach>" disabled="disabled"/>
					</td>
				</tr>
				 <tr>
					<td>用户密码：</td>
					<td><input name="pwd" id="pwd" value="●●●●●●"/><input type="hidden" name="password" id="password" value="${user.password}" /></td>
				</tr>
				 <tr>
					<td>固定电话：</td>
					<td><input name="phoneNbr" id="phoneNbr" value="${user.phoneNbr}" /></td>
				</tr>
				 <tr>
					<td>移动电话：</td>
					<td><input name="mobileNbr" id="mobileNbr" value="${user.mobileNbr}" /></td>
				</tr>
				 <tr>
					<td>邮件地址：</td>
					<td><input name="emailAddr" id="emailAddr" value="${user.emailAddr}" /></td>
				</tr>
			</table>
  </form>
		</div>
	</div>
	</div>
</body>
</html>