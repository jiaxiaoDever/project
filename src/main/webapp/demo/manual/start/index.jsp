<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang = "zh-CN">
<head>
<meta charset = "UTF-8">
<title>起步入门</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
<%@ include file="/common/metadoc.jsp" %>
</head>
<body>
<div class="ui-layout-west">
    <div class="side">
        <ul>
            <li><a href="#download" >下载</a></li>
            <li><a href="#list">目录结构</a></li>
            <li><a href="#cite">引用</a></li>
            <li><a href="#moudle">模板</a></li>
            <li><a href="#case">案例</a></li>
            <li><a href="#version">版本更新</a></li>
            <li><a href="#attention">额外注意</a></li>
            <li><a href="#faq">常见问题</a></li>
        </ul>
    </div>        
</div>
<div class="ui-layout-center">
    <div class="container">
    <h1>起步</h1>
        <div class="" id="main">
            <div class="block">
                <h2 id="download">下载</h2>
                <p>从SVN下载文件。svn地址：http://192.168.1.241:3001/svn/PCL/YH_BI/baseframe/01-受控库/15-机器代码/01-源代码/trunk/BaseFrame。</p>
                <p>目录位置：BaseFrame\src\main\webapp\static\yhui，将其中的 js 和 css 文件夹拷贝到你的项目。</p>
            </div>
            
            <div class="block">
                <h2 id="list">目录结构</h2>
                <p>yhui目录下有debug（研发版）、pro（发布版）。</p>
                <p>【研发】取debug的js、skins文件夹。【项目】取pro的js、skins文件夹。</p>
                <img src="../images/yhui_list.png" alt="">
            </div>

            <div class="block">
                <h2 id="cite">引用</h2>
                  <p>必须引用css、js文件，使用YHUI.use( "yhLayout", function() {......});方法。</p>
                  <p>【css、js引用】将 yhui-structure 、 yhui-skin 、 yhHead.js 依次引入你所要用到的页面。</p>
                  <pre class="brush:js">
                      <link rel = "stylesheet" href = "xxxx/yhui-sturcture.css">
                      <link rel = "stylesheet" href = "xxxx/yhui-skin.css">
                      <script type = "text/javascript" src="xxxxxx/yhHead.js"></script>
                   </pre> 
                   <p>可以将引用文件放到一个 <span class="code">assets.jsp</span> 中，方便各页面引入。</p>
                   <p>【调用(写在body结束标签前)】</p>
                   <pre class="brush:js">
                      <script type="text/javascript">
                        YHUI.use("yhLayout", function() {
                          $(document.body).yhLayout();      
                        });
                      </script>
                   </pre> 
            </div>

            <div class="block">
                <h2 id="moudle">模板</h2>
                <p>通用页面布局模板</p>
                <img src="../images/yhui_moudle.png" alt="">
                <pre class="brush: xml">                    
                        <!DOCTYPE html>
                        <html>
                        <head>
                            <meta charset="utf-8">
                            <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
                            <title>Document</title>
                            <meta name="description" content="">
                            <meta name="keywords" content="">
                            <link rel="stylesheet" type="text/css" href="../../yhui/debug/skins/yhui-structure.css"/>
                            <link rel="stylesheet" type="text/css" href="../../yhui/debug/skins/skinBlue/yhui-skin.css"/>
                            <script src="../../yhui/debug/js/base/yhHead.js" type="text/javascript"></script>
                        </head>
                        <body>
                            <div class="yhui-header ui-layout-north ui-helper-clearfix"></div>
                            <div class="ui-layout-west">
                                ......
                            </div>
                            <div class="ui-layout-center">
                               ......       
                            </div>
                            <script type="text/javascript">
                                YHUI.use( "yhLayout", function(){
                                    $(document.body).yhLayout({  });
                                })
                            </script>
                        </body>
                        </html>
                </pre>
            </div>

            <div class="block">
                <h2 id="case">案例</h2>
                <p>在线浏览：http://192.168.1.168:9080/YHUI1.3/</p>
                <p>SVN地址：http://192.168.1.241:3001/svn/PCL/YH_BI/baseframe/01-受控库/11-设计/前端设计/yhuihtml</p>
            </div>

            <div class="block">
                <h2 id="attention">额外注意</h2>
                <p>待续</p>
            </div>   

            <div class="block">
                <h2 id="faq">常见问题</h2>
                <p>待续</p>
            </div>      
                 
        </div>
    </div>

</div>
<script type = "text/javascript">
    YHUI.use("yhLayout yhToolbar", function() {
                $(document.body).yhLayout();
        });
    SyntaxHighlighter.defaults["toolbar"] = false;
    SyntaxHighlighter.all();
</script>
</body>
</html>