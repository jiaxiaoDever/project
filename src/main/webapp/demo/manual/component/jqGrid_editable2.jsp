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
jqGrid 编辑 之 表单编辑</h1>

<div class="hotmap">
    <a href="#summary">editGridRow</a><a href="#use">属性</a><a href="#case">事件</a><a href="#property">表单是怎样创建的</a><a href="#method">添加数据</a><a href="#return">delGridRow</a><a href="#faq">传递到服务器的数据</a>
    </div>

<p>jqGrid 可以实时地创建一个表单来添加、删除、修改相关数据</p>

<h2>
<a name="editgridrow" class="anchor" id="summary"><span class="octicon octicon-link"></span></a>editGridRow</h2>

<p><strong>请注意新增记录和修改记录都是这个方法。</strong></p>

<p>这个方法可以创建一个以模态弹窗形式呈现的 form，用来编辑指定行的字段。</p>

<p>这个方法可以使用 基本概念相关的 colModal 属性以及 editurl 属性。</p>

<p>调用形式：</p>

<div class="highlight highlight-js"><pre class="brush: js">$("#grid_id").jqGrid( "editGridRow", rowid, properties);
</pre></div>

<ul>
<li>rowid： 所要编辑行的 id ，传入 "new" 时就是新增记录。</li>
<li>properties：对象（键值对），包含如下的属性和事件。</li>
</ul><h4>
<a name="属性" class="anchor" id="use"><span class="octicon octicon-link"></span></a>属性</h4>

<table>
<tbody><tr>
<th>属性名</th>
        <th>描述</th>
        <th>默认值</th>
    </tr>
<tr>
<td>top</td>
        <td>弹窗的顶部位置</td>
        <td>0</td>
    </tr>
<tr>
<td>left</td>
        <td>弹窗的左侧位置</td>
        <td>0</td>
    </tr>
<tr>
<td>width</td>
        <td>弹窗的宽度</td>
        <td>300</td>
    </tr>
<tr>
<td>height</td>
        <td>弹窗的总体高度</td>
        <td>auto</td>
    </tr>
<tr>
<td>dataheight</td>
        <td>弹窗内容区的高度</td>
        <td>auto</td>
    </tr>
<tr>
<td>drag</td>
        <td>是否可以拖拽</td>
        <td>true</td>
    </tr>
<tr>
<td>resize</td>
        <td>是否可以改变尺寸</td>
        <td>true</td>
    </tr>
<tr>
<td>url</td>
        <td>数据传递的后台 url，如果设置了此值，将会覆盖 editurl </td>
        <td>null</td>
    </tr>
<tr>
<td>mtype</td>
        <td>请求类型，是 "get" 还是 "post" </td>
        <td>POST</td>
    </tr>
<tr>
<td>editData</td>
        <td>一个对象（键值对），这个键值对将被混入发往服务器的数据中，也就是可以添加额外的数据发往服务器。</td>
        <td>empty</td>
    </tr>
<tr>
<td>recreateForm</td>
        <td>设为 true 时，每次弹窗显示时，表单都会根据 colModel 中的最新值来重新生成</td>
        <td>false</td>
    </tr>
<tr>
<td>addedrop</td>
        <td>新增一行时，插入表格的位置。 "first"，表格顶部， "last"，表格尾部。<br>
            将属性 reloadAfterSubmit 设为 ture 时，那么该行会按顺序出现。
        </td>
        <td>first</td>
    </tr>
<tr>
<td>topinfo</td>
        <td>顶部信息，设置该值后，将会在弹窗的标题栏下面添加一行，表示顶部信息。</td>
        <td>空字符串</td>
    </tr>
<tr>
<td>bottominfo</td>
        <td>底部信息，设置该值后，将会在弹窗的按钮栏下面添加一行，表示底部信息。</td>
        <td>空字符串</td>
    </tr>
<tr>
<td>savekey</td>
        <td>
            数组。保存数据的键盘快捷键。<br>
            第一个元素是布尔值，表示是否启用快捷键。<br>
            第二个元素是数值，表示对应键的 key code，比如 enter 键是 13。 <br>
            编辑和添加记录两个操作都使用这个属性，所以快捷键是一样的。
        </td>
        <td>[ false, 13 ]</td>
    </tr>
<tr>
<td>navkeys</td>
        <td>
            数组。在不同字段中切换焦点。<br>
            第一个元素，布尔值，表示是否启用该功能。<br>
            第二个元素，数值，对应键的 key code，默认值是 "↑" 键，表示向上移动焦点。<br>
            第三个元素，数值，对应键的 key code，默认值是 "↓" 键，表示向下移动焦点。
        </td>
        <td>[ false, 38, 40 ]</td>
    </tr>
<tr>
<td>checkOnSubmit</td>
        <td>
            这个功能之存在于编辑中。<br>
            当设置为 true 时，点击提交并且表单域中的值有改动时会触发该功能，即出现一个弹窗来询问是否保存改动。
        </td>
        <td> false </td>
    </tr>
