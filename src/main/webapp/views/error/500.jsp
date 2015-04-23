<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>500 - 系统内部错误</title>
</head>
<body style="margin: 0;padding: 0;background-color: #f5f5f5;">
	<div id="center-div">
		<table style="height: 100%; width: 600px; text-align: center;">
			<tr>
				<td>
				
				<h4 style="color: #FF0000; line-height: 25px; font-size: 20px; text-align: left;">您访问的信息发生内部错误</h4>
				<p style="line-height: 12px; color: #666666; font-family: Tahoma, '宋体'; font-size: 12px; text-align: left;">
					发生未知错误,请联系管理员 或<a href="javascript:history.go(-1);">返回</a>!
				</p>
				</td>
			</tr>
			<tr>
			<td>
			<h4 style="color: #FF0000; line-height: 25px; font-size: 20px; text-align: left;">错误提示:</h4>
			<br></br>
			<%	out.println(exception.getMessage()+"");%>
			</td>
			</tr>
		</table>
	</div>
</body>
</html>