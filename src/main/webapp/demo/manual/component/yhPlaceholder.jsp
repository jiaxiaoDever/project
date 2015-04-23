<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>占位符</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metadoc.jsp" %>
</head>
<body>
    <div class="container">
        <h1>yhPlaceholder，占位符</h1>
        <div class="hotmap">
            <a href="#summary">概述</a><a href="#use">使用方法</a><a href="#guide">导航</a><a href="#case">案例</a><a href="#property">属性</a><a href="#method">方法</a><a href="#return">回调函数</a><a href="#faq">常见问题</a>
            </div>
        <div class="content">
            <h2 id="summary">概述</h2>
            <div class="panel">
                <p> html5 对表单有极大的增强，比如这个文本占位符。 </p>
                <p> input:text 元素中可以设置 placeholder 属性来达到占位符效果，也就是空时出现占位符。</p>
                <p> 不支持 html5 的浏览器不支持这个属性，但是可以用 yhPlaceholder 来模拟类似的功能。 </p>
                
            </div>

            <h2 id="use">使用方法</h2>
            <div class="panel">
                <p>html</p>
                <pre class="brush:xml">
                    <input id="holder" type="text" placeholder="我是占位符" />
                </pre>
            </div>

            <h2 id="guide">导航</h2>
            <div class="panel2">
                <div class="nav">
                    <ul>
                        <li>属性</li>
                        <li><a href="#placeholder">placeholder</a></li>
                    </ul>
                </div>
            </div>

            
            <h2 id="property">属性</h2>
            <div class="panel">
                <p class="arrow" id="placeholder">placeholder</p>
                <div class="panel2">
                    <p>占位符文本。这个属性会覆盖 html 标签中的 placeholder 。</p>
                    <pre class="brush:js; highlight: [6]">
                        // 如上的 html 结构，默认调用如下：
                        $( "#holder" ).yhPlaceholder();

                        // 使用 placeholder 属性
                        $( "#holder" ).yhPlaceholder({
                            placeholder: "占位符"      // 覆盖 input 中的 placeholder
                        });
                    </pre>
                </div>
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