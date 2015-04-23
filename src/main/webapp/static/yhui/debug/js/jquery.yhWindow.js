/*!
 * YHUI yhWindow @VERSION
 *
 * Depends:
 *  jquery.ui.core
 *	jquery.ui.widget
 *	jquery.ui.dialog
 */
(function($) {
	var isFirstUl = true, yhWindowTaskBar = null, yhWindowTaskBarUl = null, yhWindowTaskBarFirstShow = true, yhWindowCache = {}, consts = {
		id : {
			LI : "yhwindow-taskbarlist-"
		},
		className : {
			SARROW : "ui-icon-triangle-1-s",
			NARROW : "ui-icon-triangle-1-n",
			MAXI : "ui-icon-newwin",
			RESTORE : "ui-icon-yhmaxi"
		}
	};

	$.widget("yhui.yhWindow", $.ui.dialog, {
		version : "@VERSION",
		options : {
			maxi : true,
			mini : true,
			fold : true,
			showTaskBar : true,
			dragHelper : true,
			fixedMaxHeight : 0,// 修正最大化时额外减去的高度
			// callback
			beforeMaxi : null,
			beforeMini : null
		},

		_create : function() {
			this._super();
			this._parse();
			this._events();
		},

		_parse : function() {

			if (this.options.showTaskBar) {
				isFirstUl && this._createBottomUl();
			}
			$("<em class='ui-dialog-titlebar-ico'></em>").prependTo(this.uiDialogTitlebar);
			this.uiDialogTitlebar.parent().addClass("ui-dialog-border");
			if (this.options.maxi) {
				this.maxi = $("<a class = 'ui-dialog-titlebar-maxi ui-corner-all' href='#' role = 'maxi'>" + "<span class = 'ui-icon ui-icon-yhmaxi'>maxi</span>" + "</a>")
						.appendTo(this.uiDialogTitlebar);
			}

			if (this.options.showTaskBar && this.options.mini) {
				this.mini = $("<a class = 'ui-dialog-titlebar-mini ui-corner-all' href='#' role = 'mini'>" + "<span class = 'ui-icon ui-icon-minusthick'>mini</span>" + "</a>")
						.appendTo(this.uiDialogTitlebar);
			}

			if (this.options.fold) {
				this.fold = $("<a class = 'ui-dialog-titlebar-fold ui-corner-all' href='#' role = 'fold'>" + "<span class = 'ui-icon ui-icon-triangle-1-n'>fold</span>" + "</a>")
						.appendTo(this.uiDialogTitlebar);
			}
			this.fixedMaxHeight = this.options.fixedMaxHeight;
		},

		_createBottomUl : function() {
			(yhWindowTaskBar = $("<div class = 'yhui-window-taskbar'><div id = 'yhWindowTaskBarWrap' class = 'yhui-window-taskbar-inner'></div></div>"))
					.appendTo(this.document[0].body);
			(yhWindowTaskBarUl = $("<ul id = 'yhWindowTaskBar' ></ul>")).appendTo($("#yhWindowTaskBarWrap"));
		},

		_events : function() {
			var that = this;
			this._hoverable(this.fold);
			this._hoverable(this.maxi);
			this._hoverable(this.mini);
			this._recordSizeInfo();

			this.uiDialogTitlebar.on("click" + this.eventNamespace, "a", function(e) {
				if (this.className.indexOf("ui-dialog-titlebar-close") > -1)
					return;
				e.preventDefault();

				switch (this.getAttribute("role")) {
				case "fold":
					$(this).children("span").toggleClass(consts.className.SARROW + " " + consts.className.NARROW);
					that.maxi && that.maxi.toggle();
					(that.titleBarHeight !== that.uiDialog.height()) ? that.uiDialog.animate({
						"height" : that.titleBarHeight
					}) : that.uiDialog.animate({
						"height" : that.sizeInfo.height
					});
					break;
				case "mini":
					that._trigger("beforeMini", null, that._getParam());
					that.uiDialog.hide("transfer", {
						to : $("#" + consts.id.LI + that.uuid)
					}, function() {
						$(this).fadeOut(100);
					});
					break;
				case "maxi":
					$(this).children("span").toggleClass(consts.className.MAXI + " " + consts.className.RESTORE);
					that.fold && that.fold.toggle();
					that.isMaxi ? that._restore() : that._maxi();
					break;
				}
			});

			this.window.on("resize" + that.eventNamespace, function() {
				if (that.isMaxi) {
					setTimeout(function() {
						that._maxi();
					}, 20);
				}
			});

			if (this.options.showTaskBar && isFirstUl) {

				yhWindowTaskBarUl.on("click" + that.eventNamespace, function(e) {
					var nodeName = e.target.nodeName.toLowerCase();
					if (nodeName === "ul")
						return;
					if (nodeName === "li") {
						yhWindowCache[e.target.id].uiDialog.fadeIn(100);
						yhWindowCache[e.target.id].moveToTop(true);
					}
					if (nodeName === "span") {
						var id = e.target.parentNode.id;
						yhWindowCache[id].close();
					}
				});

				this._contextMenu();

				isFirstUl = false;
			}
		},

		_restore : function() {
			this.uiDialog.offset({
				top : this.sizeInfo.top,
				left : this.sizeInfo.left
			});
			this.uiDialog.width(this.sizeInfo.width);
			this.element.height(this.sizeInfo.height - this.titleBarHeight);
			this.isMaxi = false;
		},

		_maxi : function() {
			this._trigger("beforeMaxi", null, this._getParam());
			this.uiDialog.offset({
				top : 0,
				left : 0
			}).width($(window).width() - 2).css("height", "auto");
			this.element.height($(window).height() - (yhWindowTaskBar ? yhWindowTaskBar.outerHeight() : 0) - this.titleBarHeight - this.fixedMaxHeight);
			this.isMaxi = true;
		},

		_contextMenu : function() {
			var that = this, contextMenu = {
				"关闭当前" : function(e, target) {
					var id = that._getTaskItemId(target);
					yhWindowCache[id].close();
				},

				"关闭其他" : function(e, target) {
					var id = that._getTaskItemId(target);
					for ( var name in yhWindowCache) {
						if (name !== id)
							yhWindowCache[name].close();
					}
				},

				"关闭全部" : function() {
					for ( var name in yhWindowCache) {
						yhWindowCache[name].close();
					}
					yhWindowTaskBar.slideUp();
				}
			};

			yhWindowTaskBarUl.yhContextMenu({
				menu : contextMenu,
				width : 100,
				zIndex : 2001,
				eventNamespace : "yhWindow",
				beforeShow : function(e, yhui) {
					var len = $(yhui.target.parentNode).find("li").length;
					if (yhui.target.nodeName.toLowerCase() === "ul") {
						return false;
					}

					if (len === 1) {
						$(this).yhContextMenu("disableItem", 1);
					} else {
						$(this).yhContextMenu("isItemDisable", 1) && $(this).yhContextMenu("enableItem", 1);
					}
				}
			});

		},

		_getTaskItemId : function(target) {
			return target.nodeName.toLowerCase() === "span" ? target.parentNode.id : target.id;
		},

		_getParam : function() {
			return {
				window : this,
				taskBar : yhWindowTaskBar ? yhWindowTaskBar : null
			};
		},

		open : function(title) {
			this._super();

			if (this.options.showTaskBar) {
				var $taskList;
				(yhWindowTaskBarFirstShow || yhWindowTaskBarUl.children("li").length === 0) && yhWindowTaskBar.slideDown();
				$taskList = $("<li></li>").text(this.originalTitle).attr({
					"title" : this.originalTitle,
					"id" : consts.id.LI + this.uuid
				}).hide().appendTo(yhWindowTaskBarUl).delay(100).show(200);

				$("<span title = '关闭'></span>").appendTo($taskList);

				yhWindowTaskBarFirstShow = false;
				yhWindowCache[consts.id.LI + this.uuid] = this;
			}

			this.sizeInfo = {
				left : this.uiDialog.offset().left,
				top : this.uiDialog.offset().top,
				width : this.uiDialog.outerWidth(),
				height : this.uiDialog.outerHeight()
			};
			this.titleBarHeight = this.uiDialogTitlebar.outerHeight();
			this.option("title", title);
		},

		close : function() {
			this._super();

			if (this.options.showTaskBar) {
				if (yhWindowTaskBarUl.children("li").length !== 1) {
					$("#" + consts.id.LI + this.uuid).hide(300, function() {
						$(this).remove();
					});
				} else {
					$("#" + consts.id.LI + this.uuid).hide(300, function() {
						$(this).remove();
						yhWindowTaskBar.slideUp();
					});
				}
			}
		},

		_recordSizeInfo : function() {
			var that = this;
			this.uiDialog.on("resizestop" + this.eventNamespace, function() {
				var $self = $(this);
				that._delay(function() {
					that.sizeInfo.width = $self.outerWidth();
					that.sizeInfo.height = $self.outerHeight();
				}, 20);
			});
			this.uiDialog.on("dragstop" + this.eventNamespace, function() {
				var $self = $(this);
				that._delay(function() {
					var offset = $self.offset();
					that.sizeInfo.top = offset.top;
					that.sizeInfo.left = offset.left;
				}, 20);
			});
		},

		destroy : function() {
			this.window.off(this.eventNamespace);
			this.uiDialog.off(this.eventNamespace);
			this.uiDialogTitlebar.off(this.eventNamespace);
			this._super();
		}
	});

})(jQuery);