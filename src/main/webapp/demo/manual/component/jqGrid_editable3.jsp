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
p,ol{ margin: 15px 0;}
ol{padding-left:50px;}
</style>
</head>
<body>
<div class="container">
<h1>
jqGrid 编辑 之 行内编辑</h1>

<div class="hotmap">
    <a href="#summary">editRow</a><a href="#use">saveRow</a><a href="#case">restoreRow</a><a href="#property">addRow</a><a href="#method">数据是怎么组织的</a><a href="#return">传递到服务器的数据</a>
    </div>

<p>行内编辑，就是将指定行的各列变为可编辑状态，jqGrid 包含这种功能。</p>

<p>下面是使用到的一些方法：</p>

<h2>
<a name="editrow" class="anchor" id="summary"><span class="octicon octicon-link"></span></a>editRow</h2>

<p>语法：</p>

<div class="highlight highlight-js"><pre class="brush: js">$("#grid_id").</span>jqGrid("editRow",</span>rowid,</span> keys,</span> oneditfunc,</span> successfunc,</span> url,</span> extraparam,</span> aftersavefunc,</span>errorfunc,</span> afterrestorefunc);</span>
</pre></div>

<p>参数</p>

<ul>
<li><p>rowid 编辑行的行 id </p></li>
<li><p>keys 布尔值，是否启用键盘快捷键，[enter] 保存编辑， [esc] 取消编辑</p></li>
<li><p>oneditfunc 回调函数，在行变为可编辑状态那一刻执行，有一个参数，rowId，编辑行的 id 。</p></li>
</ul><p>successfunc，url，extraparam，aftersavefunc，errorfunc，afterrestorefunc 会在 saveRow 方法中解释。</p>

<p>另一种传参方式，在 jqGrid 4.0 以后，可以像下面一样传参：</p>

<div class="highlight highlight-js"><pre class="brush: js">// 很常见，以对象方式传入参数
// 这样在只需要第一个和最后一个参数时不用狂写所有的参数了
$("#grid_id").jqGrid( 'editRow', rowid,{ 
    keys:>true, 
    oneditfunc: function(){
        alert("edited"); 
    }
});
</pre></div>

<p>参数默认值：</p>

<div class="highlight highlight-js"><pre class="brush: js">// 其实下面属性名的引号可以不需要
editparameters={
    "keys":>false,
    "oneditfunc":>null,
    "successfunc":>null,
    "url":>null,
    "extraparam":{},
    "aftersavefunc":>null,
    "errorfunc":>null,
    "afterrestorefunc":>null,
    "restoreAfterError":>true,
    "mtype":"POST"
}
</pre></div>

<p>当 keys 设置为 true，那么按 [enter] 键会调用 saveRow 方法，按 [ esc ] 键会调用 restoreRow 方法。</p>

<h2>
<a name="saverow" class="anchor" id="use"><span class="octicon octicon-link"></span></a>saveRow</h2>

<p>保存被编辑的行，语法：</p>

<div class="highlight highlight-js"><pre class="brush: js">$("#grid_id").jqGrid("saveRow", rowid, successfunc, url, extraparam, aftersavefunc, errorfunc, afterrestorefunc);
</pre></div>

<p>同 editRow 方法一样，参数可以以对象的形式传入，如下：</p>

<div class="highlight highlight-js"><pre class="brush: js">$("#grid_id").jqGrid("saveRow", rowid,{ 
    successfunc: function( response){
        return>true; 
    }
});
</pre></div>

<p>参数默认值如下：</p>

<div class="highlight highlight-js"><pre class="brush: js">// 属性名可以不需要引号
saveparameters={
    "successfunc":>null,
    "url":>null,
    "extraparam":{},
    "aftersavefunc":>null,
    "errorfunc":>null,
    "afterrestorefunc":>null,
    "restoreAfterError":>true,
    "mtype":"POST"
}
</pre></div>

<p>其中：</p>

<ul>
<li><p>rowid：要保存的行的 id </p></li>
<li>
<p>successfunc：</p>

<p>函数，保存到服务器的请求成功时会执行该函数。</p>

<p>有一个参数，服务端返回的字符串。</p>

<p>根据服务端返回的信息，这个函数应该返回 true 或者 false 。 ？？？</p>
</li>
<li>
<p>url： </p>

<p>如果设置了该值，将会覆盖 editurl 。</p>

<p>如果设置为 clientArray ，那么只会保存到本地而不会同步到数据库。</p>
</li>
<li>
<p>extraparam： </p>

<p>键值对，这些值会被传递到后台。</p>
</li>
<li>
<p>aftersavefunc：</p>

<p>同步到服务器完成后，执行该函数。</p>

<p>两个参数, rowid 和 xhr ，分别表示保存行的 id 和 xmlhttprequest 对象。</p>

<p>就算 url 设置为 clientArray ，仍旧会执行该函数。</p>
</li>
<li>
<p>errorfun：</p>

<p>和 aftersavefunc 一模一样。</p>

<p>搞不定 jqGrid 搞这个回调的用意啊。</p>
</li>
<li>
<p>afterrestorefun：</p>

<p>还原编辑行 ( restoreRow ) 后执行该方法。</p>

