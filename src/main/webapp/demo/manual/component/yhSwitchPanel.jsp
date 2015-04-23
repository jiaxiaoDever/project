<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
    <head>
        <meta charset="UTF-8">
        <title>折合面板</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metadoc.jsp" %>
    </head>
    <body>
<div class="container">
    <h1> yhSwitchPanel, 折合面板</h1>
    <div class="hotmap">
    <a href="#summary">概述</a><a href="#use">使用方法</a><a href="#case">案例</a><a href="#property">属性</a><a href="#method">方法</a><a href="#return">回调函数</a><a href="#faq">常见问题</a>
    </div>
    <div class="content">
        <h2 id="summary">概述</h2>
        <div class="panel">
            <p>手风琴(accordion),参见官方<a href="http://api.jqueryui.com/accordion/">API</a>，此处不详述。</p>
            <p>折合面板，类似手风琴，但是可以同时打开多个面板;可以嵌入 iframe;可以用异步向面板中添加内容。</p>                    
        </div>

        <h2 id="use">使用方法</h2>
        <div class="panel">
            <p>html</p>
            <pre class="brush: xml">                        
                <div id = "switch" >
                    <!-- h3 是 title ，紧接着的 div 是对应的面板。 -->
                    <h3><a href="">title1</a></h3>
                    <div></div>

                    <h3><a href="">title2</a></h3>
                    <div></div>

                    <!-- 属性 data-type -->
                    <!-- 如果指向链接，面板在展开过程中会自动添加一个 iframe，并将其 src 设为这个 data-type 的值 -->
                    <h3 data-type = "../form/yhValidate.html"><a href="">title3</a></h3>
                    <div></div>
                </div>
             </pre>
            <p>js调用</p>
            <pre class="brush:js">
                $("#id").yhSwitchPanel({});
            </pre>  
        </div>


        <h2 id="case">案例</h2>
        <div class="panel">
            <table class="infotable">
              <tr>
                <th>分类</th>
                <th>图例</th>
                <th>功能点</th>
              </tr>
              <tr>
                <td>手风琴</td>
                <td><img src="../images/tabs01.gif" alt=""></td>
                <td>在页面空间有限，只需查看、操作一个核心内容时使用。<br>
                    支持打开一个手风琴；全部打开；可直定义ICO；手风琴拖拽改变顺序（注意结构）；手风琴高度自适应（布局中需设置刷新）。
                </td>
              </tr>
              <tr>
                <td>面板</td>
                <td><img src="../images/tabs02.gif" alt=""></td>
                <td>支持展开一个、全部面板。可直定义ICO。面板信息可默认、可iframe加载、可异步加载。可设置面板不能关闭。</td>
              </tr>
            </table>
        </div>

        <h2 id="property">属性</h2>
        <div class="panel">
            <table class="infotable">
              <tr>
                <th>属性</th>
                <th>描述</th>
                <th>值</th>
                <th>默认值</th>
              </tr>
              <tr>
                <td>active</td>
                <td>打开面板。比如 1 ，打开第二个面板；</td>
                <td>数值</td>
                <td>初始化时默认要打开的面板。</td>
              </tr>
              <tr>
                <td>showAllIcons</td>
                <td>是否显示&ldquo;展开全部&rdquo;和折叠全部的按钮。<br>
                不建议初始化的时候展开所有面板，那样会让页面的渲染速度很慢。
                </td>
                <td>布尔值。true;false</td>
                <td>默认值为 true ，显示。</td>
              </tr>
            </table>
            <pre class="brush:js">
                    $("#switch").yhSwitchPanel({
                        active: 2
                    });
                    $("#switch").yhSwitchPanel({
                        showAllIcons: false         // 禁用 “全部” 按钮
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
                <td>activate( index[, callback] )</td>
                <td>展开指定的面板。<br />
                  两个参数，index 的取值同属性 active , callback 可选。<br />
                  在面板为 iframe 的情况下， callback 会在 iframe 加载完成执行，并且其 this 对象指向这个 iframe 。</td>
                <td>
                    <pre class="brush:js">
                    var $switch = $("#switch").yhSwitchPanel();
                    $switch.yhSwitchPanel( "activate", 2, function() {
                        // this 指向 iframe 的 dom 对象
                        console.log( this.contentWindow.$.fn.jQuery );  // 打印子页面中的 jQuery 版本号
                    });
                </pre>
                </td>
              </tr>
              <tr>
                <td>activateAll( index )</td>
                <td>展开所有面板，就像点击&ldquo;展开全部&rdquo;按钮。</td>
                <td>
                    <pre class="brush:js">
                    var $switch = $("#switch").yhSwitchPanel();
                    $switch.yhSwitchPanel( "activateAll" );
                </pre>
                </td>
              </tr>
              <tr>
                <td>fold( index )</td>
                <td>折叠指定的面板。<br />
                  一个参数，index 的取值同属性 active 。</td>
                <td>
                    <pre class="brush:js">
                    var $switch = $("#switch").yhSwitchPanel();
                    $switch.yhSwitchPanel( "fold", 2 );
                </pre>
                </td>
              </tr>
              <tr>
                <td>foldAll( index )</td>
                <td>折叠所有面板，就像点击&ldquo;关闭全部&rdquo;按钮。</td>
                <td>
                    <pre class="brush:js">
                    var $switch = $("#switch").yhSwitchPanel();
                    $switch.yhSwitchPanel( "foldAll" );
                </pre>
                </td>
              </tr>
              <tr>
                <td>hideHeader( index[, removeFlag] )</td>
                <td><p>隐藏标题栏。面板展开时，会闭合后再隐藏标题栏。</p>
                <p>两个参数，index 的取值同<a href="#active">属性 active</a>，removeFlag 可选。</p>
                <p>removeFlag 为布尔值，为 true 时，会将这个 header(h3) 连同对应的 panel(div) 从文档中删除。<strong>该操作不可恢复</strong>。</p></td>
                <td>
                     <pre class="brush:js">
                    var $switch = $("#switch").yhSwitchPanel({
                                    active: 2        
                                });
                    $switch.yhSwitchPanel( "hideHeader", 2, true );
                </pre>
                </td>
              </tr>
              <tr>
                <td>showHeader( index[, showPanelFlag, callback] )</td>
                <td>显示被隐藏的标题栏。<br />
                  三个参数，index 的取值同属性 active，其余可选。<br />
                  showPanelFlag 为布尔值， 设为 true 时，在显示标题栏的同时展开对应的面板。<br />
                  在面板为默认加入 iframe 的情况下， callback 会在 iframe 加载完成后执行，并且其 this 指向这个 iframe 。</td>
                <td>
                    <pre class="brush:js; highlight: [1,4,6]">
                    var $switch = $("#switch").yhSwitchPanel({  // 初始化
                                    active: 2        
                                });
                    $switch.yhSwitchPanel( "hideHeader", 2 );       // 隐藏第三个标题栏
                    ...
                    $switch.yhSwitchPanel( "showHeader", 2, true, function() {   // 显示第三个标题栏
                        // this 指向 iframe 的 dom 对象
                        console.log( this.contentWindow.$.fn.jQuery );  // 打印子页面中的 jQuery 版本号
                    });
                </pre>

                </td>
              </tr>
            </table>
        </div>

    <h2 id="return">回调函数</h2>
    <div class="panel">
       <table class="infotable">
          <tr>
            <th>属性</th>
            <th>描述</th>
            <th>使用</th>
          </tr>
          <tr>
            <td>beforeActivate</td>
            <td>在面板打开之前执行。<br />
              返回值为 false 时，将阻止面板打开。<br />
              带有两个参数，如下。</td>
            <td>
                <pre class="brush:js; highlight:[8]">
                    var flag = false;
                    $("#switch").yhSwitchPanel({
                        beforeActivate: function( e, yhui ) {
                            // e 事件对象
                            // yhui 包含两个属性
                                // yhui.header 标题栏(h3)的 jQuery 对象
                                // yhui.panel  面板(div)的 jQuery 对象
                            if ( flag && yhui.header.index("h3") === 2 ) {
                                return false;       // flag 为真时返回 false，那么第三个面板不能打开
                            }
                        }
                    });
                </pre>
            </td>
          </tr>
          <tr>
            <td>beforeFold</td>
            <td>在面板折合之前执行。<br />
              返回值为 false 时，将阻止面板折合。<br />
              带有两个参数，如下。</td>
            <td>
                <pre class="brush:js; highlight:[8]">
                    var flag = false;
                    $("#switch").yhSwitchPanel({
                        beforeFold: function( e, yhui ) {
                            // e 事件对象
                            // yhui 包含两个属性
                                // yhui.header 标题栏(h3)的 jQuery 对象
                                // yhui.panel  面板(div)的 jQuery 对象
                            if ( flag && yhui.header.index("h3") === 2 ) {
                                return false;       // flag 为真时返回 false，那么第三个面板不能折合
                            }
                        }
                    });
                </pre>
            </td>
          </tr>
          <tr>
            <td>create</td>
            <td>大部分组件都有这个回调函数，在组件初始化完成后触发。</td>
            <td>
                <pre class="brush:js;highlight:[2]">
                    $("#switch").yhSwitchPanel({
                        create: function() {        // 组件初始化完成后，隐藏第三个标题栏
                            $(this).yhSwitchPanel( "hideHeader", 2 );
                        }
                    });
                </pre>
            </td>
          </tr>
        </table> 
    </div>

    <h2 id="faq">常见问题</h2>
    <div class="panel">
        待续
    </div>  

    <br><br><a href="#summary">回到顶部</a>




    </div>
</div>

        <script type="text/javascript">
            SyntaxHighlighter.defaults["toolbar"] = false;
            SyntaxHighlighter.all();
        </script>
    </body>
</html>