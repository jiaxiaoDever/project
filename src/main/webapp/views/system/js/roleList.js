var RoleList = {
	code : "RoleList",
	baseUrl : ctx + "/system/role/",
	toolBarSplitor : "1,4",
	/**
	 * 初始化store
	 */
	initStore : function() {
		var _this = this;
		var menuUrl = ctx + "/system/menu/";
		_this.roleMenuStore = $.yhStore.create({
			name : "roleMenuStore",
			url : menuUrl + "getMenuIdByRoleId",
			afterLoad : function(s) {
			},
			isAutoLoad : false
		});
		_this.menuStore = $.yhStore.create({
			name : "MenuStore",
			url : menuUrl + "getTree",
			afterLoad : function(s) {
			}
		});
	},
	initModel : function() {
		var _this = this;
		_this.gridModel = [ {
			name : "id",
			label : "编号",
			hidden : true
		}, {
			name : "name",
			label : "角色名称",
			valiRule : {
				maxLength : 16,
				minLength : 2,
				checkOldValueToRemote:ctx + "/system/role/checkRoleName",
				required : true
			}
		}, {
			name : "symbol",
			label : "角色编码",
			valiRule : {
				maxLength : 16,
				minLength : 2,
				required : true
			}
		}, {
			name : "roleLevel",
			hidden : true
		}, {
			name : "state",
			hidden : true
		}, {
			name : "description",
			label : "描述"
		} ];
		// 权限弹窗模型
		_this.authorityModel = [ {
			name : "id",
			label : "编号",
			hidden : true
		}, {
			name : "ids",
			label : "角色菜单",
			field : {
				editor : 'checkboxtree',
				config : {
					hiddenId : "ids",
					resizable : true,
					selectParent : true,
					store : _this.menuStore,
					post : "id"
				}
			}
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
			}
		};
		_this.valiRules.messages = {
			name : {
				checkOldValueToRemote : "系统中已存在该账号"
			}
		};
	},
	initListeners : function() {

	},
	/**
	 * 按钮的触发方法
	 */
	initActions : function() {
		var _this = this;
		this.actions["RoleList.set"] = function(e, form, holderDiv, btnObj) {
			var rowAllid = _this.grid.yhGrid("getGridParam", "selarrrow");
			if (rowAllid.length > 1) {
				$.yhDialogTip.alert("请“选择一行”进行编辑。");
				return;
			}
			var rowId = _this.grid.yhGrid("getGridParam", "selrow");
			if (!rowId) {
				$.yhDialogTip.alert("请“选择一行”进行编辑。");
				return;
			}
			var data = _this.grid.yhGrid("getRawData", rowId);
			postData = {
				id : data.id
			};
			_this.roleMenuStore.load({
				postData : {
					id : data.id
				},
				afterLoad : function(store) {
					authorityData = {
						id : data.id,
						ids : store.data
					};
					WinUtils.fillFrom(_this.authorityFormDiv, authorityData, _this.authorityModel);
					_this.authorityFormDiv.yhWindow("open", "修改");
				}
			});
		};
	},
	initAuthorityDialog : function() {
		var _this = this;
		_this.authorityFormDiv = $("<div/>").appendTo("body");
		WinUtils.createEditWin(_this.authorityFormDiv, _this.authorityModel);
		_this.authorityFormDiv.buttonDiv = $('<div>').insertAfter(_this.authorityFormDiv[0]);
		_this.authorityFormDiv.buttonDiv.yhButton({
			align : "right",
			form : _this.authorityFormDiv,
			items : [ {
				type : "save",
				id : "authoritySaveBtn",
				onClick : function(e, form) {
					$("#ids").yhCheckBoxTree("collectData");
					var params = $(form).serialize();
					$.ajax({
						type : "POST",
						dataType : "json",
						url : _this.baseUrl + "saveRoleMenu",
						data : params,
						success : function(data, textStatus) {
							if (data.success) {
								if (_this.grid) {
									_this.grid.trigger("reloadGrid");
								}
								_this.authorityFormDiv.yhWindow("close");
								$.yhDialogTip.confirm(data.title, data.reason);
							} else {
								$.yhDialogTip.error(data.title, data.reason);
							}
						}
					});
				}
			}, {
				type : "cancel",
				id : "authorityCancelBtn",
				onClick : function() {
					_this.authorityFormDiv.yhWindow("close");
				}
			} ]
		});
	}
};

/**
 * 初始化时layout要放在form/toolbar/button之后，loaddata之前
 */
YHUI.use("yhStore yhCheckBoxTree yhSelectmenu yhTreemenu yhFormField yhLayout yhDropDown yhGrid yhToolbar yhButton yhDialogTip  yhValidate  yhWindow yhSearchBox", function() {
	var view = $.extend(true, DefaultView, RoleList);
	view.start();
	view.initAuthorityDialog();
});