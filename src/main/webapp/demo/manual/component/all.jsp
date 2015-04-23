<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
<meta charset="UTF-8">
<title>布局</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metadoc.jsp" %>
</head>
<body>
<div class="container">
    <h1>整体说明</h1>
    <div class="content">
        <h2>使用须知</h2>
        <div class="panel">
            <p>必须引用css、js文件，使用YHUI.use( "yhLayout", function() {......});方法。</p>
            <p>【css、js引用】将 yhui-structure 、 yhui-skin 、 yhHead.js 依次引入你所要用到的页面。也可以将引用文件放到一个 <span class="code">assets.jsp</span> 中，方便各页面引入。</p>
            <pre class="brush:js">
                <link rel = "stylesheet" href = "xxxx/yhui-sturcture.css">
                <link rel = "stylesheet" href = "xxxx/yhui-skin.css">
                <script type = "text/javascript" src="xxxxxx/yhHead.js"></script>
             </pre> 
             <p>【调用(写在body结束标签前)】</p>
             <pre class="brush:js">
                &lt;script type="text/javascript"&gt;
                  YHUI.use("yhLayout", function() {
                    ......   
                  });
                &lt;/script&gt;
             </pre> 
             <p>“yhLayout”处，可按需引用多个组件（页面使用的组件必须引用）。组件对应的js通过yhHead按需加载。</p>
             <p>组件引用后，要有相应的调用、触发。</p>
             <pre class="brush:js">
                  YHUI.use("yhLayout", function() {
                    $(document.body).yhLayout();  //页面加载body时调用yhLayout。    
                  });
             </pre> 
             <p>调用多个组件式，用空格隔开。</p>
             <pre class="brush:js">
                  YHUI.use("yhLayout yhToolbar yhDropDown", function() {
                    ......    
                  });
             </pre>
        </div>
        <h2>组件总览</h2>
        <div class="panel">
          <table class="infotable">
            <tr>
              <th>序号</th>
              <th>　</th>
              <th>js文件</th>
              <th>组件名称</th>
              <th>use中调用名称</th>
              <th>组件名</th>
            </tr>
            <tr>
              <td >1</td>
              <td >base</td>
              <td >jquery-1.8.3</td>
              <td >　</td>
              <td >　</td>
              <td >YHUI.use(    &quot;jquery&quot;, function() {}); 其他组件都是一样。</td>
            </tr>
            <tr>
              <td>2</td>
              <td>　</td>
              <td>jquery-ui</td>
              <td>　</td>
              <td></td>
              <td>UI</td>
            </tr>
            <tr>
              <td >3</td>
              <td >　</td>
              <td >jquery.layout-latest</td>
              <td >　</td>
              <td ></td>
              <td>布局</td>
            </tr>
            <tr>
              <td >4</td>
              <td >　</td>
              <td >yhCore</td>
              <td >yhui    核心文件</td>
              <td ></td>
              <td></td>
            </tr>
            <tr>
              <td>5</td>
              <td>　</td>
              <td>yhHead</td>
              <td>　</td>
              <td>　</td>
              <td>js汇总文件</td>
            </tr>
            <tr>
              <td>6</td>
              <td>组件</td>
              <td>　</td>
              <td>　</td>
              <td>　</td>
              <td></td>
            </tr>
            <tr>
              <td>7</td>
              <td>　</td>
              <td>jquery.yhButton</td>
              <td>按钮</td>
              <td>yhButton</td>
              <td></td>
            </tr>
            <tr>
              <td >8</td>
              <td >　</td>
              <td >jquery.yhContextMenu</td>
              <td >右键菜单</td>
              <td >yhContextMenu</td>
              <td></td>
            </tr>
            <tr>
              <td >9</td>
              <td >　</td>
              <td >jquery.yhDatePicker</td>
              <td >日期时间选择器</td>
              <td >yhDatePicker</td>
              <td></td>
            </tr>
            <tr>
              <td>10</td>
              <td >　</td>
              <td>jquery.yhDialogTip</td>
              <td >对话框</td>
              <td >yhDialogTip</td>
              <td></td>
            </tr>
            <tr>
              <td>11</td>
              <td >　</td>
              <td>jquery.yhDropDown</td>
              <td >下拉框（昱辉下拉框）</td>
              <td >yhDropDown</td>
              <td></td>
            </tr>
            <tr>
              <td>12</td>
              <td >　</td>
              <td>jquery.yhFormField</td>
              <td >表单布局</td>
              <td >yhFormField</td>
              <td></td>
            </tr>
            <tr>
              <td>13</td>
              <td >　</td>
              <td>jquery.yhGrid</td>
              <td >jqGrid    的增强</td>
              <td >yhGrid</td>
              <td>配合 jqGrid 使用。</td>
            </tr>
            <tr>
              <td>14</td>
              <td >　</td>
              <td>jquery.yhLayout</td>
              <td >布局</td>
              <td >yhLayout</td>
              <td></td>
            </tr>
            <tr>
              <td>15</td>
              <td >　</td>
              <td>jquery.yhLoading</td>
              <td >页面加载状态</td>
              <td >yhLoading</td>
              <td></td>
            </tr>
            <tr>
              <td>16</td>
              <td >　</td>
              <td>jquery.yhMenu</td>
              <td >菜单</td>
              <td >yhMenu</td>
              <td></td>
            </tr>
            <tr>
              <td>17</td>
              <td >　</td>
              <td>jquery.yhPlaceholder</td>
              <td >占位文本</td>
              <td >yhPlaceholder</td>
              <td>占位文本</td>
            </tr>
            <tr>
              <td>18</td>
              <td >　</td>
              <td>jquery.yhPortlet</td>
              <td >页面构件</td>
              <td >yhPortlet</td>
              <td></td>
            </tr>
            <tr>
              <td>19</td>
              <td >　</td>
              <td>jquery.yhScrollTab</td>
              <td >滚动选项卡</td>
              <td >yhScrollTab</td>
              <td></td>
            </tr>
            <tr>
              <td>20</td>
              <td >　</td>
              <td>jquery.yhSearchBox</td>
              <td >搜索框</td>
              <td >yhSearchBox</td>
              <td></td>
            </tr>
            <tr>
              <td>21</td>
              <td >　</td>
              <td>jquery.yhSelectmenu</td>
              <td >下拉框（普通下拉框）</td>
              <td >yhSelectmenu</td>
              <td></td>
            </tr>
            <tr>
              <td>22</td>
              <td >　</td>
              <td>jquery.yhSelector</td>
              <td >左右互选</td>
              <td >yhSelector</td>
              <td></td>
            </tr>
            <tr>
              <td>23</td>
              <td >　</td>
              <td>jquery.yhSwitchPanel</td>
              <td >折合面板</td>
              <td >yhSwitchPanel</td>
              <td></td>
            </tr>
            <tr>
              <td>24</td>
              <td >　</td>
              <td>jquery.yhTabs</td>
              <td >选项卡</td>
              <td >yhTabs</td>
              <td></td>
            </tr>
            <tr>
              <td>25</td>
              <td >　</td>
              <td>jquery.yhThemePicker</td>
              <td >主题加载</td>
              <td >yhThemePicker</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>26</td>
              <td >　</td>
              <td>jquery.yhToolbar</td>
              <td >工具栏</td>
              <td >yhToolbar</td>
              <td></td>
            </tr>
            <tr>
              <td>27</td>
              <td></td>
              <td>jquery.yhTreemenu</td>
              <td>树形菜单</td>
              <td>yhTreemenu</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>28</td>
              <td></td>
              <td>jquery.yhValidate</td>
              <td >验证</td>
              <td >yhValidate</td>
              <td></td>
            </tr>
            <tr>
              <td>29</td>
              <td></td>
              <td>jquery.yhWindow</td>
              <td >窗口</td>
              <td >yhWindow</td>
              <td></td>
            </tr>
            <tr>
              <td>30</td>
              <td>plugin</td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
            </tr>
            <tr>
              <td>31</td>
              <td></td>
              <td>globalize</td>
              <td></td>
              <td></td>
              <td></td>
            </tr>
            <tr>
              <td>32</td>
              <td></td>
              <td>jquery-ui-datetimepicker</td>
              <td>jqueryui 的日期时间</td>
              <td>datetimepicker</td>
              <td></td>
            </tr>
            <tr>
              <td>33</td>
              <td></td>
              <td>jquery.jqGrid</td>
              <td>表格</td>
              <td>jqGrid</td>
              <td></td>
            </tr>
            <tr>
              <td>34</td>
              <td></td>
              <td>jquery.mousewheel</td>
              <td>鼠标滚轮</td>
              <td>mousewheel</td>
              <td></td>
            </tr>
            <tr>
              <td>35</td>
              <td></td>
              <td>jquery.toolbar</td>
              <td>工具栏</td>
              <td>toolbar</td>
              <td></td>
            </tr>
            <tr>
              <td>36</td>
              <td></td>
              <td>jquery.ztree</td>
              <td>树</td>
              <td>ztee</td>
              <td></td>
            </tr>
          </table>
        </div>
    </div>
</div>
    <script type="text/javascript">
        SyntaxHighlighter.defaults["toolbar"] = false;
        SyntaxHighlighter.all();
    </script>
</body>
</html>