<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ page import="org.apache.shiro.authc.LockedAccountException "%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>昱辉BI</title>
<script type="text/javascript">
var ctx = '${ctx}';
</script>
<script type = "text/javascript" src="${ctx}/static/yhui/debug/js/base/jquery-1.8.3.js"></script>
<script type = "text/javascript" src="${ctx}/views/login/js/login.js"></script>
</head>

<style> 0
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,input,textarea,p,blockquote,th,td{margin:0;padding:0;}
table{ margin:0; padding:0; border:0;}

body{ 
	overflow-x:hidden;
	background-color:#fff;
		}
.login_wrap{
	text-align:center;	
	
	font-size:12px;
	*font-size:11px;
	line-height:22px;
/* 	height:auto!important;height:550px;min-height:550px; */
	background:url(${ctx}/views/login/skins/skinBlue/images/login/loginbodybg.png) center 0 no-repeat;	
	}
.login_main{
	position:relative;
	margin:0 auto;
	width:900px;
	height:490px;}
	
.loginbar{
	position:absolute;
	left:310px; top:180px;
	}
.loginbar td{
	height:38px;
	line-height:38px;
	padding-right:15px;
	font-size:14px;
	text-align:left;
	color:#fff;}
.loginbar .errorbar{
	height:30px;
	line-height:30px;
	width:160px;
	padding-left:28px;
	font-size:12px;		
	color:#cc3030;
	border:1px solid #cc3030;
	background:#ffdfdf url(${ctx}/views/login/skins/skinBlue/images/login/login_tip.png) 8px 7px no-repeat;}

.loginbar input{
	float:left;
	overflow:hidden;
	height:28px;
	line-height:28px;
	padding:0 2px;
	margin-right:4px;	
	border:0;}
.loginbar .username{
	width:165px;
	padding-left:22px;
	background:url(${ctx}/views/login/skins/skinBlue/images/login/login_admin.png) 0 0 no-repeat;}
.loginbar .password{
	width:165px;
	padding-left:22px;
	background:url(${ctx}/views/login/skins/skinBlue/images/login/login_paddword.png) 0 0 no-repeat;}
.loginbar .code{
	float:left;
	width:100px;}
.loginbar .imgcode{
	float:left;
	width:80px;
	background:url(${ctx}/views/login/skins/skinBlue/images/login/login_validatenumb.png) 0 0 no-repeat;}
.loginbar .tipinfo{
	font-size:12px;
	height:28px;
	line-height:28px;}
	
.loginbar .login_btn{
	cursor:pointer;
	float:left;
	width:82px;
	height:32px;
	background:url(${ctx}/views/login/skins/skinBlue/images/login/login_btn.png) 0 0 no-repeat;}
.loginbar .login_btn:hover{
	background:url(${ctx}/views/login/skins/skinBlue/images/login/login_btn_hover.png) 0 0 no-repeat;}
.login_footer{
	position:relative;
	top:25px;
	font-size:12px;}
.login_footer span{ padding-right:5px;}

</style>
<body>

<div class="login_wrap">
	<div class="login_main">
		<div class="errorbar"></div>
		<div class="loginbar">
		<form id="loginForm" action="${ctx}/login" method="post">
		<table>
        	<tr>
        		<td></td>
        		<!-- ${ requestScope.shiroLoginFailure } -->
        		<td><div class="errorbar" id="errors" style="display:none;"></div></td>
        	</tr>
			<tr>
				<td>用户名</td>
				<td><label for="textfield"></label>
			    <input type="text" name="username" id="username" class="username" /></td>
			</tr>
			<tr>
				<td>密    码</td>
				<td><input type="password" name="password" id="password"  class="password"/></td>
			</tr>
			<!-- -->
			<tr>
				<td>验证码</td>
				<td><input type="text" name="vcode" id="vcode" class="code" />
			    <img title="看不清，点击换一张" alt="看不清，点击换一张" onclick="refresh(this);" id="valicodeImg"  src="${ctx}/kaptcha.jpg" width="82" height="28" /></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="button" name="button" id="button" value=""  class="login_btn" onclick="login();"/></td>
			</tr>
		</table>
		</form>		
		</div>
	</div>
	<div class="login_footer"><span>技术支持：广东昱辉通信技术有限公司</span> <span>联系电话：020-11111111</span> <span>建议IE8.0，最佳分辨率1366*768</span></div>
</div>
</body>
</html>