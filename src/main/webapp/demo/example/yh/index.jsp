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
        <div class = "yhui-cover yhui-whole-loading"></div>
        <div class = "yhui-cover yhui-whole-overlay"></div>
        <div class = "yhui-header ui-layout-north">
            <div class = "yhui-header-inner">
                <div>
                    <a class = "yhui-header-welcome" href = "#">欢迎您，1admin!</a>
                    <a href = "#" class = "yhui-header-password">[10]</a>
                    |
                        <span id = "userRole" class = "yhui-header-role">用户角色
                            <ul class = "yhui-header-rolelist">
                                <li><a href = "#">管理员管理员群众理员群众</a></li>
                                <li><a href = "#">群众</a></li>
                                <li><a href = "#">党员</a></li>
                                <li><a href = "#">共青团员</a></li>
                            </ul>
                        </span>
                    |
                    <a href = "#">个人信息</a>
                    |
                    <a href = "#">注销</a>
                </div>
            </div>
            <ul class = "yhui-menu" id = "menu"></ul>
        </div>
        <!-- <div id="west" class = "ui-layout-west">
            <ul id = "tree" class = "ztree"></ul>
        </div> -->
        <div class = "ui-layout-center">
            <div class = "yhui-tabs-header">
                <div class = "yhui-tabs-header-inner">
                    <ul>
                        <li><a href = "#tabs-1">欢迎使用昱辉基础平台</a></li>
                    </ul>
                </div>
            </div>
            <div class = "ui-layout-content noscroll">
                <div id = "tabs-1">
                	<iframe frameborder = "0" id="mianiframe"></iframe>
                </div>
            </div>
        </div>
        <script type = "text/javascript">
        var Homepage = {

                layout: function() {
                    $( document.body ).yhLayout( {
                        north: {
                            size: 65,
                            spacing_open: 0
                        },
                        west: {
                            minSize: 100,
                            size: 215,
                            maxSize: 280
                        },
                        center: {
                            onresize: function( a, b ) {
                                Homepage.tabs.yhTabs( "update" );
                            }
                        },
                        addBorder: true
                    } );
                    $("#mianiframe").css({
					"width":"100%",
					"height":"100%"
					}).attr( "src", "test.html" );
                },

    //             $("#mianiframe").css({
				// "width":"100%",
				// "height":"100%"
				// }).attr( "src", "txt.html" );

                // passWordTip: function( $dom ) {
                //     var domContent = $dom[0].innerHTML,
                //         leftDay = domContent.substring( 1, domContent.length - 1 ),
                //         text = "密码将在" + leftDay + "天后失效，请尽快修改。",
                //         $span = $( "<span>" + text + "</span>" );

                //     $dom.effect( "pulsate", { mode: "show", times: 1, duration: 600 } )
                //             .on( "mouseenter mouseleave click", function( e ) {
                //                 switch ( e.type ) {
                //                     case "mouseleave":
                //                         $span.remove();
                //                         break;
                //                     case "mouseenter":
                //                         $span.appendTo( $dom );
                //                         break;
                //                     case "click":
                //                         return false;
                //                 }
                //             });
                // },

                // userRole: function() {
                //     $( "#userRole" ).hover( function() {
                //         $( this ).toggleClass( 'userRoleHover' ).find( 'ul' ).slideToggle( 100 );
                //     } );
                // },

                // initTopMenu: function( selector, url ) {
                //     $( selector ).yhMenu( {
                //         url: url,
                //         onClick: function( e, yhui ) {
                //             if ( yhui.node.name !== "使用文档" ) {
                //                 Homepage.tabs.yhTabs( "addTab", $( this ), yhui.node.link );
                //             } else {
                //                 window.open( yhui.node.link, "_blank" );
                //             }
                //         }
                //     } );
                // },

                initTabs: function( selector ) {
                    this.tabs = $( selector ).eq( 0 ).yhTabs({
                        frame: true,
                        showLoading: true,
                        create: function() {
                            $.yhui.loadingFadeOut();
                            Homepage.initTreemenu( "#tree" );
                            $("div.ui-layout-resizer-north").eq(0).remove();
                            $.yhui.byId( "tabs-1" ).firstChild.src = "txt.html";
                        }
                    });
                },

                // themePicker: function( holder ) {
                //     $.yhui.yhThemePicker( holder );
                // },

                // initTreemenu: function( selector ) {
                //     var $l = $( "#west" ).yhLoading();  // 给加载中的树一个 loading
                //     $( selector ).yhTreemenu({
                //         source: "demo.json",
                //         expandLevel: 1,
                //         onClick: function( e, yhui ) {
                //             var $li = $( "#" + yhui.node.tId );
                //             if ( !yhui.node.isNewWindow ) {
                //                 Homepage.tabs.yhTabs( "addTab", $li, yhui.node.link );
                //             } else {
                //                 window.open( yhui.node.link, "_blank" );
                //             }
                //         },
                //         createdTree: function( e, yhui ) {
                //             $l.yhLoading("destroy"); // 加载完成，取消 loading 。
                //         },
                //         contextMenu: {
                //             width: 76,
                //             menu: {
                //                 "新窗口打开": function( e, target, container ) {
                //                     var name = $.trim( $( target ).closest("li").text() ),
                //                         tree = $.data( container[0], "yhTreemenu" ).tree,
                //                         node = tree.getNodeByParam( "name", name );
                //                     if ( node && node.link ) {
                //                         window.open( node.link, "_blank" );
                //                     }
                //                 }
                //             },
                //             beforeShow: function( e , yhui ) {
                //                 var name = $.trim( $( yhui.target ).closest( "li" ).find( "a" ).eq(0).text() ),
                //                     tree = $.data( yhui.container[0], "yhTreemenu" ).tree,
                //                     node = tree.getNodeByParam( "name", name );
                //                 return node && !node.isParent;
                //             }
                //         }
                //     });
                // }
            };         

                
				//resourceList.htmls
            YHUI.use( "yhLayout yhMenu yhTabs yhLoading yhTreemenu yhDialogTip yhThemePicker", function() {
                Homepage.layout();
                // Homepage.themePicker( $( "div.yhui-header-inner" ).find( "div" ).first() );
                // Homepage.passWordTip( $( "a.yhui-header-password" ).eq( 0 ) );
                // Homepage.userRole();
                Homepage.initTabs( "div.ui-layout-center:first" );
                // Homepage.initTopMenu( "#menu", "json/indexMenuData.txt" );
            });
        </script>
    </body>
</html>
