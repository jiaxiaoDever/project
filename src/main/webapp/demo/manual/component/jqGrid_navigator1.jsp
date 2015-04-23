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
jqGrid 导航栏之二 功能区</h1>
<div class="hotmap">
    <a href="#summary">使用方法</a><a href="#use">配置项</a><a href="#case">示例</a>
    </div>


<p>jqGrid 在渲染导航栏的时候，其实分为三个部分，也就是三列：</p>

<ul>
<li>第一列是导航(navigator)，里面会有些查询按钮什么的，我们称之为 <strong>功能区</strong> 吧。</li>
<li>第二列是翻页按钮之类的东东，其实这才是翻页栏，我们称之为 <strong>翻页区</strong> 吧。</li>
<li>第三列是放置记录信息，比如总记录条数，我们称之为 <strong>信息区</strong> 吧。</li>
</ul><p>本文涉及功能区。</p>

<p>功能区可以理解为 jqGrid 自带的工具栏，有六个功能：</p>

<p>编辑，
新增，
删除，
查找，
查看和刷新。</p>

<blockquote>
<p>功能区的位置不一定非要放在导航栏上，它可以定位在表格内部。</p>

<p>功能区是可选的，不一定非要出现，完全可以用自定义工具栏代替。</p>
</blockquote>

<h2>
<a name="使用方法" class="anchor" id="summary"><span class="octicon octicon-link"></span></a>使用方法</h2>

<h3>
<a name="设置属性" class="anchor" href="#%E8%AE%BE%E7%BD%AE%E5%B1%9E%E6%80%A7"><span class="octicon octicon-link"></span></a>设置属性</h3>

<p>和 翻页区一样，功能区也要必须要设置 pager 属性。</p>

<p>除了 pager 属性，还有一个关键方法 navGrid 。</p>

<p>HTML:</p>

<div class="highlight highlight-html"><pre class="brush: js">&lt;body&gt;
    ...
   &lt;tableid="grid"&gt;&lt;/table&gt; 
   &lt;divid="pager"&gt;&lt;/div&gt; 
    ...
&lt;/body&gt;
</pre></div>

<p>javascript:</p>

<div class="highlight highlight-js"><pre class="brush: js">$("#grid").jqGrid({
    ...
    pager:"#gridpager",
    ...
});
$("#grid").jqGrid("navGrid","#pager",{ parameters},
            prmEdit, prmAdd, prmDel, prmSearch, prmView);
</pre></div>

<p>当然，可以链式调用：</p>

<div class="highlight highlight-js"><pre class="brush: js">$("#grid").jqGrid({
    ...
    pager:"#gridpager",
    ...
}).jqGrid("navGrid","#pager",{ parameters},
            prmEdit, prmAdd, prmDel, prmSearch, prmView);
</pre></div>

<ul>
<li><p>parameters 配置项，下面有详细解释。</p></li>
<li>
<p>prmEdit, prmAdd, prmDel, prmSearch, prmView</p>

<p>依次为
编辑，
新增，
删除，
查找，
查看
的配置项。除了对应的默认配置项外，还可以加上一个 id 属性，用来表示该按钮的 id 值。
如果这个 id 缺省，则会这样构建——比如新增是 "add_grid" ，add 是增加， grid 是表格 id 。
下面是自定义编辑的情形：</p>

<div class="highlight highlight-javascript"><pre class="brush: js">$("#grid_id").jqGrid({
    ...
    pager:"#gridpager",
    ...
}).jqGrid("navGrid","#gridpager",{},{ id:"myedit"});
</pre></div>
</li>
</ul><h2>
<a name="配置项" class="anchor" id="use"><span class="octicon octicon-link"></span></a>配置项</h2>

<p>就是上面的 parameters 。</p>

<table>
<tbody><tr>
<th>属性名</th>
        <th>类型</th>
        <th>详情</th>
        <th>默认值</th>
    </tr>
<tr>
<td>add</td>
        <td>布尔值</td>
        <td>是否启用新增。 <br>
            为 true 时，有新增按钮，点击执行 editGridRow 方法。<br>
</td>
        <td> true </td>
    </tr>
<tr>
<td>addicon</td>
        <td>字符串</td>
        <td>设置新增按钮的图标。</td>
        <td>ui-icon-plus</td>
    </tr>
<tr>
<td>addtext</td>
        <td>字符串</td>
        <td>新增按钮上的字符。</td>
        <td>空</td>
    </tr>
<tr>
<td>addtitle</td>
        <td>字符串</td>
        <td>新增按钮的 title 属性，鼠标放上会显示。</td>
        <td>添加新纪录</td>
    </tr>
<tr>
<td>alertcap</td>
        <td>字符串</td>
        <td>
        </td>
        <td>注意</td>
    </tr>
<tr>
<td>alerttext</td>
        <td>字符串</td>
        <td>
            没有选中行，却执行编辑、删除、查看操作，会弹出警告。 <br>
            这个属性表示该警告。
        </td>
        <td>请选择记录</td>
    </tr>
<tr>
<td>cloneToTop</td>
        <td>布尔值</td>
        <td>
            将功能区拷贝到顶部导航栏（如果存在）。
        </td>
        <td>false</td>
    </tr>
<tr>
<td>closeOnEscape</td>
        <td>布尔值</td>
        <td>弹窗状态下，按 [Esc] 退出。</td>
        <td>true</td>
    </tr>
