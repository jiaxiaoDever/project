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
<style>
	.fold { top: 2px; background: url( "/yuhuihtml/skins/skinOrange/images/other/play.gif" ); }
</style>
</head>
<body>
    <div id = "portlet" class = "yhui-portlet" >
		<div class = "yhui-portet-column" >
			
			<div>
				<h3 data-option = "logo:fold, pop:true, fold: true, close:true" > <span>iframe</span> </h3>
				<div>
					<iframe src="/yhuihtml/commom/text.html" frameborder="0"></iframe>
				</div>
			</div>
			<div>
				<h3 data-option = "logo:false, pop:true, close:true" > <span>标题1</span> </h3>
				<div>
					<div>Feeds</div>
		       		<div>Lorem ipsum dolor sit amet, consectetuer adipiscing elit</div>
				</div>
			</div>


		</div>
		

		<div class = "yhui-portet-column" >
			
			<div>
				<h3 data-option = "fold:true" ><span>标题3</span></h3>
				<div>
					<div>Feeds</div>
		       		<div>Lorem ipsum dolor sit amet, consectetuer adipiscing elit</div>
				</div>
			</div>

			<div>
				<h3 data-option = "pop:true, fold:true" ><span>标题4</span></h3>
				<div>
					<div>Feeds</div>
		       		<div>Lorem ipsum dolor sit amet, consectetuer adipiscing elit</div>
				</div>
			</div>

		</div>
		

		<div class = "yhui-portet-column" >
			<div>
				<h3 data-option = "pop:true, fold:true" ><span>标题5</span></h3>
				<div>
					<div>Feeds</div>
		       		<div>Lorem ipsum dolor sit amet, consectetuer adipiscing elit</div>	  
				</div>
			</div>

			<div>
				<h3 data-option = "pop:true, fold:true" ><span>标题6</span></h3>
				<div>
					<div>Feeds</div>
		       		<div>Lorem ipsum dolor sit amet, consectetuer adipiscing elit</div>
				</div>
			</div>

		</div>
	</div>
	<script type="text/javascript">
        YHUI.use("yhPortlet", function() {
	        $("#portlet").yhPortlet({
	        	generateID: true
	        });

	        //$.yhui.log( $("#portlet").yhPortlet("getOrder", "json") );
	    });
    </script>
</body>
</html>
