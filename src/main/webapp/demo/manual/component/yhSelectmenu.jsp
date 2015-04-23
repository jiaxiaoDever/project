<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title> 下拉菜单 </title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metadoc.jsp" %>
</head>
<body>
    <div class="container">
        <h1>yhSelectmenu，作用于 select 元素的下拉菜单</h1>
        <div class="hotmap">
            <a href="#summary">概述</a><a href="#use">使用方法</a><a href="#guide">导航</a><a href="#case">案例</a><a href="#property">属性</a><a href="#method">方法</a><a href="#sj">事件</a><a href="#faq">常见问题</a>
            </div>
        <div class="content">
            <h2 id="summary">概述</h2>
            <div class="panel">
                <p> yhDropDown 是一个庞大的插件，不管是代码量上还是开销上来讲。 </p>
                <p>有些情况，使用 yhDropDown 的杀鸡用牛刀，比如性别的选择。</p>
                <p>而普通的 select 元素不好控制样式，并且在 ie6 中还有盖不住的奇葩问题。</p>
                <p> 所以 yhSelectmenu 就出现了。 </p>
                <p> yhSelectmenu 是对官方 selectmenu 的增强。</p>
                <p>直接作用于 select 元素上，如下：</p>
                
            </div>

            <h2 id="use">使用方法</h2>
            <div class="panel">
                <p>html</p>
               <pre class="brush:xml">
                    <select id="select">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                    </select>
                </pre>
            </div>

            <h2 id="guide">导航</h2>
            <div class="panel2">
                <div class="nav">
                    <ul>
                        <li>属性</li>
                        <li><a href="#firstItem">firstItem</a></li>
                        <li><a href="#maxHeight">maxHeight</a></li>
                        <li><a href="#renderItem">renderItem</a></li>
                        <li><a href="#type">type</a></li>
                        <li><a href="#width">width</a></li>
                        <li><a href="#zIndex">zIndex</a></li>
                    </ul>
                    <ul>
                        <li>方法</li>
                        <li><a href="#close">close</a></li>
                        <li><a href="#menuWidget">menuWidget</a></li>
                        <li><a href="#open">open</a></li>
                        <li><a href="#refresh">refresh</a></li>
                    </ul>
                    <ul>
                        <li>事件</li>
                        <li><a href="#change">change</a></li>
                        <li><a href="#select">select</a></li>
                    </ul>
                </div>
            </div>

            
            <h2 id="property">属性</h2>
            <div class="panel">
                <p class="arrow" id="firstItem">firstItem</p>
                <div class="panel2">
                    <p>使用内置选项（年或月），第一项的值。</p>
                    <p>字符串，默认值为“请选择”。</p>
                    <p>设为空字符串时，没有该项。</p>
                    <pre class="brush:js; highlight: [5]">
                        <select id="select"></select>   // select 中无需 option
                        
                        $( "#select" ).yhSelectmenu({
                            type: "month",
                            firstItem: "请选择月份"
                        });
                    </pre>
                </div>


                <p class="arrow" id="maxHeight">maxHeight</p>
                <div class="panel2">
                    <p>菜单的最大高度，超出该值即出现滚动条。</p>
                    <p>单位 px ，默认值 200 。</p>
                    <pre class="brush:js; highlight: [2]">
                        $( "#select" ).yhSelectmenu({
                            maxHeight: 100      // 最大高度值设为 100px 
                        });
                    </pre>
                </div>

                <p class="arrow" id="renderItem">renderItem</p>
                <div class="panel2">
                    <p> 这是一个函数，自定义渲染菜单(ul)的过程。</p>
                    <p> 需要极为了解菜单的构造过程，不推荐使用。</p>
                </div>

                <p class="arrow" id="type">type</p>
                <div class="panel2">
                    <p> yhSelectmenu 内置的菜单，现有月份和年份。</p>
                    <p>混合类型，可以是字符串，也可以是对象字面量。</p>
                    <pre class="brush:js; highlight: [5]">
                        <select id="select"></select>   // select 中无需 option
                        
                        // 自动填充月份
                        $( "#select" ).yhSelectmenu({
                            type: "month" // 或者为 year
                        });

                        // 还可以这样
                        $( "#select" ).yhSelectmenu({
                            type: {
                                type: "month",
                                selectd: 4      // 默认选中四月
                            }
                        });

                        // 年份的设置请参见 demo 的源码
                    </pre>
                </div>

                <p class="arrow" id="width">width</p>
                <div class="panel2">
                    <p>宽度。</p>
                    <p>数值，单位 px 。默认值为 select 元素的宽度。</p>
                    <pre class="brush:js; highlight: [2]">
                        $( "#select" ).yhSelectmenu({
                            width: 300      // 宽度设为 300px
                        });
                    </pre>
                </div>

                <p class="arrow" id="zIndex">zIndex</p>
                <div class="panel2">
                    <p>下拉菜单的 zIndex 。</p>
                    <p>数值，默认值 0 。</p>
                    <pre class="brush:js; highlight: [2]">
                        $( "#select" ).yhSelectmenu({
                            zIndex: 100      // zIndex 的值设为 100
                        });
                    </pre>
                </div>

            </div>


            <h2 id="method">方法</h2>
            <div class="panel">
                <p class="arrow" id="close">close</p>
                <div class="panel2">
                    <p>以编程的方式隐藏下拉菜单。</p>
                    <pre class="brush:js; highlight: [4]">
                        var select = $("#select").yhSelectmenu(); // 初始化
                        ....
                        ....
                        select.yhSelectmenu( "close" );   // 隐藏菜单。
                    </pre>
                </div>

                <p class="arrow" id="menuWidget">menuWidget</p>
                <div class="panel2">
                    <p>返回下拉菜单的 jQuery 对象。</p>
                    <pre class="brush:js; highlight: [4]">
                        var select = $("#select").yhSelectmenu(); // 初始化
                        ....
                        ....
                        var menu = select.yhSelectmenu( "menuWidget" );   // 获取下拉菜单的 jQuery 对象
                    </pre>
                </div>

                <p class="arrow" id="open">open</p>
                <div class="panel2">
                    <p>以编程的方式打开菜单。</p>
                    <pre class="brush:js; highlight: [4]">
                        var select = $("#select").yhSelectmenu(); // 初始化
                        ....
                        ....
                        select.yhSelectmenu( "open" );   // 打开下拉菜单
                    </pre>
                </div>

                <p class="arrow" id="refresh">refresh</p>
                <div class="panel2">
                    <p>刷新菜单。</p>
                    <p>比如 select 元素增加或者减少 option 时，就要使用该方法。</p>
                    <pre class="brush:js; highlight: [4]">
                        var select = $("#select").yhSelectmenu(); // 初始化
                        ....
                        ....
                        select.yhSelectmenu( "refresh" );   // 刷新下拉菜单
                    </pre>
                </div>
            </div>


            <h2 id="sj">事件</h2>
            <div class="panel">
                <p class="arrow" id="change">change</p>
                <div class="panel2">
                    <p> change 事件。 </p>
                    <p> 选中不同的选项后触发。</p>
                    <pre class="brush:js; highlight: [2]">
                        $("#select").yhSelectmenu({
                            change: function( e, yhui ) {
                                // 参数 yhui 是一个对象，带有属性 item
                                    // item 仍旧是一个对象，带有 value 等常用属性。
                                alert( yhui.item.value ); // option 的值
                            }
                        });
                    </pre>
                </div>

                <p class="arrow" id="select">select</p>
                <div class="panel2">
                    <p> select 事件。 </p>
                    <p> 选中选项后触发。</p>
                    <pre class="brush:js; highlight: [2]">
                        $("#select").yhSelectmenu({
                            select: function( e, yhui ) {
                                // 参数 yhui 是一个对象，带有属性 item
                                    // item 仍旧是一个对象，带有 value 等常用属性。
                                alert( yhui.item.value ); // option 的值
                            }
                        });
                    </pre>
                </div>
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