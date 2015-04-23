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
jqGrid 查询 之 单字段查询</h1>

<div class="hotmap">
    <a href="#summary">调用方法</a><a href="#use">Options</a><a href="#case">发送往服务器端的数据结构</a><a href="#property">colModel 中的参数</a>
    </div>

<p>单字段查询只是字面翻译，更确切的翻译是：字段可选条件可选的查询，单字段的意思是一次只能选一个字段和一个条件。</p>

<p>该查询会创建一个弹窗，查询的操作都在弹窗中完成。</p>

<p><strong>值得注意的事</strong>，与自定义查询和工具栏过滤不同，该查询发往服务器的参数别具一格。</p>

<h2>
<a name="调用方法" class="anchor" id="summary"><span class="octicon octicon-link"></span></a>调用方法</h2>

<div class="highlight highlight-js"><pre class="brush: js">$("#grid_id").jqGrid("searchGrid", options);
</pre></div>

<ul>
<li>options 是一个对象，做为该方法的参数。</li>
</ul><h2>
<a name="options" class="anchor" id="use"><span class="octicon octicon-link"></span></a>Options</h2>

<p>有很大一部分参数和 表单编辑 中的参数相同。 </p>

<table>
<tbody><tr>
<th>属性名</th>
        <th>类型</th>
        <th>详细</th>
        <th>默认值</th>
    </tr>
<tr>
<td>afterShowSearch</td>
        <td>函数</td>
        <td>查询弹窗显示后执行该函数。</td>
        <td>null</td>
    </tr>
<tr>
<td>beforeShowSearch</td>
        <td>函数</td>
        <td>查询弹窗显示前执行该函数。</td>
        <td>null</td>
    </tr>
<tr>
<td>closeAfterSearch</td>
        <td>布尔值</td>
        <td>设为 true 时，点击“查询”按钮后关闭弹窗。</td>
        <td>false</td>
    </tr>
<tr>
<td>closeAfterReset</td>
        <td>布尔值</td>
        <td>设为 true 时，撤销查询时关闭弹窗。</td>
        <td></td>
    </tr>
<tr>
<td>drag</td>
        <td>布尔值</td>
        <td>弹窗是否可以拖拽。</td>
        <td>true</td>
    </tr>
<tr>
<td>resize</td>
        <td>布尔值</td>
        <td>弹窗是否拖动改变大小。</td>
        <td>true</td>
    </tr>
<tr>
<td>modal</td>
        <td>布尔值</td>
        <td>弹窗是否模态。</td>
        <td>false</td>
    </tr>
<tr>
<td>width</td>
        <td>数值</td>
        <td>弹窗的宽度。</td>
        <td>450</td>
    </tr>
<tr>
<td>height</td>
        <td>字符串或者数值</td>
        <td>弹窗的高度。</td>
        <td>auto</td>
    </tr>
<tr>
<td>top</td>
        <td>数值</td>
        <td>弹窗顶部的位置。</td>
        <td>0</td>
    </tr>
<tr>
<td>left</td>
        <td>数值</td>
        <td>弹窗左部的位置。</td>
        <td>0</td>
    </tr>
<tr>
<td>caption</td>
        <td>字符串</td>
        <td>弹窗的标题。</td>
        <td></td>
    </tr>
<tr>
<td>showQuery</td>
        <td>布尔值</td>
        <td>
            设为 true 时，会显示用户的查询条件，类似 sql 。 <br>
            会出现一个按钮，可以切换显示/不显示。<br>
            高阶查询中才有效。 
        </td>
        <td>false</td>
    </tr>
<tr>
<td>searchOnEnter</td>
        <td>布尔值</td>
        <td>是否将 [Enter] 键做为查询快捷键。</td>
        <td>false</td>
    </tr>
<tr>
<td>Find</td>
        <td>字符串</td>
        <td>查询按钮上的文本。</td>
        <td></td>
    </tr>
<tr>
<td>multipleSearch</td>
        <td>布尔值</td>
        <td>设为 true 时，会激活高阶查询。</td>
        <td>false</td>
    </tr>
<tr>
<td>multipleGroup</td>
        <td>布尔值</td>
        <td>可让多个分组嵌套，详见 高阶查询 。</td>
        <td>false</td>
    </tr>
<tr>
<td>odata</td>
        <td>对象</td>
        <td> 属性 sopt 中的缩略语所对应的全称。 </td>
        <td></td>
    </tr>
<tr>
<td>onClose</td>
        <td>函数</td>
        <td>弹窗关闭时执行该函数。返回值为 fasle 时，弹窗不会被关闭。</td>
        <td>null</td>
    </tr>
