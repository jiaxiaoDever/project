<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>上-左-上下布局实例</title>    
    <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
	<!-- 有些时候为了兼容所有浏览器，得在当前页面写些样式。  -->
	<style type="text/css">
		.yhui-ie7 .ui-layout-content, .yhui-ie7 .ui-layout-south { overflow: hidden; }
	</style>
	<script type="text/javascript">
		YHUI.use( "yhLayout yhToolbar zTree", function(){
			$(document.body).yhLayout({
				north__resizable: false
			});
			$("#mainContent").yhLayout({
				south: {
					size: 0.5
				},
				center__onresize: function() {
					$("#accordion").accordion("refresh");
					$("#tabs").tabs("refresh");
				}
			});
			
			$('#toolbar').yhToolbar({//toolbar改造自一个插件，所以挖掘的不是很深
				//items就是选项了，如新增、修改什么的。所有的都是可选的。
				items : [{
						type : 'button', 
						text : '新增',
						bodyStyle : 'new',//可以理解为图标
						useable : 'T',//是否禁用，T不禁用，F禁用
						handler : function () {//单击触发
							alert( this.innerHTML );
						}
					}, {
						type : 'button',
						text : '修改',
						bodyStyle : 'edit',
						useable : 'T',
						handler : function () {
							alert( this.innerHTML );
						}
					}, {
						type : 'button',
						text : '删除',
						bodyStyle : 'delete',
						useable : 'T',
						handler : function () {
							alert( this.innerHTML );
						}
					}
				]
			});
			
			
			//初始化树
			$.getJSON("../../JSON/treeData.txt", function(data){
				$("#tree").yhTree({}, data);
			});
			$("#tabs").tabs({
				heightStyle: "fill"
			});
			$("#accordion").accordion({
				heightStyle: "fill"
			});
		
		});
	</script>
</head>
<body>
	<div class="yhui-header ui-layout-north ui-helper-clearfix">
		<!--#include virtual="/yhuihtml/commom/header.html" -->		
	</div>
	<div class="ui-layout-west">
		<ul id="tree" class="ztree">
			
			
		</ul>
		
	</div>
	<div id="mainContent" class="ui-layout-center" >
		<div class="ui-layout-center">
			<div id = 'toolbar' class = 'yhToolbar'>
				
			</div>
			<div class="ui-layout-content">
				<div id="tabs">
					<ul>
						<li><a href="#tabs-1">标题一</a></li>
						<li><a href="#tabs-2">标题二</a></li>
						<li><a href="#tabs-3">标题三</a></li>
					</ul>
					<div id="tabs-1">
						<p>开始</p>
						<p>1mauris eleifend est et turpis. duis id erat. suspendisse potenti. aliquam vulputate, pede vel vehicula accumsan, mi neque rutrum erat, eu congue orci lorem eget lorem. vestibulum non ante. class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. fusce sodales. quisque eu urna vel enim commodo pellentesque. praesent eu risus hendrerit ligula tempus pretium. curabitur lorem enim, pretium nec, feugiat nec, luctus a, lacus.</p>
						<p>duis cursus. maecenas ligula eros, blandit nec, pharetra at, semper at, magna. nullam ac lacus. nulla facilisi. praesent viverra justo vitae neque. praesent blandit adipiscing velit. suspendisse potenti. donec mattis, pede vel pharetra blandit, magna ligula faucibus eros, id euismod lacus dolor eget odio. nam scelerisque. donec non libero sed nulla mattis commodo. ut sagittis. donec nisi lectus, feugiat porttitor, tempor ac, tempor vitae, pede. aenean vehicula velit eu tellus interdum rutrum. maecenas commodo. pellentesque nec elit. fusce in lacus. vivamus a libero vitae lectus hendrerit hendrerit.</p>
						<p>1mauris eleifend est et turpis. duis id erat. suspendisse potenti. aliquam vulputate, pede vel vehicula accumsan, mi neque rutrum erat, eu congue orci lorem eget lorem. vestibulum non ante. class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. fusce sodales. quisque eu urna vel enim commodo pellentesque. praesent eu risus hendrerit ligula tempus pretium. curabitur lorem enim, pretium nec, feugiat nec, luctus a, lacus.</p>
						<p>duis cursus. maecenas ligula eros, blandit nec, pharetra at, semper at, magna. nullam ac lacus. nulla facilisi. praesent viverra justo vitae neque. praesent blandit adipiscing velit. suspendisse potenti. donec mattis, pede vel pharetra blandit, magna ligula faucibus eros, id euismod lacus dolor eget odio. nam scelerisque. donec non libero sed nulla mattis commodo. ut sagittis. donec nisi lectus, feugiat porttitor, tempor ac, tempor vitae, pede. aenean vehicula velit eu tellus interdum rutrum. maecenas commodo. pellentesque nec elit. fusce in lacus. vivamus a libero vitae lectus hendrerit hendrerit.</p>
						<p>duis cursus. maecenas ligula eros, blandit nec, pharetra at, semper at, magna. nullam ac lacus. nulla facilisi. praesent viverra justo vitae neque. praesent blandit adipiscing velit. suspendisse potenti. donec mattis, pede vel pharetra blandit, magna ligula faucibus eros, id euismod lacus dolor eget odio. nam scelerisque. donec non libero sed nulla mattis commodo. ut sagittis. donec nisi lectus, feugiat porttitor, tempor ac, tempor vitae, pede. aenean vehicula velit eu tellus interdum rutrum. maecenas commodo. pellentesque nec elit. fusce in lacus. vivamus a libero vitae lectus hendrerit hendrerit.</p>
						<p>结束</p>
					</div>
					<div id="tabs-2">
						<p>2morbi tincidunt, dui sit amet facilisis feugiat, odio metus gravida ante, ut pharetra massa metus id nunc. duis scelerisque molestie turpis. sed fringilla, massa eget luctus malesuada, metus eros molestie lectus, ut tempus eros massa ut dolor. aenean aliquet fringilla sem. suspendisse sed ligula in ligula suscipit aliquam. praesent in eros vestibulum mi adipiscing adipiscing. morbi facilisis. curabitur ornare consequat nunc. aenean vel metus. ut posuere viverra nulla. aliquam erat volutpat. pellentesque convallis. maecenas feugiat, tellus pellentesque pretium posuere, felis lorem euismod felis, eu ornare leo nisi vel felis. mauris consectetur tortor et purus.</p>
					</div>
					<div id="tabs-3">
						<p>
							22222222222222222 <br>22222222222222
						</p>
					</div>
				</div>
			</div>
		</div>
		<div class="ui-layout-south">
			<div id = 'accordion' >
				<h3><a href="#">Section 1</a></h3>
				<div>
					<p>1
					Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet
					purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor
					velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In
					suscipit faucibus urna.
					</p>
					<p>1
					Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet
					purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor
					velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In
					suscipit faucibus urna.
					</p>
					<p>1
					Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet
					purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor
					velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In
					suscipit faucibus urna.
					</p>
					<p>1
					Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet
					purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor
					velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In
					suscipit faucibus urna.
					</p>
				</div>
				<h3><a href="#">Section 2</a></h3>
				<div>
					<p>2
					Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet
					purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor
					velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In
					suscipit faucibus urna.
					</p>
				</div>
				<h3><a href="#">Section 3</a></h3>
				<div>
					<p>3
					Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet
					purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor
					velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In
					suscipit faucibus urna.
					</p>
				</div>
			</div>
		</div>
	</div>
</body>
</html>