<p>参数为 rowid，编辑行的 id 。</p>
</li>
</ul><p>除非将 url 设置为 clientArray ，否则在调用这个方法时都会发送一个 POST 请求，将编辑行的数据传递到服务器。</p>

<p>例如</p>

<div class="highlight highlight-js"><pre class="brush: js">$("#grid_id").jqGrid("saveRow","rowid",>false)
</pre></div>

<p>会将数据传递到服务器，而</p>

<div class="highlight highlight-js"><pre class="brush: js">$("#grid_id").jqGrid("saveRow","rowid",>false,"clientArray");
</pre></div>

<p>则只在页面保存修改，不发送请求。</p>

<p>当然，你也可以像下面这样传入参数：</p>

<div class="highlight highlight-js"><pre class="brush: js">$("#grid_id").jqGrid("saveRow","rowid",{ url:"clientArray"});
</pre></div>

<h2>
<a name="restorerow" class="anchor" id="case"><span class="octicon octicon-link"></span></a>restoreRow</h2>

<p>这个方法，会将处于编辑状态的行还原到编辑状态之前不可更改的状态，已修改的值忽略。其实就是撤销编辑。</p>

<p>你可以像下面这样调用：</p>

<div class="highlight highlight-js"><pre class="brush: js">$("#grid_id").jqGrid("restoreRow", rowid, afterrestorefunc);
</pre></div>

<p>或者这样：</p>

<div class="highlight highlight-js"><pre class="brush: js">$("#grid_id").jqGrid("restoreRow", rowid,{ 
    "afterrestorefunc": function( rowid){
        // code here 
    }
});
</pre></div>

<ul>
<li><p>rowid 就是还原行的 id </p></li>
<li><p>afterrestorefunc 回调函数，在还原完成后执行。有一个参数，rowid 。</p></li>
</ul><h2>
<a name="addrow" class="anchor" id="property"><span class="octicon octicon-link"></span></a>addRow</h2>

<p>以行内编辑的方式添加一行，即表格中加入所有字段全为空的一行，使用方式如下：</p>

<div class="highlight highlight-js"><pre class="brush: js">$("#grid_id").jqGrid("addRow", parameters);
</pre></div>

<p>parameters 如下：</p>

<div class="highlight highlight-js"><pre class="brush: js">{
    rowID:"new_row",
    initdata:{},
    position:"first",
    useDefValues:>false,
    useFormatter:>false,
    addRowParams:{extraparam:{}}
}
</pre></div>

<ul>
<li><p>rowID   (字符串) 新行的 id 值</p></li>
<li>
<p>initData (对象) 假如要在新增行中带些初试数据，可以在这里设置，形式如下：</p>

<pre class="brush: js"><code>    ```js
    {
        name1: value1,  // name 就是 colModel 中的 name
        name2: value2,
        ...
    }
    ```
</code></pre>
</li>
<li><p>position (字符串) 插入行的位置，默认值为 first，即在表格的顶部插入，可以设置为 last ，末尾插入。</p></li>
<li><p>useDefValues (布尔值) 设置为真时，会默认填入 colModel 中的 editoptions 的 defaultValue 。</p></li>
<li><p>useFormatter (布尔值) 设置为 true 时，将会按照一定规则对表单值进行格式化。</p></li>
<li><p>addRowParams (对象) 和 editRow 的参数一样。</p></li>
</ul><p>其实这个方法是默认调用了两个已有的方法，显示 addRowData 新增以后，然后是 editRow 对改行进行编辑。</p>

<h2>
<a name="数据是怎么组织的" class="anchor" id="method"><span class="octicon octicon-link"></span></a>数据是怎么组织的</h2>

<p>当以后可以编辑，并且 input 元素被创建时，会有如下操作：</p>

<ul>
<li><p>编辑行新增属性 editable="1"</p></li>
<li><p>属性 savedRow 会保存改行的字段，并且额外的保存一个 rowid: id</p></li>
<li><p>隐藏列忽略</p></li>
<li><p>可编辑元素(比如文本框)的 id  构造如下：  行 id + "<em>" + colModel 中的 name 。
假如行的 id 为 10，编辑的列在 colModel 中的 name 为 myname ，那么这个 id 就是 "10</em>myname"</p></li>
<li><p>可编辑元素(比如文本框)的 name 就是 colModel 中 name</p></li>
<li><p>保存或或者还原后，行属性 editable="0" ，属性 savedRow 中 和改行对应的数据被删除。</p></li>
</ul><h2>
<a name="传递到服务器的数据" class="anchor" id="return"><span class="octicon octicon-link"></span></a>传递到服务器的数据</h2>

<ul>
<li><p>可编辑元素的 name:value 键值对</p></li>
<li><p>键值对 rowid: id</p></li>
<li>
<p>如果 extraparam 不为空，也会被传递</p>

<p>假如，编辑行的 id 为 10，extraparam 如下：
{
    a: "a",
    b: "b"
}
那么传送的数据就是：
{
    name1: value1, // 表单元素名值对
    ...
    a: "a",
    b: "b",
    id: 10
}</p>
</li>
</ul>
</div>
<script type="text/javascript">
            SyntaxHighlighter.defaults["toolbar"] = false;
            SyntaxHighlighter.all();
        </script>    
</body>
</html>