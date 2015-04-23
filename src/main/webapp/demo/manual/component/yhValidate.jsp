<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>表单验证</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metadoc.jsp" %>
</head>
<body>
    <div class="container">
        <h1> yhValidate，表单验证</h1>
        <div class="hotmap">
            <a href="#summary">概述</a><a href="#use">使用方法</a><a href="#guide">导航</a><a href="#case">案例</a><a href="#property">属性</a><a href="#method">方法</a><a href="#return">回调函数</a><a href="#faq">常见问题</a>
            </div>
        <div class="connent">
            <h2 id="summary">概述</h2>
            <div class="panel">
                <p>验证，可能是 js 最最原始的应用。</p>
                <p>市面上验证的 jQuery 插件不可谓不多，也不可谓不优秀，比如之前 yhui 使用的 <a href="http://www.position-relative.net/creation/formValidator/" target="_blank">validateEngine</a> 和 报表平台使用的 <a href="http://docs.jquery.com/Plugins/Validation" target="_blank">validate</a> 。</p>
                <p>这些控件太过优秀，考虑的情况太多太复杂（老外做事就是细致）不利于项目组使用，加上对 yhDropDown 和 yhDatePicker 不兼容……</p>
                <p>所以有了 <a href="http://192.168.1.168:9080/YHUI1.2/form/yhValidate.html" target="_blank">yhValidate</a> ，考虑周全但不会芜杂，易于使用而且配套 yhui 其他组件。</p>
                <p> yhValidate 作用于表单元素(&lt;form&gt;)，这点和 yhFormField 一样。</p>
                <p> yhValidate 可以<strong>直接在标签上绑定规则</strong>，这是最简单的，可以参见 demo 。</p>
                <p> 这里主要介绍 js 中绑定规则，以及绑定规则之外的功能。 </p>
            </div>

            <h2 id="use">使用方法</h2>
            <div class="panel">
                <p>html</p>
                <pre id = "overview" class="brush:xml">
                    <form id = "validate">
                        &lt;table&gt;
                            &lt;tr>
                                &lt;td>字段1&lt;/td>
                                &lt;td>&lt;input type="text" id = "text1" />&lt;/td>
                            &lt;/tr>
                            &lt;tr>
                                &lt;td>字段2&lt;/td>
                                &lt;td>&lt;input type="text" name = "text2" />&lt;/td>
                            &lt;/tr>
                        &lt;/table&gt;
                    </form>
                </pre>
            </div>

           <h2 id="guide">导航</h2>
            <div class="panel">
                <div class="nav">
                    <ul>
                        <li>属性</li>
                        <li><a href="#ignore">ignore</a></li>
                        <li><a href="#messages">messages</a></li>
                        <li><a href="#methods">methods</a></li>
                        <li><a href="#rules">rules</a></li>
                        <li><a href="#starTip">starTip</a></li>
                        <li><a href="#validateOnSubmit">validateOnSubmit</a></li>
                    </ul>
                    <ul>
                        <li>方法</li>
                        <li><a href="#checkForm">checkForm</a></li>
                    </ul>
                    <ul>
                        <li>其他</li>
                        <li><a href="#relation">规则关联表单</a></li>
                        <li><a href="#value">规则的取值以及内置规则</a></li>
                        <li><a href="#custom">自定义规则</a></li>
                    </ul>
                </div>
            </div>

            
            <h2 id="property">属性</h2>
            <div class="panel">
                <p class="arrow" id="ignore">ignore</p>
                <div class="panel2">
                    <p>不需要验证的表单。</p>
                    <p>字符串，jQuery 选择器，默认值 "[type=hidden]" 。</p>
                    <pre class="brush:js; highlight: [2, 4]">
                        $("#validate")
                            .yhFormField()  // 可以调用 yhFormField 美化一下表单
                            .yhValidate({
                                ignore: "[type=hidden],[name=xx]"   // 隐藏类型和 name 为 xx 的表单都不验证
                            });
                    </pre>
                </div>

                <p class="arrow" id="messages"><strong>messages</strong></p>
                <div class="panel2">
                    <p>自定义提示的信息，用来取代默认的提示信息。</p>
                    <p>类型为对象字面量。</p>
                    <p>了解更多话，可以参看和这个属性密切相关的 <a href="#rules">rules</a>。 </p>
                    <pre class="brush:js; highlight: [3,6]">
                        $("#validate").yhValidate({
                            rules: {
                                text1: "required"   //给 "text1" 这个文本框绑定必填的规则，其默认提示信息是“不能为空”
                            },
                            message: {
                                text1: "请务必填写这个字段" // 修改提示信息
                            }
                        });
                    </pre>
                </div>

                <p class="arrow" id="methods"><strong>methods</strong></p>
                <div class="panel2">
                    <p>自定义验证规则。</p>
                    <p>对象字面量，默认值为 null 。</p>
                    <p>methods 的用法可以参见  <a href="#custom">自定义规则</a> 。</p>
                </div>

                <p class="arrow" id="rules"><strong>rules</strong></p>
                <div class="panel2">
                    <p>给特定表单域绑定验证规则。</p>
                    <p>最关键属性，我还是分开几点来说。</p>
                    <p id="relation" class="arrow">1. 怎样关联特定的表单</p>
                    <div class="panel2">
                        <p><strong>个人建议</strong>：在表单中尽量使用 name 而不是 id，表单中，name 比 id 有用的多。</p>
                        <p>将规则绑定到表单其实很简单，以<a href="#overview">概述中的 html</a> 为例：</p>
                        <pre class="brush:js;highlight:[3,4]">
                            $("#validate").yhValidate({
                                rules: {
                                    text1: "required",  // text1 是文本框的 id
                                    text2: "required"   // text2 是文本框的 name
                                }
                            });
                            // yhDatePicker 拿到 "text1"，会先关联 name 属性，如果找不到对应表单，再尝试关联 id。
                            // 所以，将表单的 name 或者 id 做为 rules 属性的 key 时，就会关联相应的表单。
                        </pre>
                    </div>
                    <p id="value" class="arrow">2. 规则的取值</p>
                    <div class="panel2">
                        <p><strong>传入字符串</strong>：只有一条规则，并且是使用内置的<strong>无需参数</strong>的规则。</p>
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;以下内置规则都可以：</p>
                        <table>
                            <tr>
                                <th>序号</th>
                                <th>规则</th>
                                <th>描述</th>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>required</td>
                                <td>表示字段不能为空，单选、复选框至少选中一个。</td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>email</td>
                                <td>字符串必须为邮箱格式。</td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>phone</td>
                                <td>
                                    座机号码可以通过。
                                </td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td>mobile</td>
                                <td>手机号码可以通过。</td>
                            </tr>
                            <tr>
                                <td>5</td>
                                <td>url</td>
                                <td>链接形式的字符串可以通过。</td>
                            </tr>
                        </table>
                        <p><strong>传入对象字面量</strong>：除开上面的情况，都必须传入对象字面量。</p>
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;下面用代码说话：</p>
                        <pre class="brush:js; highlight: [4,7,14]">
                            // 内置的 minSize 和 maxSize 规则。
                            $("#validate").yhValidate({
                                text1: {
                                    maxSize: 4      // 最多四个字符，传入 4 这个参数
                                },
                                text2: {
                                    minSize: 4      // 最少四个字符
                                }
                            });

                            // 内置的等值验证： equalTo 规则
                            $("#validate").yhValidate({
                                text2: {
                                    equalTo: "#text1"   // 传入对应表单的 jQuery 选择器
                                }
                            });

                            // 一个表单多条验证规则
                            $("#validate").yhValidate({
                                text1: {
                                    required: true
                                    maxSize: 4
                                },
                                text2: {
                                    required: true
                                    minSize: 4
                                }
                            });

                            //另外，自定义规则也要传入对象字面量。
                        </pre>
                    </div>

                    <p id="custom" class="arrow">3. 自定义规则</p>
                    <div class="panel2">
                        <p>我倒是觉得，自定义规则比内置规则更重要。</p>
                        <p>自定义规则是采用函数。</p>
                        <p>还是代码说话：</p>
                        <pre class="brush:js; highlight: [3,12,17]">
                            // "请选择"这个串不能通过
                            $("#validate").yhValidate({
                                methods: {
                                    mustSe: function( value, field, rules ) {
                                        // 三个参数
                                            // value 是表单值
                                            // field 是表单的 dom 对象
                                            // rules 是验证规则

                                        // 非法的情况下一定要返回 false , 这样控件就知道不合法，然后提示。
                                        if ( value === "请选择" ) {
                                            return false;
                                        }
                                    }
                                }
                                rules: {
                                    text1: "mustSe",
                                    messages: {
                                        text1: {
                                            mustSe: "请选择一项"
                                        }
                                    }
                                }
                            });

                            // 自定义规则就是那么简单。
                        </pre>
                    </div>
                </div>

                <p class="arrow" id="validateOnSubmit">validateOnSubmit</p>
                <div class="panel2">
                    <p>表单提交时是否验证，这个行为会阻止表单的提交。</p>
                    <p>布尔值，默认值 true，提交时验证，不通过则阻止提交。</p>
                    <pre class="brush:js; highlight:[2]">
                        $("#validate").yhValidate({
                            validateOnSubmit: false     // 表单提交时，不验证
                        });
                    </pre>
                </div>
            </div>


            <h2 id="method">方法</h2>
            <div class="panel">
                <p class="arrow" id="checkForm">checkForm</p>
                <div class="panel2">
                    <p>手动验证表单。</p>
                    <p>一般情况下，表单总是会在提交时验证，但是有时也有可能在其他场合验证，调用该方法即可。</p>
                    <pre class="brush:js; highlight: [3]">
                        // 点击按钮验证
                        $( "button" ).on( "click", function() {
                            $("#validate").yhValidate( "checkForm" );
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