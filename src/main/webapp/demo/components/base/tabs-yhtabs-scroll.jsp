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
    <div class="ui-layout-center">
		<div id = 'scrolltab'>
			<ul>
				<li><a href="#tabs_1">标题一</a></li>
				<li><a href="#tabs_2">标题二</a></li>
				<li><a href="#tabs_3">标题三</a></li>
				<li><a href="#tabs_4">标题四</a></li>
			</ul>
			<div>
				<div id = 'tabs_1'>内容区1</div>
				<div id = 'tabs_2'>内容区2</div>
				<div id = 'tabs_3'>内容区3</div>
				<div id = 'tabs_4'>内容区4</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		YHUI.use( "yhLayout yhScrollTab", function() {
			
			var table = [];
			table.push( '<table>' );
			for ( var i = 0; i < 10; i ++ ) {
				table.push( '<tr>' );
				for ( var j = 0; j < 10; j++ ) {
					table.push( '<td>', i + '行' + j + '列'  , '</td>' );
				}
				table.push( '</tr>' );
			}
			table.push( '</table>' );
			
			$('#tabs_1, #tabs_2, #tabs_3, #tabs_4').html( table.join('') );
			//上面是打印几个表格，大家不用理会。
			//下面就是初始化滚动选项卡
			$('#scrolltab').yhScrollTab();
		});
	</script>
</body>
</html>
