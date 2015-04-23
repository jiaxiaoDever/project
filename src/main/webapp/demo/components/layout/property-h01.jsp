<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Document</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
<style>
	.ui-layout-north,.ui-layout-center{ overflow: hidden;}
	.block{padding:20px;}
	.block p{padding:4px;}
</style>
</head>
<body>
在引入 <span class="code">yhHead.js </span>之前，运行如下代码：
<script type="text/javascript">
                var yhuiConfig = {
                    basePath: "你的路径"
                };
</script>	
</body>
</html>