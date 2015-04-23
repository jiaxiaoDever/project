<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>加载效果</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metadoc.jsp" %>
</head>
<body>
    <div class="container">
        <h1>yhLoading，加载时的提示效果</h1>
        <div class="hotmap">
            <a href="#summary">概述</a><a href="#use">使用方法</a><a href="#guide">导航</a><a href="#case">案例</a><a href="#property">属性</a><a href="#method">方法</a><a href="#return">回调函数</a><a href="#faq">常见问题</a>
            </div>
        <div class="content">
            <h2 id="summary">概述</h2>
            <div class="panel">
                <p> 加载过程中，显示动态效果（比如转圈圈），提升用户体验。 </p>
                <p> yhui 的 yhDropDown 等组件中都用到了这个组件。</p>
                <p> 比如如下的 div 会异步加载内容，那么就可以在加载之前 open yhLoading ， 加载之后 close yhLoading 。</p>
                
            </div>

            <h2 id="use">使用方法</h2>
            <div class="panel">
                <p>html</p>
                <pre class="brush:xml">
                    <div id="ajax">xxxx</div>
                </pre>
                <p>js调用</p>
                <pre class="brush:js">
                    $("#id").yhLoading({});
                </pre>  
            </div>


            <h2 id="guide">导航</h2>
            <div class="panel2">
                <div class="nav">
                    <ul>
                        <li>属性</li>
                        <li><a href="#autoOpen">autoOpen</a></li>
                        <li><a href="#backgroundColor">backgroundColor</a></li>
                        <li><a href="#duration">duration</a></li>
                        <li><a href="#opacity">opacity</a></li>
                        <li><a href="#size">size</a></li>
                    </ul>
                    <ul>
                        <li>方法</li>
                        <li><a href="#close">close</a></li>
                        <li><a href="#destroy">destroy</a></li>
                        <li><a href="#isOpen">isOpen</a></li>
                        <li><a href="#open">open</a></li>
                    </ul>
                </div>
            </div>

            <h2 id="property">属性</h2>
            <div class="panel">
                <p class="arrow" id="opacity">autoOpen</p>
                <div class="panel2">
                    <p>是否初始化时就出现遮罩效果。</p>
                    <p>默认值， true ， 出现。</p>
                    <pre class="brush:js; highlight: [2]">
                        $( "#ajax" ).yhLoading({
                            autoOpen: false        // 初始化时不出现遮罩
                        });

                        // 这种情况可以调用 open 方法打开遮罩
                    </pre>
                </div>


                <p class="arrow" id="backgroundColor">backgroundColor</p>
                <div class="panel2">
                    <p>背景的颜色值。默认为 "#FFF" 。</p>
                    <pre class="brush:js; highlight: [2]">
                        $( "#ajax" ).yhLoading({
                            backgroundColor: "#000"  // 将遮罩的背景设置为黑色
                        });
                    </pre>
                </div>

                <p class="arrow" id="duration">duration</p>
                <div class="panel2">
                    <p> 隐藏遮罩层的动画持续时间。</p>
                    <p> 单位毫秒，默认值 500 。</p>
                    <pre class="brush:js; highlight: [2]">
                        $( "#ajax" ).yhLoading({
                            duration: 100        // 将隐藏动画设置为 100ms
                        });
                    </pre>
                </div>

                <p class="arrow" id="opacity">opacity</p>
                <div class="panel2">
                    <p>遮罩层的透明度。默认值为 0.5 。</p>
                    <pre class="brush:js; highlight: [2]">
                        $( "#ajax" ).yhLoading({
                            opacity: 0.8        // 将透明度设为 0.8
                        });
                    </pre>
                </div>

                <p class="arrow" id="size">size</p>
                <div class="panel2">
                    <p>转圈的图标大小。</p>
                    <p>可选值有 big，middle，small ，默认值为 middle 。</p>
                    <pre class="brush:js; highlight: [2]">
                        $( "#ajax" ).yhLoading({
                            size: "small"        // 将图标设置为小号 16X16
                        });
                    </pre>
                </div>

            </div>


            <h2 id="method">方法</h2>
            <div class="panel">
                <p class="arrow" id="close">close</p>
                <div class="panel2">
                    <p>关闭加载效果。</p>
                    <pre class="brush:js; highlight: [4]">
                        var loading = $("#ajax").yhLoading(); // 初始化
                        ....
                        ....
                        loading.yhLoading( "close" );   // 一系列的操作完成后，关闭加载。
                    </pre>
                </div>

                <p class="arrow" id="destroy">destroy</p>
                <div class="panel2">
                    <p>销毁组件。</p>
                    <p>调用 close 方法关闭组件，还可以通过调用 open 方法打开。</p>
                    <p>调用 destroy 方法则是彻底销毁组件，适合一次性的地方。</p>
                    <pre class="brush:js; highlight: [4]">
                        var loading = $("#ajax").yhLoading(); // 初始化
                        ....
                        ....
                        loading.yhLoading( "destroy" );   // 一系列的操作完成后，销毁组件。
                    </pre>
                </div>

                <p class="arrow" id="isOpen">isOpen</p>
                <div class="panel2">
                    <p>加载效果是否开启状态。</p>
                    <p>返回布尔值， true 表示开启。</p>
                    <pre class="brush:js; highlight: [4]">
                        var loading = $("#ajax").yhLoading(); // 初始化
                        ....
                        ....
                        if ( loading.yhLoading("isOpen") ) {    // 开启时，关闭。
                            loading.yhLoading( "close" );
                        }
                    </pre>
                </div>

                <p class="arrow" id="open">open</p>
                <div class="panel2">
                    <p>显示加载效果。</p>
                    <pre class="brush:js; highlight: [4]">
                        var loading = $("#ajax").yhLoading({
                            autoOpen: false;    // 初始化时不显示
                        }); 
                        ....
                        ....
                        loading.yhLoading( "open" );    // 手动显示
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