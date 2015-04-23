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
    <div class="yhui-header ui-layout-north">    	
    </div> 
	<div class="ui-layout-center">
	  <div class = "yhui-tabs-header">
         <div class = "yhui-tabs-header-inner">
           <ul>
             <li><a href = "#tabs-1">欢迎</a></li>
           </ul>
         </div>
       </div>  
       <div class = "ui-layout-content" style="overflow:hidden;">
          <div id = "tabs-1">
          	<iframe frameborder = "0" style = "width:100%; height: 100%;"></iframe>
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
                },

    initTabs: function( selector ) {
                    this.tabs = $( selector ).eq( 0 ).yhTabs({
                        frame: true,
                        showLoading: true,
                        create: function() {
                            $.yhui.loadingFadeOut();
                            Homepage.initTreemenu( "#tree" );
                            $("div.ui-layout-resizer-north").eq(0).remove();
                            $($.yhui.byId( "tabs-1" )).find("iframe").attr( "src" ,ctx +"/demo/welcome.jsp");
                        }
                    });
                },
            };
    YHUI.use( "yhLayout yhTabs", function() {
                Homepage.layout();
                Homepage.initTabs( "div.ui-layout-center:first" );
            });
</script>
</body>
</html>
