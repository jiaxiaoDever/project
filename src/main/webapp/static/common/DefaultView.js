/**
 * 默认视图.
 * <p>
 * 针对左右布局的界面，左边是个树控件，右边有查询件的form表单， 下面是分页table,点击table上的一行，可以在弹出窗口进行编辑。
 * </p>
 * 
 * @author zhangy
 */
var DefaultView = {
	code : "",
	baseUrl : "",
	toolBarSplitor : "",// 工具栏的按钮分割线
	toolBarDiv : null,// 工具栏div
	mainDiv : null,// 页面主体div
	searchForm : null,// 查询条件的form
	searchFormSize : null,// 查询条件的form的宽度
	formDiv : null,// 生成的编辑框div
	formDivWidth : null,// 生成的编辑框div的宽度
	valiRules : {},// 生成的编辑框div的校验规则
	actions : {},
	buttons : [],// 修改新增的弹出框按钮

	// yhSearchBox
	tree : null,
	treeBarDiv : null,// yhSearchBox的div
	treeDiv : null,// yhSearchBox的zTree的div
	treeStore : null,
	treeModel : [],
	treeAccessName : null,// 树节点映射grid的字段名
	treeUrl : "",// 树的数据源url
	isAllowDrop : false,// 是否允许拖拽
	treeUpdateUrl : null,// 树节点拖拽后提交的url

	// gird
	gridDiv : null,
	gridPageDiv : null,
	grid : null,
	gridModel : [],
	pageSize : 20,// 每页数据大小
	searchUrl : "queryByPage",// grid查询url
	delUrl : "deleteIn",// grid删除url
	saveUrl : "save",// grid保存url

	// 视图功能的监听器
	listeners : {
		treeClick : null,// yhSearchBox的节点单击事件;tree控件的点击事件;
		treeDrop : null,// yhSearchBox的拖拽事件;tree控件的下拉事件;
		treeAsyncSuccess : null,// yhSearchBox的数据加载完毕事件;tree控件的加载完成事件;

		beforeSearch : null,
		beforeNew : null,
		beforeEdit : null,
		beforeDel : null,
		beforeSave : null,

		afterGridLoad : null,
		afterDel : null,
		afterSave : null
	},
	config : {
		treeConfig : null,
		gridConfig : null
	},
	/**
	 * 初始化参数
	 */
	_init : function() {
		var _this = this;
		_this.mainDiv = _this.mainDiv || ($("#mainContent").size() > 0 ? $("#mainContent") : "");
		_this.searchForm = _this.searchForm || ($("#searchForm").size() > 0 ? $("#searchForm") : "");
		_this.toolbar = _this.toolBarDiv || ($("#toolbar").size() > 0 ? $("#toolbar") : "");
		_this.treeBarDiv = _this.treeBarDiv || ($("#bar").size() > 0 ? $("#bar") : "");
		_this.treeDiv = _this.treeDiv || ($("#leftTree").size() > 0 ? $("#leftTree") : "");
		_this.gridDiv = _this.gridDiv || ($("#list").size() > 0 ? $("#list") : "");
		_this.gridPageDiv = _this.gridPageDiv || ($("#pager").size() > 0 ? $("#pager") : "");
		if (_this.baseUrl) {
			_this.searchUrl = _this.baseUrl + _this.searchUrl;// grid查询url
			_this.delUrl = _this.baseUrl + _this.delUrl;// grid删除url
			_this.saveUrl = _this.baseUrl + _this.saveUrl;// grid保存url
		}
		if (_this.searchForm) {
			_this.searchForm.submit(function() {
				_this.actions[_this.code + ".search"]();
			});
		}

		// 默认的树节点转义
		_this.treeStoreFormatter = function(value, options, rData) {
			var type = _this.treeStore.find("id", value);
			if (type) {
				return type.name;
			} else {
				return "";
			}
		};
		_this.init();
	},
	/**
	 * 初始化参数
	 */
	init : function() {
	},
	/**
	 * 初始化布局
	 */
	initLayout : function() {
		var _this = this;
		$(document.body).yhLayout({});
		var size = _this.searchFormSize ? _this.searchFormSize : northAreaHeight;
		if (_this.mainDiv) {
			var layoutConfig = {
				north : {
					size : size,
					spacing_open : 0,
					spacing_closed : 0
				}
			};
			if (_this.grid) {
				layoutConfig.center__onresize = function() {
					_this.grid.yhGrid("refresh");
				};
			}
			_this.mainDiv.yhLayout(layoutConfig);
		}
		if (_this.searchForm) {
			_this.searchForm.yhFormField({});
		}
	},
	_initStore : function() {
		if (this.treeUrl) {
			this.treeStore = $.yhStore.create({
				name : this.code + "Tree",
				url : this.treeUrl
			});
		}
		this.initStore();
	},
	/**
	 * 初始化store
	 */
	initStore : function() {
	},
	/**
	 * 初始化模型
	 */
	initModel : function() {
	},
	/**
	 * 初始化模型
	 */
	_initModel : function() {
		var _this = this;
		_this.treeModel = [ {
			name : "id",
			label : "编号"
		}, {
			name : "name",
			label : "名称"
		} ];
		_this.initModel();
		_this._initValiRules();
	},
	/**
	 * 初始化弹出框的校验规则
	 */
	_initValiRules : function() {
		var _this = this;
		var model = _this.gridModel.length > 0 ? _this.gridModel : _this.treeModel;
		var valiRules = WinUtils.getModelValiRules(model);
		$.extend(true, _this.valiRules, valiRules);
		_this.initValiRules();
	},
	/**
	 * 初始化弹出框的校验规则
	 */
	initValiRules : function() {
	},
	/**
	 * 初始化监听器
	 */
	_initListeners : function() {
		var _this = this;
		if (!_this.listeners) {
			_this.listeners = {};
		}
		if (_this.listeners.treeClick) {
			return;
		}
		if (_this.gridDiv && _this.treeDiv && _this.searchUrl && _this.searchForm) {
			_this.listeners.treeClick = function(event, treeId, treeNode, clickFlag) {
				var data = $.yhui.mapForm(_this.searchForm[0]);
				data[_this.treeAccessName] = treeNode.id;
				_this.grid.yhGrid("setGridParam", {
					url : _this.searchUrl,
					postData : data,
					search : true
				}).trigger("reloadGrid", {
					page : 1
				});
			};
		}
		_this.initListeners();
	},
	/**
	 * 初始化监听器
	 */
	initListeners : function() {
	},
	/**
	 * 初始化默认的actions,包含CRUD
	 */
	_initActions : function() {
		var _this = this;
		this.actions = {};
		this.actions[this.code + ".search"] = function() {
			var params = {};
			params = $.yhui.mapForm(_this.searchForm[0]);
			if ($.isFunction(_this.listeners.beforeSearch) && _this.listeners.beforeSearch(_this, params) == false) {
				return false;
			}
			if (!_this.grid) {
				return;
			}
			// $.yhui.log(data);
			_this.grid.yhGrid("setGridParam", {
				url : _this.searchUrl,
				postData : params,
				search : true
			}).trigger("reloadGrid", {
				page : 1
			});
		};
		this.actions[this.code + ".new"] = function() {
			if (_this.grid) {
				_this.grid.yhGrid("resetSelection");// 清除数据选择
			}
			var model = _this.gridModel.length > 0 ? _this.gridModel : _this.treeModel;
			var data = {};
			WinUtils.fillFrom(_this.formDiv, data, model);
			if ($.isFunction(_this.listeners.beforeNew) && _this.listeners.beforeNew(_this, data) === false) {
				return false;
			}
			if (_this.formDiv.yhWindow) {
				_this.formDiv.yhWindow("open", "新增");
			}
		};
		this.actions[this.code + ".edit"] = function() {
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
			if (!_this.grid) {
				return;
			}
			var data = _this.grid.yhGrid("getRawData", rowId);
			if ($.isFunction(_this.listeners.beforeEdit) && _this.listeners.beforeEdit(_this, data) === false) {
				return false;
			}
			WinUtils.fillFrom(_this.formDiv, data, _this.gridModel);
			_this.formDiv.yhWindow("open", "修改");
		};
		this.actions[this.code + ".delete"] = function() {
			var ids = null;
			if (_this.gridDiv) {
				var rowIds = _this.grid.yhGrid("getGridParam", "selarrrow");
				if (rowIds.length == 0) {
					$.yhDialogTip.alert("请“选择行”进行删除。");
					return;
				}
				var ids = "";
				var i = 0;
				$.each(rowIds, function(k, v) {
					if (i > 0) {
						ids += ",";
					}
					ids += "\'" + v + "\'";
					i++;
				});
			} else if (_this.treeBarDiv) {
				var nodes = _this.treeBarDiv.yhSearchBox("getTree").getSelectedNodes();
				if (nodes.length == 0) {
					$.yhDialogTip.error("请“选择左栏节点”进行删除。");
					return;
				}
				var ids = '';
				var i = 0;
				$.each(nodes, function(k, v) {
					if (i > 0) {
						ids += ",";
					}
					ids += "\'" + v.id + "\'";
					i++;
				});
			}
			if (!ids) {
				$.yhDialogTip.error("无删除数据，请数据进行删除。");
				return;
			}
			var params = {
				ids : ids
			};

			if ($.isFunction(_this.listeners.beforeDel) && _this.listeners.beforeDel(_this, params) === false) {
				return false;
			}
			$.yhDialogTip.alert({
				title : "删除",
				message : "是否确认删除？",
				cancelButton : true,
				ok : function() {
					$.ajax({
						type : "POST",
						dataType : "json",
						url : _this.delUrl,
						data : params,
						success : function(data, textStatus) {
							if (data.success) {
								if ($.isFunction(_this.listeners.afterDel) && _this.listeners.afterDel(data, textStatus) === false) {
									return false;
								}
								if (!_this.grid) {
									return;
								}
								_this.grid.trigger("reloadGrid", {
									page : 1
								});
								$.yhDialogTip.confirm(data.title, data.reason); // 嵌套使用
							} else {
								$.yhDialogTip.error(data.title, data.reason);
							}
						}
					});
				}
			});
		};
		_this.initActions();
	},
	/**
	 * 按钮的触发方法
	 */
	initActions : function() {
	},
	/**
	 * 初始化工具条
	 */
	initToolBar : function(_toolBarConfig) {
		var _this = this;
		var toolBarConfig = _toolBarConfig || {
			listeners : {
				beforeLoad : function(bar) {
					// bar.config.items[2].align = "right";
				},
				afterLoad : function(bar) {
					// bar.items[2].setAlign("right");
					// bar.items[3].setAlign("right");
					// bar.items[3].setAlign("left");
					// bar.items[3].setDisabled(true);
					// bar.items[3].setDisabled(false);
				}
			}
		};
		CommonUtils.loadToolBar(_this.toolbar, _this.code, _this.actions, _this.toolBarSplitor, toolBarConfig);
	},
	/**
	 * 初始化按钮
	 */
	initDialog : function() {
		var _this = this;
		_this.formDiv = $("<div>");
		_this.formDiv.appendTo("body");
		WinUtils.createEditWin(_this.formDiv, _this.gridModel, null, _this.formDivWidth);
		$(_this.formDiv[0].form).yhValidate(_this.valiRules);

		_this.formDiv.buttonDiv = $('<div>').insertAfter(_this.formDiv[0]);
		var listeners = _this.listeners;
		_this.formDiv.buttonDiv.yhButton({
			align : "right",
			form : _this.formDiv,
			items : [ {
				type : "save",
				onClick : function(e, form) {
					var vali = $(form).yhValidate("checkForm");
					if (!vali) {
						return false;
					} else {
						if (listeners && $.isFunction(listeners.beforeSave) && listeners.beforeSave(e, form) === false) {
							return false;
						}
						var params = $(form).serialize();
						$.ajax({
							type : "POST",
							dataType : "json",
							url : _this.saveUrl,
							data : params,
							success : function(data, textStatus) {
								if (data.success) {
									if (listeners && $.isFunction(listeners.afterSave) && listeners.afterSave(data, textStatus) === false) {
										return false;
									}
									if (_this.grid) {
										_this.grid.trigger("reloadGrid", {
											page : 1
										});
									}
									_this.formDiv.yhWindow("close");
									$.yhDialogTip.confirm(data.title, data.reason);
								} else {
									$.yhDialogTip.error(data.title, data.reason);
								}
							}
						});
						// data=null;
					}
				}
			}, {
				type : "cancel",
				onClick : function() {
					_this.formDiv.yhWindow("close");
				}
			} ]
		});
	},
	/**
	 * 加载数据
	 * 
	 * @param config{treeConfig:{},gridConfig:{}}
	 */
	initData : function() {
		var _this = this;

		var isDefaultConfig = _this.treeDiv && (_this.treeStore);// 是否通过默认配置
		if (_this.treeBarDiv && (_this.config.treeConfig || isDefaultConfig)) {
			var treeConfig = $.extend(true, {
				treeElement : _this.treeDiv,
				store : _this.treeStore,
				treeUpdateUrl : _this.treeUpdateUrl,
				isAllowDrop : _this.isAllowDrop,
				treeModel : _this.treeModel,
				onClick : _this.listeners.treeClick,
				onAsyncSuccess : _this.listeners.treeAsyncSuccess,
				onDrop : _this.listeners.treeDrop,
				beforeLoad : null,
				afterLoad : null
			}, _this.config.treeConfig);

			_this.treeBarDiv.yhSearchBox(treeConfig);
		}
		/** *************************************************** */

		if (_this.gridDiv && (_this.searchUrl || _this.configconfig.gridConfig)) {
			var gridConfig = $.extend(true, {
				url : _this.searchUrl,
				heightStyle : "fill",
				multiselect : true,
				multiboxonly : true,
				rowNum : 20,
				pager : _this.gridPageDiv,
				viewrecords : true,
				colModel : _this.gridModel,
				loadComplete : _this.listeners.afterGridLoad,
				jsonReader : {
					root : "result", // 对于json中数据列表
					page : "currentPage",
					total : "totalPage",
					records : "totalCount",
					repeatitems : false
				}
			}, _this.config.gridConfig);
			_this.grid = _this.gridDiv.yhGrid(gridConfig);
		}
	},

	/**
	 * 视图入口
	 */
	start : function() {
		this._init();// 初始化参数
		this.initLayout();// 初始化布局
		this._initStore();// 初始化store
		this._initModel();// 初始化模型
		this._initListeners();// 初始化监听器
		this._initActions();// 初始化按钮事件
		this.initToolBar();// 初始化工具栏
		this.initDialog();// 初始化弹窗按钮
		this.initData();// 初始化数据
	}

};
