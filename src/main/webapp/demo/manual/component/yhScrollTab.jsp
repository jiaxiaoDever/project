<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>滚动选项卡</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metadoc.jsp" %>
</head>
<body>
    <div class="container">
        <h1>yhScrollTab，滚动选项卡</h1>
        <div class="hotmap">
            <a href="#summary">概述</a><a href="#use">使用方法</a><a href="#guide">导航</a><a href="#case">案例</a><a href="#property">属性</a><a href="#method">方法</a><a href="#faq">常见问题</a>
            </div>
        <div class="content">
            <h2 id="summary">概述</h2>
            <div class="panel">
                <p>滚动选项卡，似乎在互联网公司使用的比较多。</p>
                <p>yhScrollTab，其实没有做完，但是一般场景应该够用了。</p>             
            </div>

            <h2 id="use">使用方法</h2>
            <div class="panel">
                <p>html</p>
                <pre class="brush:xml">
                    <div id = 'scrolltab'>
                        <ul>
                            <li><a href="#tabs_1">标题一</a></li>
                            <li><a href="#tabs_2">标题二</a></li>
                            <li><a href="#tabs_3">标题三</a></li>
                            <li><a href="#tabs_4">标题四</a></li>
                        </ul>
                        <div>
                            <div id = 'tabs_1'>内容区1</div>
                            <div id = 'tabs_2'>内容区2</div>
                            <div id = 'tabs_3'>内容区3</div>
                            <div id = 'tabs_4'>内容区4</div>
                        </div>
                    </div>
                </pre>
                <p>js调用</p>
                <pre class="brush:js">
                    $("#id").yhScrollTab({});
                </pre>  
            </div>

            <h2 id="guide">导航</h2>
            <div class="panel">
                <div class="nav">
                    <ul>
                        <li>属性</li>
                        <li><a href="#selected">selected</a></li>
                        <li><a href="#height">height</a></li>
                    </ul>
                    <ul>
                        <li>方法</li>
                        <li><a href="#selecte">selecte</a></li>
                    </ul>
                </div>
            </div>

            <h2 id="property">属性</h2>
            <div class="panel">
                <p class="arrow" id="selected">selected</p>
                <div class="panel2">
                    <p>初始化时，默认选中的面板。</p>
                    <p>数值，从 0 开始的整数。默认值为 0 。</p>
                    <pre class="brush:js; highlight:[2]">
                        $("#scrolltab").yhScrollTab({
                            selected: 3     //默认选中第 4 个面板
                        });
                    </pre>
                </div>

                <p class="arrow" id="height">height</p>
                <div class="panel2">
                    <p>面板的高度。</p>
                    <p>数值，单位 px。默认值为 300 。</p>
                    <pre class="brush:js; highlight:[2]">
                        $("#scrolltab").yhScrollTab({
                            height: 400     // 高度设置为 400px
                        });
                    </pre>
                </div>
            </div>

            <h2 id="method">方法</h2>
            <div class="panel">
                <p class="arrow" id="select">select( id )</p>
                <p>选中某个面板。</p>
                <p>接受一个参数，字符串，面板的 id 值。</p>
                <pre class="brush:js; highlight:[3]">
                    var $scroll = $("#scrolltab").yhScrollTab();
                    ...
                    $scroll.yhScrollTab( "select", "tabs_4" );      // 选中第四个面板
                </pre>
            </div>
            
            <h2 id="faq">常见问题</h2>
            <div class="panel">
                待续
            </div>  

            <br><br><a href="#summary">回到顶部</a>

        </div>
    </div>

    <script type="text/javascript">
        SyntaxHighlighter.defaults["toolbar"] = false;
        SyntaxHighlighter.all();
    </script>
</body>
</html>