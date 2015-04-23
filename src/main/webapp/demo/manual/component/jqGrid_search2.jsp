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
jqGrid 查询 之 自定义查询</h1>
<div class="hotmap">
    <a href="#summary">使用语法</a><a href="#use">参数</a><a href="#case">其他方法</a>
    </div>
<p><strong>在编写 demo 的时候，发现 filterGrid 方法不存在，以被官方弃用，不建议使用。</strong>
唉，陈旧文档害死人啊害死人。</p>

<p>通过方法 filterGrid 来查询表格。</p>

<p>jqGrid 的自定义查询能够给表格创建一个自定义的查询表单。</p>

<p>这个方法将参数传到属性 url 所指向的服务器端。</p>

<p>开始查询时， 一个对象（键值对）被传递到服务器端。注意的是，这个对象也会被填入属性 postData。
当撤销查询时，postData 也会被清空。</p>

<p>jqGrid 尽可能地将 colModel 中的 index 做为属性名传向服务端，如果没有 index ，则是使用 name 。</p>

<p>jqGrid 只传递有数据的字段（非空文本框）。</p>

<p>最后， _search=true 会和 postData 一起被传向服务器端。</p>

<h2>
<a name="使用语法" class="anchor" id="summary"><span class="octicon octicon-link"></span></a>使用语法</h2>

<h4>
<a name="html" class="anchor" href="#html"><span class="octicon octicon-link"></span></a>html</h4>

<div class="highlight highlight-html"><pre class="brush: xml">&lt;table id="grid"&gt;&lt;/table&gt;
&lt;div id="pager"&gt;&lt;/div&gt;
&lt;div id="mysearch"&gt;&lt;/div&gt;
</pre></div>

<p>如上，必须有一个 div#mysearch ，以创建表单，位置随意，但我还是建议像上面一样的写。</p>

<h4>
<a name="js" class="anchor" href="#js"><span class="octicon octicon-link"></span></a>js</h4>

