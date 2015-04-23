<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="org.slf4j.Logger,org.slf4j.LoggerFactory"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp"%>
<%
	Throwable ex = null;
	if (exception != null){
		ex = exception;
	}
	if (request.getAttribute("javax.servlet.error.exception") != null){
		ex = (Exception) request.getAttribute("javax.servlet.error.exception");
	}
	
	//记录日志
	Logger logger = LoggerFactory.getLogger("500.jsp");
	logger.error(ex.getMessage(), ex);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>500 - 系统内部错误</title>
<script type="text/javascript">
	$(function(){
		$('#errDetail').toggle(
			function(){
				$("#errDetail a").removeClass("errDetail2");
				$("#errDetail a").addClass("errDetail3");
				$("#errDetailBd").show();
			},
			function(){
				$("#errDetail a").removeClass("errDetail3");
				$("#errDetail a").addClass("errDetail2");
				$("#errDetailBd").hide();
			}
		);
	});
</script>
</head>

<body>
	<div class="smart_mider_center">
			<div class="operatearea">				
				<div class="outScroll">
					<div class="infoErrow">
						<table>
							<tr>
								<td>
									<div class="infoIco"></div>
								</td>
								<td>
									<div class="font16">
										非常抱歉！<br />
										您访问的信息发生内部错误<br />
									</div>
									<div class="errDetail" id="errDetail">
                                		<a href="javascript:void(0);" class="errDetail2">错误详情</a>
                               		</div>
	                                <div class="errDetailBd" id="errDetailBd">
	                                	<%
	                                		String message = ex.getMessage();
		                                	if (message.indexOf("org.springframework.jdbc.BadSqlGrammarException") >= 0) {
		                                		message = "错误描述： 查询字段异常 ";
		                                	}
		                                	if (message.indexOf("java.sql.SQLException") >= 0) { // 判断是否为SQL异常
		                                		message = "错误描述： 数据库查询异常 ";
		                                	}
		                                	if (message.indexOf("java.net.ConnectException") >= 0) { // 判断是否为数据库连接异常
		                                		message = "错误描述： 连接超时 ";
		                                	}
		                                	if (message.indexOf("java.lang.IllegalArgumentException") >= 0) { // 判断是否为非法参数异常
		                                		message = "错误描述：非法参数异常 ";
		                                	}
		                                	if (message.indexOf("java.io.IOException") >= 0) { // 判断是否为IO异常
		                                		message = "错误描述：IO异常 ";
		                                	}
		                                	if (message.indexOf("No row with the given identifier exists") >= 0) { // 判断是否为数据缺失异常
		                                		message = "错误描述：数据缺失异常 ";
		                                	}
											out.println(message+" 请联系服管系统接口人陈孝东处理 电话 18929584035 ");
										%>
	                                </div>
								</td>
							</tr>
							<tr>
								<td>
								</td>
								<td>
									<a href="#" class="btnInfo" onclick="window.history.go(-1);">返回上一页</a>
									<!--<a href="#" class="btnInfo">返回首页</a>
									<a href="#" class="btnInfo">联系管理员</a>  -->
								</td>
							</tr>
						</table>
					</div>					
				</div>
			</div>
	</div>
</body>
</html>