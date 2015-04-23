/*!
 * YHUI yhMenu @VERSION
 * imitate zTree and salute zTree
 * Depends:
 *  jquery.ui.core
 *	jquery.ui.widget
 */

(function( $ ){
	var caches = {}, roots = {}, mId = 0, that;

	$.widget("yhui.yhMenu",{
        version: "@VERSION",
		options: {
			durationIn: 80,
			durationOut: 10,
			timeToIn: 300,
			url:"",

			// callback
			beforeInit: null,
			beforeLoad:null,
            afterLoad:null,
			onClick: $.noop
		},
		
		_consts: {
			id: {
				ID: "_yhmenu_",
				A: "_a",
				SPAN: "_span",
				UL: "_ul"
			}
		},
		
		_create: function() {
			that = this;
			this.element.addClass( "yhui-menu-firstul ui-helper-clearfix" ).empty();
			this.menuId = this.element[0].id;
			if(this.options.store){
				var store = $.yhStore.get(that.options.store.name);
				that.store = store;
				if(that.store.data){
					data = that.store.data;
            		that._trigger( "beforeInit", null, {data:data} );
					that._parse( data );
					if($.isFunction(that.options.afterLoad)){
		            	that.options.afterLoad(that,data);
		            }
            	}else{
            		var initDataFun = that.store.triger.initData;
            		that.store.triger.initData = function(_store){
            			if(initDataFun && $.isFunction(initDataFun)){
            				initDataFun(that.store);
            			}
            			that._trigger( "beforeInit", null, {data:data} );
            			data = that.store.data;
    					that._parse( data );
            		};
            	}
			}else{
				this._ajaxData();
			}
			
			
		},
		
		_parse: function( data ) {
			var nodes, root;
			if ( data !== null ) {
				nodes = $.yhui.clone( data );
			}
			this._root.initRoot( this.menuId );
			root = this._root.getRoot( this.menuId );
			root.children = nodes;
			
			this._cache.initCache( this.menuId );
			this._event.bindEvent( this.menuId );
			
			if ( root.children && root.children.length > 0 ) {
				this._view.createNodes( this.menuId, 0, root.children );
			} 
		},
		
		_data:{
			initNode: function( menuId, level, n, parentNode, isFirstNode, isLastNode ) {
				if ( !n ) return;
				n.level = level;
				n.mId = menuId + that._consts.id.ID + (++mId);
				n.parentMId = parentNode ? parentNode.mId : null;
				if ( n.children && n.children.length > 0 ) {
					n.isParent = true;
				}
				n.isFirstNode = isFirstNode;
				n.isLastNode = isLastNode;
				//n.getParentNode = function() {return data.getNodeCache(setting, n.parentTId);};
				//n.getPreNode = function() {return data.getPreNode(setting, n);};
				//n.getNextNode = function() {return data.getNextNode(setting, n);};
				//data.fixPIdKeyValue(setting, n);
			},
			
			addNodeCache: function( menuId, node ){
				that._cache.getCache( menuId ).nodes[node.mId] = node;
			},
			
			getNodeCache: function( menuId, mId ) {
				if (!mId) return null;
				var n = caches[ menuId ].nodes[ mId ];
				return n ? n : null;
			}
			
		},
		
		_view:{
			createNodes: function( menuId, level, nodes, parentNode ){
				if( !nodes || nodes.length === 0 ) return;
				var root = that._root.getRoot( menuId),
					zTreeHtml = this.appendNodes( menuId, level, nodes, parentNode, true, true );
                root.createdNodes = [];
				that.element.append( zTreeHtml.join("") );	
			},
			
			appendNodes: function( menuId, level, nodes, parentNode, initFlag, openFlag ){
				if ( !nodes ) return [];
				var html = [];
				for ( var i = 0, l = nodes.length; i < l; i ++ ) {
					var node = nodes[i],
						tmpPNode = parentNode ? parentNode : that._root.getRoot( menuId ),
						tmpPChild = tmpPNode.children,
						isFirstNode = ((tmpPChild.length == nodes.length) && (i == 0)),
						isLastNode = (i == (nodes.length - 1));
					that._data.initNode( menuId, level, node, parentNode, isFirstNode, isLastNode );
					that._data.addNodeCache( menuId, node );	
					if ( node.children && node.children.length > 0 ) {
						that._view.appendNodes( menuId, level + 1, node.children, node, initFlag, false );
					}
					if ( openFlag ) {
						html.push( "<li id='", node.mId, "' class='yhui-menu-firstli ", 
									!this.isShowRightArrow( node ) ? "yhui-menu-aligncenter" : 0,
									" level", node.level, "' ><a id='", node.mId + that._consts.id.A ,"' >", 
									node.name, "</a>" );
						this.isShowRightArrow( node ) && html.push("<span>»</span>");
						html.push( "</li>" );	
					}
				}
				return html;
			},
			
			isShowRightArrow: function( node ) {
				return node.isParent;
			},
			
			expandNode: function( node, children ) {
				var html = [],
					isNotZeroLevel = ( node.level === 0 ) ? "" : "yhui-menu-thiul";
					
				html.push( "<ul id='", node.mId + that._consts.id.UL, "' class = 'yhui-menu-secul ", isNotZeroLevel, " level", node.level, "' >" );
				for ( var i = 0, l = children.length; i < l; i ++ ) {
					var n = children[i], title = "";
					if ( n.name.length > 10 ) {
						title = "title='" + n.name + "'";
					}
					html.push( "<li " + title + " id = '", n.mId ,"' class = 'level", n.level, "' >" );
					html.push( "<a id = '", n.mId + that._consts.id.A,"' >", n.name, "</a>");
					this.isShowRightArrow( n ) && html.push("<span>»</span>");
					html.push( "</li>" );
				}
				html.push( "</ul>" );
				return html;
			},
			
			fixIE6: function( li, level , leaveFlag ) {
				var className = ( level === 0 ? "yhui-menu-firhover" : "yhui-menu-seclihover" );
				if ( leaveFlag ) {
					$(li).removeClass( className );
					return;
				}
				if ( level === 0 ) { 
					$(li).addClass( className ).children( "a" ).addClass( "hover" )
						.siblings("li").removeClass( className ).children( "a" ).removeClass( "hover" );
				} else {
					$(li).addClass( className ).siblings("li").removeClass( className );
				}	
			}
		},
		
		_root: {
			initRoot: function( menuId ) {
				var r = this.getRoot( menuId );
				if ( !r ) {
					r = {};
					this.setRoot( menuId, r );
				}
				r.children = [];
				r.createdNodes = [];
			},
			getRoot: function( menuId ) {
				return menuId ? roots[ menuId ] : null;
			},
			setRoot: function( menuId, root ) {
				roots[ menuId ] = root;
			}
		},
		
		_cache: {
			initCache: function( menuId ) {
				var c = this.getCache( menuId );
				if ( !c ) {
					c = {};
					this.setCache( menuId, c );
				}
				c.nodes = [];
				c.doms = [];
			},
			
			getCache: function( menuId ) {
				return menuId ? caches[ menuId ] : null;
			},
			
			setCache: function( menuId, cache ) {
				caches[ menuId ] = cache;
			}
		},
		
		_event:{
			bindEvent: function() {
				that.element.off( ".yhmenu", this.proxy );
				that.element.off( "mouseleave", this.proxy );
				that.element.on( "click.yhmenu", this.proxy );
				that.element.on( "mouseenter.yhmenu", "li", this.proxy );
				that.element.on( "mouseleave.yhmenu", "li", this.proxy );
				that.element.on( "dbclick.yhmenu", "li", function() { return false;} );
				that.element.on( ($.support.selectstart ? "selectstart" : "mousedown" ) + ".yhmenu", "li", function(e) {
					e.preventDefault();
				});
			},
			
			proxy: function( e ) {
				var li = this,
					node = that._data.getNodeCache( that.menuId, li.id );
				switch ( e.type ) {
					case "mouseenter":
							$.yhui.isIE6 && that._view.fixIE6( li, node.level );
							that._event.timer = that._event.delayTrigger( function() { 
									that._event.mouseEnterEvent( e, li, node ); 
								}, 
								that.options.timeToIn );
						break;
					case "mouseleave":
							$.yhui.isIE6 && that._view.fixIE6( li, node.level, true );
							clearTimeout( that._event.timer );
							that._event.mouseLeaveEvent( e, li, node );
						break;	
					case "click":
							that._event.mouseClick( e );
						break;	
				}
			},
			
			mouseEnterEvent: function( e, li, node ) {
				var html,
					$ul = $(li).children("ul");
				if ( !node ) return;
				if ( node.isParent ) {
					html = that._view.expandNode( node, node.children );
					if ( !$ul.length ) {
						if( node.level === 0 ) {
							$(li).append( html.join( "" ) )
								.children( "ul" )[ $.yhui.isIE6 ? "fadeIn" : "slideDown" ]( that.options.durationIn );
						} else {
							$(li).append( html.join("") )
								.children( "ul" ).css( "display", "block" );
						}
					} else {
						$(li).siblings("li").children("ul").fadeOut(10);
						node.level === 0 
							? $ul[ $.yhui.isIE6 ? "fadeIn" : "slideDown" ]( that.options.durationIn )
							: $ul.css( "display", "block" );
					}
				}
			},
			
			mouseLeaveEvent: function( e, li, node ) {
				var $ul = $(li).children("ul");
				if ( $ul.length && $ul.is( ":visible" ) ) {
					node.level === 0 
						? $ul[ $.yhui.isIE6 ? "fadeOut" : "slideUp" ]( that.options.durationOut )
						: $ul.css( "display", "none" );
				}
			},
			
			mouseClick: function( e ) {
				if ( e.target.id === that.menuId ) return;
				
				var li = that._getLiDom( e.target ),
					node = that._data.getNodeCache( that.menuId, li.id ),
					yhui = {
						menu: that.element,
						node: node
					};
				if ( node.isParent ) {
					return false;
				} else {
					that.options.onClick && that.options.onClick.call( li, e, yhui );
				}
			},
			 
			delayTrigger: function( fun, delay ) {
				return setTimeout( fun, delay );
			}
		},
		
		_ajaxData: function() {
			var that = this;
			if($.isFunction(that.options.beforeLoad)){
            	that.options.beforeLoad(that);
            }
			if ( this.options.url ) {
				$.ajax({
					url: that.options.url,
					dataType: "json",
					success: function( data ) {
						var yhui = {
							data : data
						};
						that._trigger( "beforeInit", null, yhui );

						that._parse( data );
						if($.isFunction(that.options.afterLoad)){
			            	that.options.afterLoad(that,data);
			            }
					},
					error: function( s1, s2 ) {
						$.yhui.log( s2 );
					}
				});
			}
		},
		
		_getLiDom: function( curDom ) {
			return curDom.nodeName.toLowerCase() !== "li" ? $( curDom ).closest( "li" )[0] : curDom;
		}
		
	});
})(jQuery);