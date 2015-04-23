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
jqGrid 树形表格 之 邻接列表模型</h1>
<div class="hotmap">
 <a href="#property">treeReader</a><a href="#method">传递到服务器的数据</a><a href="#return">注意事项</a>
</div>


<p>临近列表模型指的是数据库存储树形数据的方式，这个和怎样组织数据息息相关。
而组织数据又和浏览器传递到服务器的参数息息相关，所谓 jqGrid 声称的支持临近列表模型，就是可以传递特定的参数。</p>

<p>如果你对临近列表模型(Adjacency List Model)很生疏，可以看看这篇译文《<a href="http://www.360doc.com/content/05/1215/11/3500_44502.shtml">在数据库中存储层次数据</a>》。</p>

<h2>
<a name="treereader" class="anchor" id="property"><span class="octicon octicon-link"></span></a>treeReader</h2>

<p>treeReader 是个属性，在树形表格之一 基本概念 有提及。</p>

<p>临近列表模型模型中， treeReader 的默认值如下：</p>

<div class="highlight highlight-js"><pre class="brush: js">treeReader = {
   level_field: "level",
   parent_id_field: "parent",
   leaf_field: "isLeaf",
   expanded_field: "expanded"
}
</pre></div>

<p>treeReader 会自动填入到数组 colModel 中，也就是说，服务端返回的数据除了要有对应的数据字段，还要加上 treeReader 中的属性。</p>

<table>
<tbody><tr>
<th>属性名</th>
        <th>类型</th>
        <th>详细</th>
    </tr>
<tr>
<td>level_field</td>
        <td>数值</td>
        <td>
            节点的层级。 <br>
            jqGrid 依次来缩进节点层次。
        </td>
    </tr>
<tr>
<td>parent_id_field</td>
        <td>字符串</td>
        <td>当前节点的父元素 id 值。 <br>
            如果为 null ，则是顶层节点。
        </td>
    </tr>
<tr>
<td>leaf_field</td>
        <td>布尔值</td>
        <td>
            是否是叶子节点。 <br>
            图标以及是否可展开都是由此决定。
        </td>
    </tr>
<tr>
<td>expanded_field</td>
        <td>布尔值</td>
        <td>
            是否初始化表格时就展开节点。 <br>
            通常情况下都是 false 。
        </td>
    </tr>
</tbody></table><h2>
<a name="传递到服务器的数据" class="anchor" id="method"><span class="octicon octicon-link"></span></a>传递到服务器的数据</h2>

<p>废话少说，如下：</p>

<div class="highlight highlight-js"><pre class="brush: js">postData : {
   ...
   nodeid: nodeid
   parentid: parent_id,
   n_level: level   
   ...
}
</pre></div>

<p>postData 是 jqGrid 的属性值，你可以自定义自己的属性传递到服务器。
在 treeGrid 为 true 并且 treeGridModel 为 ajansency 时，上面三个参数肯定会有。</p>

<h2>
<a name="注意事项" class="anchor" id="return"><span class="octicon octicon-link"></span></a>注意事项</h2>

<p>因为临近列表模型模型的缺陷，不建议一次加载完所有的数据，而是“点到再加载”。</p>
   
</div>
   <script type="text/javascript">
            SyntaxHighlighter.defaults["toolbar"] = false;
            SyntaxHighlighter.all();
        </script>    
</body>
</html>