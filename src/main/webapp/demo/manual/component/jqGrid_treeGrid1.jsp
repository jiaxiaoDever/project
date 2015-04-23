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
jqGrid 树形表格 之 基本概念</h1>
 <div class="hotmap">
 <a href="#property">属性</a><a href="#method">方法</a><a href="#return">注意事项</a>
</div>

<p>树形表格，自然是用来展现有着树结构的数据，而且可以按层级加载，从而提升页面性能。</p>

<p>数据库存储树形结构的数据时，有两种常见模型：嵌套集合模型(The Nested Set model) 
和 邻接列表模型(The Adjacency List Model)。
jqGrid 支持这两种模型。</p>

<p>建议先去了解这两种模型，加深对树形结构的理解，可以看看这篇译文《<a href="http://www.360doc.com/content/05/1215/11/3500_44502.shtml">在数据库中存储层次数据</a>》。</p>

<p>当然，因为项目组的数据库都是邻接列表模型，所以嵌套集合模型我也就没有深入研究。</p>

<p>当开启 jqGrid 的树形表格时，翻页栏 不能使用。</p>

<p>属性 gridview 设为 true 时，不能使用树形表格。</p>

<h2>
<a name="属性" class="anchor" id="property"><span class="octicon octicon-link"></span></a>属性</h2>

<table>
<tbody><tr>
<th>属性名</th>
        <th>类型</th>
        <th>描述</th>
        <th>默认值</th>
    </tr>
<tr>
<td>ExpandColClick</td>
        <td>布尔值</td>
        <td>设为真时，点击文字即可展开子节点，而不是非要点击“图标”才能展开。</td>
        <td>true</td>
    </tr>
<tr>
<td>ExpandColumn</td>
        <td>字符串</td>
        <td>指定哪一列做为跟节点。<br>
            取值来自 colModel 中的 name 。 <br>
            默认情况是第一列。   
        </td>
        <td>null</td>
    </tr>
<tr>
<td>treedatatype</td>
        <td>字符串||对象||函数</td>
        <td>数据类型，和属性 datatype 的意义相同。 <br>
            通常情况下，这个不用设置。
        </td>
        <td>null</td>
    </tr>
<tr>
<td>treeGrid</td>
        <td>布尔值</td>
        <td>是否启用树形表格</td>
        <td>false</td>
    </tr>
<tr>
<td>treeGridModel</td>
        <td>字符串</td>
        <td>构建树形表格的方式，可选值有 "nested" 和 "adjacency" 。</td>
        <td>"nested"</td>
    </tr>
<tr>
<td>treeIcons</td>
        <td>对象</td>
        <td>节点图标。默认值如下：<br>
            { <br>
            plus: "ui-icon-triangle-1-e", // 折合状体 <br>
            minus: "ui-icon-triangle-1-s", // 展开状态 <br>
            leaf: "ui-icon-radio-off" // 叶子 <br>
            }
        </td>
        <td>    </td>
    </tr>
<tr>
<td>treeReader</td>
        <td>对象</td>
        <td>
            这个对象中的属性，会被混入到 colModel 中（ colModel 的 length 会增加），并且对外不可见。 <br>
            也就是说，从后台返回的数据，除开对应的字段，还要加上 treeReader 中的字段。 <br>
            该属性的值，随着 treeGridModel 的值不同而不同。<br>
            在邻接列表模型有更详细的介绍。
        </td>
        <td></td>
    </tr>
<tr>
<td>tree_root_level</td>
        <td>数值</td>
        <td>定义根节点的层级。</td>
        <td>0</td>
    </tr>
</tbody></table><h2>
<a name="方法" class="anchor" id="method"><span class="octicon octicon-link"></span></a>方法</h2>

<p>大部分方法都接受这样一个参数：</p>

<div class="highlight highlight-js"><pre class="brush: js">var record = $ ( "#grid_id" ). jqGrid ("getRowData", rowid ); // id 值为 rowid 的行数据  
</pre></div>

<ul>
<li>record 是 id 为 rowid 的行的数据</li>
</ul><table>
<tbody><tr>
<th>方法名</th>
        <th>参数</th>
        <th>详细</th>
    </tr>
<tr>
<td>addChildNode</td>
        <td>nodeid, parentid, data</td>
        <td>
            根据 parentid 添加一个节点。 <br>
            nodeid 就是该节点的 id 值，页面唯一。 <br>
            parentid 当然就是父 id 了。 <br>
            data 是数组，节点的数据。
        </td>
    </tr>
<tr>
<td>collapseNode</td>
        <td>record</td>
        <td>闭合节点。</td>
    </tr>
<tr>
<td>collapseRow</td>
        <td>record</td>
        <td>闭合当前行。</td>
    </tr>
<tr>
<td>delTreeNode</td>
        <td>rowid</td>
        <td>
            删除改行及其所有子节点。 <br>
            rowid 是所在行的 id 。 <br>
            该操作不会同步到数据库。
        </td>
    </tr>
<tr>
<td>expandNode</td>
        <td>record</td>
        <td>展开节点。</td>
    </tr>
<tr>
<td>expandRow</td>
        <td>record</td>
        <td>展开当前行。</td>
    </tr>
<tr>
<td>getNodeAncestors</td>
        <td>record</td>
        <td>返回指定 record 父辈数据</td>
    </tr>
<tr>
<td>getNodeDepth</td>
        <td>record</td>
        <td>获取节点的深度。</td>
    </tr>
<tr>
<td>getNodeParent</td>
        <td>record</td>
        <td>获取父元素。</td>
    </tr>
<tr>
<td>getNodeChildren</td>
        <td>record</td>
        <td>获取节点的子元素。 <br>
            如果没有，返回一个空对象。
        </td>
    </tr>
<tr>
<td>isNodeLoaded</td>
        <td>record</td>
        <td>节点加载完成，返回 true 。</td>
    </tr>
<tr>
<td>isVisibleNode</td>
        <td>record</td>
        <td>节点是否可见。</td>
    </tr>
<tr>
<td>setTreeRow</td>
        <td>rowid, data</td>
        <td>和方法 setRowData 相同。</td>
    </tr>
<tr>
<td>SortTree</td>
        <td>direction</td>
        <td>
            direction 是 1 （升序）或者 -1（降序）。 <br>
            根据属性 sortname 所指定的列来排序。
        </td>
    </tr>
</tbody></table><h2>
<a name="注意事项" class="anchor" id="return"><span class="octicon octicon-link"></span></a>注意事项</h2>

<ul>
<li><p>现阶段不能使用 addRowData 方法添加节点。</p></li>
<li><p>翻页栏不能使用。</p></li>
</ul>
   
</div>
 <script type="text/javascript">
            SyntaxHighlighter.defaults["toolbar"] = false;
            SyntaxHighlighter.all();
        </script>       
</body>
</html>