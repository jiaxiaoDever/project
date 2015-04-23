<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!doctype html>
<html>
<head>
<title>角色管理</title>
<%@ include file="/common/meta.jsp"%>
<script type = "text/javascript" src="${ctx}/static/common/DefaultView.js"></script>
<script type="text/javascript" src="${ctx}/views/system/js/${__fileName}.js"></script>
</head>
<body>
	<div id="mainContent" class="ui-layout-center" >
        <div class="ui-layout-north">
            <form id="searchForm" class="yhui-formfield noborder"  onsubmit="return false;">
                <table style="height:34px;">
                <tr>
                    <td>角色名称：</td>
                    <td><input type="text" name="name" /></td>
                 </tr>
                </table>
            </form>
            <div id="toolbar" class="yhui-toolbar"></div>
        </div>      
        <div class="ui-layout-center">           
                <table id="list"></table>
                <div id="pager"></div>
           
        </div>
    </div>
</body>
</html>