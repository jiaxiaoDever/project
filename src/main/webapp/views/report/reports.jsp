<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html>
<html>

	<head>
		<title>报表查看</title>
		<%@ include file="/common/meta.jsp" %>
		<script>

</script>
		
	</head>

	<body>
	
		<div class="ui-layout-west" id="west">
			
			<div class="yhui-west-content">
				<div id="tools" class="yhui-toolbar"></div>
				<ul id="leftTree" class="ztree"></ul> 
			</div>
		</div>	
		
		 <div id="mainContent" class="ui-layout-center" >
			<div class = "yhui-tabs-header">
		        <div class = "yhui-tabs-header-inner">
					<ul>
					    <li><a href = "#tabs-1">报表列表</a></li>
					</ul>
				</div>
			</div>
		 	 
		<div id="tabsCommon" class = "ui-layout-content">
	    	<div id = "tabs-1"> 
		    	<div  class="ui-layout-north">
				<form id="searchForm" class="yhui-formfield noborder" onsubmit="return false;">
					<table style="height:34px;">
						<tr>
							<td>报表名称：</td>
							<td><input type="text" name="name" /></td>
							<td>显示方式：</td>
							<td><select id="rptShow" name="rptShow"><option value="">--所有--</option>
							<option value="1">PC</option>
							<option value="2">手机端</option>
							<option value="3">PC&手机端</option></select></td>
							<td>状态：</td>
							<td><select id="state" name="state"><option value="">--所有--</option>
							<option value="1">有效</option>
							<option value="-1">无效</option></select></td>
						</tr>
					</table>
				</form>
				<div id="toolbar" class="yhui-toolbar"></div>
				</div>
				<!-- <div id="toolbar" class="yhui-toolbar"></div> -->
				
					<table id="list"></table>
					<div id="pager"></div>
					<div id="editForm"></div>

			  </div>
			 </div>
		 </div>
		 
		 <script src="${ctx}/views/report/reports.js"></script>
	 <script  id ="keepsession" type="text/javascript">
		function keepsession(){ 
		document.all["keepsession"].src=ctx+"/system/session/keepSession?id="+Math.random(); 
			 
		} 
		window.setInterval("keepsession()",300000);
		//keepsession();
	</script>
	</body>
</html>
