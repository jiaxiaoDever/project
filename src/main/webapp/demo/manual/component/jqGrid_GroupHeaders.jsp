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
jqGrid 之 表头分组</h1>
 <div class="hotmap">
    <a href="#summary">使用限制</a><a href="#use">如何使用</a>
    </div>
<p>在列头之上可以添加一行，用来给列分组，就是表头分组。这个功能在 Excel 中再常见不过。</p>

<p>jqGrid 支持两种分组方式： colSpan 和非 colSpan 。</p>

<p>无图无真相——</p>

<p>colSpan</p>

<p><img src="https://github.com/jiangyuan/blog/raw/master/note/docOfjqGrid/images/colSpan.png" alt="colSpan" style="max-width:100%;"></p>

<p>非 colSpan</p>

<p><img src="https://github.com/jiangyuan/blog/raw/master/note/docOfjqGrid/images/noColSpan.png" alt="非 colSpan" style="max-width:100%;"></p>

<p>可见，两者的区别主要是体现在不参与分组的列上。</p>

<h2>
<a name="使用限制" class="anchor" id="summary"><span class="octicon octicon-link"></span></a>使用限制</h2>

<ul>
<li><p>表头排序和列分组冲突，两者选其一。</p></li>
<li><p>选中列(Column Chooser) 也和列分组冲突。</p></li>
</ul><h2>
<a name="如何使用" class="anchor" id="use"><span class="octicon octicon-link"></span></a>如何使用</h2>

<p>当表格初始化完成后，调用方法 setGroupHeaders 来给列分组，如下：</p>

<div class="highlight highlight-js"><pre class="brush: js">
$("#grid").jqGrid("setGroupHeaders",{
    useColSpanStyle:true, 
    groupHeaders:[
        {startColumnName:"id",numberOfColumns:2,titleText:"第一组"},
        {startColumnName:"state">,numberOfColumns:2,titleText:"第二组"}
    ]
});
</pre></div>

<h3>
<a name="参数解析" class="anchor" href="#%E5%8F%82%E6%95%B0%E8%A7%A3%E6%9E%90"><span class="octicon octicon-link"></span></a>参数解析</h3>

<p>调用 setGroupHeaders 会创建分组，创建分组之后，该方法的参数会被存储到 jqGrid 的参数中，
名为 groupHeader，可以通过 getGridParam 方法来获取。
相对的，调用 destroyGroupHeader 方法后，默认情况下会删除这个 groupHeader 。</p>

<p>参数列表：</p>

<table>
<tbody><tr>
<th>属性名</th>
        <th>类型</th>
        <th>详情</th>
        <th>默认值</th>
    </tr>
<tr>
<td>useColSpanStyle</td>
        <td>布尔值</td>
        <td>是用 colSpan 模式还是用 nonColSpan 模式。</td>
        <td>false</td>
    </tr>
<tr>
<td>groupHeaders</td>
        <td>数组</td>
        <td>该数组的元素是对象，用来描述分组的相关规则以及文本。详见下表。</td>
        <td>空</td>
    </tr>
</tbody></table><p>groupHeaders 中元素详细：</p>

<table>
<tbody><tr>
<th>属性名</th>
        <th>类型</th>
        <th>详情</th>
    </tr>
<tr>
<td>startColumnName</td>
        <td>字符串</td>
        <td>
            分组的开始。值都是来自 colModel 中的 name ，表示对应列。<br>
            隐藏列忽略。
        </td>
    </tr>
<tr>
<td>numberOfColumns</td>
        <td>整数</td>
        <td>
            分组的列数，即多少列分为一组。 <br>
            隐藏列忽略，但是会计数。
        </td>
    </tr>
<tr>
<td>titleText</td>
        <td>字符串</td>
        <td>分组的标题字符。可以包含 html 标签。</td>
    </tr>
</tbody></table><h3>
<a name="取消分组" class="anchor" href="#%E5%8F%96%E6%B6%88%E5%88%86%E7%BB%84"><span class="octicon octicon-link"></span></a>取消分组</h3>

<p>通过 destroyGroupHeader 来撤销分组，将表格还原到原始状态。</p>

<div class="highlight highlight-js"><pre class="brush: js">
$("#grid").jqGrid("destroyGroupHeader");
</pre></div>

<p>该方法带有一个布尔类型的参数，默认为 true ，你可以设为 false ：</p>

<div class="highlight highlight-js"><pre class="brush: js">$("#grid").jqGrid("destroyGroupHeader",false);
</pre></div>

<p>分组仍旧被撤销，但是上面说得的　groupHeader 属性不会被删除，
再次创建分组时就可以使用这个 groupHeader 来替代具体的参数了。</p>
   
</div>
 <script type="text/javascript">
            SyntaxHighlighter.defaults["toolbar"] = false;
            SyntaxHighlighter.all();
        </script>    
</body>
</html>