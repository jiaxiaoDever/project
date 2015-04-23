<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang = "en" >
<head>
<meta charset = "UTF-8">
<title>帮助手册</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
</head>
<body>
<div class="yhui-header ui-layout-north ui-helper-clearfix">
    <div class="yhui-header-inner">
        <div>YHUI帮助手册<input id = "search" type="text" placeholder="搜索 yhui 组件" /></div>
    </div>
    <ul class = "yhui-menu" id = "menu"></ul>
</div>
<div class = 'ui-layout-center' >       
    <iframe frameborder = "0" style = "width:100%; height: 100%;" src="component/index.html"></iframe>
</div>
<script type = "text/javascript">
var Homepage = {
    layout: function() {
        $( document.body ).yhLayout( {
            north: {
                size: 65,
                spacing_open: 0
            },
            center: {
                onresize: function( a, b ) {
                    Homepage.tabs.yhTabs( "update" );
                }
            },
            addBorder: true
        } );
    },            
    initTopMenu: function( selector, url ) {
        $( selector ).yhMenu( {
            url: url,
            onClick: function( e, yhui ) {
                if ( yhui.node.name !== "使用文档" ) {
                    Homepage.tabs.yhTabs( "addTab", $( this ), yhui.node.link );
                }
                else {
                    window.open( yhui.node.link, "_blank" );
                }
            }
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
                $.yhui.byId( "tabs-1" ).firstChild.src = "welcome.html";
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
    Homepage.initTopMenu( "#menu", "helpMenuData.txt" );
});

</script>
</body>
</html>