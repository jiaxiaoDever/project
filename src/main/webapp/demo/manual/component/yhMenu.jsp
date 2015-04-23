<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>菜单</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metadoc.jsp" %>
</head>
<body>
    <div class="container">
        <h1>yhMenu，菜单</h1>
            <div class="hotmap">
            <a href="#summary">概述</a><a href="#use">使用方法</a><a href="#case">案例</a><a href="#property">属性</a><a href="#method">方法</a><a href="#return">回调函数</a><a href="#faq">常见问题</a>
            </div>
        <div class="content">
            <h2 id="summary">概述</h2>
            <div class="panel">
                <p>菜单yhMenu，无限下拉菜单。</p>
                <p>只接受 json 数据格式，不利于查看 html，有利于权限配置。</p>
                <p>分层打印节点，一次只打印一层节点，快速渲染。</p>
                <p>简单高效的事件绑定，自由操作每一个节点的点击。</p>
            </div>

            <h2 id="use">使用方法</h2>
            <div class="panel">
                <p>html</p>
                <pre class="brush:js">
                    <ul id="menu" class="yhui-menu"></ul>
                </pre>
                <p>js调用</p>
                <pre class="brush:js">
                    $("#menu").yhMenu({});
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
                    <td>横向导航菜单</td>
                    <td><img src="../images/menu/menu01.gif" alt=""></td>
                    <td>
                       <pre class="brush:js">
                            <ul id="menu" class="yhui-menu"></ul>
                        </pre>                         
                    </td>
                  </tr>
<!--                   <tr>
                    <td>侧栏tree菜单</td>
                    <td><img src="../images/menu/menu02.gif" alt=""></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td>右键菜单</td>
                    <td><img src="../images/menu/menu03.gif" alt=""></td>
                    <td></td>
                  </tr> -->
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
                    <td>timeToIn</td>
                    <td>延迟显示子菜单的时间。<br />
                      用户有时不小心划过菜单，没有延迟就会快速显示子菜单，但他本意不是这样。所以通过此出现提升用户体验。</td>
                    <td>数值，单位微秒。</td>
                    <td>默认值300。</td>
                  </tr>
                  <tr>
                    <td>url</td>
                    <td>获取节点数据的链接。</td>
                    <td>字符串。</td>
                    <td>默认值为空字符串。</td>
                  </tr>
                </table>
                <div class="panel">   
                    <pre class="brush:js;highlight:[2]">
                        $("#menu").yhMenu({
                            timeToIn: 500,                   // 延迟五百毫秒显示子菜单
                            url: "../JSON/jsonOfMenu.txt"    // 从 jsonOfMenu 这个文本文件上获取数据
                        });
                    </pre>
                </div>
            </div>
            <h2 id="return">回调函数</h2>
            <div class="panel">
                <table class="infotable">
                  <tr>
                    <th>回调函数</th>
                    <th>描述</th>
                    <th>使用</th>
                  </tr>
                  <tr>
                    <td>beforeInit</td>
                    <td>在将数据转换成菜单之前执行。<br />
                      这个回调的可以处理从服务器返回的数据。</td>
                    <td>
                        <pre class="brush:js">
                        $("#menu").yhMenu({
                            beforeInit: function( e, yhui ) {
                                // e 事件对象
                                // yhui 对象
                                    // yhui.data 服务器返回的数据

                                // 这里给菜单加了一个节点
                                yhui.data.unshift({
                                    "name" : "首页", 
                                    "children" : [
                                        { "name" : "第一级第一级第一级第一级" },
                                        { "name" : "第一级1" }
                                    ]
                                });
                            }
                        });
                    </pre>
                    </td>
                  </tr>
                  <tr>
                    <td>onClick</td>
                    <td>节点的点击事件。<br />
                      需要说明的事，父节点的点击事件被屏蔽了，这个 onClick 只对子节点有效。</td>
                    <td>
                        <pre class="brush:js">
                        $("#menu").yhMenu({
                            url: "../JSON/jsonOfMenu.txt",
                            onClick: function( e, yhui ) {
                                // e 事件对象
                                // yhui 对象
                                    // yhui.node 该节点对象。这个节点对象是从服务器返回的数据的，对应节点的扩充，见下面的例子。
                                    // yhui.menu 容器 ul 的 jQuery  对象

                                alert( yhui.node.name );

                                // 这个 name 哪里来得？下面是服务器返回数据的截取：
                                // {
                                //     name: "第一级",
                                //     id: "1"
                                // }
                                // 这个 yhui.node 就是上面的扩充，当然 name 和 id 属性可以继续访问。
                                alert( yhui.node.id );
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