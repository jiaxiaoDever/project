<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>yhCore</title>
    <link rel = "stylesheet" href = "../css/api.css">
    <link rel = "stylesheet" href = "../hightLigthter/css/shCore.css">
    <link rel = "stylesheet" href = "../hightLigthter/css/shThemeDefault.css">
    <script type = "text/javascript" src="../hightLigthter/js/jquery-1.8.3.min.js"></script>
    <script type = "text/javascript" src="../hightLigthter/js/shCore.js"></script>
    <script type = "text/javascript" src="../hightLigthter/js/shBrushJScript.js"></script>
    <script type = "text/javascript" src="../hightLigthter/js/shBrushXml.js"></script>
</head>
<body>
    <div class="container">
        <h1>yhCore, yhui 的函数库</h1>
        <div class="content">
            <h2>概述</h2>
            <div class="panel">
                <p>函数库，就是将常见、常用的的函数或者方法汇总起来得到的一个库。</p>
                <p>yhCore就是这么一个函数库，封装了很多方法，比如 document.getElementById 就可以用 $.yhui.byId 来替换。</p>
            </div>
            <h2>导航</h2>
            <div class="panel">
                <div class="nav">
                    <ul>
                        <li>属性</li>
                        <li><a href="#isIE">isIE</a></li>
                        <li><a href="#isIE6">isIE6</a></li>
                        <li><a href="#isIE67">isIE67</a></li>
                        <li><a href="#isIE678">isIE678</a></li>
                        <li><a href="#isIE8">isIE8</a></li>
                        <li><a href="#isIE9">isIE9</a></li>
                        <li><a href="#version">version</a></li>
                    </ul>
                    <ul>
                        <li>方法</li>
                        <li><a href="#byId">byId</a></li>
                        <li><a href="#byTag">byTag</a></li>
                        <li><a href="#clone">clone</a></li>
                        <li><a href="#expandTreeNode">expandTreeNode</a></li>
                        <li><a href="#getDocHeight">getDocHeight</a></li>
                        <li><a href="#getUserInfo">getUserInfo</a></li>
                        <li><a href="#log">log</a></li>
                        <li><a href="#setDay">setDay</a></li>
                        <li><a href="#stringToDate">stringToDate</a></li>
                    </ul>
                </div>
            </div>
            <h2>属性</h2>
            <div class="panel">
                <p id = "isIE" class="arrow">isIE</p>
                <div class="panel2">
                    <p>判断浏览器是否为IE。</p>
                    <p>布尔值。浏览器为 IE 时，值为 true 。</p>
                    <pre class="brush:js">
                        if ( $.yhui.isIE ) {
                            // TODO
                        }
                    </pre>
                </div>

                <p id="isIE6" class="arrow">isIE6</p>
                <div class="panel2">
                    <p>判断浏览器是否为IE6。</p>
                    <p>布尔值。浏览器为 IE6 时，值为 true 。</p>
                    <pre class="brush:js">
                        if ( $.yhui.isIE6 ) {
                            // TODO
                        }
                    </pre>
                </div>

                <p id="isIE7" class="arrow">isIE7</p>
                <div class="panel2">
                    <p>判断浏览器是否为IE7。</p>
                    <p>布尔值。浏览器为 IE7 时，值为 true 。</p>
                    <pre class="brush:js">
                        if ( $.yhui.isIE7 ) {
                            // TODO
                        }
                    </pre>
                </div>

                <p id="isIE67" class="arrow">isIE67</p>
                <div class="panel2">
                    <p>判断浏览器是否为IE67。</p>
                    <p>布尔值。浏览器为 IE67 时，值为 true 。</p>
                    <pre class="brush:js">
                        if ( $.yhui.isIE67 ) {
                            // TODO
                        }
                    </pre>
                </div>

                <p id="isIE678" class="arrow">isIE678</p>
                <div class="panel2">
                    <p>判断浏览器是否为IE678。</p>
                    <p>布尔值。浏览器为 IE678 时，值为 true 。</p>
                    <pre class="brush:js">
                        if ( $.yhui.isIE678 ) {
                            // TODO
                        }
                    </pre>
                </div>

                <p id="isIE8" class="arrow">isIE8</p>
                <div class="panel2">
                    <p>判断浏览器是否为IE8。</p>
                    <p>布尔值。浏览器为 IE8 时，值为 true 。</p>
                    <pre class="brush:js">
                        if ( $.yhui.isIE8 ) {
                            // TODO
                        }
                    </pre>
                </div>

                <p id="isIE9" class="arrow">isIE9</p>
                <div class="panel2">
                    <p>判断浏览器是否为IE9。</p>
                    <p>布尔值。浏览器为 IE6 时，值为 true 。</p>
                    <pre class="brush:js">
                        if ( $.yhui.isIE9 ) {
                            // TODO
                        }
                    </pre>
                </div>

                <p id="version" class="code">version</p>
                <div class="panel2">
                    <p>yhui 的版本信息。</p>
                    <p>字符串。比如 yhui 1.2，那么值为 "1.2"。</p>
                    <pre class="brush:js">
                        // 打印 yhui 的版本信息
                        $.yhui.log( $.yhui.version );
                    </pre>
                </div>
            </div>


            <h2>方法</h2>
            <div class="panel">
                <p id="byId" class="arrow">byId( string )</p>
                <div class="panel2">
                    <p> document.getElementById 的封装。</p>
                    <p>参数，接受一个字符串，表示元素 id 。</p>
                    <p>返回值是一个 dom 对象。</p>
                    <pre class = "brush:js; html-script: true" >

                        <div id="div"></div>

                        // js
                        var div = $.yhui.byId( "div" );
                        div.innerHTML = "yhui is not bad!";
                    </pre>
                </div>

                <p id="byTag" class="arrow">byTag( string )</p>
                <div class="panel2">
                    <p> document.getElementsByTagName 的封装。</p>
                    <p>参数，接受一个字符串，表示元素的标签名，如"li"。</p>
                    <p>返回值是<strong>一组</strong> dom 对象。</p>
                    <pre class = "brush:js; html-script: true" >
                        <ul>
                            <li>2</li>
                            <li>3</li>
                            <li>4</li>
                            <li>5</li>
                        </ul>

                        //js
                        var li = $.yhui.byTag( "li" );
                        // 打印 li 的 length 。
                        $.yhui.log( li.length ); // 4
                    </pre>
                </div>


                <p id="clone" class="arrow">clone( obj )</p>
                <div class="panel2">
                    <p>来自 <a href="http://www.ztree.me/v3/main.php" target="_blank">zTree</a>。</p>
                    <p>深度复制一个对象或者一个数组，而不是简单的复制引用。</p>
                    <p>参数，接受一个数组或者对象。</p>
                    <p>返回值是传入的参数的复制品，对象或者数组。</p>
                    <pre class="brush:js">
                        var o = {
                            a: 1,
                            b: 2,
                            c: 3
                        };
                        var co = $.yhui.clone( o );
                        co.c = 4;   // co.c 改变， o.c 不变。普通的复制只是复制引用，一变都变。
                    </pre>
                </div>

                <p id = "expandTreeNode" class = "arrow">expandTreeNode( nodes, tree, level )</p>
                <div class="panel2">
                    <p>配合 <a href="http://www.ztree.me/v3/main.php" target="_blank">zTree</a> 使用，展开 zTree 指定层次的节点。</p>
                    <p>接受三个参数，依次为 zTree 的第一层节点，zTree 对象和层级。</p>
                    <p>无返回值。</p>
                    <pre class="brush:js">
                        var tree = $.fn.zTree.init( .... );
                        $.yhui.expandTreeNode( tree.getNodes(), tree, 2 );
                        // 会展开 zTree 的第二级节点。
                        // 省略第三个参数，将会展开所有的节点。
                    </pre>
                </div>

                <p id="getDocHeight" class="arrow">getDocHeight( document )</p>
                <div class="panel2">
                    <p>获取文档(document)的高度。</p>
                    <p>参数，接受一个 document 的对象。</p>
                    <p>返回值是一个数值，给定的 document 的高度。</p>
                    <pre class="brush:js">
                        var d = window.document;
                        var docH = $.yhui.getDocHeight( d );
                        $.yhui.log( docH );
                    </pre>
                </div>

                <p id="getUserInfo" class="arrow">getUserInfo()</p>
                <div class="panel2">
                    <p>获取客户端的信息，包括浏览器的类型和版本、屏幕分辨率。</p>
                    <p>没有参数。</p>
                    <p>返回一个对象，包含 browser、version 和 ratio，分别表示浏览器类型、版本，分辨率。</p>
                    <pre class="brush:js">
                        var userInfo = $.yhui.getUserInfo();
                        $.yhui.log( userInfo.browser );     // 打印 浏览器类型
                        $.yhui.log( userInfo.version );     // 打印 浏览器版本
                        $.yhui.log( userInfo.ratio );       // 打印 屏幕分辨率
                    </pre>
                </div>

                <p id="log" class="arrow">log( mix )</p>
                <div class="panel2">
                    <p>在控制台中打印信息，浏览器没有控制台则调用 alert() 。</p>
                    <p>参数，接受一个任意类型的参数。非字符串的情况，各浏览器的处理方法不同。</p>
                    <p>没有返回值。</p>
                    <pre class="brush:js">
                        var a = [ 2, 3, 4 ];
                        $.yhui.log( a );        // 打印数组。
                        $.yhui.log( "yhui" );   // 打印字符串。
                    </pre>
                </div>

                <p id="setDay" class="arrow">setDay( date, string )</p>
                <div class="panel2">
                    <p>以传入的Date对象为时间基点，以传入的string为增量设定时间。</p>
                    <p>参数，data 是一个 Date对象，省略则默认为 "new Date" ，string 是固定形式字符串，如"+7"、"-7"。</p>
                    <p>返回值是计算后 Date 对象。</p>
                    <pre class="brush:js">
                        var new1 = $.yhui.setDay( new Date( 2007, 10, 23 ), "+7" ); // "+" 向未来偏移 7 天
                        var new2 = $.yhui.setDay( "-7" ); //省略第一个参数就是表示现在，向过去偏移 7 天。
                    </pre>
                </div>

                <p id="stringToDate" class="arrow">stringToDate( value, split )</p>
                <div class="panel2">
                    <p>将指定的日期字符串转换成 Date 对象。</p>
                    <p>value 就是日期字符串，split表示分隔符，比如"2012+2+12"的的分隔符就是 "+" 。</p>
                    <p>返回一个日期对象。</p>
                    <pre class="brush:js">
                        var new1 = $.yhui.stringToDate( "2012+2+12", "+" );
                        var new2 = $.yhui.stringToDate( "2012-2-12" ); // split 的默认值就是 "-"，所以这里可以省略。
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