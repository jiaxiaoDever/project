var OrgList = {
	code : "OrgList",
	baseUrl : ctx + "/system/org/",
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
			label : "机构名称",
			sortable : true,
			valiRule : {
				required : true,
				minLength : 4
			}
		}, {
			name : "corpCode",
			label : "机构编码",
			hidden : true
		}, {
			name : "parentId",
			label : "所属机构",
			valiRule : {
				required : true
			},
			field : {
				editor : 'dropdown',
				config : {
					hiddenId : "parentId",// 生成hidden的input,id和name都为parentId
					resizable : true,
					selectParent : true,
					post : "id",
					store : _this.treeStore,
					onClick : function(e, yhui) {
						var orglevel = yhui.node.orgLevel;
						$("#editForm input[name=orgLevel]").val(parseInt(orglevel) + 1);
						return true;
					}
				}
			},
			sortable : false
		}, {
			name : "orgLevel",
			label : "机构级别",
			hidden : false
		}, {
			name : "orgOrder",
			label : "排序(越小越前)",
			hidden : false
		}, {
			name : "description",
			label : "描述",
			sortable : false
		}, {
			name : "state",
			label : "状态",
			hidden : true
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
					newNode.orgOrder = nodes[0].children[nodes[0].children.length - 1].orgOrder + 1;
				} else {
					newNode.orgOrder = 0;
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
		this.actions["OrgList.save"] = function(e, form, holderDiv, btnObj) {
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
	var view = $.extend(true, DefaultView, OrgList);
	view.start();
});