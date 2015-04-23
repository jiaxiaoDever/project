<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>页面构件</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metadoc.jsp" %>
</head>
<body>
    <div class="container">
        <h1>yhPortlet，页面构件</h1>
        <div class="hotmap">
            <a href="#summary">概述</a><a href="#use">使用方法</a><a href="#guide">导航</a><a href="#case">案例</a><a href="#property">属性</a><a href="#method">方法</a><a href="#return">回调函数</a><a href="#faq">常见问题</a>
            </div>
        <div class="content">
            <h2 id="summary">概述</h2>
            <div class="panel">
                <p>portlet，模块化的的呈现显示，将信息分门别类，<a target="_blank" href="http://192.168.1.168:9080/YHUI1.2/Components/yhPortlet.html">DEMO</a> 。</p>
                <p>yhPortlet，一二三列自由适配，各面板按钮自定义。</p>
                <p>yhPortlet 需要特定的 html 结构：</p>
                
            </div>

            <h2 id="use">使用方法</h2>
            <div class="panel">
                <p>html</p>
                <pre class="brush:xml">
                    <!-- 最外围 -->
                    <div id = "portlet">
                        <!-- 列数，三个 div 即为三列。放置一个 div，那么就是一列。 -->
                        
                        <!-- 列1 -->
                        <div>
                            <!-- 面板，理论上任意个数。 -->
                            <div>
                                <!-- h3 面板标题栏 -->
                                <!-- data-option ，配置按钮,  "close:true"即出现“关闭按钮” -->
                                    <!-- 其余可选值有： "fold"--折叠， "pop"--弹出, "logo"--图标 -->
                                <h3 data-option="close: true"></h3>
                                <!-- 内容区 -->
                                <div></div>
                            </div>
                            ....
                        </div>
                        
                        <!-- 列2 -->
                        <div>
                            ...
                        </div>
                        
                        <!-- 列3 -->
                        <div>
                            ..
                        </div>

                    </div>
                </pre>
                <p>js调用</p>
                <pre class="brush:js">
                    $("#id").yhPortlet({});
                </pre>  
            </div>


            <h2 id="property">属性</h2>
            <div class="panel">
                <p class="arrow" id="generateID">generateID</p>
                <div class="panel2">
                    <p>是否自动生成面板的 id 值。</p>
                    <p>生成 id 的值为 "yhui-portlet-panel_column_x_panel_x"，x 为变量。</p>
                    <p>多数时候测试用。</p>
                    <p>布尔值。 默认值 false。</p>
                    <pre class="brush:js">
                        $("#portlet").yhPortlet({
                            generateID: true        // 自动生成 id
                        });
                    </pre>
                </div>
            </div>

            <h2 id="method">方法</h2>
            <div class="panel">
                <p class="arrow" id="getOrder">getOrder( ["json"] )</p>
                <div class="panel2">
                    <p>获取各面板的 id 值，并按照一定顺序排列。</p>
                    <p>配合后台使用，方便的记忆面板的位置。</p>
                    <p>当然，各面板必须有唯一的 id 值。</p>
                    <p>接受一个参数，为固定字符串 "json"，表示将生成的对象转为 json 字符串。可选。</p>
                    <pre class="brush:js; highlight: [2,11]">
                        var $p = $("#portlet").yhPortlet();
                        var order1 = $p.yhPortlet( "getOrder" );
                        // order1 的格式为：
                        //    {
                        //        column1: [ id, id, id,.....],
                        //        column2: [ id,..... ]
                        //        ......
                        //    } 


                        var order2 = $p.yhPortlet( "getOrder", "json" );
                        // order2 是由 order1 转成的 json 字符串，方便地传递到服务器。
                    </pre>
                </div>
            </div>


            <h2 id="return">回调函数</h2>
            <div class="panel">
                <p class="arrow" id="create">create</p>
                <div class="panel2">
                    <p>在组件初始化完成后执行。</p>
                    <p>所谓初始化完成是指组件的样式、高宽、以及 js 都准备就位。</p>
                    <pre class="brush:js">
                        $("#portlet").yhPortlet({
                            create: function() {
                                alert( "页面构件初始化完成！" );
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