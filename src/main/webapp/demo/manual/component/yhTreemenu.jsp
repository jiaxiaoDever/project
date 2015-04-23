<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title> 树形菜单 </title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metadoc.jsp" %>
</head>
<body>
    <div class="container">
        <h1>yhTreemenu，树形菜单</h1>
         <div class="hotmap">
            <a href="#summary">概述</a><a href="#use">使用方法</a><a href="#case">案例</a><a href="#property">属性</a><a href="#method">方法</a><a href="#return">事件</a><a href="#faq">常见问题</a>
            </div>
        <div class="content">
            <h2 id="summary">概述</h2>
            <div class="panel">
                <p>通常用于页面左侧的菜单。底层来自 <a href="http://www.ztree.me/v3/demo.php#_602">ZTree</a></p>
                <p>来源ztree，研发了面板型展开关闭，整合了右键菜单。</p>
                <p>这是个比较简单的组件。</p>
            </div>

            <h2 id="use">使用方法</h2>
            <div class="panel">
                <p>html</p>
                <pre class="brush:js">
                    <ul id="menu" class="ztree"></ul>
                </pre>
                <p>js调用</p>
                <pre class="brush:js">
                    $("#menu").yhTreemenu({});
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
                    <td>侧栏tree菜单</td>
                    <td><img src="../images/menu/menu02.gif" alt=""></td>
                    <td>
                      <pre class="brush:js">
                        <ul id="tree" class="ztree"></ul>
                    </pre> 
                      
                    </td>
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
                        <td>contextMenu</td>
                        <td width="451">右键菜单的选项，详情请参见 yhContentMenu 。</td>
                        <td></td>
                        <td>默认值为 null</td>
                      </tr>
                      <tr>
                        <td>expandLevel</td>
                        <td width="451">节点需要展开的层级。</td>
                        <td>数值</td>
                        <td>默认值为 0 ，不展开。</td>
                      </tr>
                      <tr>
                        <td>source</td>
                        <td width="451">数据来源。<br />
                          数据格式遵循 zTree 的数据格式。</td>
                        <td>字符串或者数组。</td>
                        <td width="297">为字符串时，代表这获取 json 数据的 url 。</td>
                      </tr>
                      <tr>
                        <td>zTreeSettings</td>
                        <td width="451">设置 zTree 的参数。<br />
                          该参数会覆盖所有 zTree 属性，谨慎使用。</td>
                        <td></td>
                        <td></td>
                      </tr>
                    </table>
                    <pre class="brush:js; highlight: [2]">
                        $( "#select" ).yhSelectmenu({
                            contextMenu: {
                                menu: {
                                    ....
                                },
                             expandLevel: 2 ,     // 展开 0-2 级节点
                             source: "../../JSON/demo.json",  // 设置链接
                             zTreeSettings: {
                                check: {
                                    enable: true
                                }
                            }
                            }
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
                    <td>getTree</td>
                    <td>获取 zTree 对象。</td>
                    <td>
                        <pre class="brush:js; highlight: [4]">
                        var menu = $("#menu").yhTreemenu(); // 初始化
                        ....
                        ....
                        var tree = menu.yhTreemenu( "getTree" );   // 隐藏菜单。
                         </pre>

                    </td>
                  </tr>
                </table>                
            </div>

            <h2 id="return">事件</h2>
            <div class="panel">
                 <table class="infotable">
                  <col width="173" />
                  <col width="451" />
                  <col width="198" />
                  <tr>
                    <th width="173">事件</th>
                    <th width="451">描述</th>
                    <th width="198">使用</th>
                  </tr>
                  <tr>
                    <td>createdTree</td>
                    <td width="451">createdTree 事件，zTree 初始化完成后触发。</td>
                    <td></td>
                  </tr>
                  <tr>
                    <td>onClick</td>
                    <td>节点的点击事件。</td>
                    <td>
                         <pre class="brush:js; highlight: [2]">
                        $("#select").yhSelectmenu({
                            onClick: function( e, yhui ) {
                                // 参数 yhui 是一个对象，带有两个属性
                                    // yhui.node 该节点的节点对象
                                    // yhui.tree zTree对象
                                console.log( yhui.node ); // option 的值
                            }
                        });
                    </pre>

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