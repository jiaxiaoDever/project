<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
<%@ include file="/common/meta.jsp" %>
<title>desktop桌面</title>
<script type="text/javascript" src="jsLib/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="jsLib/myLib.js"></script>
<script type="text/javascript" src="jsLib/portlet_admin.js"></script>
<script type="text/javascript" src="../../static/yhui/debug/js/plugin/json2.js"></script>
</head>
<body>
	<div id="wallpapers"></div>
	<div id="desktopPanel">
		<div id="desktopInnerPanel">
			<ul id="desktop-1" class="deskIcon currDesktop">
			</ul>
		</div>
	</div>
	<div id="start_item">
	      <ul class="deskIcon">
	        
	      </ul>
	</div>
	<div id="role_portlets_item">
	</div>
	<div id="role_item">
      <ul class="item">
      </ul>
    </div>
	<div id="add_item">
	  <form name="save_form" id="save_form">
	  <ul class="item admin">
        <li><span class="titleImg"></span> 添加portlet</li>
      </ul>
      <ul class="item admin">
        <li>portlet名称&nbsp;&nbsp;<a style="color: orange;" title="此项必须填写">*</a></li>
        <li> 
        <div><input id="title" name="title" style="width: 165px;height:25px;"/></div> 
        </li>
      </ul>
      <ul class="item admin">
        <li>图标路径</li>
	    <li style="height:64px;"> <div class="icon" ><img src="icon/icon7.png"/></div> </li>
        <li> 
        <div><input id="icon" name="icon" style="width: 165px;height:25px;"/></div> 
        </li>
      </ul>
      <ul class="item admin">
        <li>portlet  URL&nbsp;&nbsp;<a style="color: orange;" title="此项必须填写">*</a></li>
        <li> 
        <div><input id="url" name="url" style="width: 165px;height:25px;"/></div> 
        </li>
      </ul>
      <ul class="item admin">
        <li>描述</li>
        <li style="height: 100px;width: 180px;"> 
        <div><textarea id="description" name="description" cols="21px" rows="14px"></textarea></div> 
        </li>
      </ul>
      <ul class="item admin">
        <li style="height: 95px;width: 180px;"> 
        <div align="center"><input id="save_icon" type="button" value="保存" style="width: 90px;height: 30px;"/></div> 
        <div id="error_save" style="color: red;padding-left: 8px;padding-right: 8px;">
        	<div id='title_error'></div>
        	<div id='url_error'></div>
        </div>
        </li>
      </ul>
      </form>
	</div>
	<div id="lr_bar">
	<ul id="default_app">
		<li id="role_portlets"><span><img src="icon/icon2.png" title="角色portlet管理"/></span><div class="text">角色portlet管理<s></s></div></li>
		<li id="add_portlets"><span><a id="add_icon" title="添加portlet"></a></span><div class="text">添加portlet<s></s></div></li>
	</ul>
	</div>


</body>
</html>
