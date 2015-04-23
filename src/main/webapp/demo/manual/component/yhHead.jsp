<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>js 加载器</title>
    <link rel = "stylesheet" href = "../css/api.css">
    <link rel = "stylesheet" href = "../hightLigthter/css/shCore.css">
    <link rel = "stylesheet" href = "../hightLigthter/css/shThemeDefault.css">
    <script type = "text/javascript" src="../hightLigthter/js/jquery-1.8.3.min.js"></script>
    <script type = "text/javascript" src="../hightLigthter/js/shCore.js"></script>
    <script type = "text/javascript" src="../hightLigthter/js/shBrushJScript.js"></script>
    <script type = "text/javascript" src="../hightLigthter/js/shBrushXml.js"></script>
    <style type="text/css">
        .panel2 table { border-collapse: collapse; }
        .panel2 th { font-weight: normal; color: #3300FF; }
        .panel2 th, .panel2 td { border: 1px solid #ccc; font-size: 12px; padding: 8px; }
    </style>
</head>
<body>
    <div class="container">
        <h1> yhHead ，js 加载器</h1>
        <div class="content">
            <h2>概述</h2>
                <div class="panel">
                    <p>随着 js 代码量的增大和 js 文件的增多，直接将所有文件引入到页面中的传统开发模式，已经不能满足需求了。</p>
                    <p>为了提高页面的加载速度和更好地管理 js ，yhHead 诞生了。</p>
                    <p> yhHead 内部包含了 <a href="http://headjs.com/" target="_blank">head.js</a> 、 yhui 各个组件的依赖关系以及定义并初始化了 <a href="#YHUI">YHUI</a> 这个全局变量。</p>
                </div>
            <h2>配置项</h2>
                <div class="panel">
                    <p>如果你对配置 yhui 一头雾水，建议先阅读 <a href="../fiveMinute/index.html">五分钟上手 yhui </a>。</p>
                    <p>请注意：配置应该在 页面引入 yhHead.js <strong>之前</strong>。</p>
                    <p><strong>配置方法</strong>：设置全局变量 yhuiConfig 的属性，比如 yhuiConfig.basePath。</p>
                    <p> yhuiConfig有<strong>一个属性</strong> assets 。</p>
                    <p class="arrow"> <strong>assets</strong> -- 添加自己的 js 模块</p>
                    <div class="panel2">
                        <p>因为页面一开始只引入了 yhHead.js ，所以自己引入 yhui 之外的 js 很可能报依赖错误。</p>
                        <p>配置 assets 就可以轻松解决这个问题。</p>
                        <p>假如，要引入的 js 的路径为 http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js。</p>
                        <p>那么可以配置为： </p>
                        <pre class="brush: js">
                            var yhuiConfig = {
                                assets: {
                                    jq1_9: {                              // 模块名称，YHUI.use( "xxx" )
                                        src: "http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js",     // 路径，字符串。
                                        relyOn: []                  // relyOn，数组，所依赖的 js。
                                    }
                                }
                            };
                        </pre>
                    </div>
                </div>
            <h2 id = "YHUI"> YHUI 这个对象</h2>
            <div class="panel">
                <p>页面中引入 yhHead.js后，YHUI 就被初始化为一个对象。</p>
                <p>包含两个方法：</p>
                <div class="panel2">
                    <p class="arrow"> <strong>use</strong> </p>
                    <div class="panel2">
                        <p>YHUI 的入口方法，负责加载所需的 js 。</p>
                        <p>接受两个参数，一个用空格隔开的、表示组件的<strong>字符串</strong>，还有一个<strong>回调函数</strong>，在所有 js 加载完成后执行。</p>
                        <pre class="brush:js">
                            // 会自动加载 yhLayout 所依赖的 js
                            // 务必保证代码在回调函数中，否则 js 可能还没有加载完成。
                            YHUI.use( "yhLayout", function() {
                                $( document.body ).yhLayout();
                            });
                        </pre>
                    </div>
                    <p class="arrow"> log </p>
                    <div class="panel2">
                        <p> 在控制台中打印数据，浏览器没有控制台就会调用 alert 方法。</p>
                        <p> 接受一个参数，可以为任何类型。 </p>
                        <pre class="brush:js">
                            YHUI.log( "yhui is not bad! " );
                        </pre>
                    </div>
                </div>
            </div>
            <h2>组件的名称</h2>
            <div class="panel">
                <p> YHUI.use() 中的组件字符串，和组件的js调用方法以及js文件名都是相同的。比如：</p>
                <pre class="brush:js">
                    // 选项卡 的 js 文件名称为 jquery.yhTabs.js。
                    YHUI.use( "yhTabs", function() {    // use 中对应的字符串： yhTabs
                        $( selector ).yhTabs();         // 调用方法 yhTabs
                    });
                </pre>
                <p><strong>对照表</strong>：</p>
                <div class="panel2">
                    <table>
                        <tr>
                            <th>序号</th>
                            <th>组件名</th>
                            <th> js 文件名</th>
                            <th> use 中的调用名称</th>
                            <th>备注</th>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td><a href="http://api.jquery.com/" target="_blank" class="code">jquery</a></td>
                            <td></td>
                            <td>jquery</td>
                            <td> YHUI.use( "jquery", function() {}); 其他组件都是一样，不多说。</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td><a href="http://api.jqueryui.com/" target="_blank" class="code">jqueryui</a></td>
                            <td></td>
                            <td>jqueryui</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td><a href="http://layout.jquery-dev.net/documentation.cfm" target="_blank" class="code">jquerylayout</a></td>
                            <td></td>
                            <td>jquerylayout</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td>yhui 核心文件</td>
                            <td>yhCore.js</td>
                            <td> yhCore</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>5</td>
                            <td>布局</td>
                            <td>jquery.yhLayout.js</td>
                            <td>yhLayout</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>6</td>
                            <td>右键菜单</td>
                            <td>jquery.yhContextMenu.js</td>
                            <td>yhContextMenu</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>7</td>
                            <td>主题皮肤加载</td>
                            <td>jquery.yhThemePicker.js</td>
                            <td>yhThemePicker</td>
                            <td>待完善。</td>
                        </tr>
                        <tr>
                            <td>8</td>
                            <td>选项卡</td>
                            <td>jquery.yhTabs.js</td>
                            <td>yhTabs</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>9</td>
                            <td>菜单</td>
                            <td>jquery.yhMenu.js</td>
                            <td>yhMenu</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>10</td>
                            <td>窗口</td>
                            <td>jquery.yhWindow.js</td>
                            <td>yhWindow</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>11</td>
                            <td>滚动选项卡</td>
                            <td>jquery.yhScrollTab.js</td>
                            <td>yhScrollTab</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>12</td>
                            <td>页面构件</td>
                            <td>jquery.yhPortlet.js</td>
                            <td>yhPortlet</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>13</td>
                            <td>对话框</td>
                            <td>jquery.yhDialogTip.js</td>
                            <td>yhDialogTip</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>14</td>
                            <td>工具栏</td>
                            <td>jquery.yhToolbar.js</td>
                            <td>yhToolbar</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>15</td>
                            <td>下拉框</td>
                            <td>jquery.yhDropDown.js</td>
                            <td>yhDropDown</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>16</td>
                            <td>表单布局</td>
                            <td>jquery.yhFormField.js</td>
                            <td>yhFormField</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>17</td>
                            <td>日期时间选择器</td>
                            <td>jquery.yhDatePicker.js</td>
                            <td>yhDatePicker</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>18</td>
                            <td>按钮</td>
                            <td>jquery.yhButton.js</td>
                            <td>yhButton</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>19</td>
                            <td>折合面板</td>
                            <td>jquery.yhSwitchPanel.js</td>
                            <td>yhSwitchPanel</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>20</td>
                            <td>左右互选</td>
                            <td>jquery.yhSelector.js</td>
                            <td>yhSelector</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>21</td>
                            <td>验证</td>
                            <td>jquery.yhValidate--.js</td>
                            <td>yhValidate</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>22</td>
                            <td>搜索框</td>
                            <td>jquery.yhSearchBox.js</td>
                            <td>yhSearchBox</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>23</td>
                            <td>jqGrid 的增强</td>
                            <td>jquery.yhGrid.js</td>
                            <td>yhGrid</td>
                            <td>配合 jqGrid 使用。</td>
                        </tr>
                        <tr>
                            <td>24</td>
                            <td>加载效果</td>
                            <td>jquery.yhLoading.js</td>
                            <td>yhLoading</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>25</td>
                            <td>树形菜单</td>
                            <td>jquery.yhLoading.js</td>
                            <td>yhTreemenu</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>26</td>
                            <td>zTree</td>
                            <td></td>
                            <td>zTree</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>27</td>
                            <td>jqGrid</td>
                            <td></td>
                            <td>jqGrid</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>28</td>
                            <td>jqueryui 的日期时间</td>
                            <td></td>
                            <td>datetimepicker</td>
                            <td></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script type = "text/javascript">
        SyntaxHighlighter.defaults["toolbar"] = false;
        SyntaxHighlighter.all();
    </script>
</body>
</html>