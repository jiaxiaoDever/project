<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-US">
<head>
	<meta charset="UTF-8">
	<title>yhToolbar</title>
	<style type="text/css">
        html {margin:0;padding:0;border:0;}
        body, div, span, object, iframe,h1, h2, h3, h4, h5, h6, p, blockquote, pre,a, abbr, acronym, address, code,del, dfn, em, img, q, dl, dt, dd, ol, ul, li,fieldset, form, label, legend,table, caption, tbody, tfoot, thead, tr, th, td,article, aside, dialog, figure, footer, header,hgroup, nav, section {margin: 0;padding: 0;border: 0;}
        .clearfix{ zoom:1; }
        .clearfix:after{display:table;content:"";clear:both;}

        a {
            text-decoration: none;
            color: #666;
        }

        a:hover {
            text-decoration: underline;
        }
        .container {
            width: 600px;
            /*overflow: hidden;*/
        }

        .top {
            position: fixed;
            left: 601px;
            top: 50%;
            margin-top: 100px;
            color: #F00;
        }

        h2 {
            background-color: #4F81BD;
            color: #FFF;
            text-indent: 1em;
            margin: 2px 0 2px 5px;
            font-size: 16px;
            padding: 3px 0;
        }

            h2 a {
                color: #FFF;
            }

        .content {}

            .content h3 {
                background-color: #95B3D7;
                color: #FFF;
                text-indent: 1em;
                margin: 5px 0 5px 10px;
                padding: 3px 0;
                font-size: 14px;
            }

            .content div h4 {
                background-color: #DBE5F1;
                text-indent: 1em;
                margin: 2px 0 2px 12px;
                padding: 3px 0;
                font-size: 14px;
            }

            .content div table {
                border-collapse: collapse;
                width: 90%;
                margin: 5px 20px;
            }

            .content div table tr {}

            .content div table td {
                border: 1px solid #DDD;
                padding: 3px;
            }

            .content div table td a {
                margin-left: 5px;
            }

            .content div table tr td:first-child {
                font-weight: bold;
                font-size: 12px;
                width: 50px;
                text-align: center;
            }

            .content div p {
                font-size: 12px;
                text-indent: 3em;
                padding: 3px 0;
            }

        pre {
            background-color:#EEE;
            margin:5px 40px;
            border-radius: 5px;
            box-shadow: 2px 2px 2px #CCC;
        }
    </style>
</head>
<body>
	<a class = "top" href="#top">TOP</a>
	<div id = "top" class="container">
		<h2>工具栏(yhToolbar) 【<a target = "_blank" href="http://192.168.1.168:9080/YHUI1.2/Components/toolbar.html">DEMO</a>】</h2>
		<div class="content">
			<h3>导航</h3>
			<div>
				<table>
					<tr>
						<td>属性</td>
						<td>
							<a href="#items">items</a>
					    </td>
					</tr>
					<tr>
						<td>方法</td>
						<td>
							<a href="#disable">disable</a> <a href="#enable">enable</a>
							<a href="#isDiable">isDiable</a>
						</td>
					</tr>
					<tr>
						<td>事件</td>
						<td>
							无
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="content">
			<h3>概述</h3>
			<div>
				<p>工具栏，由第三方插件修改而来。再次感谢作者。</p>
				<p>属性众多，但有些的实用性不大，被我抹去了。</p>
				<p>下面就说些常用的属性和方法。</p>
				<p>不常用的，有时间在补充。</p>
				<p> <a href="#footer">完整js代码</a> </p>
				<pre><code>
    // html 结构
    &lt;div id = "toolbar" class = "yhToolbar" &gt;&lt;/div&gt;

    // js
    $("#toolbar").yhToolbar({
        items: [
            {
                type: "button",
                text: "新增",
                bodyStyle: "new",
                useable: "T", 
                handler: function() {
                    alert( this.innerHTML );
                }
            }
        ]
    });
				</code></pre>
			</div>
		</div>
		<div class="content">
			<h3>属性</h3>
			<div>
				<h4 id = "items" >items</h4>
				<p>数组，数组元素为对象字面量，包含多个属性。</p>
				<p>items 是必须设置的，否则……还是不要用工具栏了。</p>

				<pre><code>
    //example:
    $("#toolbar").yhToolbar({
        items: [
            {
            	type: "button", //表示元素类型，还可以是"textfield"，文本框。
                text: "新增",  //显示的文字
                bodyStyle: "new", //可以理解为类名，后台人员照着复制就行了。
                useable: "T", //是否可用， "F"为禁用。
                handler: function() { // 按钮的单击事件。
                    alert( this.innerHTML ); //this 指向按钮的dom对象。
                }
            },
            "-", //这里的小横线，是表示分隔符。利用这个可以给按钮分组。
            {
                type: "button",
                .
                .
                .
            }
        ]
    });
				</code></pre>
			</div>
		</div>
		<div class="content">
			<h3>方法</h3>
			<div>
				<h4 id = "disable" >disable</h4>
				<p>禁用按钮。</p>
				<p>接收一个参数，数值型，表示按钮的所以，从0开始。</p>
				<pre><code>
    //example:
    //禁用第一个位置的按钮
    $("#tooltip").yhTooltip( "disable", 0 );
				</code></pre>




				<h4 id = "enable" >enable</h4>
				<p>按钮禁用情况下，启用按钮。</p>
				<p>接收一个参数，数值型，表示按钮的所以，从0开始。</p>
				<pre><code>
    //example:
    //禁用第一个位置的按钮
    $("#tooltip").yhTooltip( "enable", 0 );
				</code></pre>




				<h4 id = "isDiable" >isDiable</h4>
				<p>探测按钮是否禁用。</p>
				<p>返回一个布尔值，true表示禁用。</p>
				<pre><code>
    //example:
    //判断第一个按钮是否禁用
    var isDisable = $("#tooltip").yhTooltip( "isDisable", 0 );
    $.yhui.log( isDisable );
				</code></pre>
			</div>
		</div>
		<div class="content">
			<h3>事件</h3>
			<div>
				<h4>无</h4>
			</div>
		</div>
		<div class = "content" >
			<h3 id = "footer" >完整的js代码</h3>
			<pre><code>
    //初始化两个按钮
    var $toolbar = $("#toolbar").yhToolbar({
        items: [
            {
                type: "button",
                text: "新增",
                bodyStyle: "new",
                useable: "T", 
                handler: function() {
                    alert( this.innerHTML );
                }
            },
            "-",
            {
                type: "button",
                text: "查询",
                bodyStyle: "search",
                useable: "F",
                handler: function() {
                    alert( this.innerHTML );
                }
            }
        ]
    });

    //查询默认是禁用的，让它启用。
    var isDiaable = $toolbar.yhToolbar( "isDisable", 1 );
    if ( isDisable ) {
    	$toolbar.yhToolbar( "enable", 1 );
    }
			</code></pre>
		</div>
	</div>
</body>
</html>