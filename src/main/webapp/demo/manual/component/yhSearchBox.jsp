<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>搜索框</title>
    <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metadoc.jsp" %>
</head>
<body>
    <div class="container">
        <h1>yhSearchBox，搜索框</h1>
        <div class="hotmap">
            <a href="#summary">概述</a><a href="#use">使用方法</a><a href="#guide">导航</a><a href="#case">案例</a><a href="#property">属性</a><a href="#method">方法</a><a href="#return">回调函数</a><a href="#faq">常见问题</a>
            </div>
        <div class="content">
            <h2 id="summary">概述</h2>
            <div class="panel">
                <p>搜索框，最有名的是 google 。</p>
                <p>yhSearchBox，目前还很弱，只能搜索 zTree 的节点。</p>
                <p>所以，使用起来也很简单。</p>
                <p> 典型的 html 结构如下：</p>
                
            </div>

            <h2 id="use">使用方法</h2>
            <div class="panel">
                <p>html</p>
                <pre class="brush:xml">
                    <div class="ui-layout-west">
                        
                        <!-- search box placeholder, init when use yhSearchBox() -->
                        <div id = "box" class="yhui-searchbox"></div>
                        
                        <div class="ui-layout-content">
                            <!-- just ztree -->
                            <ul id="tree" class="ztree"></ul>
                        </div>

                    </div>
                </pre>
                <p>js调用</p>
                <pre class="brush:js">
                    $("#id").yhSearchBox({});
                </pre>  
            </div>

            <h2 id="property">属性</h2>
            <div class="panel">
                <p class="arrow">tree</p>
                <div class="panel2">
                    <p> zTree 对象。</p>
                    <p>如果你调用 zTree 原生方法 $.fn.zTree.init，那么返回的就是 zTree 对象。</p>
                    <p>使用 yhui 修改版 api，则用 getTree 方法获取该对象。</p>
                    <pre class="brush:js">
                        // init tree and get zTree object
                        var node = xxxx,
                            tree = $("#tree").yhTree( {}, node ).yhTree( "getTree" );

                        //init searchbox, just pass the zTreeObj
                        $("#box").yhSearchBox({
                            tree: tree
                        });
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