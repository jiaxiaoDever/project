<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>右键菜单</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metadoc.jsp" %>
</head>
<body>
    <div class="container">
        <h1>yhContextMenu，右键菜单</h1>
        <div class="hotmap">
            <a href="#summary">概述</a><a href="#use">使用方法</a><a href="#case">案例</a><a href="#property">属性</a><a href="#method">方法</a><a href="#return">回调函数</a><a href="#faq">常见问题</a>
            </div>
        <div class="content">
            <h2 id="summary">概述</h2>
            <div class="panel">
                <p>右键菜单yhContextMenu。简单易用。</p>
                <p>完全脱离 html ，只需传入一个数组就能定制右键。</p>
                <p>支持禁止特定项，特定情况下禁用整个右键。</p>
            </div>

<h2 id="use">使用方法</h2>
            <div class="panel">
                <p>html</p>
                <pre class="brush:js">
                    <ul id="menu" class="ztree"></ul>
                </pre>
                <p>js调用</p>
                <pre class="brush:js">
                    $("#menu").yhContextMenu({});
                </pre>  
            </div>

            
            <h2 id="case">案例</h2>
            <div class="panel">
                <table class="infotable">
                  <tr>
                    <th>菜单分类</th>
                    <th>图例</th>
                    <th>案例</th>
                  </tr>
                  <tr>
                    <td>右键菜单</td>
                    <td><img src="../images/menu/menu03.gif" alt=""></td>
                    <td></td>
                  </tr>
                </table>
            </div>

            <h2 id="property">属性</h2>
            <div class="panel"> 
                <table class="infotable">
                      <col width="173" />
                      <col width="451" />
                      <col width="198" />
                      <col width="297" />
                      <tr>
                        <th width="173">属性</th>
                        <th width="451">描述</th>
                        <th width="198">值</th>
                        <th width="297">默认值</th>
                      </tr>
                      <tr>
                        <td>menu</td>
                        <td width="451">对象类型，key/value 对， key 就是菜单的节点，    value 就是点击事件。<br />
                          这个是必须要设置的属性，默认值 null 。</td>
                        <td></td>
                        <td>默认值 null。</td>
                      </tr>
                      <tr>
                        <td>width</td>
                        <td>菜单的宽度。</td>
                        <td>数值，单位 px</td>
                        <td>默认值 150。</td>
                      </tr>
                      <tr>
                        <td>zIndex</td>
                        <td width="451">菜单的 z-index 属性。<br />
                          如果你发现菜单被其他元素盖住了，把这个属性设大点(&gt;200)往往能解决。</td>
                        <td>数值，单位 px</td>
                        <td>默认值 200。</td>
                      </tr>
                    </table>
                    <pre class="brush:js; highlight: [16]">
                        var contextmenu = {
                            "趋势图": function( e, target ) {
                                // e  事件对象
                                // target 实际元素的 dom 对象
                                    // 如果理解 “事件对象，这个 target 就很好理解
                                    // 我们是给表格绑定右键的，可我们其实右击的是单元格
                                    // 这个 target 就是那个单元格 
                                alert( target.innerHTML );
                            },
                            "派发督办单": function( e, target ) {},
                            "操作名称": function() {}
                        };

                        // 比如要在一个 id 为 "tb" 的表格绑定右键菜单
                        $("#tb").yhContextMenu({
                            menu: contextmenu,
                            width: 100      // 将菜单的宽度调整为 100px
                        });
                    </pre>
            </div>

            <h2 id="method">方法</h2>
            <div class="panel">
                <table class="infotable">
                  <col width="173" />
                  <col width="451" />
                  <col width="198" />
                  <tr>
                    <th width="173">方法</th>
                    <th width="451">描述</th>
                    <th width="198">使用</th>
                  </tr>
                  <tr>
                    <td>disableItem</td>
                    <td width="451">禁用某个选项。<br />
                      可以在 beforeShow 回调中使用。<br />
                      接受一个从 0 开始的、数值类型的参数，表示第几个选项。<br />
                      或者数组，其中的元素从 0 开始。</td>
                    <td>
                        <pre class="brush:js">
                        $("#tb").yhContextMenu({
                            menu: contextmenu,
                            beforeShow: function() {
                                // 禁用第一项
                                $(this).yhContextMenu( "disableItem", 0 );
                                // 禁用了第二和第三项
                                $(this).yhContextMenu( "disableItem", [ 1, 2 ] );
                            }
                        });
                    </pre>
                    </td>
                  </tr>
                  <tr>
                    <td>enableItem</td>
                    <td width="451">菜单选项禁用的情况下，启用之。<br />
                      取值与用法都和 disableItem 类似。</td>
                    <td></td>
                  </tr>
                </table>       
            </div>

            <h2 id="return">回调函数</h2>
            <div class="panel">
                 <table class="infotable">
                      <col width="173">
                      <col width="451">
                      <col width="198">
                      <tr>
                        <th width="173">回调函数</th>
                        <th width="451">描述</th>
                        <th width="198">使用</th>
                      </tr>
                      <tr>
                        <td>beforeHide</td>
                        <td width="451">隐藏菜单之前触发。<br>
                          返回值为 false 时，阻止菜单隐藏。</td>
                        <td> 
                            <pre class="brush:js; highlight: [3]">
                        $("#tb").yhContextMenu({
                            menu: contextmenu,
                            beforeHide: function( e, yhui ) {
                                // e 事件对象
                                // yhui 对象
                                    // yhui.target 触发右键事件的目标元素
                                    // yhui.menu 即菜单(ul)的 jQuery 对象
                                    // yhui.container 这里就是 $( "#tb" )

                                // 在 xxx 情况下，不出现右键菜单。
                                if ( xxx ) {
                                    return false;
                                }
                            }
                        });
                    </pre>
                            
                        </td>
                      </tr>
                      <tr>
                        <td>beforeShow</td>
                        <td width="451">在菜单显示之前执行。<br>
                          返回值为 false 时，不显示菜单。<br>
                          可以控制什么时候显示菜单，也可以禁用一项菜单选项。</td>
                        <td>
                            <pre class="brush:js; highlight: [3]">
                        $("#tb").yhContextMenu({
                            menu: contextmenu,
                            beforeShow: function( e, yhui ) {
                                // e 事件对象
                                // yhui 对象
                                    // yhui.target 触发右键事件的目标元素
                                    // yhui.menu 即菜单(ul)的 jQuery 对象
                                    // yhui.container 这里就是 $( "#tb" )

                                // 在 xxx 情况下，不出现右键菜单。
                                if ( xxx ) {
                                    return false;
                                }
                            }
                        });
                    </pre>

                        </td>
                      </tr>
                      <tr>
                        <td>createdMenu</td>
                        <td width="451">菜单初始化完成后执行。<br>
                          菜单并不是在调用 yhContextMenu 后就初始化，而是在右键点击时才初始化。<br>
                          用法和 beforeShow 类型，参数也一样。</td>
                        <td></td>
                      </tr>
                      <tr>
                        <td>hide</td>
                        <td width="451">菜单隐藏后后执行。<br>
                          用法和 beforeShow 类型，参数也一样。</td>
                        <td></td>
                      </tr>
                      <tr>
                        <td>show</td>
                        <td width="451">菜单显示后执行。<br>
                          用法和 beforeShow 类型，参数也一样。</td>
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