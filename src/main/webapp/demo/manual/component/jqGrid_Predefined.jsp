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
jqGrid 自定义单元格内容 之 预定义</h1>
<div class="hotmap">
    <a href="#summary">语言选项</a><a href="#use">规则的可设置项</a><a href="#case">设置规则的进一步分析</a><a href="#property">showlink 示例</a>
    </div>


<p>jqGrid 单元格默认的内容是文本，但是有时候需要放个 a 标签进去，这就要自定义内容了。</p>

<p>这个自定义单元格的过程在 jqGrid 中被成为格式化，有两种格式化方法：</p>

<p>预定义(Predefined )和自定义(Custom)。</p>

<p>本文介绍预定义。</p>

<h2>
<a name="语言选项" class="anchor" id="summary"><span class="octicon octicon-link"></span></a>语言选项</h2>

<p>为适应多语言，jqGrid 有配套的言语文件，下面是中文：</p>

<div class="highlight highlight-js"><pre class="brush: js">$ . jqgrid=  { 
    ... 
    formatter:  { 
        integer:  { thousandsSeparator:" " ,  defaultValue:   >'0' }, 
        number:  { decimalSeparator:  "." ,  thousandsSeparator:" " ,  decimalPlaces:   2 ,  defaultValue:   >'0.00' }, 
        currency:  { decimalSeparator:  "." ,  thousandsSeparator:" " ,  decimalPlaces:   2 ,  prefix:"" ,  suffix:  "" ,  defaultValue:   >'0.00' }, 
        date:  { 
            dayNames:    [ 
                 "Sun" ,"Mon" ,"Tue" ,"Wed" ,"Thr" ,"Fri" ,"Sat" , 
                  "Sunday" ,"Monday" ,"Tuesday" ,"Wednesday" ,"Thursday" ,"Friday" ,"Saturday" 
            ], 
            monthNames:  [ 
                 "Jan" ,"Feb" ,"Mar" ,"Apr" ,"May" ,"Jun" ,"Jul" ,"Aug" ,"Sep" ,"Oct" ,"Nov" ,"Dec" , 
                 "January" ,"February" ,"March" ,"April" ,"May" ,"June" ,"July" ,"August" ,"September" ,"October" ,"November" ,"December" 
            ], 
            AmPm:  [  "am" ,  "pm" ,  "AM" ,  "PM" ], 
            S:   function  ( j )  {  return  j&lt;   11||  j&gt;   13?  [  >'st' ,   >'nd' ,   >'rd' ,   >'th' ][ <span class="nb">Math . min (( j-   1 )%   10 ,   3 )]:   >'th' }, 
            srcformat:   >'Y-m-d' , 
            newformat:   >'m-d-Y' , 
            masks:  { 
                ISO8601Long:  "Y-m-d H:i:s" , 
                ISO8601Short:  "Y-m-d" , 
                ShortDate:"Y/j/n" , 
                LongDate:"l, F d, Y" , 
                FullDateTime:"l, F d, Y g:i:s A" , 
                MonthDay:"F d" , 
                ShortTime:"g:i A" , 
                LongTime:"g:i:s A" , 
                SortableDateTime:"Y-m-d\\TH:i:s" , 
                UniversalSortableDateTime:"Y-m-d H:i:sO" , 
                YearMonth:"F, Y" 
            }, 
            reformatAfterEdit: false 
        }, 
        baseLinkUrl:   >'' , 
        showAction:   >'' , 
        target:   >'' , 
        checkbox:  { disabled:  true }, 
        idName:   >'id' 
    } 
} 
</pre></div>

<p>所谓的预定义就是指这个语言文件。你可以修改上面的值，使之符合使用习惯。</p>

<p>知道了预定义的规则，那么就可以在代码中使用，如下：</p>

<div class="highlight highlight-javascript"><pre class="brush: js">$ ("#grid"  ). jqGrid ({ 
    ... 
    colModel:  [ 
        ... 
        {  name:"myname" ,  ...  formatter:"number" ,  ...  }, 
        ... 
    ], 
    ... 
}); 
</pre></div>

<p>这会将 myname 列的数字格式化，比如某单元格的内容为 "1234.1" ，会被格式化为 "1234.10" 。</p>

<p>问题是，你想保留三位小数，怎么办？</p>

<h2>
<a name="规则的可设置项" class="anchor" id="use"><span class="octicon octicon-link"></span></a>规则的可设置项</h2>

<p>你可以设置预定义中的规则，比如将保留两位小数改成保留三位：</p>

<div class="highlight highlight-javascript"><pre class="brush: js">$ ("#grid"  ). jqGrid ({ 
    ... 
    colModel:  [ 
        ... 
        {  name:"myname" ,  ...  formatter:"number" ,  formatoptions:  {  decimalPlaces:   3  }  }  , 
        ... 
    ], 
    ... 
}); 
</pre></div>

<p>上面的 decimalPlaces 设为 3 就会覆盖默认的 2 。</p>

<h2>
<a name="设置规则的进一步分析" class="anchor" id="case"><span class="octicon octicon-link"></span></a>设置规则的进一步分析</h2>

<p>下面的规则有一个共同属性 defaultValue —— 当对应值为空时，显示为这个 defaultValue 。</p>

<table>
<tbody><tr>
<th>类型</th>
        <th>属性</th>
        <th>详情</th>
    </tr>
