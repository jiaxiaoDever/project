var islogined = false;
$(function() {
	trunTopWin();
	enterSubmit();
});
/**
 * 回车键提交表单
 */
function enterSubmit() {
	$("#password,#username,#vcode").keydown(function(event) {
		if (event.keyCode == 13) {
			login();
		}
	});
}
function login() {
	var url = [ ctx, '/login' ].join('');

	$.post(url, {
		username : $('#username').val(),
		password : $('#password').val(),
		vcode : $('#vcode').val()
	}, function(data, textStatus) {

		if (textStatus == 'success')// "timeout","error","notmodified","success","parsererror"
		{
			// alert(data);
			try {
				data = eval('(' + data + ')');
			} catch (ex) {
				self.location.replace(ctx + '/index');
				return;
			}
			if (data.success == true) {// 登录成功
				self.location.replace(ctx + '/index');
			} else {// 登录失败
				$("#errors").show();
				$("#errors").html(data.message);
				refresh('#valicodeImg');
			}

		}
	},"text");
}

/**
 * 刷新验证码
 */
function refresh(obj) {
	// 绑定码证码点击事件
	$(obj).attr('src', ctx + "/kaptcha.jpg?d=" + new Date().getTime());
}

function trunTopWin() {
	// 当session超时时，完全跳出frameset到登录页面
	if (top.location != self.location) {
		top.location = self.location;
	}
}