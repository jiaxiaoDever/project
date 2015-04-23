/*!
 * YHUI yhSearchBox @VERSION
 *
 * Depends:
 *  jquery.ui.core
 *  jquery.ui.widget
 */

(function($) {
	$.widget("yhui.yhSearchBox", $.yhui.yhPlaceholder, {
		version : "@VERSION",
		options : {
			tree : null,// ztree对象
			treeElement : null,// ztree的DIV容器
			treeModel : null,// 树数据模型
			treeUrl : null,// 树数据获取地址
			zTreeSettings : null,
			isAllowDrop : false,// 是否支持拖拽
			treeUpdateUrl : null,// 树数据获取地址
			// callback
			onClick : null,
			onAsyncSuccess : null,
			onDrop : null
		},

		_create : function() {
			var that = this;
			if (this.options.store) {
				var store = $.yhStore.get(that.options.store.name);
				that.store = store;
				if (that.store.data) {
					that.options.json = that.store.data;
					that.__create();
				} else {
					var initDataFun = that.store.triger.initData;
					that.store.triger.initData = function(_store) {
						if (initDataFun && $.isFunction(initDataFun)) {
							initDataFun(that.store);
						}
						that.options.json = that.store.data;
						that.__create();
					};
				}
			} else {
				that.__create();
			}
		},
		__create : function() {
			this.options.treeElement = typeof this.options.treeElement == "string" ? $("#" + this.options.treeElement) : this.options.treeElement;
			if (!this.options.tree) {
				this._initDefaultTree();
			}
			this._parse();
			this._events();
			this.$input.yhPlaceholder();
		},
		// 创建默认树
		_initDefaultTree : function() {
			var that = this;
			var setting = {
				async : {
					enable : true,// 异步获取数据
					url : that.options.treeUrl,
					autoParam : [ "id", "parentId" ],
					contentType : "application/json"
				},

				callback : {
					// beforeExpand:myExpand(treeId, treeNode),
					onAsyncSuccess : that.options.onAsyncSuccess,
					onClick : function(event, treeId, treeNode, clickFlag) {
						if ($.isFunction(that.options.onClick)) {
							that.options.onClick(event, treeId, treeNode, clickFlag);
						}
					}
				}

			};
			if (that.options.isAllowDrop) {
				setting.edit = {
					enable : true,// 允许编辑拖拽
					showRemoveBtn : false,
					showRenameBtn : false,
					drag : {
						prev : true,
						next : true,
						inner : true
					}
				};
				setting.callback.onDrop = function(event, treeId, treeNodes, targetNode, moveType) {
					var sort = 0;
					var updateNodes = [];// 储存要保存的菜单数据
					if ("inner" == moveType) {// 插入为子菜单
						if (targetNode.children) {
							if (targetNode.children.length == 1) {
								sort = 0;
							} else {
								sort = targetNode.children[targetNode.children.length - 1].sort + 1;
							}
						}
						for ( var i in treeNodes) {
							var node = treeNodes[i];
							node.parentId = targetNode.id;
							node.sort = sort++;
							updateNodes.push(WinUtils.getNodeByMode(that.options.treeModel, node));
						}
					} else if ("prev" == moveType) {// 前置或后置时
						sort = targetNode.sort;
						for ( var i in treeNodes) {
							var node = treeNodes[i];
							node.parentId = targetNode.parentId;
							node.sort = sort++;
							updateNodes.push(WinUtils.getNodeByMode(that.options.treeModel, node));
						}
						var currentNode = targetNode;
						do {
							currentNode.sort = sort++;
							updateNodes.push(WinUtils.getNodeByMode(that.options.treeModel, currentNode));
						} while ((currentNode = currentNode.getNextNode()) != null)
					} else if ("next" == moveType) {
						sort = targetNode.sort;
						for ( var i in treeNodes) {
							var node = treeNodes[i];
							node.parentId = targetNode.parentId;
						}
						var currentNode = targetNode;
						do {
							currentNode.sort = sort++;
							updateNodes.push(WinUtils.getNodeByMode(that.options.treeModel, currentNode));
						} while ((currentNode = currentNode.getNextNode()) != null)
					}
					if ($.isFunction(that.options.onDrop) && that.options.onDrop(event, treeId, treeNodes, targetNode, moveType, updateNodes) === false) {
						return false;
					}
					if (updateNodes.length == 0 || !that.options.treeUpdateUrl)
						return;
					// 更新所有要修改的菜单
					$.ajax({
						type : "POST",
						dataType : "json",
						contentType : "application/json; charset=utf-8",
						url : that.options.treeUpdateUrl,
						data : JSON.stringify(updateNodes),
						success : function(data, textStatus) {
							if (data.success) {
								$.yhDialogTip.confirm(data.title, data.reason); // 嵌套使用
							} else {
								$.yhDialogTip.error(data.title, data.reason);
							}
						}
					});
				};
			}
			if (that.options.zTreeSettings) {
				if (that.options.zTreeSettings.callback) {
					$.extend(true, that.options.zTreeSettings.callback, settings.callback);
				}
				if (that.options.zTreeSettings.view) {
					$.extend(true, that.options.zTreeSettings.view, settings.view);
				}
				// END---防止覆盖效果JS
				$.extend(true, settings, that.options.zTreeSettings);
			}
			that.options.tree = $.fn.zTree.init(that.options.treeElement, setting, that.options.json);

		},
		_parse : function() {
			var innerHtml = '<button class = "yhui-searchbox-cancel" title = "撤销查询"></button>' + '<button class = "yhui-searchbox-search" title = "关键字查询" ></button>'
					+ '<input  class = "yhui-searchbox-input" type="text" placeholder = "请输入关键字" />';

			this.element.addClass("yhui-searchbox").empty().html(innerHtml);

			var that = this, children = that.element[0].children;
			$.each("$cancel $search $input".split(" "), function(i, name) {
				that[name] = $(children[i]);
			});
		},

		_events : function() {
			var tree = this.options.tree, that = this;

			this.element.on("click" + this.eventNamespace, "button", function() {
				var arrayNodes = tree.transformToArray(tree.getNodes());
				this.originalNodes = tree.getNodes();
				$(".yhui-searchbox-input").trigger("focus");

				var value, tempValue = "", newNodes = null, input = that.$input[0];

				if (this.className.indexOf("yhui-searchbox-search") >= 0) {
					value = input.value;
					// console.log(tempValue);
					if (value !== "" && value != tempValue) {
						newNodes = $.grep(arrayNodes, function(node) {
							return node.name.indexOf(value) >= 0 && node.id != 'root';
						});
						tempValue = value;
						$(".yhui-searchbox-search").attr({
							"title" : "请输入新的关键词，再查询"
						});
					}

					if (newNodes && newNodes.length) {
						tree.destroy();
						that.newTree = $.fn.zTree.init($("#" + tree.setting.treeId), tree.setting, newNodes);
						that.$cancel.addClass("yhui-searchbox-cancel-enable");
					} else {
						alert("没有找到符合的对象！");
					}
				}

				if (this.className.indexOf("yhui-searchbox-cancel") >= 0) {
					if (that.newTree) {
						input.value = "";
						that.newTree.destroy();
						delete that.newTree;
						that.tree = $.fn.zTree.init($("#" + tree.setting.treeId), tree.setting, that.options.json);
						$(this).removeClass("yhui-searchbox-cancel-enable");
						that.$search.removeClass("yhui-searchbox-search-enable");
						$(".yhui-searchbox-search").attr({
							"disabled" : false,
							"title" : "关键字查询"
						});
					}
				}
			}).on("keydown" + this.eventNamespace, ".yhui-searchbox-input", function(e) {
				if (e.keyCode === $.ui.keyCode.ENTER) {
					e.preventDefault();
					that.$search.trigger("click");
					if (!$.yhui.isIE) {
						this.focus();
					}
				}
				if (e.keyCode === $.ui.keyCode.ESCAPE) {
					that.$cancel.trigger("click");
				}
			}).on("keyup" + this.eventNamespace, ".yhui-searchbox-input", function() {
				that.$search[this.value !== "" ? "addClass" : "removeClass"]("yhui-searchbox-search-enable");
			});
		},
		setValue : function(v) {
			var that = this;
			if (!that.tree) {
				if (!that.options.afterLoad) {
					that.options.afterLoad = function() {
						that._setValue(v);
					};
				} else {
					$.yhui.log("数据还没加载完，请在afterLoad事件中设置数据");
				}
			} else {
				that._setValue(v);
			}

		},
		_setValue : function(v) {
			var node = this.tree.getNodeByParam("id", v, null);
			this.tree.selectNode(node, false);
			// this.tree.checkNode(node, true, true);
		},
		getTree : function() {
			return this.options.tree;
		}
	});
})(jQuery);