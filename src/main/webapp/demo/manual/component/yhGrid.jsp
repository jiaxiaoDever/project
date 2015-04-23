<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title> 表格 </title>
    <link rel = "stylesheet" href = "../css/api.css">
    <link rel = "stylesheet" href = "../hightLigthter/css/shCore.css">
    <link rel = "stylesheet" href = "../hightLigthter/css/shThemeDefault.css">
    <style type="text/css">
        table { margin-left: 50px; border-collapse: collapse; }
        td, th { padding: 5px; border: 1px solid #BBB; font-size: 12px; text-align: center; }
        td:first-child{ font-weight: bold; }
    </style>
    <script type = "text/javascript" src="../hightLigthter/js/jquery-1.8.3.min.js"></script>
    <script type = "text/javascript" src="../hightLigthter/js/shCore.js"></script>
    <script type = "text/javascript" src="../hightLigthter/js/shBrushJScript.js"></script>
    <script type = "text/javascript" src="../hightLigthter/js/shBrushXml.js"></script>
</head>
<body>
    <div class="container">
        <h1>yhGrid，表格控件</h1>
        <div class="content">
            <h2>概述</h2>
            <div class="panel">
                <p> 面向企业后台的框架，最最重要的组件就是表格。 </p>
                <p>yhGrid，99% 脱胎于 jqGrid 。</p>
                <p> jqGrid <a href="http://www.trirand.com/blog/">官网</a>，<a href="https://github.com/jiangyuan/blog/tree/master/note/docOfjqGrid">中文使用文档</a>。</p>
                <p>本篇主要是介绍下 yhGrid 特有的属性和方法。</p>
            </div>

            <h2>导航</h2>
            <div class="panel2">
                <div class="nav">
                    <ul>
                        <li>属性</li>
                        <li><a href="#contextMenu">contextmenu</a></li>
                        <li><a href="#expandLevel">heightstyle</a></li>
                    </ul>
                    <ul>
                        <li>方法</li>
                        <li><a href="#refresh">refresh</a></li>
                    </ul>
                </div>
            </div>

            <h2>属性</h2>
            <div class="panel">
                <p class="arrow" id="contextmenu">contextmenu</p>
                <div class="panel2">
                    <p>布尔值，是否绑定右键菜单。</p>
                    <p>默认值 false 。</p>
                    <pre class="brush:js; highlight: [3]">
                        $( "#grid" ).yhGrid({
                            ...
                            contextmenu: true,
                            ...
                        });
                    </pre>
                </div>


                <p class="arrow" id="heightStyle">heightStyle</p>
                <div class="panel2">
                    <p>目前自由一个值合法，"fill" ，自适应表格高宽。</p>
                </div>
            </div>


            <h2>方法</h2>
            <div class="panel">
                <p class="arrow" id="refresh">refresh</p>
                <div class="panel2">
                    <p>重新计算表格的高宽，使之自适应。</p>
                    <pre class="brush:js;highlight:[3]">
                        var grid = $( "#grid" ).yhGrid();
                        ...
                        grid.yhGrid( "refresh" );
                    </pre>
                </div>
            </div>

        </div>
    </div>
    
    <script type="text/javascript">
        SyntaxHighlighter.defaults["toolbar"] = false;
        SyntaxHighlighter.all();
    </script>
</body>
</html>