<tr>
<td>afterRedraw</td>
        <td>函数</td>
        <td>改变查询字段或者查询条件时，执行该函数。</td>
        <td>null</td>
    </tr>
<tr>
<td>onSearch</td>
        <td>函数</td>
        <td>点击查询按钮时执行。</td>
        <td>null</td>
    </tr>
<tr>
<td>onReset</td>
        <td>函数</td>
        <td>点击撤销按钮时执行。</td>
        <td>null</td>
    </tr>
<tr>
<td>closeOnEscape</td>
        <td>布尔值</td>
        <td>设为 true 时，[Esc]键关闭弹窗。</td>
        <td>false</td>
    </tr>
<tr>
<td>onInitializeSearch</td>
        <td>函数</td>
        <td>弹窗被创建时执行，该函数只执行一次。<br>
            有一个参数，jQuery对象，包含查询自动的最近父 div 元素。
        </td>
        <td>null</td>
    </tr>
<tr>
<td>recreateForm</td>
        <td>布尔值</td>
        <td>设为 true 时，每次显示弹窗事都重新创建 form 元素。</td>
        <td>false</td>
    </tr>
<tr>
<td>showOnLoad</td>
        <td>布尔值</td>
        <td>只在“navigator”的参数中有效。表格初始化完成后就显示查询弹窗。</td>
        <td>false</td>
    </tr>
<tr>
<td>errorcheck</td>
        <td>布尔值</td>
        <td></td>
        <td></td>
    </tr>
<tr>
<td>Reset</td>
        <td>字符串</td>
        <td>撤销按钮上的显示文本。</td>
        <td>"重置"</td>
    </tr>
<tr>
<td>sField</td>
        <td>字符串</td>
        <td>详见下面的数据构成。</td>
        <td>searchField</td>
    </tr>
<tr>
<td>sFilter</td>
        <td>字符串</td>
        <td>只适用于 高阶查询，即传递数据的名称。<br>
            比如默认值是 filters ，那么服务端就可以获取 "filters" 。
        </td>
        <td>filters</td>
    </tr>
<tr>
<td>sOper</td>
        <td>字符串</td>
        <td>详解下面的数据构成。</td>
        <td>searchOper</td>
    </tr>
<tr>
<td>sopt</td>
        <td>数组</td>
        <td>查询类型，比如“等于”，“包含于”等。 <br>
            在基本概念中有很详尽的描述。
        </td>
        <td></td>
    </tr>
<tr>
<td>sValue</td>
        <td>字符串</td>
        <td>详见下面的数据构成。</td>
        <td>searchString</td>
    </tr>
<tr>
<td>overlay</td>
        <td>数值</td>
        <td>如果设置为 0 ，那么就不是模态弹窗。？？似乎和 modal 重复了。</td>
        <td></td>
    </tr>
<tr>
<td>layer</td>
        <td>字符串</td>
        <td>必须是 html 中合法的 id 值。 <br>
            “过滤器”会成为该元素的子元素。
        </td>
        <td>null</td>
    </tr>
<tr>
<td>zIndex</td>
        <td>整数</td>
        <td>弹窗的 z-index 。</td>
        <td>950</td>
    </tr>
</tbody></table><h2>
<a name="发送往服务器端的数据结构" class="anchor" id="case"><span class="octicon octicon-link"></span></a>发送往服务器端的数据结构</h2>

<p>这个结构与 filterToolbar 和自定义查询的结构不同。</p>

<p>假如 colModel 中的 index 为 name ，对应的文本框的值为 name1，查询的条件是 "eq" ，那么：</p>

<div class="highlight highlight-js"><pre class="brush: js"> filters:"",     // 这个在高阶查询中会用到
page:1,
sidx:"id",
sord:"asc",
rows:30,       // 这四个参数一直都在

serachField: name,      
searchString: name1,
searchOper:"eq",       // searchField, searchString, searchOper 三个属性名都可以在 options 中更改。
_search:true
</pre></div>

<p>难道上述参数后就可以很容易的做查询了。</p>

<h2>
<a name="colmodel-中的参数" class="anchor" id="property"><span class="octicon octicon-link"></span></a>colModel 中的参数</h2>

<p>在 jqGrid 的 3.5 之后，所有的查询方法都可以使用 colModel 中的一些参数，详细请参见查询之一 基本概念</a> 。</p>



   
</div>
<script type="text/javascript">
            SyntaxHighlighter.defaults["toolbar"] = false;
            SyntaxHighlighter.all();
        </script>      
</body>
</html>