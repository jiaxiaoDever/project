<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
	<title>五分钟教你筛选zTree节点</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
	<script type="text/javascript">
		YHUI.use("yhLayout zTree yhSearchBox", function() {
			$( document.body ).yhLayout();

			// get ztree nodes
            $.getJSON( "treeData.txt" )
				.done(function( node ) {

					// init tree and get zTree object
					var tree = $("#tree").yhTree( {}, node ).yhTree( "getTree" );

					// expand first level node
					for ( var i = 0, nodes = tree.getNodes(), l = nodes.length; i < l; i ++ ) {
						tree.expandNode( nodes[i], true );
					}

                    //init searchbox, just pass the zTreeObj
					$("#bar").yhSearchBox({
						tree: tree
					});
				});


			
		});
	</script>
</head>
<body>

	<div class="ui-layout-west">
		<div class="yhui-west-header">
			<!-- search box placeholder, init when use yhSearchBox() -->
			<div id = "bar" class="yhui-searchbox"></div>
		</div>
		<div class="yhui-west-content">
			<ul id="tree" class="ztree"></ul>
		</div>

	</div>
	<div class="ui-layout-center"></div>

</body>
</html>