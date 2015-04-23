<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>日期时间选择器</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metadoc.jsp" %>
</head>
<body>
    <div class="container">
        <h1>yhDatePicker，日期时间选择器</h1>
        <div class="hotmap">
            <a href="#summary">概述</a><a href="#use">使用方法</a><a href="#guide">导航</a><a href="#case">案例</a><a href="#property">属性</a><a href="#method">方法</a><a href="#return">回调函数</a><a href="#faq">常见问题</a>
            </div>
        <div class="content">
            <h2 id="summary">概述</h2>
            <div class="panel">
                <p>日期时间选择器，已经不是新鲜东西了，市面上也有不少现成的。</p>
                <p>市面现场的或多或少都有点缺陷，<a target="_blank" href="http://192.168.1.168:9080/YHUI1.2/form/timePicker.html">jqueryui 自带的</a>样式难控制，我比较喜欢的 <a target="_blank" href="http://www.my97.net/">My97</a> 代码风格诡异，更重要的是不开源。</p>
                <p>所以才有了 <a target="_blank" href="http://192.168.1.168:9080/YHUI1.2/form/yhDatePicker.html">yhDatePicker</a> 。</p>
                <p> yhDatePicker 包含了常用的时间日期功能，比如最大最小日期、联动等等。</p>
                <p> yhDatePicker 可以作用在普通文本框(&lt;input&gt;)上。 </p>
                <pre class="brush:xml">
                    &lt;input type="text" id="picker" />
                </pre>
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



            <h2 id="guide">导航</h2>
            <div class="panel">
                <div class="nav">
                    <ul>
                        <li>属性</li>
                        <li><a href="#maxDate">maxDate</a></li>
                        <li><a href="#minDate">minDate</a></li>
                        <li><a href="#selectedDate">selectedDate</a></li>
                        <li><a href="#separator">separator</a></li>
                        <li><a href="#showTime">showTime</a></li>
                    </ul>
                    <ul>
                        <li>方法</li>
                        <li><a href="#getSelected">getSelected</a></li>
                        <li><a href="#hide">hide</a></li>
                        <li><a href="#show">show</a></li>
                    </ul>
                    <ul>
                        <li>回调函数</li>
                        <li><a href="#hide1">hide</a></li>
                    </ul>
                </div>
            </div>

            
            <h2 id="property">属性</h2>
            <div class="panel">
                <p class="arrow" id="maxDate">maxDate</p>
                <div class="panel2">
                    <p>日期的最大选择范围。</p>
                    <p>混合类型，可以是Date 对象或者日期字符串。默认值 null 。</p>
                    <p>想要设置相对日期，可以使用 <a target="_blank" href="yhCore.html#setDay">$.yhui.setDay()</a> 方法。</p>
                    <pre class="brush:js;highlight:[2]">
                        $("#picker").yhDatePicker({
                            maxDate: $.yhui.setDay( "+7" )      // 最大值为当前的日期上加 7 天
                        });
                    </pre>
                </div>


                <p class="arrow" id="minDate">minDate</p>
                <div class="panel2">
                    <p>日期的最小选择范围。</p>
                    <p>混合类型，可以是Date 对象或者日期字符串。默认值 null 。</p>
                    <p>想要设置相对日期，可以使用 <a target="_blank" href="yhCore.html#setDay">$.yhui.setDay()</a> 方法。</p>
                    <pre class="brush:js;highlight:[2]">
                        $("#picker").yhDatePicker({
                            minDate: $.yhui.setDay( "-7" )      // 最大值为当前的日期上减 7 天
                        });
                    </pre>
                </div>

                <p class="arrow" id="selectedDate">selectedDate</p>
                <div class="panel2">
                    <p>设置默认选择的日期。</p>
                    <p>混合类型，可以是Date 对象或者日期字符串。默认值 null 。</p>
                    <p>想要设置相对日期，可以使用 <a target="_blank" href="yhCore.html#setDay">$.yhui.setDay()</a> 方法。</p>
                    <pre class="brush:js;highlight:[2]">
                        $("#picker").yhDatePicker({
                            selectedDate: new Date()      // 总是选中当前日期
                        });
                    </pre>
                </div>

                <p class="arrow" id="separator">separator</p>
                <div class="panel2">
                    <p>定义日期字符串的分隔符。</p>
                    <p>默认值为 "-"。</p>
                    <pre class="brush:js;highlight:[2]">
                        $("#picker").yhDatePicker({
                            separator: "/"     // 日期字符串会是这样： xxxx/xx/xx
                        });
                    </pre>
                </div>

                <p class="arrow" id="showTime">showTime</p>
                <div class="panel2">
                    <p>是否显示时间选择器。还可以设置默认选择的时间。</p>
                    <p>混合类型，字符串或者布尔值。默认值，false。</p>
                    <pre class="brush:js; highlight: [2,6,10,15]">
                        $("#picker").yhDatePicker({
                            showTime: true      // 出现时间选择器
                        });

                        $("#picker").yhDatePicker({
                            showTime: "00"      // 小时可用，分秒禁用
                        });

                        $("#picker").yhDatePicker({
                            showTime: "00:00"   // 时分可用，秒钟禁用
                        });

                        $("#picker").yhDatePicker({
                            selectedDate: new Date(),
                            showTime: "00:00"   // 默认时间，配合 selectedDate 使用。
                            // 默认时间 "00:00"，并且秒钟不可以使用。
                        });
                    </pre>
                </div>
            </div>

            <h2 id="method">方法</h2>
            <div class="panel">
                <p class="arrow" id="getSelected">getSelected()</p>
                <div class="panel2">
                    <p>获取选中的 Date 对象。</p>
                    <p>没有参数。</p>
                    <pre class="brush:js; highlight:[2]">
                        var $p = $("#picker").yhDatePicker();
                        var date = $p.yhDatePicker( "getSelected" );    // 返回选中的日期对象
                        console.log( date );
                    </pre>
                </div>
                <p class="arrow" id="hide">hide()</p>
                <div class="panel2">
                    <p>隐藏选择器。没有参数。</p>
                    <pre class="brush:js; highlight:[2]">
                        var $p = $("#picker").yhDatePicker();
                        $p.yhDatePicker( "hide" );
                    </pre>
                </div>

                <p class="arrow" id="show">show()</p>
                <div class="panel2">
                    <p>显示选择器。没有参数。</p>
                    <pre class="brush:js; highlight:[2]">
                        var $p = $("#picker").yhDatePicker();
                        $p.yhDatePicker( "show" );
                    </pre>
                </div>
            </div>

            <h2 id="return">回调函数</h2>
            <div class="panel">
                <p class="arrow" id="hide1">hide</p>
                <div class="panel2">
                    <p>在选择器隐藏后执行。</p>
                    <p>在<strong>联动</strong>和<strong>验证</strong>的时候，这个回调非常有用。</p>
                    <p>可以看看 <a target="_blank" href="http://192.168.1.168:9080/YHUI1.2/form/yhDatePicker.html">DEMO</a> ，上面的联动就是利用这个回调做得。</p>
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