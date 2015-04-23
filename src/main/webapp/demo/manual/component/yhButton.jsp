<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>按钮</title>
    <%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metadoc.jsp" %>
</head>
<body>
    <div class="container">
        <h1>yhButton，按钮</h1>
        <div class="hotmap">
            <a href="#summary">概述</a><a href="#use">使用方法</a><a href="#guide">导航</a><a href="#case">案例</a><a href="#property">属性</a><a href="#method">方法</a><a href="#return">回调函数</a><a href="#faq">常见问题</a>
            </div>
        <div class="content">
            <h2>概述</h2>
            <div class="panel">
                <p>按钮，快速生成带有图标的、并且简洁地绑定事件的按钮，一直都是个问题。</p>
                <p>yhButton，提供八种图标，利用<strong>事件委托</strong>来高性能的绑定事件，可以让页面的 css、html、js 完完全全地分离。</p>
                <p>尝试<strong>现代 js </strong>的编码方式，我觉得吧，从 <a href="http://192.168.1.168:9080/YHUI1.2/Components/toolbar.html" target="_blank">yhButton</a> 开始再合适不过。</p>                
            </div>

            <h2 id="use">使用方法</h2>
            <div class="panel">
                <p>html</p>
                <pre class="brush:xml">
                    <div id = "btn" class="yhui-button"></div>
                </pre>
            </div>

            <h2 id="guide">导航</h2>
            <div class="panel2">
                <div class="nav">
                    <ul>
                        <li>属性</li>
                        <li><a href="#align">align</a></li>
                        <li><a href="#items">items</a></li>
                        <li><a href="#space">space</a></li>
                    </ul>
                    <ul>
                        <li>方法</li>
                        <li><a href="#enable">enable</a></li>
                        <li><a href="#disable">disable</a></li>
                        <li><a href="#isDisable">isDisable</a></li>
                    </ul>
                    <ul>
                        <li>回调函数</li>
                        <li><a href="#create">create</a></li>
                    </ul>
                    <ul>
                        <li>其他</li>
                        <li><a href="#items">设定按钮的类型</a></li>
                    </ul>
                </div>
            </div>

            <h2 id="property">属性</h2>
            <div class="panel">
                <p class="arrow" id="align">align</p>
                <div class="panel2">
                    <p>控制按钮的位置。</p>
                    <p>这里不是指单个按钮，而是整组按钮的位置。</p>
                    <p>字符串类型。默认值 "center" 。</p>
                    <pre class="brush:js; highlight:[2,8]">
                        $("#btn").yhButton({
                            align: "left"       // 按钮整体靠左
                        });

                        // align 可以设为 "left" "right" "center"
                        // 也可以微调，如下
                        $("#btn").yhButton({
                            align: "center+100"       // 中间向右偏移 100px 
                        });
                        // "center-100" 就是中间向左偏移 100px 
                        // "left" 和 "right" 的用法相同
                    </pre>
                </div>

                <p class="arrow" id="items"><strong>items</strong></p>
                <div class="panel2">
                    <p>最主要属性，设置按钮类型和绑定事件都在这里。</p>
                    <p>数组，默认值 undefined。这是一个不可省略的属性。</p>
                    <pre class="brush:js">
                        $("#btn").yhButton({
                            items: [
                                {
                                    type: "submit",                 // 按钮的类型，主要是图标不同，更多见下表。
                                    // disabled: true,              // 是否禁用按钮。默认 false ，不禁用。
                                    onClick: function( e, form ) {  // 按钮的 click 事件
                                        // e 事件对象
                                        // form 按钮在的表单

                                    }
                                }
                            ]
                        });
                    </pre>
                    <p><strong>按钮的类型速查表</strong></p>
                    <table>
                        <tr>
                            <td>type</td>
                            <td>submit</td>
                            <td>back</td>
                            <td>confirm</td>
                            <td>save</td>
                            <td>reset</td>
                            <td>cancel</td>
                            <td>close</td>
                            <td>search</td>
                        </tr>
                        <tr>
                            <td>类型</td>
                            <td>提交</td>
                            <td>返回</td>
                            <td>确认</td>
                            <td>保存</td>
                            <td>重置</td>
                            <td>取消</td>
                            <td>关闭</td>
                            <td>查询</td>
                        </tr>
                    </table>
                </div>

                <p class="arrow" id="space">space</p>
                <div class="panel2">
                    <p>按钮之间的距离。</p>
                    <p>数值。单位 px 。默认值的是10px。</p>
                    <pre class="brush:js; highlight:[2]">
                        $("#btn").yhButton({
                            space: 20       // 按钮之间的空隙为 "20px"
                        });
                    </pre>
                </div>
            </div>

            <h2 id="method">方法</h2>
            <div class="panel">
                <p class="arrow" id="enable">enable( type )</p>
                <div class="panel2">
                    <p>按钮禁用状态下，启用按钮。</p>
                    <p>接受一个参数 type，就是上面表格中的 type 值。</p>
                    <pre class="brush:js; highlight:[8]">
                        var $btn = $("#btn").yhButton({
                            items: [{
                                type: "submit",
                                disabled: true
                            }]
                        });
                        ......
                        $btn.yhButton( "enable", "submit" );        // 启用按钮
                    </pre>
                </div>

                <p class="arrow" id="disable">disable</p>
                <div class="panel2">
                    <p>禁用按钮。</p>
                    <p>接受一个参数 type，就是上面表格中的 type 值。</p>
                    <pre class="brush:js; highlight:[5]">
                        var $btn = $("#btn").yhButton({
                            items: [ { type: "submit" } ]
                        });
                        ......
                        $btn.yhButton( "disable", "submit" );        // 启用按钮
                    </pre>
                </div>

                <p class="arrow" id="isDisable">isDisable</p>
                <div class="panel2">
                    <p>按钮是否可用。</p>
                    <p>接受一个参数 type，就是上面表格中的 type 值。</p>
                    <p>返回布尔值。按钮禁用则是 true，可用则为 false 。</p>
                    <pre class="brush:js; highlight:[5]">
                        var $btn = $("#btn").yhButton({
                            items: [ { type: "submit" } ]
                        });
                        ......
                        var isDisable = $btn.yhButton( "isDisable", "submit" );
                        console.log( isDisable );  // false
                    </pre>
                </div>
            </div>

            <h2 id="return">回调函数</h2>
            <div class="panel">
                <p class="arrow" id="create">create</p>
                <div class="panel">
                    <p>在按钮初始化完成后执行。</p>
                    <pre class="brush:js; highlight:[3]">
                        $("#btn").yhButton({
                            items: [{ type: "reset" } ],
                            create: function() {
                                alert( "按钮准备完成！" );
                            }
                        });
                    </pre>
                </div>
            </div>
        </div>
    </div>
    
    <script type="text/javascript">
        SyntaxHighlighter.defaults["toolbar"] = false;
        SyntaxHighlighter.all();
    </script>
</body>
</html>