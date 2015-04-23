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
jqGrid 的数据格式</h1>


<p>在 jqGrid 的开发过程中，其不断地扩展其所支持的数据格式的种类，
包括 xml, json, jsonp, array, xmlstring 等等，
这些都可以在属性 datatype 中设置。</p>

<p>当然，由于现在几乎所有的数据传递格式都是 json ，那么也没有太多关注 json 之外格式的理由。
在 yhui 的开发过程中，会逐步剔除 jqGrid 支持 xml 等格式功能，从而精简代码。</p>

<h2>
<a name="json-数据" class="anchor" href="#json-%E6%95%B0%E6%8D%AE"><span class="octicon octicon-link"></span></a>JSON 数据</h2>

<p><strong>提醒：返回的JSON格式必须合法，<a href="http://www.json.org/json-zh.html">详细</a>。</strong></p>

<p>将属性 datatype 设置为 "json"，即启用 jqGrid 对 json 的支持。</p>

<p>jqGrid 期望的 json 格式如下：</p>

<pre class="brush: js"> { 
    "total": "xxx", 
    "page": "yyy", 
    "records": "zzz",
    "rows" : [
        {"id" :"1", "cell" :["cell11", "cell12", "cell13"]},
        {"id" :"2", "cell":["cell21", "cell22", "cell23"]},
        ...
    ]
}
 </pre>

<p>对上述格式的一些解释：</p>

<table>
<tbody><tr>
<th>属性名</th>
        <th>描述</th>
    </tr>
<tr>
<td>total</td>
        <td>查询结果的总页数</td>
    </tr>
<tr>
<td>page</td>
        <td>当前页数，比如第 2 页</td>
    </tr>
<tr>
<td>records</td>
        <td>查询结果的总记录条数</td>
    </tr>
<tr>
<td>rows</td>
        <td>包含着所有行数据的数组</td>
    </tr>
<tr>
<td>id</td>
        <td>每一行的标识值(页面id)</td>
    </tr>
<tr>
<td>cell</td>
        <td>包含着一行数据的数组</td>
    </tr>
</tbody></table><hr><p>上面的默认模式已经满足大部分需求了，如果想深入了解，可以继续读下去。</p>

<hr><p>有一个属性 jsonReader ，用来描述 json 格式的结构，其默认值如下：</p>

<pre class="brush: js">    $("#gridid").jqGrid({
        ...
        jsonReader : {
            root: "rows",
            page: "page",
            total: "total",
            records: "records",
            repeatitems: true,
            cell: "cell",
            id: "id",
            userdata: "userdata",
            subgrid: {root:"rows", 
            repeatitems: true, 
            cell:"cell"
            }
        },
        ...
    });
</pre>

<ul>
<li>
<p>root 指向包含具体数据的属性，比如上述默认值的 "rows" 。</p>

<p>假如设成如下值：</p>

<pre class="brush: js">    jQuery("#gridid").jqGrid({
    ...
       jsonReader : {root:"invdata"},
    ...
    });
</pre>

<p>那么期望的 json 格式就是：</p>

<pre class="brush: js">    { 
        "total": "xxx", 
        "page": "yyy", 
        "records": "zzz",
        "invdata" : [
                {"id" :"1", "cell" :["cell11", "cell12", "cell13"]},
                {"id" :"2", "cell":["cell21", "cell22", "cell23"]},
                ...
            ]
        }
</pre>
</li>
<li>page </li>
<li>total</li>
<li>
<p>records 这个三个值都是翻页栏需要的值，也就是说，如果你没有翻页栏，就不需要。</p>

<p>设置这个三个值就能改变期望值中对应的属性。</p>

<p>比如，设置成如下：</p>

<pre class="brush: js">    jQuery("#gridid").jqGrid({
        ...
        jsonReader : {
            root:"invdata",
            page: "currpage",
            total: "totalpages",
            records: "totalrecords"
        },
        ...
    });
</pre>

<p>那么，期望结构变为：</p>

<pre class="brush: js">    { 
        "totalpages": "xxx", 
        "currpage": "yyy",
        "totalrecords": "zzz",
        "invdata" : [
            {"id" :"1", "cell" :["cell11", "cell12", "cell13"]},
            {"id" :"2", "cell" :["cell21", "cell22", "cell23"]},
            ...
        ]
    }      
</pre>
</li>
<li><p>cell</p></li>
<li>id 这两个值都是用来描述具体某行的数据的，用法和上面几个值一样。</li>
</ul><p>需要特别说明的是，将 cell 设置为空字符串， id 设为数字时，可以精简结构。</p>

<p>比如：</p>

<pre class="brush: js">   jQuery("#gridid").jqGrid({
        ...
        jsonReader : {
            root:"invdata",
            page: "currpage",
            total: "totalpages",
            records: "totalrecords",
            cell: "",
            id: "0"
        },
        ...
    });
</pre>

<p>那么期望的 json 格式，也就是服务端返回的格式如下：</p>

<pre class="brush: js">    { 
        "totalpages" : "xxx", 
        "currpage" : "yyy",
        "totalrecords" : "zzz",
        "invdata" : [
            ["1", "cell11", "cell12", "cell13"],
            ["2", "cell21", "cell22", "cell23"],
            ...
        ]
    }
</pre>

<p>这个时候，原本的 id 值是去 invdata 元素数组中的第一项，精简了一点。</p>

<ul>
<li>
<p>repeatitems</p>

<p>
<pre class="brush: js">{ 
    "total": "xxx", 
    "page": "yyy", 
    "records": "zzz",
    "rows" : [
        // 这个值是为了说明，cell 数组中的值是规则的，
        // 在此处都是三项，不会出现二项或者四项的情况。
        {"id" :"1", "cell" :["cell11", "cell12", "cell13"]},
        {"id" :"2", "cell":["cell21", "cell22", "cell23"]},
        ...
    ]
}</pre></p>
</li>
</ul><p>假如设为 false，那么 jqGrid 就会根据 colModel 中的 name 的值进行查找，从而不需要列和列一一对应，当然，结构就会改变。</p>

<p>比如：</p>

 <pre class="brush: js">jQuery("#gridid").jqGrid({
    ...
        jsonReader : {
        root:"invdata",
        page: "currpage",
        total: "totalpages",
        records: "totalrecords",
        repeatitems: false,
        id: "0"
    },
    ...
});
</pre>

<p>那么期望值为：</p>

<pre class="brush: js">    { 
        "totalpages" : "xxx", 
        "currpage" : "yyy",
        "totalrecords" : "zzz",
        "invdata" : [
            // 假如在 colModel 的 name 中 有下面的这些属性值
            {"invid" :"1", "invdate" : "cell11", "note" :"somenote"},
            {"invid" :"2", "amount" : "cell22", "tax" :"cell23", "total" :"2345"},
            ...
        ]
    }
</pre>
   
</div>
    <script type="text/javascript">
            SyntaxHighlighter.defaults["toolbar"] = false;
            SyntaxHighlighter.all();
        </script> 
</body>
</html>