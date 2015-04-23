<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Document</title>
<meta name="description" content="">
<meta name="keywords" content="">
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
</head>
<body>
    <form id = "field" class = 'yhui-formfield'>
		<table>
			<tr>
				<td>必填字段</td>
				<td><input type="text" id="text1" data-validation-engine = "required" /></td>
				<td>必填字段</td>
				<td><input type="text" id="text2"/></td>
				<td>必填字段</td>
				<td><input type="text" id="text3"/></td>
			</tr>
			<tr>
				<td>选填字段</td>
				<td><input type="text" id="text4"/></td>
				<td>必填字段</td>
				<td><input type="text" id="text5"/></td>
				<td>必填字段</td>
				<td><input type="text" id="text6"/></td>
			</tr>
			<tr>
				<td>单选框</td>
				<td>
					<input type="radio" name="in" />张三1
					<input type="radio" name="in" />张三2
					<input type="radio" name="in" />张三3
				</td>
				<td>复选框</td>
				<td>
					<input type="checkbox" name="cn" />张三1
					<input type="checkbox" name="cn" />张三2
					<input type="checkbox" name="cn" />张三3
				</td>
				<td>复选框</td>
				<td>
					<input type="checkbox" name="cn" />张三1
					<input type="checkbox" name="cn" />张三2
					<input type="checkbox" name="cn" />张三3
				</td>
			</tr>
			<tr>
				<td>大段文本</td>
				<td  colspan="5"><textarea name="" cols="30" rows="10" style="width:91%;"></textarea></td>
			</tr>
		</table>
		<div class = "yhui-btn-holder">
			<a class = "yhui-btn yhui-btn-disabled" href="#"><span class = "yhui-form-icon yhui-btn-save"></span>保存</a>
			<a class = "yhui-btn" href="#"><span class = "yhui-form-icon yhui-btn-reset"></span>重置</a>
		</div>
	</form>
	<script type="text/javascript">
		YHUI.use("yhDropDown yhFormField", function() {
			//六列布局，没什么好说的。
			//formField会自动探测表格的列数，然后加载样式。
			//请移步四列布局，那有详细的使用说明。
			
			$('#field').yhFormField();
			 
			$('#text7').yhDropDown({
				url: "treeData.txt"
			});
			
			$('#text8').yhDropDown({
				url: "treeData.txt",
				beforeCreatedTree: function( e, data ) {
					//$.yhui.log( data );
				}
			});
			
			
		});
		
		
	</script>
</body>
</html>
