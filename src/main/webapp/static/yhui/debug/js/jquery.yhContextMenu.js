/*!
 * YHUI yhContextMenu @VERSION
 *
 * Depends:
 *  jquery.ui.core
 *	jquery.ui.widget
 */
(function( $ ){
	var funId = 0, menuId = 0;
    $.widget( "yhui.yhContextMenu", {
        version: "@VERSION",
		options: {
            eventNamespace: "",
			menu: null,
			width: 150,
            zIndex: 200,

			//callback
			beforeShow: null,
            createdMenu: null,
            show: null,
            beforeHide: null,
            hide: null,
            beforeLoad:null,
            afterLoad:null
		},

        _create: function() {
        	var that = this;
            this.menuId = "yhui-menu-" + (menuId++);
            this.element.attr( "hascontextmenu", this.menuId );
            if(this.options.store){
            	var store = $.yhStore.get(that.options.store.name);
				that.store = store;
            	if(that.store.data){
            		that.options.menu = that.store.data;
            		that._context();
            	}else{
            		var initDataFun = that.store.triger.initData;
            		that.store.triger.initData = function(_store){
            			if(initDataFun&&$.isFunction(initDataFun)){
            				initDataFun(that.store);
            			}
            			that.options.menu = that.store.data;
            			that._context();
            		};
            	}
            }else {
            	that._context();
            }
            
		},

		_parse: function() {
			var menu = this.options.menu;
			if ( !menu ) {
				return $.yhui.log( "menu属性不是有效值" );
			}
			if($.isFunction(this.options.beforeLoad)){
            	that.options.afterLoad(this,menu);
            }
            this.windowSize = {
                width : $(window).width(),
                height: $(window).height()
            };

			if ( $.isPlainObject( menu ) ) {
				this._createMenu( menu );
                this._events();
			}
			if($.isFunction(this.options.afterLoad)){
            	that.options.afterLoad(this,menu);
            }
		},

		_createMenu: function( menu ) {
			var $menuItem = $(), that = this;
            this.funCache = {};

			$.each( menu, function( label, fun ) {
                var id = funId ++;
                that.funCache[ id ] = fun;
				$menuItem = $menuItem.add( $("<li><a data-funid = " + id + " href = '#'>"+ label +"</a></li>") );
			});

            this.menu = $("<ul></ul>")
                            .attr( "id", this.menuId )
							.width( this.options.width )
							.addClass( "yhui-contextmenu" )
							.append( $menuItem )
							.appendTo( document.body )
							.menu()
							.hide();

            this._trigger( "createdMenu", null, this._getEventParam() );
		},

        _context: function() {
            var that = this,
                namespace = this.options.eventNamespace ? "." + this.options.eventNamespace : this.eventNamespace;

            
            //bind contextmenu
            this.element.on( "contextmenu" + namespace, function( e ) {
                that.eventObj = e;
                if ( !that.menu ) {
                    that._parse();
                }
                that._showMenu( e );
                return false;
            });
        },

        _events: function() {
            var that = this,
                namespace = this.options.eventNamespace ? "." + this.options.eventNamespace : this.eventNamespace;

            //hide menu when click any position
            this.document
                .on( "click" + namespace + " contextmenu" + namespace, function() {
                    that.hideMenu();
                })
                .on( "keydown" + namespace, function(e) {
                    if ( e.keyCode === $.ui.keyCode.ESCAPE ) {
                        that.hideMenu();
                    }
                });

            this.menu.on( "click" + namespace, "a", function( e ) {
            	e.preventDefault();
            	var fun = that.funCache[ this.getAttribute("data-funid") ];
                if ( fun && typeof fun === "function" ) {
            		fun.call( this, e, that.eventObj.target, that.element );
            	}
            });

            this.window.on( "resize" + namespace, function() {
                that.hideMenu();
                that.windowSize = {
                    width : $(window).width(),
                    height: $(window).height()
                };
            });

         },

        _showMenu: function( e ) {
            var that = this,
                position = this._calPosition( e.pageX, e.pageY ),
                zIndex = that.options.zIndex;

            if ( this._trigger( "beforeShow", null, this._getEventParam() ) === false ) return;

            if ( zIndex && zIndex < 200 ) zIndex = 200;

            this.menu.css({
            	position : "absolute",
            	zIndex: zIndex,
                top : position.top + "px",
                left: position.left + "px"
            }).show();

            this._trigger( "show", null, this._getEventParam() );
		},

        _calPosition: function( left, top ) {
            var ret = {},
                width = this.menu.width(),
                height = this.menu.height(),
                dValueX, dValueY;

            if ( (dValueX = left + width - this.windowSize.width) > 0 ) {
                ret.left = left - dValueX - 6;
            } else {
                ret.left = left;
            }

            if ( (dValueY = top + height - this.windowSize.height) > 0 ) {
                ret.top = top - dValueY - 6;
            } else {
                ret.top = top;
            }
            
            return ret;
        },

        hideMenu: function() {
            if ( this.menu.is( ":visible" ) && this._trigger("beforeHide",null,this._getEventParam()) !== false ) {
                this.menu.hide().css({
                    top : "-1000px",
                    left: "-1000px"
                });
                this._trigger( "hide", null, this._getEventParam() );
            }
        },

        _getEventParam: function() {
            return {
                target: this.eventObj.target,
                menu: this.menu,
                container: this.element
            };
        },

        _disableItem: function( index ) {
        	this.menu.find("a").eq( index ).addClass("ui-state-disabled").on( "click.disable mouseenter.disable mouseleave.disable", function() {
    			return false;
    		});
        },

        _enableItem: function( index ) {
        	this.menu.find("a").eq( index ).removeClass("ui-state-disabled").off( ".disable" );
        },

        disableItem: function( index ) {
        	if ( typeof index === "number" ) {
        		this._disableItem( index );
        	} else {
        		var i = 0, l = index.length;
        		for ( ; i < l; i++ ) {
        			this._disableItem( index[i] );
        		}
        	}
        },

        enableItem: function( index ) {
        	if ( typeof index === "number" ) {
        		this._enableItem( index );
        	} else {
        		var i = 0, l = index.length;
        		for ( ; i < l; i++ ) {
        			this._enableItem( index[i] );
        		}
        	}
        },

        isItemDisable: function( index ) {
            return this.menu.find("a").eq( index ).hasClass( "ui-state-disabled" );
        }
    });
})(jQuery);