<tr>
<td>integer</td>
        <td>thousandsSeparator, defaultValue</td>
        <td>
            整数规则。 <br>
            thousandsSeparator 是 1,000 中的那个逗号，千位分隔符。<br>
</td>
    </tr>
<tr>
<td>number</td>
        <td>decimalSeparator, thousandsSeparator,<br> decimalPlaces, defaultValue</td>
        <td>
            数字规则。 <br>
            thousandsSeparator 同上。 <br>
            decimalSeparator 是 1.1 中的点号，整数小数分隔符。 <br>
            decimalPlaces 是保留的小数的位数。
        </td>
    </tr>
<tr>
<td>currency</td>
        <td>demicalSeparator, thousandsSeparator,<br> decimalPlaces,
         defaultValue, <br> prefix, suffix</td>
        <td>
            货币规则。 <br>
            和数字规则一样，但是多了两个： <br>
            prefix: 前缀，加在数字之前，比如 "$" 。 <br>
            suffix:: 后缀。
        </td>
    </tr>
<tr>
<td>date</td>
        <td>srcFormat, newFormat</td>
        <td>
            日期规则。 <br>
            srcFormat 是现有的日期格式，但是你想换。 <br>
            newFormat 就是你想换的日期格式。 <br>
            jqGrid 的日期格式来自 php 。 <br>
            你可以在上面的语言文件中修改 mask 。
        </td>
    </tr>
<tr>
<td>email</td>
        <td>无</td>
        <td>
            邮箱规则。 <br>
            键入 xxx@oo 类邮箱时，会被转换为 mailto:xxx@oo 链接。
        </td>
    </tr>
<tr>
<td>link</td>
        <td>target</td>
        <td>
            链接规则。 <br>
            创建一个 a 标签， href 指向单元格内容， target 属性指向这个 target。
        </td>
    </tr>
<tr>
<td>showlink</td>
        <td>
            baseLinkUrl,
            showAction, <br>
            addParam, 
            target, <br>
            idName
        </td>
        <td>
            增强的链接规则。 <br>
            baseLinkUrl 是一个链接。 <br>
            showAction 是一个字符串，会加在 baseLinkUrl 之后。 <br>
            addParam 是一个字符串，会加在 idName 之后。 <br>
            target 就是 a 标签的 target 属性。 <br>
            idName 会 被加在 showAction 之后，( this is id )？
        </td>
    </tr>
<tr>
<td>checkbox</td>
        <td>disabled</td>
        <td>
            复选框链接。 <br>
            disabled ，复选框是否禁用，默认 true ，禁用
        </td>
    </tr>
<tr>
<td>select</td>
        <td>无</td>
        <td>很繁琐。可以参见 编辑之一 基本概念 中的 select 说明。</td>
    </tr>
<tr>
<td>actions</td>
        <td>对象</td>
        <td>可以让这列成为一个可以编辑和删除的列。详见表格下方。</td>
    </tr>
</tbody></table><p>actions:</p>

<div class="highlight highlight-js"><pre class="brush: js">{  
    keys: false , 
    editbutton: true , // 启用 编辑 按钮 
    delbutton: true ,             // 启用 删除 按钮 
    editformbutton: false ,        // 编辑使用表单编辑 
    onEdit: null ,                // 变为编辑状态之后触发 
    onSuccess: null ,             
    afterSave:  null ,               // 保存成功 
    onError: null ,               
    afterRestore: null ,           // 撤销编辑后触发。 
    extraparam:  {  oper:"edit"  },   // 额外的参数 
    url: null ,                    // 新的 url ，会覆盖 editurl 
    delOptions:  {},               // 删除参数 
    editOptions:  {}              // 编辑参数 
} 
</pre></div>

<p>更多和 actions 属性相关的内容，请参考 “编辑” 文档。</p>

<h2>
<a name="showlink-示例" class="anchor" id="property"><span class="octicon octicon-link"></span></a>showlink 示例</h2>

<p>我们假定你有如下设置：</p>

<div class="highlight highlight-js"><pre class="brush: js">$ ("#grid"  ). jqGrid ({ 
    ... 
    colModel:  [  {  name:"myname" ,  formatter:"showlink" ,  formatoptions: {  baseLinkUrl:"someurl.jsp" ,  addParam:"&amp;action=edit"  },  ...}  
    ...  
    ] 
    ... 
}); 
</pre></div>

<p>会输出：</p>

<div class="highlight highlight-html"><pre class="brush: js">http://localhost:8080/someurl.jsp?id=123 &amp; action=edit
</pre></div>

<p>id 是所在行的 id 值，如果你不想用 "id" 这个字符，可以如下：</p>

<div class="highlight highlight-js"><pre class="brush: js">$ ("#grid"  ). jqGrid ({ 
    ... 
    colModel:  [  {  name:"myname" ,  formatter:"showlink" ,  formatoptions:  {  baseLinkUrl:"someurl.jsp" ,  addParam:"&amp;action=edit" ,  idName:"myid"  },  ...}  
    ...  
    ] 
    ... 
}); 
</pre></div>

<p>会输出：</p>

<div class="highlight highlight-html"><pre class="brush: js">http://localhost:8080/someurl.jsp?myid=123 &amp; action=edit
</pre></div>
</div>
  <script type="text/javascript">
            SyntaxHighlighter.defaults["toolbar"] = false;
            SyntaxHighlighter.all();
        </script>   
</body>
</html>