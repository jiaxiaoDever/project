<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset = "UTF-8">
	<title>welcome</title>
    <%@ include file="/common/taglibs.jsp"%>
	<%@ include file="/common/meta.jsp" %>
	<style type="text/css">
		html,body { overflow-x: hidden; }
		a  { color: #003399; text-decoration: none; }
		a:hover{color:#003399;}
		h5,h6 { text-indent:1em; padding:5px; }
		ul{margin:10px;}
		li{ list-style: none; font:12px; text-indent:1em; padding:5px; }
		.yhui-portlet-content {
			min-height: 200px;
			max-height: 400px;
			}
	</style>	
</head>

<body>	
	<div id ="portlet"  class = "yhui-portlet" >
		<div class="yhui-portet-column">
			<div>
				<h3 data-option = "pop:true, fold: true, close:true" > <span>指引</span> </h3>
				<div>
					<ul>
						<li><a href="manual/start/index.jsp" target="_blank">【起步入门】如果您初次使用，从这里开始。</a></li>
						<li><a href="manual/component/index.jsp" target="_blank">
						【帮助手册】曾经使用过，希望阅读组件说明。</a></li>
						<li><a href="manual/custom/index.jsp" target="_blank">【定制手册】有js功底，希望按需定制组件</a></li>
					</ul>
				</div>
			</div>
			<div>
				<h3 data-option = "pop:true, fold: true, close:true"><span>简述</span></h3>
				<div>
					<ul>
						<li>作者：产品中心</li>						
						<li>YHUI隶属于BringBI产品Baseframe的前端框架。简称YHUI。</li>
						<li><a href="http://jquery.com/">YHUI来源于jQuery库。</a></li>
						<li></li>
						<li>组件包括：<a href="compontents/layout/layout-index.html">布局</a>、<a href="compontents/base/base-index.html">组件</a>、<a href="compontents/form/form-index.html">表单</a>、<a href="compontents/jqgrid/jqgrid-index.html">表格</a>等。</li>
						<li>YHUI已经逐步成熟稳定，但不排除bug的存在。发现bug请联系技术中心。</li>
						<li>希望大家共同参与。让我们的基础平台更丰富、易用，组件更完善。</li>
					</ul>
				</div>
			</div>			
		</div>
		<div class="yhui-portet-column">
			<div>
				<h3 data-option = "pop:true, fold: true, close:true"><span>常见问题</span></h3>
				<div>
					<ul>
						<li><a href="">组件为什么不显示？</a></li>						
					</ul>
				</div>
			</div>
			<div>
				<h3 data-option = "pop:true, fold: true, close:true" > <span>更新日志</span> </h3>
				<div>
					<ul>
						<li><a href=""></a></li>
					</ul>
				</div>
			</div>
		</div>

	</div>	
	<script type="text/javascript">
		YHUI.use( "yhPortlet", function() {
			$( "#portlet" ).yhPortlet();
		});
	</script>	
</body>
</html>