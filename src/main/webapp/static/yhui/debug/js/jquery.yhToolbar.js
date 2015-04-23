/**
 * 工具栏
 * @author zhangy
 */
(function($, undefined) {

	var Toolbar = function(config) {
		// 承载容器
		this.renderTo = typeof config.renderTo == "string" ? $("#" + config.renderTo) : config.renderTo;
		// 子组件
		this.items = [];
		this.listeners = {};
		this.config = config;
		if(this.config.listeners){
			// 渲染前事件
			if (this.config.listeners.beforeLoad && $.isFunction(this.config.listeners.beforeLoad )) {
				this.listeners.beforeLoad = this.config.listeners.beforeLoad;
			}
			// 渲染后事件
			if (this.config.listeners.afterLoad && $.isFunction(this.config.listeners.afterLoad )) {
				this.listeners.afterLoad = this.config.listeners.afterLoad;
			}
		}
	};
	
	Toolbar.prototype = {
		init : function() {
			// 工具按钮层
			this.toolbar = $("<div/>");
			this.toolbar.addClass("toolbar");
			this.toolbar.appendTo(this.renderTo);
			this.renderTo.bar = this;
			if(!this.config||!this.config.items){
				return;
			}
			this.toolbar.rightContainer = $("<span/>").addClass("rightContiainer");
			this.toolbar.rightContainer.appendTo(this.toolbar);
			// 循环子组件
			for (var i = 0, len = this.config.items.length; i < len; i++) {
				this.add(this.config.items[i]);
			}
		},
		render : function() {
			if(this.listeners.beforeLoad){
				this.listeners.beforeLoad(this);
			}
			
			this.init();
			// 渲染后事件
			if(this.listeners.afterLoad){
				this.listeners.afterLoad(this);
			}
			return this;
		},
		add : function(t) {
			var toolbarEntity = this;
			if (t == "-") {
				$("<span/>").addClass("spacer").appendTo(toolbarEntity.toolbar);
			} else {
				var item = null;
				if (t.type == "button") {
					
					var container = $("<span/>");
					item = $("<a/>").appendTo(container);
					item.container = container;
					if(t.align=="right"){
						container.appendTo(toolbarEntity.toolbar.rightContainer);
					}else{
						container.appendTo(toolbarEntity.toolbar);
					}
					item.text(t.text);
					if (t.bodyStyle) {
						item.addClass(t.bodyStyle);
					}
					if (t.title) {
						item[0].title = t.title;
					}
					// 是否有权限
					if (t.useable != "F") {
						container.addClass("btn");
						item.on("mousedown", function() {
							container.addClass("down");
						});
						item.on("mouseup mouseout", function() {
							container.removeClass("down");
						});
						if (t.listeners) {
							for ( var k in t.listeners) {
								item.on(k, t.listeners[k]);
							}
						}
					} else {
						item.attr("disabled", true);
						container.addClass("toolbar_disabled");
					}
				} else if (t.type == "textfield") {
					item = $("<input />");
					item.attr("id", t.id);
					item.attr("name", t.id);
					item.attr("type", "text");
					item.addClass("textfield");
					item.appendTo(toolbarEntity.toolbar);
					if (t.bodyStyle) {
						item.addClass(t.bodyStyle);
					}
					if (t.listeners) {
						for ( var k in t.listeners) {
							item.on(k, t.listeners[k]);
						}
					}
				} else {
					item = $(t.html);
					item.appendTo(toolbarEntity.toolbar);
					if (t.listeners) {
						for ( var k in t.listeners) {
							item.on(k, t.listeners[k]);
						}
					}
				}
				item.parent = toolbarEntity;
				item.config = t;
				this.setItemsFun(item);
				this.items.push(item);
			}
		},
		setItemsFun:function(item){
			item.setAlign=function(align){
				item.align = align;
				if(item.align=="right"){
					item.container.appendTo(item.parent.toolbar.rightContainer);
				}else{
					item.container.appendTo(item.parent.toolbar);
				}
			};
			item.setDisabled=function(dis){
				if (dis) {
					item.attr("disabled", dis).off("click");
					item.off("mouseup mousedown mouseout click");
					item.container.removeClass("btn");
					item.container.addClass("toolbar_disabled");
				} else {
					item.removeAttr("disabled");
					item.container.addClass("btn");
					item.container.removeClass("toolbar_disabled");
					item.on("mousedown", function() {
						item.container.addClass("down");
					});
					item.on("mouseup mouseout", function() {
						item.container.removeClass("down");
					});
					var listeners = item.config.listeners;
					if (listeners) {
						for ( var k in listeners) {
							item.on(k, listeners[k]);
						}
					}
				}
			};
		},
		setDisabled : function(index, dis) {
			var item = this.items[index];
			if (item) {
				if (dis) {
					item.attr("disabled", dis).off("click");
					item.off("mouseup mousedown mouseout click");
					item.container.removeClass("btn");
					item.container.addClass("toolbar_disabled");
				} else {
					item.removeAttr("disabled");
					item.container.addClass("btn");
					item.container.removeClass("toolbar_disabled");
					item.on("mousedown", function() {
						item.container.addClass("down");
					});
					item.on("mouseup mouseout", function() {
						item.container.removeClass("down");
					});
					var listeners = item.config.listeners;
					if (listeners) {
						for ( var k in listeners) {
							item.on(k, listeners[k]);
						}
					}
				}
			}
		},
		getDisabled : function(index) {
			return this.items[index].attr("disabled");
		}
	};

	$.fn.yhToolbar = function(options) {
		var arg = arguments[1] || 0;

		if (typeof options === "string") {
			var toolbarObj = $.data(this[0], "yhToolbar");

			if (options === "disable") {
				toolbarObj.setDisabled(arg, true);
				return this;
			} else if (options === "enable") {
				toolbarObj.setDisabled(arg, false);
				return this;
			} else if (options === "isDisable") {
				return !!toolbarObj.getDisabled(arg);
			} else if (options === "getItems") {
				return toolbarObj.items;
			} else if (options === "addItem") {
				return toolbarObj.add(arg);
			} else {
				return $.yhui.log("yhToolbar没有" + options + "方法");
			}
		}

		return this.each(function() {
			$.extend(options, {
				renderTo : $(this)
			});
			var toolbar = new Toolbar(options);
			toolbar.render();
			$.data(this, "yhToolbar", toolbar);
		});

	};
})(jQuery);