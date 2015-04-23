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
jqGrid 编辑 之 基本概念</h1>
<div class="hotmap">
    <a href="#summary">概览</a><a href="#use">editable</a><a href="#case">edittype</a><a href="#property">editoptions</a><a href="#method">editrules</a><a href="#return">自定义规则实例</a><a href="#faq">formoptions</a>
    </div>
<p>快速简单地编辑数据，应该是表格类控件最为重要的功能之一，jqGrid 支持以下三种编辑方式：</p>

<ol>
<li>单元格编辑</li>
<li>行编辑</li>
<li>表单编辑：创建一个包含指定行的字段的表单来进行编辑</li>
</ol><h2>
<a name="概览" class="anchor" id="summary"><span class="octicon octicon-link"></span></a>概览</h2>

<p>任何一种编辑方式都可在 colModel 中使用如下的属性：</p>

<ul>
<li>editable</li>
<li>edittype</li>
<li>editoptions</li>
<li>editrules</li>
<li>
<p>formoptions ( 只在 <strong>表单编辑</strong> 中有效 )</p>

<p>通用语法如下：</p>

<div class="highlight highlight-js"><pre class="brush: js">&lt;script&gt;
$("#grid_id").jqGrid({
    ...
    colModel:[
    ...
        {name:'price',...,editable:true,edittype:'text',editoptions:{...},editrules:{...},formoptions:{...},
    ...
    ]
    ...
});
&lt;/script&gt;
</pre></div>
</li>
</ul><h3>
<a name="editable" class="anchor" id="use"><span class="octicon octicon-link"></span></a>editable</h3>

<p>布尔值，用来表示该列是否可以编辑，默认值是 false ，不可编辑。</p>

<p>值得注意的是，隐藏的列是不可以编辑的，但是他们被标记为了可编辑状态。</p>

<p>在行编辑和单元格编辑模式中，应该让他们显示 ( showCol ) 出来，从而可以编辑，而表单编辑则要用到属性 editrules 。</p>

<h3>
<a name="edittype" class="anchor" id="case"><span class="octicon octicon-link"></span></a>edittype</h3>

<p>编辑自动通常是创建一个文本框或者其他的表单元素。</p>

<p>这个值决定了所创建的表单元素的类型，可以有如下取值：</p>

<ul>
<li>
<p>text </p>

<p>默认值，编辑状态时，jqGrid会创建如下元素：</p>

<div class="highlight highlight-html"><pre class="brush: xml">&lt;input type="text"...../&gt;
</pre></div>

<p>在属性 editoptions 中，我们可以设置上面元素的任意属性，例如：</p>

<div class="highlight highlight-js"><pre class="brush: js">...editoptions:{size:10,maxlength:15}
</pre></div>

<p>如上设置，那么 input 元素将会以如下形式呈现：</p>

<div class="highlight highlight-html"><pre class="brush: xml">&lt;input type="text" size="10" maxlength= "15" /&gt; 
</pre></div>

<p>另外，jqGrid 会按照一定规则自动添加 id 和 name 属性。</p>
</li>
<li>
<p>textarea</p>

<p>编辑状态时，创建一个 textarea 元素。</p>

<p>用法和 text 类似。</p>
</li>
<li>
<p>checkbox</p>

<p>显示为一个复选框。</p>

<p>属性 editoptions 被用来设置选中和未选中的值，如下：</p>

<div class="highlight highlight-js"><pre class="brush: js"> ... editoptions : { value : "Yes:No" } // 第一个是选中状态的值 
</pre></div>

<p>如上设置，会创建如下文本框：</p>

<div class="highlight highlight-html"><pre class="brush: xml"> &lt;input type= "checkbox" value= "Yes" offval= "No" ... /&gt;
</pre></div>

<p>仍旧以上述元素为例，当 value 设置为 Yes 时，将会默认选中复选框,即会自动添加 checked 属性。</p>

<p>这个值会会被传递到后台。</p>

<p>editoptions 中如果没有设置 value 这个属性，jqGrid 为了创建复选框，将会寻找如下值 (false|0|no|off|undefined)，
如果单元格内容不包含这些值，那么 value 就会被设置为单元格内容， offval 被设置为 off。</p>

<p>例如，假如单元格内容为 true 时，那么</p>

<div class="highlight highlight-html"><pre class="brush: js"> &lt;input type= "checkbox" value= "true" offval= "off" checked ... /&gt; 
</pre></div>

<p>最后，jqGrid 会自动添加 id 和 name 属性。</p>
</li>
<li>
<p>select</p>

<p>不用多说：</p>

<pre class="brush: xml"><code>&lt;select&gt; 
    &lt;option value='val1'&gt; Value1 &lt;/option&gt; 
    &lt;option value='val2'&gt; Value2 &lt;/option&gt; 
    ... 
    &lt;option value='valn'&gt; ValueN &lt;/option&gt; 
&lt;/select&gt;
</code></pre>

<p>为了创建上面形式的 select ，一些参数是必要的，如下两种形式任选：</p>

<ul>
<li>
<p>将 editoptions 中的 value 设置为字符串</p>

<p>该 value 必须是以分号分割的键值对字符串，比如下面这种形式</p>

<pre class="brush: js"><code>  // 注意，结尾处没有分号
  editoptions: { value: “FE:FedEx; IN:InTime; TN:TNT” }
</code></pre>

<p>将会创建</p>

<pre class="brush: js"><code>  &lt;select&gt; 
      &lt;option value='FE'&gt; FedEx &lt;/option&gt; 
      &lt;option value='IN'&gt; InTime &lt;/option&gt; 
      &lt;option value='TN'&gt; TNT &lt;/option&gt; 
  &lt;/select&gt;
</code></pre>
</li>
<li>
<p>将 editoptions 中的 value 设置为一个对象，如下形式</p>

<pre class="brush: js"><code>  editoptions:{value:{1:'One',2:'Two'}
</code></pre>

<p>将会创建：</p>

<pre class="brush: js"><code>      &lt;select&gt; 
          &lt;option value='1'&gt;One&lt;/option&gt; 
          &lt;option value='2'&gt;Two&lt;/option&gt; 
      &lt;/select&gt;
</code></pre>
</li>
</ul>
</li>
<li><p>password</p></li>
<li><p>button</p></li>
<li><p>image</p></li>
<li>
<p>file</p>

<p>上面的几个值都会在创建对应的元素。</p>

<p>用法和 text 类似。</p>
</li>
<li><p>custom</p></li>
</ul><h3>
<a name="editoptions" class="anchor" id="property"><span class="octicon octicon-link"></span></a>editoptions</h3>

<p>上面其实提过很多次 editoptions 了。</p>

<p>editoptions 是一个对象，包含着标记列的相关信息。</p>

<p>值得注意的是，edittype 中设置的表单元素任意属性值你都可以在这里设置。</p>

<p>再次强调设置方式，是在 colModel 中：</p>

<div class="highlight highlight-js"><pre class="brush: js">$ ( "#grid_id" ). jqGrid ({ 
     ... 
    colModel : [ 
       ... 
       { name : "price" , ..., editoptions : { name1 : value1 ... }, editable : true }, 
       ... 
    ]
     ... 
 }); 
</pre></div>

<p>如下属性皆可使用：</p>

<table>
<tbody><tr>
<th>属性名</th>
        <th>类型</th>
        <th>描述</th>
    </tr>
<tr>
<td>defaultValue</td>
        <td>字符串或者函数</td>
        <td>新增模式所生成的表单元素一般为空，如果设置该值，就可以将该值默认填入表单元素。<br>
            当然，如果你使用的是函数，务必返回一个字符串。
        </td>
    </tr>
</tbody></table><h3>
<a name="editrules" class="anchor" id="method"><span class="octicon octicon-link"></span></a>editrules</h3>

<p>这个属性就是验证规则，用来确定用户填入的数据合不合法：语法如下：</p>

<div class="highlight highlight-js"><pre class="brush: js"> $ ( "#grid_id" ). jqGrid ({ 
     ... 
    colModel : [ 
       ... 
       { name : "price" , ..., editrules : { edithidden : true , required : true ....}, editable : true }, 
       ... 
    ] 
     ... 
 }); 
</pre></div>

<p>可用的属性值如下：</p>

<table>
<tbody><tr>
<th>属性名</th>
        <th>类型</th>
        <th>描述</th>
    </tr>
<tr>
<td>edithidden</td>
        <td>布尔值</td>
        <td>
            这个属性只能在表单编辑中使用。<br>
            默认情况下，隐藏的列是不可以编辑的，但是该值设置为 true ，即可编辑。
        </td>
    </tr>
<tr>
<td>required</td>
        <td>布尔值</td>
        <td>好说，非空。</td>
    </tr>
<tr>
<td>number</td>
        <td>布尔值</td>
        <td>必须为数字</td>
    </tr>
<tr>
<td>integer</td>
        <td>布尔值</td>
        <td>整数</td>
    </tr>
<tr>
<td>minValue</td>
        <td>整数</td>
        <td>最小值</td>
    </tr>
<tr>
<td>maxValue</td>
        <td>整数</td>
        <td>最大值</td>
    </tr>
<tr>
<td>email</td>
        <td>布尔值</td>
        <td>合法的邮箱</td>
    </tr>
<tr>
<td>url</td>
        <td>布尔值</td>
        <td>合法的 url </td>
    </tr>
<tr>
<td>custom</td>
        <td>布尔值</td>
        <td>启用自定义规则。详见下面的 custom_func 。</td>
    </tr>
<tr>
<td>custom_func</td>
        <td>函数</td>
        <td>
            当 custom 设置为 true 时，该属性可以。<br>
            两个参数，第一个 value ，及表单元素的值，第二个 colname 是 colModel 中的 name 。<br>
            返回值是一个数组，第一个元素为布尔值，验证成功为 true ； <br>
            第二个元素在第一个元素为 false 时有效，字符串，即出错提示语。
        </td>
    </tr>
</tbody></table><h5>
<a name="自定义规则实例" class="anchor" id="return"><span class="octicon octicon-link"></span></a>自定义规则实例</h5>

<div class="highlight highlight-js"><pre class="brush: js"> function mypricecheck ( value , colname ) { 
     if ( value &lt; 0 || value &gt; 20 ) {  
        return [ false , "请输入 0~20 之间的数" ]; 
     } else { 
        return [ true , "" ]; 
     } 
 } 
 $ ( "#grid_id" ). jqGrid ({ 
     ... 
     colModel : [  
         ...  
         { name : "price" , ..., editrules : { custom : true , custom_func : mypricecheck .... }, editable : true >}, 
         ... 
    ] 
     ...v
}); 
 // 就是那么简单 
</pre></div>

<h3>
<a name="formoptions" class="anchor" id="faq"><span class="octicon octicon-link"></span></a>formoptions</h3>

<p>这个属性只在 表单编辑 模式下有效。</p>

<p>这个属性的作用是在创建表单的过程中，添加一些标识元素，比如 * 号，语法：</p>

<div class="highlight highlight-js"><pre class="brush: js"> $ ( "#grid_id" ). jqGrid ({ 
     ... 
        colModel :  [  
            ... 
            { name : "price" ,  ..., formoptions :  { elmprefix : '(*)' , rowpos : 1 , colpos : 2 ....},  editable : true  }, 
            ...
       ] 
    ... 
}); 
</pre></div>

<p>可用属性如下：</p>

<table>
<tbody><tr>
<th>属性名</th>
        <th>类型</th>
        <th>描述</th>
    </tr>
<tr>
<td>elempreifx</td>
        <td>字符串</td>
        <td>在表单元素之前加一个文本或者元素，比如 "*" 或者 "&amp;ltspan&gt;*&amp;lt/span&gt;" 。</td>
    </tr>
<tr>
<td>elmsuffix</td>
        <td>字符串</td>
        <td>在表单元素之后加一个文本或者元素，比如 "*" 或者 "&amp;ltspan&gt;*&amp;lt/span&gt;" 。</td>
    </tr>
<tr>
<td>label</td>
        <td>字符串</td>
        <td>替代 colNames 中的名称 </td>
    </tr>
</tbody></table>


 <script type="text/javascript">
            SyntaxHighlighter.defaults["toolbar"] = false;
            SyntaxHighlighter.all();
        </script>    
</body>
</html>