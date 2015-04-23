<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/meta.jsp"%>
<title></title>
</head>
<body>
	<div id="mainContent" class="ui-layout-center">
		<div class="ui-layout-center noscroll">
			<form id="searchForm1" class="yhui-formfield noborder">
				<input type="hidden" id="id" />
				<table>
					<tr>
						<td>目录名称：</td>
						<td><input type="text" id="name" /></td>
					</tr>
					<tr>
						<td>目录类型:</td>
						<td id="dirtypes"><input type="radio" name="privilege"
							value="0" />公有 <input type="radio" name="privilege" value="1" />私有
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>

	<script type="text/javascript">
		YHUI.use("yhFormField yhLayout", function() {
			$(document.body).yhLayout({});
			$("#searchForm1").yhFormField({});

			$("#id").val('${param.id}');
			$("#name").val('${param.name}');
			var privilege = '${param.privilege}';
			if (privilege && privilege != 'null') {
				$('input:radio').eq(privilege).attr('checked', 'true');
				var input = $("#dirtypes").find("input:radio");
				input.attr("disabled", "disabled");
			}

		});
	</script>
</body>
</html>