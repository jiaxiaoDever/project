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
jqGrid 冻结列</h1>

<div class="hotmap">
    <a href="#summary">使用</a><a href="#use">限制</a>    </div>

<p>jqGrid 很容易实现冻结列。冻结列不会因为滚动而离开视野，这在处理很宽的表格时是非常有用的。</p>

<h2>
<a name="使用" class="anchor" id="summary"><span class="octicon octicon-link"></span></a>使用</h2>

<p>设置起来是很简单的。</p>

<h3>
<a name="创建" class="anchor" href="#%E5%88%9B%E5%BB%BA"><span class="octicon octicon-link"></span></a>创建：</h3>

<p>第一步：</p>

<p>在属性 colModel 中添加 frozen: true ，如下：</p>

<div class="highlight highlight-javascript"><pre class="brush: js">colModel: [
    { name:"id", label:"编号", width:100, sortable:false, frozen:true }, // forzen 属性，关键
    { name:"id", label:"机构名称", width:150, sortable:false, frozen:true },
    { name:"id", label:"ORG类型", width:100, sortable:false },
    { name:"id", label:"父 ID", width:200, sortable:false },
    { name:"id", label:"状态", width:200, sortable:false },
    { name:"id", label:"描述", width:300, sortable:false },
    { name:"id", label:"日期", width:300, sortable:false },
    { name:"id", label:"ORG 层级", width:300, sortable:false }
]
</pre></div>

<p>第二步：</p>

<p>调用方法 setFrozenColumns ，如下：</p>

<div class="highlight highlight-js"><pre class="brush: js">$("#grid" ).jqGrid("setFrozenColumns" );
</pre></div>

<p>冻结列必须是连续的，比如第一第二列都设置了 frozen: true ，那么会冻结，如果是第一第三列被设置了，那么只会冻结第一列。</p>

<h3>
<a name="销毁" class="anchor" href="#%E9%94%80%E6%AF%81"><span class="octicon octicon-link"></span></a>销毁</h3>

<p>有些时候可能要撤销冻结，可以使用 destroyFrozenColumns ，如下：</p>

<div class="highlight highlight-js"><pre class="brush: js">$("#grid" ).jqGrid("destroyFrozenColumns" );
</pre></div>

<h3>
<a name="动态设置" class="anchor" id="use"><span class="octicon octicon-link"></span></a>动态设置</h3>

<p>有时候，可能要在表格初始化完成后再冻结列，那么可以先销毁，再冻结，如下：</p>

<div class="highlight highlight-js"><pre class="brush: js">$("#grid" )
    .jqGrid("destroyFrozenColumns" );
    .jqGrid("setColProp","invdate", {frozen:true} )
    .jqGrid("setFrozenColumns" )
    .trigger("reloadGrid", [{current:true}] );
</pre></div>

<h2>
<a name="限制" class="anchor" href="#%E9%99%90%E5%88%B6"><span class="octicon octicon-link"></span></a>限制</h2>

<p>冻结列有很大的局限性，如下：</p>

<ul>
<li><p>使用树形表格时，冻结列无效。</p></li>
<li><p>使用子表格时，冻结列无效。</p></li>
<li><p>单元格编辑时，冻结列无效。</p></li>
<li><p>行内编辑时，冻结的列不可编辑。</p></li>
<li><p>列可排序时，冻结列无效。</p></li>
<li><p>启用“滚动条加载数据”时，冻结列无效。</p></li>
<li><p>启用数据分组时，冻结列无效。</p></li>
</ul>
</div>
  <script type="text/javascript">
            SyntaxHighlighter.defaults["toolbar"] = false;
            SyntaxHighlighter.all();
        </script>   
</body>
</html>