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
    <button>添加一个选项卡</button>
	<div id = "tabs">
		<ul>
			<li><a href="#tabs-1">标题一</a></li>
			<li><a href="#tabs-2">标题二</a></li>
			<li><a href="#tabs-3">标题三</a></li>
		</ul>
		<div id="tabs-1">
			<p>mauris eleifend est et turpis. duis id erat. suspendisse potenti. aliquam vulputate, pede vel vehicula accumsan, mi neque rutrum erat, eu congue orci lorem eget lorem. vestibulum non ante. class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. fusce sodales. quisque eu urna vel enim commodo pellentesque. praesent eu risus hendrerit ligula tempus pretium. curabitur lorem enim, pretium nec, feugiat nec, luctus a, lacus.</p>
			<p>duis cursus. maecenas ligula eros, blandit nec, pharetra at, semper at, magna. nullam ac lacus. nulla facilisi. praesent viverra justo vitae neque. praesent blandit adipiscing velit. suspendisse potenti. donec mattis, pede vel pharetra blandit, magna ligula faucibus eros, id euismod lacus dolor eget odio. nam scelerisque. donec non libero sed nulla mattis commodo. ut sagittis. donec nisi lectus, feugiat porttitor, tempor ac, tempor vitae, pede. aenean vehicula velit eu tellus interdum rutrum. maecenas commodo. pellentesque nec elit. fusce in lacus. vivamus a libero vitae lectus hendrerit hendrerit.</p>
		</div>
		<div id="tabs-2">
			<p>morbi tincidunt, dui sit amet facilisis feugiat, odio metus gravida ante, ut pharetra massa metus id nunc. duis scelerisque molestie turpis. sed fringilla, massa eget luctus malesuada, metus eros molestie lectus, ut tempus eros massa ut dolor. aenean aliquet fringilla sem. suspendisse sed ligula in ligula suscipit aliquam. praesent in eros vestibulum mi adipiscing adipiscing. morbi facilisis. curabitur ornare consequat nunc. aenean vel metus. ut posuere viverra nulla. aliquam erat volutpat. pellentesque convallis. maecenas feugiat, tellus pellentesque pretium posuere, felis lorem euismod felis, eu ornare leo nisi vel felis. mauris consectetur tortor et purus.</p>
		</div>
		<div id="tabs-3">
			<p>morbi tincidunt, dui sit amet facilisis feugiat, odio metus gravida ante, ut pharetra massa metus id nunc. duis scelerisque molestie turpis. sed fringilla, massa eget luctus malesuada, metus eros molestie lectus, ut tempus eros massa ut dolor. aenean aliquet fringilla sem. suspendisse sed ligula in ligula suscipit aliquam. praesent in eros vestibulum mi adipiscing adipiscing. morbi facilisis. curabitur ornare consequat nunc. aenean vel metus. ut posuere viverra nulla. aliquam erat volutpat. pellentesque convallis. maecenas feugiat, tellus pellentesque pretium posuere, felis lorem euismod felis, eu ornare leo nisi vel felis. mauris consectetur tortor et purus.</p>
		</div>
	</div>
	<script type="text/javascript">
		YHUI.use( "yhTabs", function() {
			var $tabs = $("#tabs").yhTabs({
				heightStyle: "fill"
			});

            var i = 1, j = 1, n = 1;

			$( $.yhui.byTag( "button" )[0] ).on( "click", function() {
				$tabs.yhTabs( "add", {
					title: "title" + i++,
					id: "hh" + j++,
					//src: "id.html",
					callback: function( yhui ) {
						yhui.panel.append( "<p>中国人" + n++ +"</p>" );
					}
				});
			});

			$.yhui.windowResize(function() {
				$tabs.yhTabs( "refresh" );
			});
		});
	</script>

</body>
</html>
