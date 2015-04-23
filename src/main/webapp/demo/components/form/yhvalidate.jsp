<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Document</title>
<meta name="description" content="">
<meta name="keywords" content="">
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
    <style type="text/css">
        .info h1 { font-size: 20px; }
        .info h1, .info p { margin: 10px 30px; }
        .info p { text-indent: 2em; }
    </style>
    
</head>
<body>
    <div class="info">
        <h1>表单验证 ( yhValidate )</h1>
        <p>表单验证是很重要但又让人头痛的事情，比如提示出错的机制和方式就有无数种。</p>
        <p>各种各样的表单让人头疼不已， ajax 验证更是让问题复杂到了极致…… </p>
        <p>市面上不乏优秀的验证插件，但是或多或少的都和项目组的实际使用状况不符。</p>
        <p>所以便有了 yhValidate 。</p>
        <p>本 demo 所在路径， Components/form/yhValidate.jsp ， 使用文档。</p>
    </div>
    <form class = "yhui-formfield" >
        <div id = "btn" class = "yhui-button" ></div>
		<table>
			<tr>
				<td>必填</td>
				<td><input type="text" name = "field1" required phone /></td>
				<td>自定义提示语</td>
				<td><input type="text" name = "field2" required required-msg = "必填字段" /></td>
			</tr>
            <tr>
                <td>&nbsp;</td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
			<tr>
				<td>内置规则之最小值</td>
				<td><input type="text" name = "field3" minLength="3" /></td>
				<td>自定义规则</td>
				<td><input type="text" name = "field4" number="number" number-msg="只能为数字" /></td>
			</tr>
            <tr>
                <td>&nbsp;</td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
			<tr>
				<td>密码验证</td>
				<td><input type="password" id = "field5" required required-msg = "请填入密码" /></td>
				<td>重复密码</td>
				<td>
                    <input type="password" id = "field6" required required-msg = "请再次填入密码"
                                    equalTo = "field5" equalTo-msg = "密码不一致"  />
                </td>
			</tr>
            <tr>
                <td>&nbsp;</td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td>ajax 验证</td>
                <td>
                    <input type="text" id = "field7" remote = "validate.jsp" />
                    "yhui"能通过，延迟 0.5s 返回结果
                </td>
                <td>第二个 ajax 验证</td>
                <td>
                    <input type = "text" name="field8" remote="validate2.jsp" remote-msg="用户名存在">
                    "yhui2" 能通过，延迟 1s 返回结果。
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td>单选框</td>
                <td>
                    <span class="yhui-form-checkable" required required-msg="请选择一项" >
                        <input type="radio" name="field9" value = "男" />男
                        <input type="radio" name = "field9" value = "女" />女
                    </span>
                </td>
                <td>复选框</td>
                <td>
                    <span class="yhui-form-checkable" maxChecked="2" >
                        <input type="checkbox" name = "field10" value = "足球" />足球
                        <input type="checkbox" name = "field10" value = "篮球" />篮球
                        <input type="checkbox" name = "field10" value = "羽毛球" />羽毛球
                    </span> 至多两项
                </td>
            </tr>
            <tr>
                <td>单选框</td>
                <td>
                    <span class="yhui-form-checkable" required required-msg="请务必选择一项">
                        <input type="radio" name = "field11" value = "男" />男
                        <input type="radio" name = "field11" value = "女" />女
                    </span>
                </td>
                <td>复选框</td>
                <td>
                    <span class="yhui-form-checkable" minChecked="1" >
                        <input type="checkbox" name = "field12" value = "足球" />足球
                        <input type="checkbox" name = "field12" value = "篮球" />篮球
                        <input type="checkbox" name = "field12" value = "羽毛球" />羽毛球
                    </span> 至少一项
                </td>
            </tr>
            <tr>
                <td>时间选择器</td>
                <td><input type = "text" id = "field13" required></td>
                <td>下拉框</td>
                <td><input type = "text" id = "field14" required></td>
            </tr>
		</table>
	</form>
    <script type="text/javascript">
        YHUI.use("yhFormField yhValidate yhButton yhDatePicker yhDropDown", function() {
            $( "form" )
                    .yhFormField()
                    .yhValidate({
                        // 属性 methods ，用来定义自己的验证规则
                        // 这里定义了 只能为数字 的规则
                        methods: {
                            number: function( value ) {
                                return /^\d+$/.test( value );
                            }
                        }
                    });
            $( "#field13" ).yhDatePicker();
            $( "#field14" ).yhDropDown({
                url: "treeData.txt"
            });
            $( "#btn" ).yhButton({
                items: [{ type: "submit" }, { type: "reset" } ]
            });
        });
    </script>
    <br><br><br><br><br><br><br><br><br><br>
</body>
</html>
