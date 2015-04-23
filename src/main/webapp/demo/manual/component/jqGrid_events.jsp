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
        <h1>jqGrid 的事件</h1>
      <table border="1" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td valign="top" width="145">
<p><span>事件</span></p>

</td>
<td valign="top" width="190">
<p><span>参数</span></p>

</td>
<td valign="top" width="463">
<p><span>备注</span></p>

</td>

</tr>
<tr>
<td valign="top" width="145">
<p><span><span>afterInsertRow</span></span></p>

</td>
<td valign="top" width="190">
<p><span><span>rowidrowdatarowelem</span></span></p>

</td>
<td valign="top" width="463">
<p><span><span>当插入每行时触发。</span><span>rowid</span><span>插入当前行的</span><span>id</span><span>；</span><span>rowdata</span><span>插入行的数据，格式为</span><span>name: value</span><span>，</span><span>name</span><span>为</span><span>colModel</span><span>中的名</span><span>字</span></span></p>

</td>

</tr>
<tr>
<td valign="top" width="145">
<p><span><span>beforeRequest</span></span></p>

</td>
<td valign="top" width="190">
<p><span><span>none</span></span></p>

</td>
<td valign="top" width="463">
<p><span><span>向服务器端发起请求之前触发此事件但如果</span><span>datatype</span><span>是一个</span><span>function</span><span>时例</span><span>外</span></span></p>

</td>

</tr>
<tr>
<td valign="top" width="145">
<p><span><span>beforeSelectRow</span></span></p>

</td>
<td valign="top" width="190">
<p><span><span>rowid, e</span></span></p>

</td>
<td valign="top" width="463">
<p><span><span>当用户点击当前行在未选择此行时触发。</span><span>rowid</span><span>：此行</span><span>id</span><span>；</span><span>e</span><span>：事件对象。返回值为</span><span>ture</span><span>或者</span><span>false</span><span>。如果返回</span><span>true</span><span>则选择完成，如果返回</span><span>false</span><span>则不会选择此行也不会触发其他事</span><span>件</span></span></p>

</td>

</tr>
<tr>
<td valign="top" width="145">
<p><span><span>gridComplete</span></span></p>

</td>
<td valign="top" width="190">
<p><span><span>none</span></span></p>

</td>
<td valign="top" width="463">
<p><span><span>当表格所有数据都加载完成而且其他的处理也都完成时触发此事件，排序，翻页同样也会触发此事</span><span>件</span></span></p>

</td>

</tr>
<tr>
<td valign="top" width="145">
<p><span><span>loadComplete</span></span></p>

</td>
<td valign="top" width="190">
<p><span><span>xhr</span></span></p>

</td>
<td valign="top" width="463">
<p><span><span>当从服务器返回响应时执行，</span><span>xhr</span><span>：</span><span>XMLHttpRequest&nbsp;</span><span>对</span><span>象</span></span></p>

</td>

</tr>
<tr>
<td valign="top" width="145">
<p><span><span>loadError</span></span></p>

</td>
<td valign="top" width="190">
<p><span><span>xhr,status,error</span></span></p>

</td>
<td valign="top" width="463">
<p><span><span>如果请求服务器失败则调用此方法。</span><span>xhr</span><span>：</span><span>XMLHttpRequest&nbsp;</span><span>对象；</span><span>satus</span><span>：错误类型，字符串类型；</span><span>error</span><span>：</span><span>exception</span><span>对</span><span>象</span></span></p>

</td>

</tr>
<tr>
<td valign="top" width="145">
<p><span><span>onCellSelect</span></span></p>

</td>
<td valign="top" width="190">
<p><span><span>rowid,iCol,cellcontent,e</span></span></p>

</td>
<td valign="top" width="463">
<p><span><span>当点击单元格时触发。</span><span>rowid</span><span>：当前行</span><span>id</span><span>；</span><span>iCol</span><span>：当前单元格索引；</span><span>cellContent</span><span>：当前单元格内容；</span><span>e</span><span>：</span><span>event</span><span>对</span><span>象</span></span></p>

</td>

</tr>
<tr>
<td valign="top" width="145">
<p><span><span>ondblClickRow</span></span></p>

</td>
<td valign="top" width="190">
<p><span><span>rowid,iRow,iCol,e</span></span></p>

</td>
<td valign="top" width="463">
<p><span><span>双击行时触发。</span><span>rowid</span><span>：当前行</span><span>id</span><span>；</span><span>iRow</span><span>：当前行索引位置；</span><span>iCol</span><span>：当前单元格位置索引；</span><span>e:event</span><span>对</span><span>象</span></span></p>

</td>

</tr>
<tr>
<td valign="top" width="145">
<p><span><span>onHeaderClick</span></span></p>

</td>
<td valign="top" width="190">
<p><span><span>gridstate</span></span></p>

