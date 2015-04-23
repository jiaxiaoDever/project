<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>表单布局</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metadoc.jsp" %>
</head>
<body>
    <div class="container">
        <h1>yhFormField，昱辉表单布局</h1>
        <div class="hotmap">
            <a href="#summary">概述</a><a href="#use">使用方法</a><a href="#guide">导航</a><a href="#case">案例</a><a href="#property">属性</a><a href="#method">方法</a><a href="#return">回调函数</a><a href="#faq">常见问题</a>
            </div>
        <div class="content">
            <h2 id="summary">概述</h2>
            <div class="panel">
                <p>表单布局其实是很高深的一门学问，大公司都有专人来研究表单应该怎样放置、怎样验证……</p>
                <p>yhFormField，谈不上如果的牛掰，但是可以轻松地将很多表单排列的很美观。</p>
                <p>一般情况下，yhFormField 只对 表单(form) 有效，并且只适用于 2、4、或者6列。</p>                
            </div>

            <h2 id="use">使用方法</h2>
            <div class="panel">
                <p>html</p>
                <pre class="brush:xml">
                    <form id = "formfield" class="yhui-forfield">
                        &lt;table&gt;
                            &lt;tr>
                                &lt;td>字段&lt;/td>
                                &lt;td>&lt;input type="text" />&lt;/td>
                            &lt;/tr>
                            &lt;tr>
                                &lt;td>字段&lt;/td>
                                &lt;td>&lt;input type="text" />&lt;/td>
                            &lt;/tr>
                        &lt;/table&gt;
                    </form>
                </pre>
                <p>js调用</p>
                <pre class="brush:js">
                    $("#id").yhFormField({});
                </pre>  
            </div>

            
            <h2 id="property">属性</h2>
            <div class="panel">
                <p class="arrow" id="hoverable">hoverable</p>
                <div class="panel2">
                    <p>鼠标移动某行时，会高亮此行。</p>
                    <p>布尔值。默认 false ，没有此效果。</p>
                    <pre class="brush:js">
                        $("#formfield").yhFormField({
                            hoverable: true             // 启用 hover 效果
                        });
                    </pre>
                </div>
            </div>

            <h2 id="return">回调函数</h2>
            <div class="panel">
                <p class="arrow" id="create">create</p>
                <div class="panel2">
                    <p>在组件初始化完成后执行。</p>
                    <p>所谓初始化完成是指组件的样式、高宽、以及 js 都准备就位。</p>
                    <pre class="brush:js">
                        $("#formfield").yhFormField({
                            create: function() {
                                alert( "表单布局初始化完成！" );
                            }
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