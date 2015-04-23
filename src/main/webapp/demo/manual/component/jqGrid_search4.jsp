<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>布局</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metadoc.jsp" %>
<style type="text/css">
.container table {
    display: block;
    overflow: auto;
    width: 100%;
}
.container table th {
    font-weight: bold;
}
.container table th, .container table td {
    border: 1px solid #DDDDDD;
    padding: 6px 13px;
}
.container table tr {
    background-color: #FFFFFF;
    border-top: 1px solid #CCCCCC;
}
.container table tr:nth-child(2n) {
    background-color: #F8F8F8;
}
p{ margin: 15px 0;}
</style>
</head>
<body>
<div class="container">
        
<h1>
jqGrid 查询 之 高阶查询</h1>

<div class="hotmap">
    <a href="#summary">调用语法</a><a href="#use">属性</a><a href="#case">向服务器端传递的数据</a>
    </div>

<p>高阶查询，多字段多条件的的查询。</p>

<p>高阶查询和单字段查询使用同一个方法 searchGrid ，但是设置项和传送的数据不同。</p>

<h2>
<a name="调用语法" class="anchor" id="summary"><span class="octicon octicon-link"></span></a>调用语法</h2>

<div class="highlight highlight-js"><pre class="brush: js">$("#grid_id").jqGrid("searchGrid",{ multipleSearch: true,...});
</pre></div>

<ul>
<li>multipleSearch 设为 true 即启用高阶查询。</li>
</ul><p>让查询条件更复杂一点：</p>

<div class="highlight highlight-js"><pre class="brush: js">$("#grid_id").jqGrid("searchGrid",{
    multipleSearch: true,
    multipleGroup: true
    ... 
});
</pre></div>

<p>单字段是单字段单查询条件，比如 id 字段，值为 1 ，条件为“以xx开始”，那么就查询以 1 开始的 id 的所有记录。</p>

<p>假如再加一个条件，“或者以 2 开始的 id ”，那么这个时候就有一个 "or" 连接符。</p>

<p>jqGrid 称这种情况为一个分组( group )。</p>

<p>还有更复杂的情况就是嵌套查询，还是上面的例子，查询以 1 开始的 id 的所有记录。</p>

<p>然后再在这些记录中搜索以 2 结尾的 id 的所有记录。这种情况就是一个嵌套查询。</p>

<p>jqGrid 处理嵌套的方式，是添加分组( group )，上面的参数 multipleGroup 就是这么个作用。</p>

<h2>
<a name="属性" class="anchor" id="use"><span class="octicon octicon-link"></span></a>属性</h2>

<p>高阶查询和<a href="../../manual/component/jqGrid_search3.jsp">单字段查询</a>的属性一样。</p>

<h2>
<a name="向服务器端传递的数据" class="anchor" id="case"><span class="octicon octicon-link"></span></a>向服务器端传递的数据</h2>

<p>其实和单字段查询一样，只不过有效值不同：</p>

<div class="highlight highlight-js"><pre class="brush: js">filters:{      // 高阶查询的所有条件都在这个里面
    groupOp:"OR",  // 连接字
    rules:[{ field:<span class="s2">"a.id", op:"eq", data:1}],
    groups:[   // 嵌套查询的分组
        {
            groupOp:"AND",
            rules:[{ field:"a.id", op:"eq", data:"2"}],
            groups:[...]
        }
    ]
},
page:1,
sidx:"id",
sord:"asc",
rows:30,       // 这四个参数一直都在

serachField:"",      
searchString:"",
searchOper:"",       // 这三个是单字段查询的参数
_search: true
</pre></div>

<ul>
<li><p>groupOp 不同条件之间的关系，可以是 "AND" 和 "OR" 。</p></li>
<li>
<p>rules 包含如下字段：</p>

<ul>
<li><p>field  字段名称，来自 colModel 中的 name </p></li>
<li><p>op 字段和其值之间的关系，比如“等于”、“包含于”什么的</p></li>
<li><p>data 字段的值了</p></li>
</ul>
</li>
<li><p>groups 嵌套查询的分组</p></li>
</ul>
   
</div>
  <script type="text/javascript">
            SyntaxHighlighter.defaults["toolbar"] = false;
            SyntaxHighlighter.all();
        </script>   
</body>
</html>