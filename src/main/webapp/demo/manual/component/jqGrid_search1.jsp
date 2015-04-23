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
jqGrid 查询 之 工具栏过滤</h1>

<div class="hotmap">
    <a href="#summary">调用方法</a><a href="#case">属性</a><a href="#use">其他</a>
    </div>

<p>工具栏过滤，其实是用到了一个方法 filterToolbar 。</p>

<p>调用该方法，会在表头的下方创建一行可输入的元素（如文本框），以此来过滤数据。</p>

<p>这个方法是将请求发送到 属性 url 指向的链接。</p>

<p>请求开始时，一个对象做为数据被发送到服务器，这个对象还被填入属性 postData ，该对象（键值对），包含了表单元素的名值对，和 _search: true ，如下：</p>

<div class="highlight highlight-js"><pre class="brush: js">{
    name1:value1,
    name2,value2,
    ...
    _search: true
}
</pre></div>

<p>空表单字段不会放入上述对象，也就是说，如果表单为空，将不会传到服务端。</p>

<p>jqGrid 会尽量使用 colModel 中的 index 而不是 name 来做为表单元素的 name 。</p>

<p>当撤销过滤时， postData 的值会被清空。</p>

<h2>
<a name="调用方法" class="anchor" id="summary"><span class="octicon octicon-link"></span></a>调用方法</h2>

<div class="highlight highlight-js"><pre class="brush: js">$("#grid_id" ).jqGrid("filterToolbar",options );
</pre></div>

<h2>
<a name="属性" class="anchor" id="case"><span class="octicon octicon-link"></span></a>属性</h2>

<p>上面代码中的 options 是该方法的参数，如下表：</p>

<p>该方法也会使用 colModel 中的一些属性，参见 基本概念 。</p>

<table>
<tbody><tr>
<th>方法名</th>
        <th>类型</th>
        <th>详细</th>
        <th>默认值</th>
    </tr>
<tr>
<td>autosearch</td>
        <td>布尔值</td>
        <td>
            自动查询。<br>
            自动执行查询按有如下方式：<br>
            如果是文本框，那么按 [Enter] 键就会执行。 <br>
            下拉框则是下拉改变选中值就可查询。
        </td>
        <td>true</td>
    </tr>
<tr>
<td>beforeSearch</td>
        <td>函数</td>
        <td>
            触发查询前会执行该函数。<br>
            返回值为 true (好奇葩！)时，会阻止查询，这种情况情况可以构建自己的查询。 <br>
            没有或者其他任何返回值都会执行查询。
        </td>
        <td>null</td>
    </tr>
<tr>
<td>afterSearch</td>
        <td>函数</td>
        <td>
            执行查询后执行
        </td>
        <td>null</td>
    </tr>
<tr>
<td>beforeClear</td>
        <td>函数</td>
        <td>
            在撤销查询前执行。
        </td>
        <td>null</td>
    </tr>
<tr>
<td>after</td>
        <td>函数</td>
        <td>撤销查询之后执行。</td>
        <td>null</td>
    </tr>
<tr>
<td>searchOnEnter</td>
        <td>布尔值</td>
        <td>
            执行查询的方式。<br>
            当该值和上面的 autosearch 同时为 true 时，按 [Enter] 键查询。<br>
            该值为 false，输入字符就开始查询。
        </td>
        <td>true</td>
    </tr>
<tr>
<td>stringResult</td>
        <td>布尔值</td>
        <td>
            传递数据的方式和内容。 <br>
            为 false 时，就是上面介绍的简单的键值对。 <br>
            为 true 时，和 高阶查询 传递的数据一样，会多一个字段 filter 。
        </td>
        <td>false</td>
    </tr>
<tr>
<td>groupOp</td>
        <td>字符串</td>
        <td>
            不同条件之间的关联关系，stringResult 为 true 时，该属性生效。<br>
            可选值有 "AND" 和 "OR" 。
        </td>
        <td>AND</td>
    </tr>
<tr>
<td>defaultSearch</td>
        <td>字符串</td>
        <td>
            查询数据的操作符，比如是“等于”还是“包含于”。<br>
            所有的字段都会使用该类型。 <br>
            默认值 bw ，表示“以xx开始”。<br>
            更多类型，请查看 <a href="/jiangyuan/blog/blob/master/note/docOfjqGrid/%E6%9F%A5%E8%AF%A2%E4%B9%8B%E4%B8%80%20%E5%9F%BA%E6%9C%AC%E6%A6%82%E5%BF%B5.md">基本概念</a>。
        </td>
        <td>bw</td>
    </tr>
</tbody></table><h2>
<a name="其他" class="anchor" id="use"><span class="octicon octicon-link"></span></a>其他</h2>

<p>当调用 filterToolbar 方法时，会动态生成几个方法：</p>

<table>
<tbody><tr>
<th>属性名</th>
        <th>详细</th>
    </tr>
<tr>
<td>triggerToolbar</td>
        <td>执行一次查询， 属性 search 被设置为 true ，并发送请求。</td>
    </tr>
<tr>
<td>clearToolbar</td>
        <td>撤销查询。 search 设为 false，传递的字段 _search 也变为 false ，从而还原到默认状态。 </td>
    </tr>
<tr>
<td>toggleToolbar</td>
        <td>轮流执行上述两种方法。</td>
    </tr>
</tbody></table><p>吐槽下调用方法，如下：</p>

<div class="highlight highlight-js"><pre class="brush: js">var grid=$("#grid_id")[0];
sgrid.triggerToolbar();
</pre></div>

<p>什么情况？</p>

<p>这些方法调用的方式真是让我一头雾水，完全可以改进一下。</p>




</div>
  <script type="text/javascript">
            SyntaxHighlighter.defaults["toolbar"] = false;
            SyntaxHighlighter.all();
        </script>    
</body>
</html>