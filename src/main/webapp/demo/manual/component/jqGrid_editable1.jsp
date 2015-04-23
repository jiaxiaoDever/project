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
ol{padding-left:50px;}
</style>
</head>
<body>
<div class="container">
 <h1>
jqGrid 编辑 之 单元格编辑</h1>
<div class="hotmap">
    <a href="#summary">相关属性</a><a href="#use">实例</a><a href="#case">相关事件</a><a href="#property">事件堆栈</a><a href="#method">相关方法</a><a href="#return">从只读到可编辑的过程</a><a href="#faq">传递到服务器的数据</a>
    </div>


<p>单元格编辑，嗯……就是单元格编辑。</p>

<p>jqGrid 的单元格编辑提供键盘导航和编辑单独的单元格的功能：</p>

<ul>
<li><p>当单击了不可编辑的单元格时，单元格被选中，我们可以使用键盘上的“↑”、“→”、“↓”、“←”键来移动光标。</p></li>
<li>
<p>移到可编辑的单元格上时，按 Enter 键即可进入编辑状态，再次 Enter 或者按 Tab 键 或者点击其他单元格就会保存更改。</p>

<p>按 Esc 键撤销编辑。编辑状态时，方向键只能在单元格内移动。</p>
</li>
<li><p>如果单击了可以编辑的单元格，直接进入编辑模式。</p></li>
<li><p>如果单元格有类名 (class) "not-editable-cell" ，则不可编辑，这个的优先级高于 colModal 中的 editable 。</p></li>
</ul><h2>
<a name="相关属性" class="anchor" id="summary"><span class="octicon octicon-link"></span></a>相关属性</h2>

<table>
<tbody><tr>
<th>属性名</th>
        <th>类型</th>
        <th>描述</th>
        <th>默认值</th>
    </tr>
<tr>
<td>cellEdit</td>
        <td>布尔值</td>
        <td>是否启用单元格编辑。<br>如果设置为 true ，启用，同时事件 onSelectRow 不可用，tr 上的 hover 效果（鼠标行高亮）禁用。</td>
        <td>false</td>
    </tr>
<tr>
<td>cellsubmit</td>
        <td>字符串</td>
        <td>
            单元格的内容保存到何处。<br>
            两个值可用：<br><strong>remote</strong>： <br>
            保存时，立刻通过 ajax 的方式将数据发送 cellurl 指定的服务器端。<br>
            发送的数据包括所在行的 id ，以及单元格的内容。<br><strong>clientArray：</strong><br>
            不会发送请求，只保存在页面中。<br>
            可以通过 getChangedCells 来获取修改的单元格，或者监听事件。
        </td>
        <td>remote</td>
    </tr>
<tr>
<td>cellurl</td>
        <td>字符串</td>
        <td>发送请求的链接。</td>
        <td>null</td>
    </tr>
<tr>
<td>ajaxCellOptions</td>
        <td>对象</td>
        <td>设置 $.ajax 的相关参数。注意，如果你设置了这个属性，可能覆盖任何默认值。不了解的话，慎用。</td>
        <td>空对象</td>
    </tr>
</tbody></table><h4>
<a name="实例" class="anchor" id="use"><span class="octicon octicon-link"></span></a>实例</h4>

<div class="highlight highlight-js"><pre class="brush: js">// cellsubmit 为 remote ， cellurl 就有必要了</span>
{</span>
    cellEdit:</span> <span class="kc">true</span>,</span>
    cellsubmit:</span> <span class="s2">"remote"</span>,</span>
    cellurl:</span> <span class="s2">"/url/to/handling/the/changed/cell/value"</span>
}</span>
</pre></div>

<div class="highlight highlight-js"><pre class="brush: js">// cellsubmit 为 clientArray ，则 cellurl 没有必要</span>
{ 
    cellEdit:true , 
    cellsubmit: "clientArray" 
} 
</pre></div>

<h2>
<a name="相关事件" class="anchor" id="case"><span class="octicon octicon-link"></span></a>相关事件</h2>

<p>大多数事件有的参数，先列出来：</p>

<ul>
<li><p>rowid： 行 id 值</p></li>
<li><p>cellname： 单元格的 name ，来自 colModel 中的 name</p></li>
<li><p>value： 单元格的内容</p></li>
<li><p>iRow： 行索引，务必不要和 rowid 混淆</p></li>
<li><p>iCol： 列索引</p></li>
</ul><table>
<tbody><tr>
<th>事件名</th>
        <th>参数</th>
        <th>描述</th>
    </tr>
<tr>
<td>afterEditCell</td>
        <td>
            rowid, cellname <br>
            value, iRow, iCol
        </td>
        <td>编辑完成之后触发。</td>
    </tr>
<tr>
<td>afterRestoreCell</td>
        <td>
            rowid, value <br>
            iRow, iCol
        </td>
        <td>调用 restoreCell 或者用 Esc 键撤销编辑后触发该事件。</td>
    </tr>
<tr>
<td>afterSaveCell</td>
        <td>
            rowid, cellname <br>
            value, iRow, iCol
        </td>
        <td>成功保存后触发。</td>
    </tr>
<tr>
<td>afterSubmitCell</td>
        <td>
            xhr, <br>
            rowid, cellname, <br>
            value, iRow, iCol       
        </td>
        <td>在请求发动到服务器之后触发。 <br>
            务必返回一个数组 [ success(boolean), message ] 。<br>
            [ true, "" ] 表示一切正常，将会保存单元格内容 。<br>
            [ false, "Error message" ] 表示出错，会弹出内容为 Error message 的窗口，并且不保存内容。<br>
            xhr 是 xmlhttpresponse 对象。
        </td>
    </tr>
