<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Document</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
</head>
<body>
<div class="yhui-header ui-layout-north ui-helper-clearfix">头部区</div>
<div id="mainContent" class="ui-layout-center" >
	<div class="ui-layout-center">
		<div id = 'toolbar' class = 'yhToolbar'>				
		</div>
		<div class="ui-layout-content">
			<br/>中间-上
		</div>
	</div>
	<div class="ui-layout-south">
		<div id = 'toolbar1' class = 'yhToolbar'>				
		</div>
		<div class="ui-layout-content">
			<br/>中间-下
		</div>			
	</div>
</div>
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
	
	$('#toolbar,#toolbar1').yhToolbar({//toolbar改造自一个插件，所以挖掘的不是很深
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
});
</script>
</body>
</html>