<tr>
<td>del</td>
        <td>布尔值</td>
        <td>
            是否启用删除。<br>
            设为 true 时，出现删除按钮，点击执行 delGridRow 方法。
        </td>
        <td>true</td>
    </tr>
<tr>
<td>delicon</td>
        <td></td>
        <td> 同 addicon </td>
        <td>ui-icon-trash</td>
    </tr>
<tr>
<td>deltext</td>
        <td></td>
        <td> 同 addtext </td>
        <td>空</td>
    </tr>
<tr>
<td>deltitle</td>
        <td></td>
        <td>  同 addtitle  </td>
        <td>删除所选记录</td>
    </tr>
<tr>
<td>edit</td>
        <td>布尔值</td>
        <td>
            是否启用编辑功能。 <br>
            为 true 时，出现编辑按钮，点击执行 editGridRow 方法。
        </td>
        <td></td>
    </tr>
<tr>
<td>editicon</td>
        <td></td>
        <td>同 addicon</td>
        <td>ui-icon-pencil</td>
    </tr>
<tr>
<td>edittext</td>
        <td></td>
        <td>同 addicon </td>
        <td>空</td>
    </tr>
<tr>
<td>edittitle</td>
        <td></td>
        <td>同 addtitle </td>
        <td>编辑所选记录</td>
    </tr>
<tr>
<td>position</td>
        <td>字符串</td>
        <td>导航区的位置。可以是 "left"，"center"，"right" 。</td>
        <td>left</td>
    </tr>
<tr>
<td>refresh</td>
        <td>布尔值</td>
        <td>
            是否启用刷新功能。 <br>
            设为 true 时，出现刷新按钮，点击执行 trigger( "reloadGrid" ) 方法。
        </td>
        <td>true</td>
    </tr>
<tr>
<td>refreshicon</td>
        <td></td>
        <td> 同 addicon </td>
        <td>ui-icon-refresh</td>
    </tr>
<tr>
<td>refreshtext</td>
        <td></td>
        <td>同 addtext </td>
        <td>空</td>
    </tr>
<tr>
<td>refreshtitle</td>
        <td></td>
        <td>同 addtitle </td>
        <td>刷新表格</td>
    </tr>
<tr>
<td>refreshstate</td>
        <td>字符串</td>
        <td>
            刷新表格的方式。 <br>
            firstpage: 刷新到第一页 <br>
            current: 刷新当前页  
        </td>
        <td>firstpage</td>
    </tr>
<tr>
<td>afterRefresh</td>
        <td>函数</td>
        <td>点击刷新按钮之后触发。</td>
        <td>null</td>
    </tr>
<tr>
<td>beforeRefresh</td>
        <td>函数</td>
        <td>点击刷新按钮之前执行</td>
        <td>null</td>
    </tr>
<tr>
<td>search</td>
        <td>布尔值</td>
        <td>
            是否启用查询功能。 <br>
            设为 true 时，出现查询按钮，点击执行 searchGrid 方法。
        </td>
        <td>true</td>
    </tr>
<tr>
<td>searchicon</td>
        <td></td>
        <td>同 addicon</td>
        <td>ui-icon-search</td>
    </tr>
<tr>
<td>searchtext</td>
        <td></td>
        <td>同 addtext </td>
        <td>空</td>
    </tr>
<tr>
<td>searchtitle</td>
        <td></td>
        <td>同 addtitle</td>
        <td>查找</td>
    </tr>
<tr>
<td>view</td>
        <td>布尔值</td>
        <td>
            是否启用查看功能。 <br>
            设置为 true 时，出现查看按钮，点击执行 viewGridRow 方法。
        </td>
        <td>false</td>
    </tr>
<tr>
<td>viewicon</td>
        <td></td>
        <td>同 addicon </td>
        <td>ui-icon-document</td>
    </tr>
<tr>
<td>viewtext</td>
        <td></td>
        <td>同 addtext </td>
        <td></td>
    </tr>
<tr>
<td>viewtitle</td>
        <td></td>
        <td>同 addtitle</td>
        <td>查看所选记录</td>
    </tr>
<tr>
<td>addfunc</td>
        <td>函数</td>
        <td>如果设置，则会取代内置的 add 方法。</td>
        <td>null</td>
    </tr>
<tr>
<td>editfunc</td>
        <td>函数</td>
        <td>如果设置，取代内置的 edit 方法。</td>
        <td>null</td>
    </tr>
<tr>
<td>delfunc</td>
        <td>函数</td>
        <td>如果设置，取代内置的 del 方法。</td>
        <td>null</td>
    </tr>
</tbody></table><h2>
<a name="示例" class="anchor" id="case"><span class="octicon octicon-link"></span></a>示例</h2>

<div class="highlight highlight-javascript"><pre class="brush: js">$("#grid").jqGrid({
    ...
    pager:'#pager',
    ...
}).jqGrid("navGrid","#pager",{ view:true, del:false}, 
    {},
    {}, // 空对象即表示默认
    { multipleSearch: true}, // 请用高阶查询
    { closeOnEscape: true} // 启用 Esc 键
);
</pre></div>
   
</div>
    <script type="text/javascript">
            SyntaxHighlighter.defaults["toolbar"] = false;
            SyntaxHighlighter.all();
        </script>   
</body>
</html>