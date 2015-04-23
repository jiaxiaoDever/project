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
	<div class="button_temp">
		<button id="button1">Open</button>
		<button id="button2">Open</button>
		<button id="button3">Open</button>
		<button id="button4">不出现在任务栏</button>
		<button id="button5">一次性弹窗</button>		
	</div>
   
	
	<div id = "window1" title = "窗口1">

		
	</div>
	<div id = "window2" title = "窗口2">
		
	</div>
	<div id = "window3" title = "窗口3">
		
	</div>

	<div id = "window4" title = "窗口4">
		
	</div>
	

	<script type="text/javascript">
		//yhWindow是继承dialog的，如果没看过dialog，大家看先去看看。
		
		var Yhwin = {
			cacheWindow : {},
			initWindow : function( selector, settings ) {
				Yhwin.cacheWindow[ selector ] = $( selector ).yhWindow( settings );//这里才是初始化yhWindow的地方
			},

			//做一个一次性弹窗的例子吧。
			//不用在html里实现放个div，会自动添加。
			//关闭后会在彻底移除，所以叫一次性。
			dispWindow: function() {
				var $wrap = $("<div></div>"),
					$ifr = $("<iframe style = 'width:100%;height:100%' frameborder = '0'></iframe>");
				
				$wrap.appendTo( document.body ).yhWindow({
					title: "一次性窗口",
					width: 600,
					height: 400,
					position: [ "center", "center-5%" ],
					resizable: false,
					dragHelper: true,
                    showTaskBar: false,
					open: function( e, ui ) {
						$ifr.appendTo( $(this) ).prop( "src" ,"../form/yhFormField4.html" );
					},
					close: function() {
						var $ifr = $(this).find("iframe");
						$ifr.length && $ifr.remove();
						$.yhui.isIE && CollectGarbage();
						$(this).yhWindow( "destroy" ).remove();
					}
				});
			}
		};
		
		

		YHUI.use("yhCore yhWindow", function() {
			
			Yhwin.initWindow( "#window1", {
				autoOpen: false,  //默认隐藏
				resizeStop: function(e) {    //停止拖动时执行的回调函数
					//$.yhui.log( "h" );
				},
				close: function() {   //关闭时执行的回调函数
                    var btn = $.yhui.byId( "button1" );
                    btn.disabled = false;
                    btn.innerHTML = "Open";
				},
				position:[ "left", "top" ],   //位置
				beforeMaxi: function( e, yhui ) {  //最大化之前执行的回调函数
					$.yhui.log( yhui );
				}
			});
			
			Yhwin.initWindow( "#window2", {
				autoOpen: false,
				maxi: false,   //不显示最大化按钮。
				close: function() {
                    var btn = $.yhui.byId( "button2" );
                    btn.disabled = false;
                    btn.innerHTML = "Open";
				},
				beforeMini: function( e, yhui ) {   //最小化之前执行的回调函数
					$.yhui.log( yhui );
				}
			});
			
			Yhwin.initWindow( "#window3", {
				autoOpen: false,
				mini: false,   //不显示最小化按钮。
				close: function() {
                    var btn = $.yhui.byId( "button3" );
                    btn.disabled = false;
                    btn.innerHTML = "Open";
				},
				position:[ "right", "top" ]
			});
			
			Yhwin.initWindow( "#window4", {
				autoOpen: false,
				showTaskBar: false,
				close: function() {
                    var btn = $.yhui.byId( "button4" );
                    btn.disabled = false;
                    btn.innerHTML = "不出现在任务栏";
                    $(this).yhWindow("destroy").remove();
				}
			});



			$('button').attr('disabled',false);  //让按钮可用
			
			
			//给按钮绑定事件
			$(document.body).on( 'click' , 'button' ,function(){
				if ( this.id === "button5" ) {
					Yhwin.dispWindow();
				} else {	
					Yhwin.cacheWindow[ "#window" + this.id.match( /(\d+)$/ )[1] ].yhWindow( "open" );
					this.disabled = true;
					this.innerHTML = "已打开……";
				}
			});
			
		});
	</script> 
</body>
</html>
