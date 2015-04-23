<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>选项卡</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metadoc.jsp" %>
</head>
<body>
    <div class="container">
        <h1>yhTabs， yhui 的选项卡</h1>
         <div class="hotmap">
            <a href="#summary">概述</a><a href="#use">使用方法</a><a href="#case">案例</a><a href="#property">属性</a><a href="#method">方法</a><a href="#faq">常见问题</a>
            </div>
        <div class="content">
            <h2 id="summary">概述</h2>
            <div class="panel">
                <p>yhTabs继承自官方<a target="_blank" href="http://api.jqueryui.com/tabs/">选项卡(tabs)</a>，但扩展了新功能。</p>
                <p>yhTabs 分为<strong>框架模式</strong>和<strong>一般模式</strong>。</p>
                <p><strong>框架模式</strong>会初始化左右箭头和右侧列表，并且有特定的 html 结构和类名。</p>
                <p><strong>一般模式</strong>简单，与官方一致。但增加了“add”方法，一键添加选项卡。</p>
            </div>

            <h2 id="use">使用方法</h2>
            <div class="panel">
                <p>html</p>
                <pre class="brush:xml">
                    框架模式
                    <div> <!-- 最外层 -->

                        <div class = "yhui-tabs-header">  <!-- 头部 -->
                            <div class = "yhui-tabs-header-inner">
                                <ul>
                                    <li><a href = "#tabs-1">框架模式</a></li>
                                </ul>
                            </div>
                        </div>

                        <div class = "ui-layout-content"> <!-- 面板区 -->
                            <div id = "tabs-1">
                                
                            </div>
                        </div>

                    </div>
                </pre>
                <pre class="brush:xml">
                    一般模式
                    <div id="tabs"> <!-- 最外层 -->

                        <!-- 头部 -->
                        <ul>
                            <li><a href="#tabs1">一般模式1</a></li>
                            <li><a href="#tabs2">一般模式2</a></li>
                        </ul>

                        <!-- 面板区 -->
                        <div id="tabs1"></div>
                        <div id="tabs2"></div>

                    </div>
                </pre>
                <p>js调用</p>
                <pre class="brush:js">
                    $("#tabs").yhTabs({});
                </pre>  
                <p>使用时，务必保证 html 的结构正确。</p>
            </div>  
            
            <h2 id="property">属性</h2>
            <div class="panel">
                <table class="infotable">
                  <tr>
                    <th >属性</th>
                    <th>描述</th>
                    <th>值</th>
                    <th>默认值</th>
                  </tr>
                  <tr>
                    <td>frame</td>
                    <td>yhTabs 是否框架模式。</td>
                    <td>布尔值。true;false</td>
                    <td>false </td>
                  </tr>
                  <tr>
                    <td>showLoading</td>
                    <td>框架模式下加载新选项卡时，是否出现 loading 遮罩层。</td>
                    <td>布尔值。true;false</td>
                    <td>false&nbsp;</td>
                  </tr>
                  <tr>
                    <td>standTimeout</td>
                    <td>加载超过多长时间才出现遮罩层，从而避免加载较快的页面也短暂的出现遮罩层。</td>
                    <td>数值。单位微秒</td>
                    <td align="right">500</td>
                  </tr>
                  <tr>
                    <td>timeOut</td>
                    <td>选项卡加载超过该时间就视为超时，会关闭正在加载的选项卡。</td>
                    <td>数值。单位微秒</td>
                    <td>默认值 10000，10 秒 。</td>
                  </tr>
                  <tr>
                    <td>tooltip</td>
                    <td>列表位置是否出现提示，表现形式是鼠标移到，出现一块区域展示列表的内容。</td>
                    <td>布尔值。true;false</td>
                    <td>true </td>
                  </tr>
                  <tr>
                      <td>level</td>
                      <td>数值。当2个相邻的tabs出现时，从视觉上区分层级关系</td>
                      <td>数值</td>
                      <td>默认 1 </td>
                  </tr>
                </table>

               <pre class="brush:js;">
                    $("div.ui-layout-center").yhTabs({
                        frame: true,           // 开启框架模式
                        showLoading: true,       // 出现遮罩层。
                        standTimeout: 100,    // 超过 100 微秒就出现遮罩层。
                        timeOut: 2000,      // 超过 2 秒就算超时，自动关闭选项卡。
                        tooltip: false       // 禁用提示
                    }); 
                </pre>                
            </div>

            

            <h2 id="method">方法</h2>
                <div class="panel">
                <table class="infotable">
                  <tr>
                    <th>属性</th>
                    <th>描述</th>
                    <th>使用</th>
                  </tr>
                  <tr>
                    <td>add</td>
                    <td><p>add 方法在<strong>一般模式下使用</strong>，可以方便地添加一个选项卡。</p>
                    <p>接受一个对象类型的参数，该对象的属性如下：</p>
                    <p><strong>title</strong>：选项卡的标题，字符串，必须设置。</p>
                    <p><strong>id</strong>：面板的 id 值，字符串，必须页面唯一。省略时，会自动生成唯一的 id 。</p>
                    <p><strong>src</strong>：链接形式的字符串。如果设置了，会<strong>自动</strong>添加一个 iframe，并将其指向这个 src 。</p>
                    <p><strong>callback</strong>：函数。在添加完面板后会触发这个函数。带有一个参数，包含两个属性，详见代码。</p></td>
                    <td>
                        <pre class="brush:js; highlight:[8]">
                        <button>添加</button>

                        // js
                        var $yhTabs = $("#tabs").yhTabs({
                                            heightStyle: "fill"     // 官方 tabs 的属性之一
                                        });
                        $("button").on( "click", function() {
                            $yhTabs.yhTabs( "add", {                // 调用 add 方法。
                                title: "添加一个iframe",
                                id: "myIframe",
                                src: "http://www.baidu.com/",
                                callback: function( yhui ) {
                                    console.log( yhui.tab );        // tab 就是新加选项卡的 li
                                    console.log( yhui.panel );      // panel 就是新加选项卡的 div
                                }
                            });
                        });

                    </pre>
                    </td>
                  </tr>
                  <tr>
                    <td>addTab</td>
                    <td>
                        <p> addTab 方法在<strong>框架模式</strong>使用，添加一个标签页。</p>
                    <p>接受三个参数，依次为 触发事件的元素的 jQuery 对象，iframe 的链接和 title。</p>
                    <p> title 是表示标题的字符串，省略的情况下，会自动将第一个参数也就是触发事件的元素的 innerHTML 做为 title 。</p>
                    <p>说起来有点绕口，大家直接看<a href="http://192.168.1.168:9080/YHUI1.2/Components/yhTabs.html" target="_blank">DEMO</a>，源码有详细的注释。</p>

                    </td>
                    <td>

                    </td>
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