<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>窗口</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metadoc.jsp" %>
</head>
<body>
    <div class="container">
        <h1>yhWindow，窗口</h1>
        <div class="hotmap">
            <a href="#summary">概述</a><a href="#use">使用方法</a><a href="#guide">导航</a><a href="#case">案例</a><a href="#property">属性</a><a href="#method">方法</a><a href="#return">回调函数</a><a href="#faq">常见问题</a>
            </div>
        <div class="content">
            <h2 id="summary">概述</h2>
            <div class="panel">
                <p>窗口，继承于对话框( <a href="http://192.168.1.168:9080/YHUI1.2/Components/dialog.html" target="_blank">dialog</a> )但区别之。</p>
                <p>窗口其实是模拟 windows，有任务栏和一些列的可最大化、最小化、关闭按钮的窗口，<a target="_blank" href="http://192.168.1.168:9080/YHUI1.2/Components/yhWindow.html">DEMO</a>。</p>
                <p>webqq 就是将窗口用到了极致。</p>
                <p>目前来看，在项目中用的比较少。</p>
                <p>在 html 中放置占位 div ： </p>
                
            </div>

            <h2 id="use">使用方法</h2>
            <div class="panel">
                <p>html</p>
                <pre class="brush:js">
                    <div title="窗口" id="window"></div>
                </pre>
                <p>js调用</p>
                <pre class="brush:js">
                    $("#id").yhWindow({});
                </pre>  
            </div>


            <h2 id="guide">导航</h2>
            <div class="panel">
                <p>继承自 <a href="http://api.jqueryui.com/dialog/" target="_blank">dialog</a> ， dialog 中的属性、方法、事件回调<strong>仍旧有效</strong>。</p>
                <div class="nav">
                    <ul>
                        <li>属性</li>
                        <li><a href="#maxi">maxi</a></li>
                        <li><a href="#mini">mini</a></li>
                        <li><a href="#fold">fold</a></li>
                        <li><a href="#showTaskBar">showTaskBar</a></li>
                    </ul>
                </div>
            </div>
           
            <h2 id="property">属性</h2>
            <div class="panel">
                <p class="arrow" id="maxi">maxi</p>
                <div class="panel2">
                    <p>出现最大化按钮。</p>
                    <p>布尔值。 默认值 true 。</p>
                    <pre class="brush:js;highlight:[2]">
                        $("#window").yhWindow({
                            maxi: false     // 不出现最大化按钮
                        });
                    </pre>
                </div>

                <p class="arrow" id="mini">mini</p>
                <div class="panel2">
                    <p>出现最小化按钮。</p>
                    <p>布尔值。 默认值 true 。</p>
                    <pre class="brush:js;highlight:[2]">
                        $("#window").yhWindow({
                            mini: false     // 不出现最小化按钮
                        });
                    </pre>
                </div>

                <p class="arrow" id="fold">fold</p>
                <div class="panel2">
                    <p>出现折叠按钮。</p>
                    <p>布尔值。 默认值 true 。</p>
                    <pre class="brush:js;highlight:[2]">
                        $("#window").yhWindow({
                            mini: false     // 不出现折叠按钮
                        });
                    </pre>
                </div>

                <p class="arrow" id="showTaskBar">showTaskBar</p>
                <div class="panel2">
                    <p>打开一个窗口，是否出现在任务栏上。</p>
                    <p>布尔值，默认值 true 。</p>
                    <pre class="brush:js;highlight:[2]">
                        $("#window").yhWindow({
                            showTaskBar: false     // 该窗口不出现在任务栏
                        });

                        // 如果页面只有这一个窗口，则不会创建任务栏。
                    </pre>
                </div>

                <h2 id="faq">常见问题</h2>
            <div class="panel">
                待续
            </div>  

            <br><br><a href="#summary">回到顶部</a>
            
            </div>
        </div>
    </div>

    <script type="text/javascript">
        SyntaxHighlighter.defaults["toolbar"] = false;
        SyntaxHighlighter.all();
    </script>
</body>
</html>