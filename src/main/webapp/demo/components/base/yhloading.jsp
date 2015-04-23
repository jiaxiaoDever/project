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
<style type = "text/css">
            html, body { height: 100%; }
            h1 { font-size: 20px; }
            h1, p { margin: 10px 40px; }
            p { text-indent: 2em; }
            .con { float: left; margin: 30px; width: 200px; height: 200px; background-color: #AAA; }
</style>
</head>
<body>
     <h1> 加载效果 ( yhLoading )</h1>
        <p> ajax 和 iframe 加载的时候造成页面短暂空白，给客户造成不好的体验。</p>
        <p> 所以加载效果就有必要了 。</p>
        <p> yhLoading，适合各种情况的加载效果，可作用于任意元素。</p>
        <p> Example: <a href="tabs-loading.html">tabs</a>、<a href = "accordion-switch-pannel.html">折合面板</a>等。 </p>
        <p> 该页 DEMO 所在路径： Components/base/yhLoading.jsp 。</p>
        <p><strong>点击页面任意位置切换加载效果。</strong></p>
        <div class="con">中等图标</div>
        <div class="con">大号图标</div>
        <div class="con" id="loading">请重新尝试或联系<a href="http://www.baidu.com">管理员</a></div>
        <br style="clear:both;"/>
        <script type = "text/javascript">
            YHUI.use("yhLoading", function() {
                var $d = $( "div" );
                $d.eq( 0 ).yhLoading();
                $d.eq( 1 ).yhLoading({
                    size: "big"
                });
                $("#loading").yhLoading({
                    size: "big"
                });

                $( document.body )
                        .on("click", function() {
                            $d.yhLoading("isOpen") ? $d.yhLoading("close") : $d.yhLoading("open");
                        })
                        .on("click", "a", function() {
                            if ( parent ) {
                                parent.Homepage.tabs.yhTabs( "addTab", $(this), this.href );
                                return false;
                            }
                        });
            });
        </script>
</body>
</html>