<tr>
<td>checkOnUpdate</td>
        <td>这个功能在新增和编辑中都可以使用。<br>
            关闭对话框时，提示是否保存更改。
        </td>
        <td>false</td>
    </tr>
<tr>
<td>closeAfterAdd</td>
        <td>如果是增加一条记录，那么该值设为 true 时，添加完成就关闭对话框。</td>
        <td>false</td>
    </tr>
<tr>
<td>closeAfterEdit</td>
        <td>编辑完成时，关闭对话框。</td>
        <td>false</td>
    </tr>
<tr>
<td>reloadAfterSubmit</td>
        <td>异步提交数据之后重新载入表格</td>
        <td>true</td>
    </tr>
<tr>
<td>closeOnEscape</td>
        <td>按 "Esc" 键关闭弹窗。</td>
        <td>false</td>
    </tr>
<tr>
<td>ajaxEditOptions</td>
        <td>即 ajax 的参数，设置该值会覆盖所有 jqGrid 内置的 ajax 参数。 </td>
        <td>空对象</td>
    </tr>
<tr>
<td>viewPageButtons</td>
        <td>是否显示表单中的前进、后台按钮。</td>
        <td>true</td>
    </tr>
<tr>
<td>zIndex</td>
        <td>设置弹窗的 zIndex 。</td>
        <td>950</td>
    </tr>
</tbody></table><h4>
<a name="事件" class="anchor" id="case"><span class="octicon octicon-link"></span></a>事件</h4>

<table>
<tbody><tr>
<th>事件名</th>
        <th>描述</th>
    </tr>
<tr>
<td>afterComplete</td>
        <td>新增或编辑一条记录完成，并且所有的 actions 和 事件都执行完成时，触发该事件。<br>
            afterComplete: function( xhr, postdata, form ) {} <br>
            其中：<br>
            xhr：xmlhttprequest 对象<br>
            postdata：传递到服务器的数据<br>
            form： 表单的 jQuery 对象
        </td>
    </tr>
<tr>
<td>afterShowForm</td>
        <td>表单显现时触发该事件，接受一个参数，为表单的 jQuery 对象。</td>
    </tr>
<tr>
<td>beforeInitData</td>
        <td>表单初始化并并填充数据时触发。 <br>
            一个参数，为 form 的 jQuery 对象。 <br>
            返回 false 时，表单不会被创建。
        </td>
    </tr>
<tr>
<td>beforeShowForm</td>
        <td>表单显示前触发。带一个参数，表单的 jQuery 对象。</td>
    </tr>
<tr>
<td>beforeSubmit</td>
        <td>
            请求发送之前触发。<br>
            两个参数，第一个是将要传递的数据，第二个是表单的 jQuery 对象。<br>
            使用该事件时，请务必返回一个数组，否则出错。 <br>
            数组的第一个元素是布尔值，表示是否继续发送请求。 <br>
            第二元素则是字符串，表示出错信息。
        </td>
    </tr>
<tr>
<td>onclickSubmit</td>
        <td>提交按钮被点击，传递的数据构建完成之后触发该事件。<br>
            接受两个参数， editGridRow 方法的属性集合以及将要传递到服务端的键值对。<br>
            返回值为一个对象（键值对），将会取代参数中的键值对被传递到服务器。
        </td>
    </tr>
<tr>
<td>onInitializeForm</td>
        <td>只在表单初始化的时候触发一次。接受一个参数，表单的 jQuery 对象。</td>
    </tr>
<tr>
<td>onClose</td>
        <td>关闭对话框之前触发。返回 false 时，将阻止对话框关闭。</td>
    </tr>
<tr>
<td>errorTextFormat</td>
        <td>
            请求服务器出错时，触发该事件，用来语义化出错信息。<br>
            服务端的返回值做为参数传入该事件，返回值必须是字符串，即新的出错信息。
        </td>
    </tr>
<tr>
<td>serializeEditData</td>
        <td>
            序列化传递到服务器的数据。<br>
            务必返回序列号之后的数据。<br>
            参数是将要传递到服务器的数据。<br>
</td>
    </tr>
</tbody></table><h4>
<a name="表单是怎样创建的" class="anchor" id="property"><span class="octicon octicon-link"></span></a>表单是怎样创建的</h4>

<p>表单创建遵循如下规则：</p>

<ul>
<li><p>隐藏列以隐藏行的形式包含进表单中</p></li>
<li><p>文本框等元素的 id 是 colModel 中对应的 name</p></li>
<li><p>文本框等元素的 name 也是来自于 colModel 中的 name</p></li>
<li><p>为了更方便的操作数据，表单中的每一行都有一个这样的 id ： "tr_" 加上 colModel 中的 name</p></li>
</ul><h4>
<a name="传送到服务器的数据" class="anchor" href="#%E4%BC%A0%E9%80%81%E5%88%B0%E6%9C%8D%E5%8A%A1%E5%99%A8%E7%9A%84%E6%95%B0%E6%8D%AE"><span class="octicon octicon-link"></span></a>传送到服务器的数据</h4>

