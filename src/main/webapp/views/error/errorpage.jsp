<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>系统业务异常</title>
</head>
<body style="margin: 0;padding: 0;background-color: #f5f5f5;">
	<div id="center-div">
		<table style="height: 100%; width: 600px; text-align: center;">
			<tr>
				<td>
				   <h4 style="color: #FF0000; line-height: 25px; font-size: 20px; text-align: left;">您的请求发生业务逻辑异常</h4>
					<%= exception.getMessage()%>
					<p style="line-height: 12px; color: #666666; font-family: Tahoma, '宋体'; font-size: 12px; text-align: left;">
					<a href="javascript:history.go(-1);">返回</a>!!!
					</p>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>