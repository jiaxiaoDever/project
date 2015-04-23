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
	<div id="accordion3">
		<div>
			<h3><a href="#">标题 1</a></h3>
			<div>
				<p>
				拖拽；自适应高度；自定义图标<br>
				注意代码结构：<br>
				普通手风琴：h3+div<br>
				拖拽手风琴：div>h3+div
				</p>
			</div>
		</div>
		<div>
			<h3><a href="#">标题 2</a></h3>
			<div>
				<p>2
				普通手风琴
				</p>
			</div>
		</div>
		<div>
			<h3><a href="#">标题 3</a></h3>
			<div>
				<p>3
				普通手风琴
				</p>
			</div>
		</div>
	</div>
</div>
	<script type="text/javascript">
		//手风琴是UI自带，这里不需要引入其他组件了。
		YHUI.use( "yhLayout", function() {
			$(document.body).yhLayout({
				center: {
					onresize: function() {
						$("#accordion3").accordion("refresh");
					}
				}
			});
			
			$('#accordion3').accordion({ 
				heightStyle: "fill", //充满父容器
				active:0, 
				header: '>div>h3'   //标题的选择器，因为Dom结构不是默认的结构，注意。
			}).sortable( { axis: 'y'} );//可以拖拽


			var icons = $( "#accordion3" ).accordion( "option", "icons" );
			$( "#accordion3" ).accordion( "option", "icons", { 
				"header": "ui-icon-plus", 
				"activeHeader": "ui-icon-minus" } );

		});
		
	</script>
</body>
</html>
