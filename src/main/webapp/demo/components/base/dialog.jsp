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
    <!-- 弹窗的dom结构-->
	<div id = 'dialog1' title = '普通弹窗'>
		<p>这是一个普通弹窗。</p>
	</div>
	<div id = 'dialog2' title = '动画弹窗'>
		<p>这是一个动画弹窗。</p>
	</div>
	<div id = 'dialog3' title = '模态弹窗'>
		<p>这是一个模态弹窗。除了弹出窗口，其他元素全都屏蔽。</p>
	</div>
	<div id = 'dialog4' title = 'OK'>
		<p>这是一个‘OK’弹窗。</p>
	</div>
<!-- 弹窗结束-->
	<div id = "trigger" class="button_temp">
		<button id = 'button1'>普通弹窗</button>
		<button id = 'button2'>动画弹窗</button>
		<button id = 'button3'>模态弹窗</button>
		<button id = 'button4'>确定弹窗</button>
	</div>
	<script type="text/javascript">
		YHUI.use(function() {
			//初始化弹窗
			$('#dialog1').dialog({ 
				autoOpen: false  //默认是隐藏的
			});
			
			$('#dialog2').dialog( { 
					autoOpen: 	false
				,	show:		'drop'   //打开时动画效果。drop就是一个效果。
				,	hide:		'drop'		//关闭时动画效果。
			
			});
			
			$('#dialog3').dialog( { 
					autoOpen: 	false
				,	show:		'fade'
				,	hide:		'fade'
				,	modal:		true    //这里是模态
			});
			
			$('#dialog4').dialog({
					autoOpen:	false
				,	buttons:	{//添加按钮
						'确定':	function(){ //按钮的事件
									$(this).dialog('close'); 
								}
					,	'取消':	function(){ 
									$(this).dialog('close'); 
								}
					}
				,	create: function(){
							}
			});
			
			//dialog还有更多属性，比如width,height,position等等。
			
			
			//给按钮绑定事件
			$("#trigger").on('click', 'button', function(){
				$('#dialog' + ($(this).index() + 1)).dialog('open'); //调用dialog的open方法打开它
			});
		});
	</script>
</body>
</html>
