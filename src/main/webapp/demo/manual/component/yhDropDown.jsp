<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>下拉框</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metadoc.jsp" %>
</head>
<body>
    <div class="container">
        <h1>yhDropDown，下拉框</h1>
        <div class="hotmap">
            <a href="#summary">概述</a><a href="#use">使用方法</a><a href="#guide">导航</a><a href="#case">案例</a><a href="#property">属性</a><a href="#method">方法</a><a href="#return">回调函数</a><a href="#faq">常见问题</a>
            </div>
        <div class="content">
            <h2 id="summary">概述</h2>
            <div class="panel">
                <p>下拉框，就是下拉一个框，框里面可以是列表，也可以是一个棵树。</p>
                <p>浏览器原生的 &lt;select&gt; 太弱，所以有了这个组件。</p>
                <p>yhDropdDown 的特色是<strong>异步</strong>获取节点和<strong>延迟</strong>初始化下拉树。</p>
                <p>yhDropDown 内部使用了 <a href="http://www.ztree.me/v3/api.php" target="_blank">zTree</a> 。</p>
                <p>可以在普通的文本框上直接调用 yhDropDown ：</p>
                <pre class="brush:xml">
                    &lt;input id="dropdown" type="text" /&gt;
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
                        <li><a href="#autocomplete">autocomplete</a></li>
                        <li><a href="#checkbox">checkbox</a></li>
                        <li><a href="#chkboxType">chkboxType</a></li>
                        <li><a href="#customContent">customContent</a></li>
                        <li><a href="#disable">disable</a></li>
                        <li><a href="#height">height</a></li>
                        <li><a href="#hiddenId">hiddenId</a></li>
                        <li><a href="#idKey">idKey</a></li>
                        <li><a href="#inputWidth">inputWidth</a></li>
                        <li><a href="#json">json</a></li>
                        <li><a href="#minLength">minLength</a></li>
                        <li><a href="#noChild">noChild</a></li>
                        <li><a href="#pIdKey">pIdKey</a></li>
                        <li><a href="#post">post</a></li>
                        <li><a href="#postData">postData</a></li>
                        <li><a href="#selectAllSelected">selectAllSelected</a></li>
                        <li><a href="#selectParent">selectParent</a></li>
                        <li><a href="#showButton">showButton</a></li>
                        <li><a href="#simpleData">simpleData</a></li>
                        <li><a href="#type">type</a></li>
                        <li><a href="#url">url</a></li>
                        <li><a href="#width">width</a></li>
                        <li><a href="#zTreeSettings">zTreeSettings</a></li>
                    </ul>
                    <ul>
                        <li>方法</li>
                        <li><a href="#enable">enable</a></li>
                        <li><a href="#disable">disable</a></li>
                        <li><a href="#getTree">getTree</a></li>
                        <li><a href="#option">option</a></li>
                        <li><a href="#parseDrop">parseDrop</a></li>
                    </ul>
                    <ul>
                        <li>回调函数</li>
                        <li><a href="#beforeCreatedTree">beforeCreatedTree</a></li>
                        <li><a href="#createdTree">createdTree</a></li>
                        <li><a href="#hide">hide</a></li>
                        <li><a href="#onClick">onClick</a></li>
                    </ul>
                </div>
            </div>

            
            <h2 id="property">属性</h2>
            <div class="panel">
                <p class="arrow" id="autocomplete">autocomplete</p>
                <div class="panel2">
                    <p>下拉框内部集成了<a href="http://api.jqueryui.com/autocomplete/" target="_blank">自动完成</a>的效果，在单选、树形模式下可以启用。</p>
                    <p>布尔值，默认值 false 。</p>
                    <pre class="brush:js; highlight:[2]">
                        $("#dropdown").yhDropDown({
                            autocomplete: true
                        });
                    </pre>
                </div>

                <p class="arrow" id="chechbox">checkbox</p>
                <div class="panel2">
                    <p>显示复选框，也就意味着启用多选模式。</p>
                    <p>布尔值，默认值 false 。</p>
                    <pre class="brush:js; highlight:[2]">
                        $("#dropdown").yhDropDown({
                            checkbox: true
                        });
                    </pre>
                </div>

                <p class="arrow" id="chkboxType">chkboxType</p>
                <div class="panel2">
                    <p> <a href="http://www.ztree.me/v3/api.php" target="_blank">zTree</a> 的一个属性，有复选框的时候，表示父子节点直接的关联。 </p>
                    <pre class="brush:js; highlight: [15]">
                        //默认值是一个对象，如下：
                            {
                                Y: "ps",
                                N: "ps"
                            }
                            // Y 属性定义 checkbox 被勾选后的情况； 
                            // N 属性定义 checkbox 取消勾选后的情况； 
                            // "p" 表示操作会影响父级节点； 
                            // "s" 表示操作会影响子级节点。
                            // 请注意大小写，不要改变
                            // 以上从 zTree 官网拷贝
                    
                        $("#dropdown").yhDropDown({
                            checkbox: true,
                            chkboxType: { Y: "", N: "" }  // 父子节点之间完全没有关系
                        });
                    </pre>
                </div>

                <p class="arrow" id="customContent">customContent</p>
                <div class="panel2">
                    <p>自定义的内容，单选、没有复选框情况下，通常希望在列表的开始加个“请选择”什么的。</p>
                    <p>字符串，默认值 "请选择" 。为空时，则不会添加一个选项。</p>
                    <pre class="brush:js;highlight:[3]">
                        $("#dropdown").yhDropDown({
                            noChild: true,                  // 列表形式，必须设置 noChild 为 true
                            customContent: "请选择一项"
                        });
                    </pre>
                </div>

                <p class="arrow" id="disable">disable</p>
                <div class="panel2">
                    <p>禁用下拉框。</p>
                    <p>布尔值。默认值 false，不禁用。</p>
                    <pre class="brush:js; highlight:[2]">
                        $("#dropdown").yhDropDown({
                            disable: true       // 禁用下拉框
                        });
                    </pre>
                </div>

                <p class="arrow" id="height">height</p>
                <div class="panel2">
                    <p>自定义下拉框的高度。</p>
                    <p>数值。大家适当定义，不要大的页面都放不下去。</p>
                    <p>默认值为 css 中的 "auto" 。</p>
                    <pre class="brush:js">
                        $("#dropdown").yhDropDown({
                            height: 250         // 高度定义为二百五
                        });
                    </pre>
                </div>

                <p class="arrow" id="hidderId">hiddenId</p>
                <div class="panel2">
                    <p>自定义隐藏域的 id 值，同时 name 属性也设为该值。</p>
                    <p>字符串类型，请保证 id 值是页面唯一的。</p>
                    <p>缺省时，会按照一定规律自动生成 id 。</p>
                    <p> name 值始终与 id 值相同。</p>
                    <pre class="brush:js; highlight:[3]">
                        $("#dropdown").yhDropDown({
                            post: "id",
                            hiddenId: "hidden"      // 设定 id
                        });
                    </pre>
                </div>

                <p class="arrow" id="idKey">idKey</p>
                <div class="panel2">
                    <p><a href="http://www.ztree.me/v3/api.php" target="_blank">zTree</a> 的一个属性，配合 <a href="#simpleData">simpleData</a> 使用。</p>
                    <p>请务必了解 zTree 的简单数据格式。</p>
                    <p>标识本节点的字段名称，值必须是唯一的。</p>
                    <p>字符串，默认值 "id" 。 </p>
                    <pre class="brush:js; highlight:[4]">
                        $("#dropdown").yhDropDown({
                            simpleData: true,
                            pIdKey: "parentId",
                            idKey: "iid"
                        });
                    </pre>
                </div>

                <p class="arrow" id="inputWidth">inputWidth</p>
                <div class="panel2">
                    <p>文本框的宽度，区别于下拉框的宽度(<a href="#width">width</a>)。</p>
                    <p>数值。 大家看着办，不要设个 1000 啊什么的。</p>
                    <pre class="brush:js; highlight:[2]">
                        $("#dropdown").yhDropDown({ 
                            inputWidth: 250     // 文本框的宽度设置为二百五
                        });
                    </pre>
                </div>

                <p class="arrow" id="json">json</p>
                <div class="panel2">
                    <p>符合 <a href="http://www.ztree.me/v3/api.php" target="_blank">zTree</a> 节点格式的数组或者对象。取名为 "json" 是一个错误啊。</p>
                    <p>利用本地数据构建下拉框，而不是异步获取数据。</p>
                    <pre class="brush:js; highlight:[7]">  
                        var list = [
                            { name: "广东", id: 1 },
                            { name: "安徽", id: 2 }
                        ];

                        $("#dropdown").yhDropDown({
                            json: list,     // 传入节点
                            noChild: true   // 列表形式
                        });
                    </pre>
                </div>

                <p class="arrow" id="minLength">minLength</p>
                <div class="panel2">
                    <p>配合<a href="#autocomplete">自动完成</a>使用，输入多少个字符时开始提示。</p>
                    <p>数值类型。默认值 1 ，即输入一个字符就开始提示。</p>
                    <pre class="brush:js;highlight:[3]">
                        $("#dropdown").yhDropDown({
                            autocomplete: true,
                            minLength: 2        // 输入两个字符开始提示。
                        });
                    </pre>
                </div>

                <p class="arrow" id="noChild">noChild</p>
                <div class="panel2">
                    <p>下拉框为<strong>列表</strong>时，必须设置该属性为 true 。</p>
                    <p>该属性为 true，会调整一些样式。</p>
                    <pre class="brush:js">
                        $("#dropdown").yhDropDown({
                            noChild: true
                        });
                    </pre>
                </div>

                <p class="arrow" id="pIdKey">pIdKey</p>
                <div class="panel2">
                    <p><a href="http://www.ztree.me/v3/api.php" target="_blank">zTree</a> 的一个属性，配合 <a href="#simpleData">simpleData</a> 使用。</p>
                    <p>请务必了解 zTree 的简单数据格式。</p>
                    <p>本节点中表示父节点的字段。</p>
                    <p>字符串，默认值 "pId" 。 </p>
                    <pre class="brush:js; highlight:[3]">
                        $("#dropdown").yhDropDown({
                            simpleData: true,
                            pIdKey: "parentId"
                        });
                    </pre>
                </div>

                <p class="arrow" id="post">post</p>
                <div class="panel2">
                    <p>隐藏域中要传送的字段名称。</p>
                    <p>字符串类型，默认值为空字符。</p>
                    <pre class="brush:js; highlight: [2]">
                        $("#dropdown").yhDropDown({
                            post: "id"      //  将 id 传送到后台
                        })
                    </pre>
                </div>

                <p class="arrow" id="postData">postData</p>
                <div class="panel2">
                    <p>配合 <a href="#url">url</a> 使用，异步获取数据时，将额外的数据传递到服务器。</p>
                    <p>对象或者字符串类型，和 <a href="http://api.jquery.com/jQuery.ajax/" target="_blank">$.ajax</a> 中的 data 属性一样。</p>
                    <p>默认值 null 。</p>
                    <pre class="brush:js;highlight: [3]">
                        $("#dropdown").yhDropDown({
                            url: "...",
                            postData: {         // 后台就可以获取到 test，根据其值就可以响应相应的节点
                                test: "anhui"
                            }
                        });
                    </pre>
                </div>

                <p class="arrow" id="selectAllSelected">selectAllSelected</p>
                <div class="panel2">
                    <p>该属性在 <a href="#noChild">noChild</a> 和 <a href="#checkbox">checkbox</a> 都为 true 时有效。</p>
                    <p>另外，在 yhui 1.2 版本中，要配合 <a href="#parseDrop">parseDrop</a> 方法使用。</p>
                    <p>布尔值，默认值 false 。 设置为 true 时，会选中所有的节点。</p>
                    <pre class="brush:js; highlight: [5]">
                        $("#dropdown").yhDropDown({
                            url: "....",
                            noChild: true,
                            checkbox: true,
                            selectAllSelected: true     // 默认选中所有节点
                        }).yhDropDown( "parseDrop" );
                    </pre>
                </div>

                <p class="arrow" id="selectParent">selectParent</p>
                <div class="panel2">
                    <p>可以选择父节点。默认情况下，点击父节点是展开子节点的。</p>
                    <p>默认值 false 。</p>
                    <pre class="brush:js;highlight[2]" >
                        $("#dropdown").yhDropDown({
                            selectParent: true      // 父节点可选
                        });
                    </pre>
                </div>

                <p class="arrow" id="showButton">showButton</p>
                <div class="panel2">
                    <p>是否显示按钮。</p>
                    <p>布尔值，默认 true，显示。</p>
                    <pre class="brush:js; highlight:[2]">
                        $("#dropdown").yhDropDown({
                            showButton: false
                        });
                    </pre>
                </div>

                <p class="arrow" id="simpleData">simpleData</p>
                <div class="panel2">
                    <p>节点数据为简单数据格式。</p>
                    <p>请务必了解 zTree 的简单数据格式。</p>
                    <p>布尔值， 默认值 false 。</p>
                    <pre class="brush:js;highlight:[2]">
                        $("#dropdown").yhDropDown({
                            simpleDate: true    // 启用简单数据模式
                        });
                    </pre>
                </div>

                <p class="arrow" id="type">type</p>
                <div class="panel2">
                    <p>异步请求的模式。默认值"post"，可选值"get"。</p>
                    <pre class="brush:js; highlight: [3]">
                        $("#dropdown").yhDropDown({
                            url: ".....",
                            type: "get"         // 将请求类型设为 "get"
                        });
                    </pre>
                </div>

                <p class="arrow" id="url">url</p>
                <div class="panel2">
                    <p>异步请求的路径。</p>
                    <p>字符串类型，默认值为空字符串。</p>
                    <pre class="brush:js; highlight: [2]">
                        $("#dropdown").yhDropDown({
                            url: "treeData.txt"     // 获取 treeData.txt 中的数据。
                        });
                    </pre>
                </div>

                <p class="arrow" id="width">width</p>
                <div class="panel2">
                    <p>下拉框的宽度，区别于 <a href="#inputWidth">inputWidth</a> 。</p>
                    <p>数值。默认和文本框一样宽。</p>
                    <pre class="brush:js; highlight:[2]">
                        $("#dropdown").yhDropDown({
                            width: 250      // 将下拉框的宽度设置为二百五
                        });
                    </pre>
                </div>

                <p class="arrow" id="zTreeSettings">zTreeSettings</p>
                <div class="panel2">
                    <p> zTree 的属性设置。</p>
                    <p>会覆盖下拉框中的所有属性，慎用。</p>
                    <pre class="brush:js; highlight:[2]">
                        $("#dropdown").yhDropDown({
                            zTreeSettings: {
                                check: {
                                    chkStyle: "radio"        // 将复选框变为单选框
                                }
                            }
                        });
                    </pre>
                </div>

            </div>


            <h2 id="method">方法</h2>
            <div class="panel">
                <p class="arrow" id="enable">enable()</p>
                <div class="panel2">
                    <p>下拉框禁用模式下，解除禁用模式。</p>
                    <pre class="brush:js;highlight:[5]">  
                        var $drop = $("#dropdown").yhDropDown({
                                        disable: true
                                    });
                        .....
                        $drop.yhDropDown( "enable" );       // 解除禁用

                    </pre>
                </div>

                <p class="arrow" id="disable">disable()</p>
                <div class="panel2">
                    <p>禁用下拉框。</p>
                    <pre class="brush:js;highlight:[5]">  
                        var $drop = $("#dropdown").yhDropDown();
                        .....
                        $drop.yhDropDown( "disable" );       // 禁用
                    </pre>
                </div>

                <p class="arrow" id="getTree">getTree()</p>
                <p>获取下拉框中的 zTree 对象。</p>
                <pre class="brush:js">
                    var treeObj = $("#dropdown").yhDropDown({...}).yhDropDown( "getTree" );
                    $.yhui.log( treeObj );
                </pre>

                <p id="option" class="arrow">option( prop )</p>
                <div class="panel2">
                    <p>获取属性值。</p>
                    <p>接受一个字符串，表示属性名称。</p>
                    <pre class="brush:js; highlight:[3]">
                        var $drop = $("#dropdown").yhDropDown({...});
                        ....
                        var isDisable = $drop.yhDropDown( "option", "disable" );
                        if ( isDisable ) {
                            ....
                        }
                    </pre>
                </div>

                <p class="arrow" id="parseDrop"><strong>parseDrop()</strong></p>
                <div class="panel2">
                    <p>1.2 版本以后，“下拉框”的那个框，其实是在点击箭头的时候才创建的。</p>
                    <p>但是，有时候初始化的时候就要默认选中一些值，怎么办？</p>
                    <p>parseDrop 方法可以解决这个问题。</p>
                    <pre class="brush:js; highlight: [6]">
                        $("#dropdown").yhDropDown({
                            url: "....",
                            noChild: true,
                            checkbox: true,
                            selectAllSelected: true     // 默认选中所有节点
                        }).yhDropDown( "parseDrop" );   // 手动促使下拉框创建。
                    </pre>
                </div>
            </div>

            <h2 id="return">回调函数</h2>
            <div class="panel">
                <p class="arrow" id="beforeCreatedTree">beforeCreatedTree</p>
                <div class="panel2">
                    <p>在初始化下拉树之前执行。</p>
                    <p>这个回调可以处理返回的节点数据，以及设置 zTree 的属性。</p>
                    <p>带有两个参数，如下。</p>
                    <pre class="brush:js">
                        $("#dropdown").yhDropDown({
                            url: "treeData.txt",
                            beforeCreatedTree: function( e, yhui ) {
                                // e 事件对象
                                // yhui 对象，两个属性
                                    // yhui.data  服务器返回的数据，可以修改。
                                    // yhui.zTreeSetttings zTree的一些属性，可以修改。

                                // 移除第一个节点
                                yhui.data.shift();
                            }
                        });
                    </pre>
                </div>

                <p class="arrow" id="createdTree">createdTree</p>
                <div class="panel2">
                    <p>树创建完成后触发。</p>
                    <p>一般会在这个回调中做一些默认的操作，比如选中一些节点。</p>
                    <p>带有两个参数，如下。</p>
                    <pre class="brush:js">
                        // 这是从 demo 中拷贝的代码
                        $("#dropdown").yhDropDown({
                            url: "../DropDown",  
                            post: "id",
                            postData: { test: "anhui" },
                            noChild: true,
                            createdTree: function( e, tree ) {
                                // e 事件对象
                                // tree zTree 对象
                                // 下面选中 id 为 1 的节点。
                                var node = tree.getNodeByParam( "id", 1 );
                                tree.selectNode( node );
                                this.value = node.name;
                                $(this).siblings(":hidden").val( 1 );
                            }
                        }).yhDropDown("parseDrop");
                    </pre>
                </div>

                <p class="arrow" id="hide">hide</p>
                <div class="panel2">
                    <p>下拉框隐藏时会执行这个回调函数。</p>
                    <p>这个回调，在做验证的时候非常有用。 yhValidate 其实就是用了这个回调。</p>
                    <p>带有两个参数，如下。</p>
                    <pre class="brush:js">
                        $("#dropdown").yhDropDown({
                            url: "treeData.txt",
                            hide: function( e, yhui ) {
                                // e 事件对象
                                // yhui 对象，两个属性
                                    // yhui.dropDiv 下拉 div 的 jQuery 对象
                                    // yhui.instance 下拉框实例
                                alert( "下拉框隐藏！" );
                            }
                        });
                    </pre>
                </div>

                <p class="arrow" id="onClick"><strong>onClick</strong></p>
                <div class="panel2">
                    <p>最常用回调。</p>
                    <p>可以用此回调自定义文本框和隐藏域的值，可以做单选或者多选联动。</p>
                    <p>这个回调的返回值如果为 false ( return false; ) 的话，会阻止组件的默认行为。</p>
                    <p>组件的默认行为是将选中的节点的值拼到文本框和隐藏域中。</p>
                    <p>实例的话，大家就看看 <a target="_blank" href="http://localhost:8080/YHUI1.2/form/yhDropDown.html">DEMO</a>，里面的联动就用了 onClick 。</p>
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