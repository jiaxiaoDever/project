function synchronizationAjax(url, para) {
	function createXhrObject() {
		var http = null;
		var activeX = [ 'MSXML2.XMLHTTP.3.0', 'MSXML2.XMLHTTP', 'Microsoft.XMLHTTP' ];
		try {
			http = new XMLHttpRequest();
		} catch (e) {
			for (var i = 0; i < activeX.length; ++i) {
				try {
					http = new ActiveXObject(activeX[i]);
					break;
				} catch (e) {
					;
				}
			}
		} 
		return http;
	}
	;
	var conn = createXhrObject();
	if (para != null && para != '' && typeof (para) != 'undefined') {
		url = [ url, '?', para ].join('');
	}
	conn.open("GET", url, false);
	conn.send(null);
	if (conn.responseText != '') {
		var rs;
		try {
			rs = conn.responseText; // eval('(' + conn.responseText + ')');
		} catch (e) {
			return null;
		}
		return rs;
	} else {
		return null;
	}
}

var logoutclick = 1;
function logout() {
	if (logoutclick > 1) {
		return false;
	}
	logoutclick = 2;
	var check = window.confirm("是否退出系统?");
	if (check == true) {
		var rs = synchronizationAjax(ctx + '/logout', null);
		try {
			var r = eval('(' + rs + ')');
			var casurl = r.casUrl;
			var clienturl = r.clientServiceUrl;
			var ur = casurl + '/logout' + '?' + 'service=' + clienturl;
			window.location.replace(ur);

		} catch (e) {
//			alert("注销失败");
			window.location.reload(false);
		}

	}
}