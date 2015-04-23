<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
<%@ include file="/common/meta.jsp" %>
<title>desktop桌面</title>
<script type="text/javascript" src="jsLib/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="jsLib/myLib.js"></script>
<script type="text/javascript" src="jsLib/portlet.js"></script>
<script type="text/javascript" src="../../static/yhui/debug/js/plugin/json2.js"></script>
</head>
<body>
	<input type="hidden" id="roleId" name="roleId" value="${param.roleId }"/>
	<div id="wallpapers"></div>
	<div id="taskBarWrap">
		<div id="taskBar">
			<div id="leftBtn">
				<a href="#" class="upBtn"></a>
			</div>
			<div id="rightBtn">
				<a href="#" class="downBtn"></a>
			</div>
			<div id="task_lb_wrap">
				<div id="task_lb"></div>
			</div>
		</div>
	</div>
	<div id="navBar">
		<a id="desktop1" href="#" class="currTab" title="桌面1"></a><a id="desktop2" href="#" title="桌面2"></a><a id="desktop3"
			href="#" title="桌面3"></a><a id="desktop4" href="#" title="桌面4"></a>
	</div>
	<div id="desktopPanel">
		<div id="desktopInnerPanel">
			<ul id="desktop-1" class="deskIcon currDesktop">
			</ul>
			<ul id="desktop-2" class="deskIcon">
			</ul>
			<ul id="desktop-3" class="deskIcon">
			</ul>
			<ul id="desktop-4" class="deskIcon">
			</ul>
		</div>
	</div>
	<div id="start_item">
	      <ul class="deskIcon">
	        
	      </ul>
	</div>
	<div id="lr_bar">
	 <div id="start_block"> 
	  <a title="我的portlet" id="start_btn"></a>
	  </div>
	</div>

</body>
</html>
