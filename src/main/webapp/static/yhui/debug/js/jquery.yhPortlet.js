/*!
 * YHUI yhPortlet @VERSION
 *
 * Depends:
 *  jquery.ui.core
 *	jquery.ui.widget
 *	jquery.ui.sortable
 */

(function( $ ){
	var CONSTS = {
		CLASS: {
			COLUMN: "yhui-portlet-column",
			PANEL: "yhui-portlet-panel ui-widget-content",
			HEAD: "yhui-portlet-head ui-widget-header",
			TITLE: "yhui-portlet-title",
			CONTENT: "yhui-portlet-content ui-widget-content"
		},
		DATA: {
			PANEL: "panelOption"
		},
		ID: {
			PANEL: "yhui-portlet-panel"
		}
	};
	$.widget( "yhui.yhPortlet", {
		version: "@VERSION",
		
		options: {
			generateID: false,
			close: null
		},

		_create: function() {
			this._parse();
			this._sortable();
			this.element.fadeIn();
			this._events();
		},

		_parse: function() {
			this.element.addClass( "yhui-portlet ui-helper-clearfix" );
			this.column = this.element.children( "div" ).addClass( CONSTS.CLASS.COLUMN );
			this.panel = this.column.children("div").addClass( CONSTS.CLASS.PANEL );
			this.head = this.panel.children("h3").addClass( CONSTS.CLASS.HEAD );
			this.title = this.head.find("span").addClass( CONSTS.CLASS.TITLE );
			this.content = this.panel.children("div").addClass( CONSTS.CLASS.CONTENT );
			
			if ( this.options.generateID ) {
				this.column.each(function(i) {
					$(this).children("div").each(function(j) {
						if ( !this.id ) this.id = CONSTS.ID.PANEL + "_column_" + i + "_panel_" + j;
					});
				});
			}

			this._calSize();
			this._parsePanel();
		},

		_calSize: function() {
			var len = this.column.length,
				colStyle = {};
			switch ( len ) {
				case 1:
						colStyle.width = "92%";
						colStyle.marginLeft = "4%";
						colStyle.marginRight = "3%"; 
					break;
				case 2:
						colStyle.width = "47%";
						colStyle.marginLeft = "2%";
					break;
				case 3: 
						colStyle.width = "30%";
						colStyle.marginLeft = "2.5%";
					break	
			}

			this.column.css( colStyle );
		},

		_parsePanel: function() {
			var that = this;
			this.panel.each(function() {
				var options = this.children[0].getAttribute( "data-option" ),
					tempOpt1,tempOpt2, opts = {}, i = 0, l, $logo;
				
				if ( options ) {
					tempOpt1 = options.split(/\s*,\s*/);
					for ( l = tempOpt1.length; i < l; i ++ ) {
						tempOpt2 = tempOpt1[i].split(/\s*:\s*/);
						tempOpt2[1] && (opts[ tempOpt2[0] ] = tempOpt2[1] === "true" ? true : tempOpt2[1] === "false" ? false : tempOpt2[1]);
					}
					//$.data( this, CONSTS.DATA.PANEL, opts );
					if ( (typeof opts.logo) === "boolean" && !opts.logo ) {
						$logo = null;
						$.yhui.byTag( this, "h3" )[0].style.paddingLeft = "12px";
					} else if ( (typeof opts.logo) === "string" ) {
						$logo = $("<span class = 'yhui-portlet-logo " + opts.logo + "'></span>");
					} else {
						$logo = $("<span class = 'yhui-portlet-logo ui-icon ui-icon-triangle-1-e' ></span>");
					}
					that.__parsePanel( opts, this, $logo );
				}

			});
		},

		__parsePanel: function( opts, panel, $logo ) {
			if ( !opts ) return;
			var template = "<a href = '#' title = '{title}' class = 'yhui-portlet-panelcontrol ui-corner-all yhui-portlet-{btn}' >"
							+ "<span class = 'ui-icon ui-corner-all {ico}' ></span></a>",
				$head = $( panel.children[0] ),
				button = [],
				hash = {
					pop: "ui-icon-newwin",
					fold: "ui-icon-triangle-1-s",
					close: "ui-icon-close"
				},
				title = {
					pop: "弹出内容",
					fold: "折叠/展开面板",
					close: "关闭面板"
				};

			for ( var i in opts ) {
				if ( opts[i] && i !== "logo" ) {
					button.push( template.replace( /\{btn\}/, i ).replace( /\{ico\}/, hash[i] ).replace( /\{title\}/, title[i] ) );
				}
			}
			button.reverse();
			$logo ? $( button.join("") ).add($logo).appendTo( $head ) : $( button.join("") ).appendTo( $head );
		},

		_sortable: function() {
			if ( !$.ui.sortable ) return $.yhui.log( "没有 ui.sortable！" );
			var that = this;
			this.column.sortable({
				connectWith: "." + CONSTS.CLASS.COLUMN,
				tolerance: "pointer",
				handle: ".yhui-portlet-head",
				helper: function( e, ui ) {
	            	var height = $(ui).outerHeight(),
	            		width = $(ui).outerWidth();
	            	return "<div style = 'background-color: #EEE; width: {width}px; height: {height}px; border: 1px dashed #000; opacity: 0.5; filter: alpha(opacity=50);'></div>"
	            			.replace(/\{width\}/, width).replace(/\{height\}/, height);
	            },
	            start: function() {
	            	$.yhui.isIE6 && that.head.css( "zoom", 0 );
	            },
	            stop : function() {
	            	$.yhui.isIE6 && that.head.css( "zoom", 1 );
	            }
			});
		},

		_events: function() {
			var that = this;
            that.element.on( that._namespace("mouseenter mouseleave"), "a.yhui-portlet-panelcontrol", function() {
				$(this).toggleClass( "ui-state-hover" );
			});

            that.element.on( that._namespace("click"), "h3>a", function(e) {
                e.preventDefault();
                var className = this.className;
                if ( className.indexOf("fold") > -1 ) {
                    that._fold( this );
                }
                if ( className.indexOf("pop") > -1 ) {
                    that._pop( this );
                }
                if ( className.indexOf("close") > -1 ) {
                    that._close( this );
                }
            });
		},

        _namespace: function( event ) {
            return $.yhui.parseEventType( event, this.eventNamespace );
        },

        _fold: function( a ) {
            $.yhui.isIE6 && this.head.css( "zoom", 0 );
            $(a)
                .find("span" ).toggleClass( "ui-icon-triangle-1-s ui-icon-triangle-1-n" ).end()
                .parents("h3").toggleClass( "noBorderBottom" ).next().toggle();
            $.yhui.isIE6 && this.head.css( "zoom", 1 );
        },

        _pop: function( a ) {
            var $hold = $(a).parents("h3"), $content = $hold.next(),
                $panel = $hold.parent(),
                title = $(a).siblings("span")[0].innerHTML;

            this._createPop( title, $hold, $content, $panel );
        },

        _close: function( a ) {
            $.yhui.isIE6 && this.head.css( "zoom", 0 );
            $(a).closest(".yhui-portlet-panel")
                .find("iframe").remove().end()
                .removeData().remove();
            $.yhui.isIE6 && this.head.css( "zoom", 1 );
        },

		_createPop: function( title, $hold, $content, $panel ) {
			var height = $(window).height() - 100,
				width = $(window).width() - 200,
				$append = $content.children("*"),
                that = this;
			
			var dialogOption = {
				title: title,
				width: width,
				height: height,
				modal: true,
				resizable: false,
				open: function() {
					var height = $panel.height();
					$panel.css( "height", height + "px" );
					if ( $append.length === 1 && $append[0].nodeName.toLowerCase() === "iframe" ) {
                        that.iframe || (that.iframe = true);
                        $append.hide();
                        $("<iframe style='height:100%;width:100%' frameborder='0'></iframe>" )
                            .appendTo(this)
                            .prop( "src", $append.prop("src") );
                        $(this).css("overflow","hidden");
                    } else {
                        $append.appendTo(this);
                    }
				},
				close: function() {
                    if ( that.iframe ) {
                        $(this).css("overflow","auto" ).find("iframe").remove();
                        $append.prop( "src", $append.prop("src") ).show();
                    } else {
					    $append.appendTo( $content );
                    }
					$panel.css( "height", "auto" );
				}
			};
			
			if ( !this.$dialog ) {
				this.$dialog = 
					$("<div class = 'yhui-portlet-dialog'></div>").appendTo( this.document[0].body )
						.dialog( dialogOption );
			} else {
				this.$dialog.dialog( "destroy" ).dialog( dialogOption );
			}
		},

		getOrder: function( json ) {
			var columeLength = this.column.length,
				i = 0, ret = {};
			for ( ; i < columeLength; i++ ) {
				ret["column" + i] = [];
				this.column.eq(i).children("div").each(function() {
					if ( this.id ) {
						ret["column" + i].push( this.id );
					} else {
						$.yhui.log( "面板id为空，portlet 可能记忆错误的位置。" );
					}
				});
			}

			if ( json === "json" ) {
				ret = JSON.stringify( ret );
			}
			return ret;
		}
	});
})( jQuery );