/*!
 * YHUI yhCheckBoxTree @VERSION
 *
 * Depends:
 *  jquery.ui.core
 *  jquery.ui.widgte
 *  zTree
 */
(function($, undefined) {
	$.widget("yhui.yhCheckBoxTree", {
		version : "@VERSION",
		options : {
			hiddenId : null,
			toolbar : null,
			store : null,
			zTreeSettings : null,
			store : null,
			expandLevel : null,// 比expandAll优先
			expandAll : true,
			height:null,
			// callback
			beforeLoad : null,
			afterLoad : null,
			beforeCollapse : null,
			beforeExpand : null,
			beforeClick : null,
			onClick : null
		},
		_create : function() {
			var that = this;
			var toolbar = $.type(that.options.toolbar) == 'string' ? $("#" + that.options.toolbar) : this.options.toolbar;
			that.toolbar = toolbar ? toolbar : $("<div  class=\"yhui-toolbar\"></div>");
			that.ztreeEle = $("<ul class=\"ztree\"></ul>");
			that.hidden = $("<input type=\"hidden\"  name=\"" + that.options.hiddenId + "\" />");
			this.element.append(that.hidden).append(that.toolbar).append(that.ztreeEle);
			if(that.options.height){
				that.element.css("overflow","auto");
				this.element.height(that.options.height);
			}
			if (this.options.store) {
				var store = $.yhStore.get(that.options.store.name);
				that.store = store;
				if (that.store.data) {
					that.nodes = that.store.data;
					if ($.isFunction(that.options.beforeLoad)&&that.options.beforeLoad(that)===false) {
						return false;
					}
					that._parseTree();
				} else {
					var initDataFunc = that.store.triger.initData;
					that.store.triger.initData = function(_store) {
						if (initDataFunc && $.isFunction(initDataFunc)&&initDataFun(_store)===false) {
							return false;
						}
						that.nodes = _store.data;
						that._parseTree();
					};
				}
			} else {
				this._getNodes();
			}

		},

		_parseTree : function() {
			var that = this;
			var settings = {
				view : {
					showIcon : false
				},
				check : {
					enable : true,
					checkType : {
						"Y" : "",
						"N" : ""
					},
					checkStyle : "checkbox",
					checkRadioType : "all",
				},
				async : {
					enable : false,// 异步获取数据
				}
			};
			if (that.options.zTreeSettings) {
				$.extend(true, settings, that.options.zTreeSettings);
			}
			that.tree = $.fn.zTree.init(that.ztreeEle, settings,that.nodes);
//			that.tree = that.ztreeEle.yhTree(settings, that.nodes).yhTree("getTree");
			if (that.options.expandLevel) {
				$.yhui.expandTreeNode(that.tree.getNodes(), that.tree, that.options.expandLevel);
			} else {
				that.tree.expandAll(that.options.expandAll);
			}
		},

		_getNodes : function() {
			var that = this;
			if ($.isFunction(that.options.beforeLoad)) {
				that.options.beforeLoad(that);
			}
			if (typeof this.options.source === "string") {
				$.getJSON(this.options.source).success(function(nodes) {
					that.nodes = nodes;
					that._parseTree();
					if ($.isFunction(that.options.afterLoad)) {
						that.options.afterLoad(that, nodes);
					}
				}).error(function(m1, m2) {
					$.yhui.log(m2);
				});
			} else {
				this.nodes = this.options.source;
				this._parseTree();
			}
		},

		getTree : function() {
			return this.tree || null;
		},

		setValue : function(v) {
			var that = this;
			if (!that.tree) {
				if (!that.options.afterLoad) {
					that.options.afterLoad = function() {
						that._set2Value(v);
					};
				} else {
					$.yhui.log("数据还没加载完，请在afterLoad事件中设置数据");
				}
			} else {
				that._set2Value(v);
			}

		},
		_set2Value : function(v) {
			this.tree.cancelSelectedNode();
			if ($.type(v) == 'undefined' || v === '') {
				this.hidden.val("");
			} else if ($.isArray(v)) {// 数组
				for (var i = 0; i < v.length; i++) {
					var kv = v[i];
					if ($.type(kv) == 'object' && kv["id"]) {
						var node = this.tree.getNodeByParam("id", kv["id"], null);
						if (node) {
							this.tree.checkNode(node, true, null, true);
						}
					} else if ($.type(kv) == 'string' && kv) {
						var node = this.tree.getNodeByParam("id", kv, null);
						if (node) {
							this.tree.checkNode(node, true, null, true);
						}
					}
				}
			} else if ($.type(v) == 'string' && v.indexOf(',') > 0) {// 带逗号分隔的字符串
				// 设置ID
				if (v.substring(v.length - 1, v.length) == ',') {
					this.hidden.val(v.substring(0, v.length - 1));
				} else {
					this.hidden.val(v);
				}
				var kvs = v.split(',');
				for (var i = 0; i < kvs.length; i++) {
					var kv = kvs[i];
					if (kv != '') {
						var node = this.tree.getNodeByParam("id", kv, null);
						if (node) {
							this.tree.checkNode(node, true, null, true);
						}
					}
				}
			} else {// 设置单个值
				var node = this.tree.getNodeByParam("id", v, null);
				if (node) {
					this.tree.checkNode(node, true, null, true);
				}
			}
		},
		collectData:function(){
			var selectNodes = this.tree.getCheckedNodes();
			var ids = "";
			for(var i=0 ;i<selectNodes.length ;i++){
				ids += selectNodes[i].id + ",";
			}
			this.hidden.val(ids);
		}
	});
})(jQuery);
