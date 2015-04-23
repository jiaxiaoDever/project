<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>手风琴</title>
<meta name="description" content="">
<meta name="keywords" content="">
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
</head>
<body>
<div class="ui-layout-center">		
	<div id="accordion">
		<h3><a href="#">标题 1</a></h3>
		<div>
			<p>1
			普通手风琴
			</p>
		</div>
		<h3><a href="#">标题 2</a></h3>
		<div>
			<p>2
			普通手风琴
			</p>
		</div>
		<h3><a href="#">标题 3</a></h3>
		<div>
			<p>3
			普通手风琴
			</p>
		</div>
	</div>
</div>
<script type="text/javascript">
	//手风琴是UI自带，这里不需要引入其他组件了。
	YHUI.use( "yhLayout", function() {
		$(document.body).yhLayout({	});
		
		$( "#accordion" ).accordion({ 
			//heightStyle: "fill",  //充满容器
			active:2,             //设置默认显示的面板索引，从0开始	
			showAllIcons:false,			
			collapsible: true     //允许所有内容关闭。
		});
	});	
</script>
</body>
</html>