</td>
<td valign="top" width="463">
<p><span><span>当点击显示</span><span>/</span><span>隐藏表格的那个按钮时触发；</span><span>gridstate</span><span>：表格状态，可选值：</span><span>visible or hidden</span></span></p>

</td>

</tr>
<tr>
<td valign="top" width="145">
<p><span><span>onPaging</span></span></p>

</td>
<td valign="top" width="190">
<p><span><span>pgButton</span></span></p>

</td>
<td valign="top" width="463">
<p><span><span>点击翻页按钮填充数据之前触发此事件，同样当输入页码跳转页面时也会触发此事</span><span>件</span></span></p>

</td>

</tr>
<tr>
<td valign="top" width="145">
<p><span><span>onRightClickRow</span></span></p>

</td>
<td valign="top" width="190">
<p><span><span>rowid,iRow,iCol,e</span></span></p>

</td>
<td valign="top" width="463">
<p><span><span>在行上右击鼠标时触发此事件。</span><span>rowid</span><span>：当前行</span><span>id</span><span>；</span><span>iRow</span><span>：当前行位置索引；</span><span>iCol</span><span>：当前单元格位置索引；</span><span>e</span><span>：</span><span>event</span><span>对</span><span>象</span></span></p>

</td>

</tr>
<tr>
<td valign="top" width="145">
<p><span><span>onSelectAll</span></span></p>

</td>
<td valign="top" width="190">
<p><span><span>aRowids,status</span></span></p>

</td>
<td valign="top" width="463">
<p><span><span>multiselect</span><span>为</span><span>ture</span><span>，且点击头部的</span><span>checkbox</span><span>时才会触发此事件。</span><span>aRowids</span><span>：所有选中行的</span><span>id</span><span>集合，为一个数组。</span><span>status</span><span>：</span><span>boolean</span><span>变量说明</span><span>checkbox</span><span>的选择状态，</span><span>true</span><span>选中</span><span>false</span><span>不选中。无论</span><span>checkbox</span><span>是否选择，</span><span>aRowids</span><span>始终有</span>&nbsp;<span>值</span></span></p>

</td>

</tr>
<tr>
<td valign="top" width="145">
<p><span><span>onSelectRow</span></span></p>

</td>
<td valign="top" width="190">
<p><span><span>rowid,status</span></span></p>

</td>
<td valign="top" width="463">
<p><span><span>当选择行时触发此事件。</span><span>rowid</span><span>：当前行</span><span>id</span><span>；</span><span>status</span><span>：选择状</span><span>态</span><span>，当</span><span>multiselect&nbsp;</span><span>为</span><span>true</span><span>时此参数才可</span><span>用</span></span></p>

</td>

</tr>
<tr>
<td valign="top" width="145">
<p><span><span>onSortCol</span></span></p>

</td>
<td valign="top" width="190">
<p><span><span>index,iCol,sortorder</span></span></p>

</td>
<td valign="top" width="463">
<p><span><span>当点击排序列但是数据还未进行变化时触发此事件。</span><span>index</span><span>：</span><span>name</span><span>在</span><span>colModel</span><span>中位置索引；</span><span>iCol</span><span>：当前单元格位置索引；</span><span>sortorder</span><span>：排序状态：</span><span>desc</span><span>或者</span><span>asc</span></span></p>

</td>

</tr>
<tr>
<td valign="top" width="145">
<p><span><span>resizeStart</span></span></p>

</td>
<td valign="top" width="190">
<p><span><span>event, index</span></span></p>

</td>
<td valign="top" width="463">
<p><span><span>当开始改变一个列宽度时触发此事件。</span><span>event</span><span>：</span><span>event</span><span>对象；</span><span>index</span><span>：当前列在</span><span>colModel</span><span>中位置索</span><span>引</span></span></p>

</td>

</tr>
<tr>
<td valign="top" width="145">
<p><span><span>resizeStop</span></span></p>

</td>
<td valign="top" width="190">
<p><span><span>newwidth, index</span></span></p>

</td>
<td valign="top" width="463">
<p><span><span>当列宽度改变之后触发此事件。</span><span>newwidth</span><span>：列改变后的宽度；</span><span>index</span><span>：当前列在</span><span>colModel</span><span>中的位置索</span><span>引</span></span></p>

</td>

</tr>
<tr>
<td valign="top" width="145">
<p><span><span>serializeGridData</span></span></p>

</td>
<td valign="top" width="190">
<p><span><span>postData</span></span></p>

</td>
<td valign="top" width="463">
<p><span><span>向服务器发起请求时会把数据进行序列化，用户自定义数据也可以被提交到服务器</span><span>端</span></span></p>

</td>

</tr>

</tbody>

</table>
    
</div>
    
</body>
</html>