<div class="highlight highlight-js"><pre class="brush: js">$("#mysearch" jqGrid( "filterGrid", "#grid", options );
</pre></div>

<ul>
<li><h1>
<a name="grid-是-table-的-id-值" class="anchor" href="#grid-%E6%98%AF-table-%E7%9A%84-id-%E5%80%BC"><span class="octicon octicon-link"></span></a>grid 是 table 的 id 值</h1></li>
<li><p>options 是一个对象，也就是该方法的参数，如下。</p></li>
</ul><h2>
<a name="参数" class="anchor" id="use"><span class="octicon octicon-link"></span></a>参数</h2>

<p>参数是做为一个对象传入这个方法的，可用值如下：</p>

<table>
<tbody><tr>
<th>属性名</th>
        <th>描述</th>
        <th>默认值</th>
    </tr>
<tr>
<td>gridModel</td>
        <td>
            布尔值。是否使用 colModel 中的参数来构建查询表单，来自 colModel 中的属性如下：name, index, 
            edittype, editoptions, search 。<br>
            另外，还可以在 colModel 中加入只对该方法有效的属性，如下： <br><strong>defval</strong>：查询表单的初始化数据。 <br><strong>surl</strong>：当 edittype 为 select 时有效，surl 指向填有 select 具体机构的 html 。<br>
            当该值为 false 时，jqGrid 会依据一个 filterModel(如下) 来创建表单。

        </td>
        <td>false</td>
    </tr>
<tr>
<td>gridNames</td>
        <td>
            当 gridModel 为 true 时，该值有效。<br>
            设为 true 时，会使用 colNames 来做为查询字段的名称。
        </td>
        <td>false</td>
    </tr>
<tr>
<td>filterModel</td>
        <td>
            当 gridModel 为 false 时，该值有效。<br>
            这是一个很类似 colModel 的对象，详见本表格下方。
        </td>
        <td>空数组</td>
    </tr>
<tr>
<td>formtype</td>
        <td>字符串。表单被创建的方式，可以是 'horizontal' 或者 'vertical' 。</td>
        <td>horizontal</td>
    </tr>
<tr>
<td>autosearch</td>
        <td>布尔值。当设置为 true 时，会有如下行为： <br>
            当用户在 input 元素中输入一些值，按 [Enter] 键会执行查询； <br>
            如果有 select 元素，其值被改变时，执行查询。 <br>
            当设为 false 时，我们可以使用 button 来执行查询。
        </td>
        <td>true</td>
    </tr>
<tr>
<td>formclass</td>
        <td>字符串。给被创建的表单添加类名。</td>
        <td>"filterform"</td>
    </tr>
<tr>
<td>tableclass</td>
        <td>字符串。可以给表单中的表格添加类名。</td>
        <td>"filtertable"</td>
    </tr>
<tr>
<td>buttonclass</td>
        <td>字符串。给按钮添加的类名。</td>
        <td>"filterbutton"</td>
    </tr>
<tr>
<td>searchButton</td>
        <td>字符串。查询按钮上的文本。</td>
        <td></td>
    </tr>
<tr>
<td>clearButton</td>
        <td>字符串。撤销查询按钮上的文本。</td>
        <td></td>
    </tr>
<tr>
<td>enableSearch</td>
        <td>布尔值，启用/禁用查询按钮。</td>
        <td>false</td>
    </tr>
<tr>
<td>enableClear</td>
        <td>布尔值，启用/禁用撤销按钮。</td>
        <td>false</td>
    </tr>
<tr>
<td>beforeSearch</td>
        <td>函数。在查询之前触发。</td>
        <td>null</td>
    </tr>
<tr>
<td>afterSearch</td>
        <td>函数。在查询之后触发。</td>
        <td>null</td>
    </tr>
<tr>
<td>beforeClear</td>
        <td>函数。在撤销之前触发。</td>
        <td>null</td>
    </tr>
<tr>
<td>afterClear</td>
        <td>函数。在撤销之后触发。</td>
        <td>null</td>
    </tr>
<tr>
<td>url</td>
        <td>字符串。传递的服务器的路径，如果设置的话，将会覆盖 jqGrid 的 url 。</td>
        <td>空字符串</td>
    </tr>
</tbody></table><h4>
<a name="filtermodel" class="anchor" href="#filtermodel"><span class="octicon octicon-link"></span></a>filterModel</h4>

<div class="highlight highlight-js"><pre class="brush: js">filterModel:[
    … 
    { 
        label:'LableFild', 
        name: 'colname', 
        stype: 'select', 
        defval: 'default_value', 
        surl: 'someurl', 
        sopt:{ optins for the select }
    },
    …
</pre></div>

<ul>
<li><p>label: 表单字段的 label。</p></li>
<li><p>name: 列名称，应该和 colModel 中的 name 相对。</p></li>
<li><p>stype: 自动的类型，可以是 'text' 或者 'select' 。</p></li>
<li><p>defval: 字段的初始值</p></li>
<li>
<p>surl: 当 stype 为 true 时有效。</p>

<p>指向装有 select 结构的 html，如下：</p>

<pre class="brush: xml">   &lt;select&gt; 
        &lt;option value='val1'&gt; Value1 &lt;/option&gt; 
        &lt;option value='val2'&gt; Value2 &lt;/option&gt; 
        … 
        &lt;option value='valn'&gt; ValueN &lt;/option&gt; 
    &lt;/select&gt; 
</pre>
</li>
</ul><p>sopt: 对象，给字段添加的属性，和 colModel 中 editoptions 一样。</p>

<h2>
<a name="其他方法" class="anchor" id="case"><span class="octicon octicon-link"></span></a>其他方法</h2>

<p>当使用 filterGrid 方法时，能够使用下面的两个特权方法。</p>

<ul>
<li>
<p>triggerSearch</p>

<p>以编程的方式执行一次查询，如下：</p>

<pre class="brush: js">    ```js
    var sg = $("#mysearch").filterGrid(...)[0]; 
    sg.triggerSearch();
    ```
</pre>
</li>
<li>
<p>clearSearch</p>

<p>撤销查询：</p>

<pre class="brush: js">    ```js
    sg.clearSearch();
    ```
</pre>
</li>
</ul><p>最后，再次吐槽这两个方法坑爹的 API 。</p>



   
</div>
  <script type="text/javascript">
            SyntaxHighlighter.defaults["toolbar"] = false;
            SyntaxHighlighter.all();
        </script>    
</body>
</html>