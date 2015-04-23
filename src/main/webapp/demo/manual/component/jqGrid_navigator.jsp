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
jqGrid 导航栏 之 翻页区</h1>

<div class="hotmap">
    <a href="#summary">定义</a><a href="#use">和翻页区相关的属性</a>
    </div>

<p>jqGrid 在渲染导航栏的时候，其实分为三个部分，也就是三列：</p>

<ul>
<li>第一列是导航(navigator)，里面会有些查询按钮什么的，我们称之为 <strong>功能区</strong> 吧。</li>
<li>第二列是翻页按钮之类的东东，其实这才是翻页栏，我们称之为 <strong>翻页区</strong> 吧。</li>
<li>第三列是放置记录信息，比如总记录条数，我们称之为 <strong>信息区</strong> 吧。</li>
</ul><p>本文涉及到翻页区和信息区。</p>

<p>如果你的数据少到一屏就可以展示完，那么你估计也不会为了怎么翻页发愁。
这只是一个美好的愿望，大多数时候都是要处理海量数据的，当然，如果你一次性的将所有数据都加载出来，那么
仍旧不用为分页发愁。</p>

<p>分页，可以一次加载一点点数据，响应快速，用户体验尤佳，这个时候 <strong>翻页栏</strong> 就有存在的必要了。</p>

<h2>
<a name="定义-definition" class="anchor" id="summary"><span class="octicon octicon-link"></span></a>定义 (definition)</h2>

<p><strong>第一步</strong> 翻页栏要依托一个 div 元素，你可以随意放置 div 的位置，但我还是建议将页面写成如下格式：</p>

<pre class="brush: xml"><code>&lt;body&gt;
    ...
    &lt;table id="list"&gt;&lt;/table&gt; 
    &lt;div id="gridpager"&gt;&lt;/div&gt; 
    ...
&lt;/body&gt;
</code></pre>

<p><strong>第二步</strong> javascript 代码：</p>

<pre class="brush: js"><code>jQuery("#list").jqGrid({
    ...
    pager : '#gridpager',
    ...
});
</code></pre>

<blockquote>
<p>属性 pager 的取值有如下三种形式：</p>

<p>"#girdpager", "gridpager", $("#gridpager")</p>

<p>但是我强烈建议你使用第一种或者第二种，因为第三种在使用 导入和导出 功能时有点问题。</p>
</blockquote>

<p>对于翻页栏中具体的文字信息，实际上都是定义在语言文件中，yhui 的情况如下：</p>

<pre class="brush: js"><code>defaults : {
    recordtext: "{0} - {1}\u3000共 {2} 条",   // 共字前是全角空格
    emptyrecords: "无数据显示",
    loadtext: "读取中...",
    pgtext : " {0} 共 {1} 页"
}
</code></pre>

<p>毫无疑问，你可以改变这些文字，比如修改 emptyrecords:</p>

<pre class="brush: js"><code>jQuery("#grid_id").jqGrid({
    ...
    pager : '#gridpager',
    emptyrecords: "Nothing to display",
    ...
});
</code></pre>

<p>通常情况下，翻页栏是在表格的底部，但是你也完全定义一个拷贝放到表格的顶部。</p>

<p>到目前为止，翻页栏中的图标都是写死的，不能自定义。这些图标是来自 jQuery UI 的皮肤。</p>

<h2>
<a name="和翻页区相关的属性" class="anchor" id="use"><span class="octicon octicon-link"></span></a>和翻页区相关的属性</h2>

<table>
<tbody><tr>
<td>属性名</td>
        <td>类型</td>
        <td>描述</td>
        <td>默认值</td>
        <td>是否可改</td>
    </tr>
<tr>
<td>lastpage</td>
        <td>数值</td>
        <td>只读属性，表示总页数。</td>
        <td>0</td>
        <td>否</td>
    </tr>
<tr>
<td>pager</td>
        <td>混合类型</td>
        <td>页面中的哪一个 div 当作翻页栏，其取值在上面已经讲过了，不再赘述。</td>
        <td>空字符串</td>
        <td>否</td>
    </tr>
<tr>
<td>pagerpos</td>
        <td>字符串</td>
        <td> 翻页区的位置。 </td>
        <td> "center" </td>
        <td>否</td>
    </tr>
<tr>
<td>pgbuttons</td>
        <td>布尔值</td>
        <td>是否出现翻页按钮，也就是左右箭头啊什么的。</td>
        <td>true</td>
        <td>否</td>
    </tr>
<tr>
<td>pginput</td>
        <td>布尔值</td>
        <td>是否出现填写页数的文本框。</td>
        <td>true</td>
        <td>否</td>
    </tr>
<tr>
<td>recordpos</td>
        <td>字符串</td>
        <td>信息区的位置。</td>
        <td>"right"</td>
        <td>否</td>
    </tr>
<tr>
<td>records</td>
        <td>数值</td>
        <td>只读属性。数据的总记录条数。</td>
        <td>none</td>
        <td>否</td>
    </tr>
<tr>
<td>recordtext</td>
        <td>string</td>
        <td>翻页去所显示的文本。请务必按照上面的 defaults 中的 recordtext 格式来写。</td>
        <td>看上面。</td>
        <td>可</td>
    </tr>
<tr>
<td>rowList</td>
        <td>数组</td>
        <td>这个数组里的值，是会渲染到一个下拉框中去的。表示一页所显示的记录条数。</td>
        <td>空数组</td>
        <td>否</td>
    </tr>
<tr>
<td>rowNum</td>
        <td>数值</td>
        <td>一页显示多少条数据。</td>
        <td>20</td>
        <td>可</td>
    </tr>
<tr>
<td>viewrecords</td>
        <td>boolean</td>
        <td>是否显示上面说的信息区。</td>
        <td>fasle</td>
        <td>否</td>
    </tr>
</tbody></table>
 
</div>
    <script type="text/javascript">
            SyntaxHighlighter.defaults["toolbar"] = false;
            SyntaxHighlighter.all();
        </script>   
</body>
</html>