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
</head>
<body>
<div class="button_temp">
    <button>不出现图标</button><button>确定按钮事件</button><button>出现取消按钮</button>
        <button>自定义按钮文字</button>
</div>
        <script type="text/javascript">
            YHUI.use("yhDialogTip", function() {
                $( document.body ).on( "click", "button", function() {
                    switch ( this.innerHTML ) {
                        case "不出现图标":
                            $.yhDialogTip.alert({
                                message: "这是一个警告",
                                title: "哈哈",
                                showLogo: false
                            });
                            break;
                        case "确定按钮事件":
                            $.yhDialogTip.alert({
                                message: "这是一个警告。点击确认会有alert窗口。",
                                title: "哈哈",
                                ok: function() {
                                    alert("你点击了确定按钮!")
                                }
                            });
                            break;
                        case "出现取消按钮":
                            $.yhDialogTip.alert({
                                message: "这是一个警告",
                                title: "哈哈",
                                cancelButton: true
                            });
                            break;
                        case "自定义按钮文字":
                            $.yhDialogTip.alert({
                                message: "这是一个警告",
                                title: "哈哈",
                                cancelButton: true,
                                okText: "确定",
                                cancelText: "取消"
                            });
                            break;

                    }

                });
            });
        </script>
</body>
</html>
