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
 jqGrid 自定义单元格内容 之 自定义</h1>

<div class="hotmap">
    <a href="#summary">格式化(format)</a><a href="#use">还原</a><a href="#case">创建通用的格式化、还原函数</a>    </div>

<p>jqGrid 单元格默认的内容是文本，但是有时候需要放个 a 标签进去，这就要自定义内容了。</p>

<p>这个自定义单元格的过程在 jqGrid 中被成为格式化，有两种格式化方法：</p>

<p>预定义(Predefined )和自定义(Custom)。</p>

<p>本文介绍自定义。</p>

<p>总有些情况预定于不是用，所以自定义必不可少。</p>

<p>jqGrid 自定义单元格内容比较简单，一个函数格式化内容，一个函数还原。</p>

<h2>
<a name="格式化format" class="anchor" id="summary"><span class="octicon octicon-link"></span></a>格式化(format)</h2>

<div class="highlight highlight-js"><pre class="brush: js">$("#grid").jqGrid({
    ...
    colModel:[ 
        ... 
        { name:"price", index:"price", width:>60, align:"center", editable:true, formatter: currencyFmatter},
        ...
    ]
    ...
});

function currencyFmatter( cellvalue, options, rowObject){
    // do something here
    return new_format_value
}
</pre></div>

<p>上面的自定义函数，必须有合适的返回值。</p>

<ul>
<li><p>cellvalue 单元格内容，等待被格式化</p></li>
<li>
<p>options 一个对象</p>

<ul>
<li>
<p><code>options: { rowId: id, colModel: cm }</code></p>

<p>rowId 就是所在行 id </p>

<p>colModel 就是 jqGrid 的 colModel 中对应该列的值</p>
</li>
</ul>
</li>
<li><p>rowObject 改行的数据，通常为一个数组</p></li>
</ul><h2>
<a name="还原" class="anchor" id="use"><span class="octicon octicon-link"></span></a>还原</h2>

<p>预定义(Predefined ) 所定义的格式是适用于“编辑”模块的，这就是说，
那些链接啊什么的在转为可编辑状态时，就要取消格式化，也就是还原。
另外，有些获取数据的方法( getRowData 和 getCell )也要还原单元格内容。</p>

<p>所以除了要有自定义格式化的函数，还要有自定义还原的函数。</p>

<p>比如单元格内容是指向图标的链接，我们想让其显示为图片：</p>

<div class="highlight highlight-js"><pre class="brush: js">$("#grid").jqGrid({
    ...
    colModel:[ 
      ... 
      {name:"price", index:"price", width:60, align:"center", editable:true, formatter: imageFormat, unformat: imageUnFormat},
      ...
    ]
...
});

function imageFormat( cellvalue, options, rowObject){
    return '&lt;img src="'+cellvalue+'" /&gt;';
}
function imageUnFormat( cellvalue, options, cell){
    return $("img", cell).attr("src");
}
</pre></div>

<p>还原函数的几个参数：</p>

<ul>
<li><p>cellvalue 还原之前的单元格内容</p></li>
<li><p>options 和格式化函数相同</p></li>
<li><p>cell 单元格的 jQuery 对象</p></li>
</ul><h2>
<a name="创建通用的格式化还原函数" class="anchor" id="case"><span class="octicon octicon-link"></span></a>创建通用的格式化、还原函数</h2>

<p>某些格式化、还原函数函数特别常用，比如上面的显示图片，比如在货币前面加上 "￥" 。</p>

<p>这时候，你如下创建通用函数对：</p>

<div class="highlight highlight-js"><pre class="brush: js">$.extend( $.fn.fmatter,{
    currencyFmatter:function( cellvalue, options, rowdata){
        return"$"+ cellvalue;
    }
});
$.extend( $.fn.fmatter.currencyFmatter,{
    unformat:function( cellvalue, options){
        return cellvalue.replace("$","");
    }
});
</pre></div>

<p>使用起来就很容易了，而且，可以不用设置还原函数：</p>

<div class="highlight highlight-js"><pre class="brush: js">$("#grid").jqGrid({
    ...
    colModel:[ 
        ... 
        { name:"price", index:"price", width:60, align:"center", editable:true, formatter:"currencyFmatter"},
        ...
    ]
...
</pre></div>
</div>
  <script type="text/javascript">
            SyntaxHighlighter.defaults["toolbar"] = false;
            SyntaxHighlighter.all();
        </script>   
</body>
</html>