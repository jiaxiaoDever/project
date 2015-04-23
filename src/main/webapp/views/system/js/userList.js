/**
 * 用户管理
 * 
 * @author zhangy
 */
var UserList = {
	code : "UserList",
	baseUrl : ctx + "/system/user/",
	toolBarSplitor : "1",
	formDivWidth : 750,
	treeAccessName : "organizationId",
	saveUrl : "saveUser",
	/**
	 * 初始化store
	 */
	initStore : function() {
		var _this = this;
		_this.treeStore = $.yhStore.create({
			name : "orgTree",
			url : _this.baseUrl + "getOrgTree"
		});
		_this.roleStore = $.yhStore.create({
			name : "roleTree",
			url : _this.baseUrl + "findAllRole"
		});
	},
	initModel : function() {
		var _this = this;
		_this.gridModel = [ {
			name : "id",
			label : "编号",
			hidden : true
		}, {
			name : "username",
			label : "用户账号",
			valiRule : {
				required : true,
				maxLength : 8,
				minLength : 2,
				isRegisterUserName : true,
				checkOldValueToRemote : ctx + "/system/user/checkUsername"
			}
		}, {
			name : "name",
			label : "用户姓名",
			valiRule : {
				required : true,
				maxLength : 8,
				minLength : 2
			}
		}, {
			name : "organizationId",
			label : "所属机构",
			formatter : _this.treeStoreFormatter,
			valiRule : {
				required : true
			},
			field : {
				editor : 'dropdown',
				config : {
					hiddenId : "organizationId",
					resizable : true,
					selectParent : true,
					store : _this.treeStore,
					post : "id"
				}
			}
		}, {
			name : "regions",
			label : "管辖地区",
			formatter : _this.treeStoreFormatter,
			valiRule : {
				required : true
			},
			field : {
				editor : 'dropdown',
				config : {
					hiddenId : "regions",
					resizable : true,
					selectParent : true,
					checkbox : true,
					chkboxType : {
						Y : "",
						N : ""
					},
					store : _this.treeStore,
					post : "id"
				}
			}
		}, {
			name : "roles",
			label : "系统角色",
			valiRule : {
				required : true
			},
			field : {
				editor : 'dropdown',
				config : {
					hiddenId : "roleids",
					resizable : true,
					checkbox : true,
					noChild : true,
					store : _this.roleStore,
					post : "id"
				}
			},
			sortable : false,
			formatter : function(value, options, rowObject) {
				var roleNames = "";
				var ls = rowObject.roles;
				if (!ls || ls.length == 0) {
					return "";
				}
				for (var i = 0; i < ls.length; i++) {
					var role = ls[i];
					if (role && role.name) {
						roleNames += role.name + " ";
					}
				}
				return roleNames;
			}
		}, {
			name : "password",
			index : "password",
			label : "用户密码",
			valiRule : {
				maxLength : 15,
				isPasswd : true
			},
			hidden : true,
			field : {
				editor : 'text'
			}
		}, {
			name : "salt",
			label : "salt",
			hidden : true
		}, {
			name : "sex",
			label : "用户性别",
			field : {
				editor : 'select',
				config : {
					json : [ {
						name : "男",
						id : 1
					}, {
						name : "女",
						id : 0
					} ]
				}
			},
			sortable : false,
			formatter : 'select',
			editoptions : {
				value : '1:男;0:女'
			}
		}, {
			name : "phoneNbr",
			label : "固定电话",
			valiRule : {
				phone : true
			}
		}, {
			name : "phsNbr",
			label : "小灵通",
			hidden : true
		}, {
			name : "mobileNbr",
			label : "移动电话",
			valiRule : {
				mobile : true
			}
		}, {
			name : "emailAddr",
			label : "邮件地址",
			valiRule : {
				email : true
			}
		}, {
			name : "channelId",
			label : "channelId",
			hidden : true
		}, {
			name : "staffId",
			label : "staffId",
			hidden : true
		}, {
			name : "isLogincode",
			label : "是否登陆",
			hidden : true,
			field : {
				editor : 'no'
			}
		}, {
			name : "corpId",
			label : "corpId",
			hidden : true
		} ];
	},
	initValiRules : function() {
		var _this = this;
		_this.valiRules.methods = {
			checkOldValueToRemote : function(value, field, param) {
				var rowId = _this.grid.yhGrid("getGridParam", "selrow");
				var ret = null;
				if (!(field.className.indexOf("yhui-form-checkable") > -1)) {
					ret = field.name || field.id;
				} else {
					ret = $(field).find("input")[0].name;
				}
				var data = null;
				if (rowId) {
					data = _this.grid.yhGrid("getRowData", rowId);
					if (value == data[ret])
						return true;
				}
				return $(_this.formDiv[0].form).yhValidate("callMethod", "remote", value, field, param);
			},
			isRegisterUserName : function(value, field, param) { // 校验登录名：只能输入以字母开头、可带数字、“_”、“.”的字串
				var patrn = /^[a-zA-Z]{1}([a-zA-Z0-9]|[._])*$/;
				if (!patrn.exec(value))
					return false;
				return true;
			},
			isPasswd : function(value, field, param) {// 校验密码：只能输入字母、数字、下划线
				var rowId = _this.grid.yhGrid("getGridParam", "selrow");
				if (rowId) {
					if (value == "" || value == "●●●●●●")
						return true;
				}
				var patrn = /^(\w)+$/;
				if (!patrn.exec(value))
					return false;
				return true;
			}
		};
		_this.valiRules.messages = {
			username : {
				isRegisterUserName : "用户名称只能由字母开头；可带数字、“_”、“.”的字串组成",
				checkOldValueToRemote : "系统中已存在该账号"
			},
			password : {
				isPasswd : "用户密码只能由字母、数字、下划线组成"
			}
		};
	},
	/**
	 * 初始化监听器
	 */
	initListeners : function() {
		var _this = this;
		_this.listeners.beforeNew = function(owner, data) {
			data.password = "123456";
		};
		_this.listeners.beforeEdit = function(owner, data) {
			if (data.password)
				data.password = "●●●●●●";
		};
	},
};

/**
 * 初始化时layout要放在form/toolbar/button之后，loaddata之前
 */
YHUI.use("yhStore yhSelectmenu yhTreemenu yhFormField yhLayout yhDropDown yhGrid yhToolbar yhButton yhDialogTip  yhValidate  yhWindow yhSearchBox", function() {
	UserList = $.extend(true, DefaultView, UserList);
	UserList.start();
});
