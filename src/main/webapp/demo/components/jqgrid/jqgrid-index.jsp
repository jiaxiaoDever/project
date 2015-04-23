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
<style type="text/css">
    .ui-layout-content,.ui-layout-content{overflow: hidden;}
</style>
</head>
<body>
	<div id="west" class = "ui-layout-west">
        <ul id = "tree" class = "ztree"></ul>
    </div>
	<div class = "ui-layout-center">
        <div class = "yhui-tabs-header">
            <div class = "yhui-tabs-header-inner">
                <ul>
                    <li><a href = "#tabs-1">jqGrid 的 参数</a></li>
                </ul>
            </div>
        </div>
        <div class = "ui-layout-content">
            <div id = "tabs-1">
            	<iframe frameborder = "0" style = "width:100%; height: 100%;"></iframe>
            </div>
        </div>
    </div>

 <script type = "text/javascript">
            var Homepage = {
                layout: function() {
                    $( document.body ).yhLayout( {
                        west: {
                            minSize: 100,
                            size: 215,
                            maxSize: 280
                        },
                        center: {
                            onresize: function( a, b ) {
                                Homepage.tabs.yhTabs( "update" );                                
                            }
                            // $("#tabs-1 iframe").accordion("refresh");
                        },
                        addBorder: true
                    } );
                },            

                initTabs: function( selector ) {
                    this.tabs = $( selector ).eq( 0 ).yhTabs({
                        frame: true,
                        showLoading: true,
                        create: function() {
                            $.yhui.loadingFadeOut();
                            Homepage.initTreemenu( "#tree" );
                            $("div.ui-layout-resizer-north").eq(0).remove();
                            //$.yhui.byId( "tabs-1" ).firstChild.src = "../../manual/document2014/api/yhLayout.html";
                            $( "#tabs-1" ).children("iframe").attr("src","../../manual/component/jqGrid_options.jsp");
                        }
                    });
                },                

                initTreemenu: function( selector ) {
                    var $l = $( "#west" ).yhLoading();  // 给加载中的树一个 loading
                    $( selector ).yhTreemenu({
                        source: "demo.json",
                        expandLevel: 1,
                        onClick: function( e, yhui ) {
                            var $li = $( "#" + yhui.node.tId );
                            if ( !yhui.node.isNewWindow ) {
                                Homepage.tabs.yhTabs( "addTab", $li, yhui.node.link );
                            } else {
                                window.open( yhui.node.link, "_blank" );
                            }
                        },
                        createdTree: function( e, yhui ) {
                            $l.yhLoading("destroy"); // 加载完成，取消 loading 。
                        },
                        contextMenu: {
                            width: 76,
                            menu: {
                                "新窗口打开": function( e, target, container ) {
                                    var name = $.trim( $( target ).closest("li").text() ),
                                        tree = $.data( container[0], "yhTreemenu" ).tree,
                                        node = tree.getNodeByParam( "name", name );
                                    if ( node && node.link ) {
                                        window.open( node.link, "_blank" );
                                    }
                                }
                            },
                            beforeShow: function( e , yhui ) {
                                var name = $.trim( $( yhui.target ).closest( "li" ).find( "a" ).eq(0).text() ),
                                    tree = $.data( yhui.container[0], "yhTreemenu" ).tree,
                                    node = tree.getNodeByParam( "name", name );
                                return node && !node.isParent;
                            }
                        }
                    });
                }
            };

            YHUI.use( "yhLayout yhMenu yhTabs yhLoading yhTreemenu yhDialogTip yhThemePicker", function() {
                Homepage.layout();
                Homepage.initTabs( "div.ui-layout-center:first" );
            });

</script>



</body>
</html>
