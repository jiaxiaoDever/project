var ResourceList = {
	code : "ResourceList",
	baseUrl : ctx + "/system/resource/",
	isAllowDrop : true,
	init : function() {
		var _this = this;
		_this.treeUrl = _this.baseUrl + "getTree";
		_this.treeUpdateUrl = _this.baseUrl + "updateAll";
	},
	/**
	 * 初始化数据模型
	 */
	initModel : function() {
		var _this = this;
		_this.treeModel = [ {
			name : "id",
			label : "编号",
			hidden : true
		}, {
			name : "name",
			label : "资源名称",
			valiRule : {
				required : true
			}
		}, {
			name : "code",
			label : "资源编码",
			hidden : true
		}, {
			name : "parentId",
			label : "父资源",
			valiRule : {
				required : true
			},
			field : {
				editor : 'dropdown',
				config : {
					hiddenId : "parentId",// 生成hidden的input,id和name都为parentId
					resizable : true,
					selectParent : true,
					store : _this.treeStore,
					post : "id"
				}
			}
		}, {
			name : "description",
			label : "描述"
		}, {
			name : "local",
			label : "协议(http/https..)",
			valiRule : {
				required : true
			}
		}, {
			name : "host",
			label : "ip或域名",
			valiRule : {
				required : true
			}
		}, {
			name : "port",
			label : "端口",
			valiRule : {
				required : true
			}
		}, {
			name : "path",
			label : "路径"
		}, {
			name : "context",
			label : "上下文"
		}, {
			name : "sort",
			label : "排序(越小越前)",
			valiRule : {
				required : true,
				number : true
			}
		} ];
	},
	/**
	 * 初始化监听器
	 */
	initListeners : function() {
		var _this = this;
		_this.listeners.treeClick = function(event, treeId, treeNode, clickFlag) {
			WinUtils.fillFrom(_this.formDiv, treeNode, _this.treeModel);
		};
		_this.listeners.beforeNew = function(_this, data) {
			var tree = _this.treeBarDiv.yhSearchBox("getTree");
			var nodes = tree.getSelectedNodes();
			if (nodes.length == 1) {
				var newNode = {};
				newNode.parentId = nodes[0].id;
				newNode.type = 1;
				newNode.resourceId = '';
				if (nodes[0].children && nodes[0].children.length > 0) {
					newNode.sort = nodes[0].children[nodes[0].children.length - 1].sort + 1;
				} else {
					newNode.sort = 0;
				}
				WinUtils.fillFrom(_this.formDiv, newNode, _this.treeModel);
			}
		};
		_this.listeners.afterDel = function(data, textStatus) {
			var tree = _this.treeBarDiv.yhSearchBox("getTree");
			var nodes = tree.getSelectedNodes();
			for (i in nodes) {
				tree.removeNode(nodes[i]);
			}
			var treeObj = $("#parentId").yhDropDown("getTree");
			var newnodes = treeObj.getNodeByParam("id", nodes[0].id, null);

			treeObj.removeNode(newnodes);
		};
	},
	/**
	 * 按钮的触发方法
	 */
	initActions : function() {
		var _this = this;
		this.actions["ResourceList.save"] = function(e, form, holderDiv, btnObj) {
			var vali = $(_this.formDiv[0].form).yhValidate("checkForm");
			if (!vali) {
				return;
			}
			$.ajax({
				type : "POST",
				dataType : "json",
				url : _this.baseUrl + "save",
				data : $(_this.formDiv[0].form).serialize(),
				success : function(data, textStatus) {
					if (data.success) {
						var arrFromJson = $(_this.formDiv[0].form).serializeArray();
						var leftTree = _this.treeBarDiv.yhSearchBox("getTree");
						var treeObj = $("#parentId", _this.formDiv).yhDropDown("getTree");
						var id = $("form [name=id]", _this.formDiv).val();
						if (!id) {
							var newnodes = treeObj.getNodeByParam("id", data.result.parentId, null);
							var treeNodes = leftTree.getNodeByParam("id", data.result.parentId, null);
							WinUtils.fillFrom(_this.formDiv, data.result, _this.treeModel);
							leftTree.addNodes(treeNodes, data.result);
							treeObj.addNodes(newnodes, data.result);
						} else {
							var nodes = leftTree.getSelectedNodes();
							var updatedNode = WinUtils.updateDataByJqArray(nodes[0], arrFromJson);
							leftTree.updateNode(updatedNode);
							// 同时对dropdown树进行操作
							var nod = treeObj.getNodeByParam("id", nodes[0].id, null);
							nod.name = nodes[0].name;
							treeObj.updateNode(nod);
						}

						$.yhDialogTip.confirm(data.title, data.reason);
						$("form :text", _this.formDiv).val("");

					} else {
						$.yhDialogTip.error(data.title, data.reason);
					}
				}
			});
		};
	},
	initDialog : function() {
		var _this = this;
		_this.formDiv = $("#editForm");
		WinUtils.createFormTo(_this.formDiv, _this.treeModel, null);
		$(_this.formDiv[0].form).yhValidate(_this.valiRules);
	}
};

/**
 * 初始化时layout要放在form/toolbar/button之后，loaddata之前
 */
YHUI.use("yhFormField yhLayout yhDropDown yhToolbar yhButton yhDialogTip yhSearchBox yhValidate yhStore", function() {
	var view = $.extend(true, DefaultView, ResourceList);
	view.start();
});