<tr>
<td>beforeEditCell</td>
        <td>rowid, cellname, <br>
            value, iRow, iCol
        </td>
        <td>在编辑单元格之前触发。</td>
    </tr>
<tr>
<td>beforeSaveCell</td>
        <td>rowid, cellname, <br>
            value, iRow, iCol
        </td>
        <td>保存之前触发。 <br>
            可以用来验证内容，返回一个字符串表示新的内容。
        </td>
    </tr>
<tr>
<td>beforeSubmitCell</td>
        <td>rowid, cellname,
            value, iRow, iCol
        </td>
        <td>
            发送请求之前触发。<br>
            返回一个对象的话，这个对象的数据也能被传到服务端。
        </td>
    </tr>
<tr>
<td>errorCell</td>
        <td>xhr, status</td>
        <td>请求出错时触发。<br>
            xhr 是 xmlhttprequest 对象。 <br>
            status 是错误信息。
        </td>
    </tr>
<tr>
<td>formatCell</td>
        <td>rowid, cellname, <br>
            value, iRow, iCol
        </td>
        <td> 
            这个事件可以在编辑之前，格式化单元格的内容。 <br>
            返回一个字符串表示新的内容。
        </td>
    </tr>
<tr>
<td>onSelectCell</td>
        <td>rowid, cellname, <br>
            value, iRow, iCol
        </td>
        <td>选中单元格之后触发。</td>
    </tr>
</tbody></table><h4>
<a name="事件堆栈" class="anchor" id="property"><span class="octicon octicon-link"></span></a>事件堆栈</h4>

<p>事件很多，总有一个触发顺序，如下：</p>

<p>cellsubmit 为 "remote" 时：</p>

<ol>
<li>formatCell</li>
<li>beforeEditCell</li>
<li>afterEditCell</li>
<li>beforeSaveCell</li>
<li>beforeSubmitCell</li>
<li>afterSubmitCell</li>
<li>afterSaveCell</li>
<li>errorCell</li>
<li>onSelectCell</li>
</ol><p>cellsubmit 为 "clientArray" 时：</p>

<ol>
<li>formatCell</li>
<li>beforeEditCell</li>
<li>afterEditCell</li>
<li>beforeSaveCell</li>
<li>beforeSubmitCell</li>
<li>afterSaveCell</li>
<li>onSelectCell</li>
</ol><h2>
<a name="相关方法" class="anchor" id="method"><span class="octicon octicon-link"></span></a>相关方法</h2>

<br><table>
<tbody><tr>
<th>方法名</th>
        <th>参数</th>
        <th>描述</th>
    </tr>
<tr>
<td>editCell</td>
        <td>iRow, iCol, edit</td>
        <td>
            编辑 iRow 行 iCol 列的单元格。 <br>
            edit 为 false 时，只选中单元格，为 true 时，选中并编辑单元格。
        </td>
    </tr>
<tr><td>getChangedCells</td>
        <td>method</td>
        <td>
            根据 method 的值返回对象。<br>
            method 为 "all" 时，返回所有改动的行。
            method 为 "dirty" 时，返回改动的单元格。
        </td>
    
    </tr><tr>
<td>restoreCell</td>
        <td>iRow, iCol</td>
        <td>撤销 iRow 行 iCol 列单元格的编辑。</td>
    </tr>
<tr>
<td>saveCell</td>
        <td>iRow, iCol</td>
        <td>保存 iRow 行 iCol 列单元格的编辑。</td>
    </tr>
</tbody></table><h2>
<a name="从只读到可编辑的过程" class="anchor" id="return"><span class="octicon octicon-link"></span></a>从只读到可编辑的过程</h2>

<p>单元格进入可编辑状态、input 元素被创建这一过程遵从如下规则：</p>

<ul>
<li>
<p>可编辑元素（通常为文本框）的 id 值构成：</p>

<pre><code>单元格所在行的索引 + "_" + 来自 colModel 中的 name
</code></pre>

<p>假如编辑的单元格在第 20 行， colModel 中的 name 为 myname ，那么 id 为 "20_myname" 。</p>
</li>
<li><p>可编辑元素（通常为文本框）的 name 就是 colModel 中的 name</p></li>
</ul><h2>
<a name="传递到服务器的数据" class="anchor" id="faq"><span class="octicon octicon-link"></span></a>传递到服务器的数据</h2>

<p>一般都是传递一个键值对({})到服务器：</p>

<ul>
<li><p>name: value 键值对，文本框中很常见，不多说</p></li>
<li><p>id: rowid ，所在行的 id 也传到后台</p></li>
<li><p>事件 beforeSubmitCell 的返回值如果非空，一并传递到后台</p></li>
</ul><p>Example:</p>

<pre class="brush: js"><code>假如文本框的 name 是 myname ，值为 2222
所在行 id 为 2572
事件 beforeSubmitCell 返回值如下：
{
    a: "a",
    b: "b"
}

那么传递到后台的数据就是：
{
    myname: 2222,
    id: 2572,
    a: "a",
    b: "b"
}
</code></pre>
 <script type="text/javascript">
            SyntaxHighlighter.defaults["toolbar"] = false;
            SyntaxHighlighter.all();
        </script> 
</body>
</html>