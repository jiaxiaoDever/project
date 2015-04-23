<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/meta.jsp" %>
<title>发布报表</title>
</head>
<body>
	<div id="mainContent" class="ui-layout-center" >
		<div class="ui-layout-center noscroll">
			<form id="mainForm" class="yhui-formfield noborder">
				<input type="hidden" id="report_type" />
				<input type="hidden" id ="rpt_class" />
				<table>
				 	<tr>
					<td>报表名称：</td>
					<td><input type="text" id="name"  /></td>
					</tr>
					<tr>
					<td>所属分类：</td>
					<td><input type="text" id="report_type_name"  disabled /></td>
					</tr>
					<tr>
					<td>报表类型：</td>
					<td><input type="text" id="rpt_class_name"  /></td>
					</tr>
					
					<tr>
					<td>显示类型：</td>
					<td><input type="text" id="show_type"  /></td>
					</tr>
					
					<tr>
					<td>URL：</td>
					<td><input type="text" id="url"  /></td>
					</tr>
					<tr>
					<td>报表状态:</td>
					<td><input type="text" id="state"  /></td>
					</tr>
					
								
				</table>
				
			</form>
			
		</div>		
	</div>

	<script type="text/javascript">
	YHUI.use("yhFormField yhLayout yhDropDown", function() {
		$(document.body).yhLayout({});
		$("#mainForm").yhFormField({});
		
		$("#report_type").val('${param.pid}');
		$("#report_type_name").val('${param.pname}');
		
		var list = [
		            { name: "多维报表", id: 'olap' },
		            { name: "平面报表", id: 'flat' }
		        ];
		         
        $("#rpt_class_name").yhDropDown({
		            json: list,     // 传入节点
		            noChild: true   // 列表形式
		        });
        
        $("#rpt_class_name").val("多维报表");
        var stlist = [
		            { name: "有效", id: '1' },
		            { name: "无效", id: '-1'}
		        ];
		         
        $("#state").yhDropDown({
		            json: stlist,     // 传入节点
		            noChild: true   // 列表形式
		        });
        $("#state").val("有效");
        
        var shlist = [
  		            { name: "PC", id: 1 },
  		            { name: "PC&手机端", id: 3 },
  		          { name: "手机端", id: 2 }
  		        ];
  		         
          $("#show_type").yhDropDown({
  		            json: shlist,     // 传入节点
  		            noChild: true   // 列表形式
  		        });
  		  $("#show_type").val("PC");
		
	});
	</script>
</body>
</html>