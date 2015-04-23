<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>提示框</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metadoc.jsp" %>
</head>
<body>
    <div class="container">
        <h1>yhDialogTip，提示框</h1>
        <div class="hotmap">
            <a href="#summary">概述</a><a href="#use">使用方法</a><a href="#guide">导航</a><a href="#case">案例</a><a href="#property">属性</a><a href="#method">方法</a><a href="#return">回调函数</a><a href="#faq">常见问题</a>
            </div>
        <div class="content">
            <h2 id="summary">概述</h2>
            <div class="panel">
                <p>提示框，很容易忽视但是有很重要的组件。合理使用提示框，<strong>用户体验</strong>能得到极大提升。</p>
                <p>yhDialogTip，目前为止提供 “警告、确认、错误” 三种提示框。</p>
            </div>

            <h2 id="use">使用方法</h2>
            <div class="panel">
                <p>html</p>
                <pre class="brush:js">
                   yhDialogTip无需html结构，直接调用即可。
                </pre>
            </div>

            <h2 id="guide">导航</h2>
            <div class="panel">
                <div class="nav">
                    <ul>
                        <li>方法</li>
                        <li><a href="#alert">alert</a></li>
                        <li><a href="#confirm">confirm</a></li>
                        <li><a href="#error">error</a></li>
                    </ul>
                </div>
            </div>

            <h2 id="method">方法</h2>
            <div class="panel">
                <p class="arrow" id="alert">alert( message[, title, callback] )</p>
                <div class="panel2">
                    <p>警告框，带有图标“！”。</p>
                    <p>接受三个参数：message 就是提示信息， title 是标题， callback 是点击 “确定” 按钮的点击事件处理程序。</p>
                    <pre class="brush:js">
                        // 1 后两个参数可以省略
                        $.yhDialogTip.alert( "这个操作非法！" );

                        // 2 改变提示窗的标题
                        $.yhDialogTip.alert( "这个操作非法！", "严重警告！" );

                        // 3 参数写全的情况
                        $.yhDialogTip.alert( "这个操作非法！", "严重警告！", function( e ) {
                            // e 事件对象
                            // 这个函数的 this 指向 $.yhDialogTip
                            this.alert( "确定做这个操作？" );
                        });

                        // 4 第二参数若为函数，则认定为 "确定" 按钮的事件
                        $.yhDialogTip.alert( "message", function() {} );
                    </pre>
                </div>

                <p class="arrow" id="confirm">confirm( message[, title, callback] )</p>
                <div class="panel2">
                    <p>“确定”，带有图标“对钩”。</p>
                    <p>用法同 <a href="#alert">alert</a>， 比如：</p>
                    <pre class="brush:js">
                        $.yhDialogTip.confirm( "操作成功！" );
                    </pre>
                </div>

                <p class="arrow" id="error">error( message[, title, callback] )</p>
                <div class="panel2">
                    <p>“出错”，带有图标“×”。</p>
                    <p>用法同 <a href="#alert">alert</a>， 比如：</p>
                    <pre class="brush:js">
                        $.yhDialogTip.error( "操作失败！" );
                    </pre>
                </div>

            </div>

            <h2>深度控制</h2>
            <div class="panel">
                <p>以上方法非常常用，一般也能满足大部分情况。</p>
                <p>但总是有些个别情况上面的方法不能满足，这就需要深度定制对话框。</p>
                <pre class="brush:js">
                    // 这是 dialogtip 的全部参数
                    _config: {
                        showLogo: true, // 是否显示图标
                        title: "xxx",   // 标题
                        message: "xxxx",    // 信息
                        cancel: function() {    // “取消按钮”事件
                            $( this ).dialog( "close" );
                        },
                        cancelButton: false,    // 是否出现“取消按钮”
                        cancelText: "取消",      // “取消”按钮上的文本
                        okText: "确定",           // “确定”按钮上的
                        ok: function() {}        // “确定”按钮事件
                        modal: true             // 是否模态
                    }
                </pre>
                <p>比如，我来 alert 一下：</p>
                <pre class="brush:js">
                    $.yhDialogTip.alert({
                        title: "系统警告",
                        message: "系统未知错误，请联系管理员",
                        ok: function() {
                            alert( "弹窗已关闭!" );
                        }
                    });
                </pre>
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