<p>显然我们是传递一个 {} 的键值对到服务器，其构成如下：</p>

<ul>
<li><p>name/value 键值对， name 是表单元素的 name ， value 是表单元素的 value</p></li>
<li><p>额外的， id: rowid ，这里的 rowid 是编辑的那一行( tr ) 的 id 值</p></li>
<li><p>额外的， oper: add 来说明操作类型，比如 add 就是新增一行</p></li>
<li><p>如果属性 editData 非空，将会把该值混入到将要传递的数据中</p></li>
<li><p>如果事件 onclickSubmit 的返回值非空，将会把该返回值混入到将要传递的数据中</p></li>
</ul><h4>
<a name="添加数据" class="anchor" id="method"><span class="octicon octicon-link"></span></a>添加数据</h4>

<p>方法 editGridRow 同样可以用来新增记录。</p>

<p>语法：</p>

<div class="highlight highlight-js"><pre class="brush: js">// 注意关键参数 "new"
$("#grid_id").jqGrid('editGridRow', "new", properties);
</pre></div>

<ul>
<li><p>new 表示新增一行，务必和<strong>编辑模式</strong>区别开来</p></li>
<li><p>properties 参数，和编辑模式相同，请查看上述表格。</p></li>
</ul><h6>
<a name="表单的创建" class="anchor" href="#%E8%A1%A8%E5%8D%95%E7%9A%84%E5%88%9B%E5%BB%BA"><span class="octicon octicon-link"></span></a>表单的创建</h6>

<p><strong>和编辑模式相同</strong></p>

<h6>
<a name="传递到后台的数据" class="anchor" href="#%E4%BC%A0%E9%80%92%E5%88%B0%E5%90%8E%E5%8F%B0%E7%9A%84%E6%95%B0%E6%8D%AE"><span class="octicon octicon-link"></span></a>传递到后台的数据</h6>

<p><strong>和编辑模式相同</strong></p>

<h2>
<a name="delgridrow" class="anchor" id="return"><span class="octicon octicon-link"></span></a>delGridRow</h2>

<p>通过这个方法，我们可以删除记录并同步到数据库。</p>

<p>这个方法用到了属性 colModal 和 editurl 。</p>

<p>语法形式：</p>

<div class="highlight highlight-js"><pre class="brush: js">$( "#grid_id").jqGrid( "delGridRow", row_id_s, options);
</pre></div>

<ul>
<li>
<p>row_id_s</p>

<p>目标行的 id 可以是一个简单的字符串，或者用逗号隔开字符串表示很多行的 id 。</p>
</li>
<li>
<p>options </p>

<p>参数，一个对象，可以是下面的值。</p>
</li>
</ul><h4>
<a name="属性-1" class="anchor" href="#%E5%B1%9E%E6%80%A7-1"><span class="octicon octicon-link"></span></a>属性</h4>

<table>
<tbody><tr>
<th>属性名</th>
        <th>描述</th>
        <th>默认值</th>
    </tr>
<tr>
<td>top</td>
        <td>弹窗的顶部位置。</td>
        <td>0</td>
    </tr>
<tr>
<td>left</td>
        <td>弹窗的左边位置。</td>
        <td>0</td>
    </tr>
<tr>
<td>width</td>
        <td>弹窗的宽度。</td>
        <td>300</td>
    </tr>
<tr>
<td>height</td>
        <td>弹窗的高度。</td>
        <td>auto</td>
    </tr>
<tr>
<td>modal</td>
        <td>是否模态。</td>
        <td>false</td>
    </tr>
<tr>
<td>url</td>
        <td>处理数据的 url 。如果设置了，将会覆盖 editurl 。</td>
        <td>null</td>
    </tr>
<tr>
<td>delData</td>
        <td>键值对，将会被传递到后台。</td>
        <td>空</td>
    </tr>
<tr>
<td>reloadAfterSubmit</td>
        <td>在发送删除请求成功后，重新加载表格。</td>
        <td>true</td>
    </tr>
</tbody></table><h4>
<a name="事件-1" class="anchor" href="#%E4%BA%8B%E4%BB%B6-1"><span class="octicon octicon-link"></span></a>事件</h4>

<p><strong>和 editGridRow 一样。</strong></p>

<h4>
<a name="传递到服务器的数据" class="anchor" id="faq"><span class="octicon octicon-link"></span></a>传递到服务器的数据</h4>

<ul>
<li><p>键值对 id: rowids ，rowids 可以是字符串，或者逗号隔开的字符串</p></li>
<li><p>键值对 oper: del ，标识该操作为删除</p></li>
<li><p>如果 delData 属性非空，将会混入到传递到后台的数据中</p></li>
<li><p>事件 onclickSubmit 返回值非空的话，会被混入到传递到后台的数据中</p></li>
</ul> 
</div>
    <script type="text/javascript">
            SyntaxHighlighter.defaults["toolbar"] = false;
            SyntaxHighlighter.all();
        </script>   
</body>
</html>