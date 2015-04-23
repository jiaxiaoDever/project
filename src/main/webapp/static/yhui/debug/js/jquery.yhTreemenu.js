/*!
 * YHUI yhTreemenu @VERSION
 *
 * Depends:
 *  jquery.ui.core
 *  jquery.ui.widgte
 *  zTree
 *  yhCore
 *  jquery.yhContextMenu
 */
(function( $, undefined ) {
    function toggleTopLevel( flag, id, node ) {
        $( "#" + node.tId + "_a" )[ flag ? "addClass" : "removeClass" ]( 'actived' );
        if ( node.isLastNode ) {
            $( "#" + id )[ flag ? "addClass" : "removeClass" ]( "yhui-treemenu-nobottom" );
        }
    }
    $.widget( "yhui.yhTreemenu", {
        version: "@VERSION",
        options: {
            contextMenu: null,
            expandLevel: 0,
            source: null,
            zTreeSettings: null,
            //callback
            createdTree: null,
            beforeLoad:null,
            afterLoad:null,
            beforeCollapse:null,
            beforeExpand:null,
            beforeClick:null,
            onClick:null
        },
        _create: function() {
        	var that = this;
            this.element.addClass("ztree yhui-treemenu");
            if(this.options.store){
            	var store = $.yhStore.get(that.options.store.name);
				that.store = store;
            	if(that.store.data){
            		that.nodes = that.store.data;
            		if($.isFunction(that.options.beforeLoad)){
                    	that.options.beforeLoad(that);
                    }
                    that._parseTree();
            	}else{
            		var initDataFun = that.store.triger.initData;
            		that.store.triger.initData = function(_store){
            			if(initDataFun&&$.isFunction(initDataFun)){
            				initDataFun(that.store);
            			}
            			that.nodes = that.store.data;
                        that._parseTree();
            		};
            	}
            }else {
            	this._getNodes();
            }
           
        },
        
        _parseTree: function() {
            var that = this;
            var settings = {
                view: {
                    selectedMulti: false,
                    dblClickExpand: false,
                    addDiyDom: function( treeId, node ) {
                        if ( node.isNewWindow ) {
                            var nodeA = $( "#" + node.tId + "_a" );
                            //if ($( "#diySpan" + node.tId).length ) return;
                            var diySpan = '<span class = "ui-icon ui-icon-newwin" style = "display:inline-block; height:12px;"></span>';
                            nodeA.append( diySpan );
                        }
                        if ( node.isNew ) {
                            var path = "debug",
                                node_A = $( "#" + node.tId + "_a" );
                            //if ( $("#diyNew" + node.tId).length ) return;
                            if ( that.window[0].location.hostname !== "localhost" ) {
                                path = "pro";
                            }
                            var diyNew = "<img src='yhui/"+ path + "/skins/skinOrange/images/other/new.gif' alt='new' />";
                            node_A.append( diyNew );
                        }
                    }
                },
                callback: {
                    beforeCollapse: function( id, node ) {
                    	if ( $.isFunction(that.options.beforeCollapse) ) {
                    		return that.options.beforeCollapse( id, node );
                    	}
                        if ( node.level === 0 ) {
                            toggleTopLevel( 0, id, node );
                        }
                    },
                    beforeExpand: function( id, node ) {
                    	if ( $.isFunction(that.options.beforeExpand) ) {
                    		return that.options.beforeCollapse( id, node );
                    	}
                        if ( node.level === 0 ) {
                            toggleTopLevel( 1, id, node );
                        }
                    },
                    beforeClick: function( id, node ) {
                    	if ( $.isFunction(that.options.beforeClick) ) {
                        	return that.options.beforeCollapse( id, node );
                        }
                        if ( node.children ) {
                            that.tree.expandNode( node, !node.open, null, null, true );
                            return false;
                        }
                        
                    },
                    onClick: function( e, id, node ) {
                        if ( $.isFunction(that.options.onClick) ) {
                            that.options.onClick.call( that, e, {
                                node: node,
                                tree: that.tree
                            });
                        }
                    }
                }
            };
            if ( this.options.zTreeSettings ) {
            	//防止覆盖效果JS
            	if($.isFunction(this.options.zTreeSettings.callback.beforeCollapse)){
            		this.options.beforeCollapse = this.options.zTreeSettings.callback.beforeCollapse;
            	}
            	if($.isFunction(this.options.zTreeSettings.callback.beforeExpand)){
            		this.options.beforeExpand = this.options.zTreeSettings.callback.beforeExpand;
            	}
            	if($.isFunction(this.options.zTreeSettings.callback.beforeClick)){
            		this.options.beforeClick = this.options.zTreeSettings.callback.beforeClick;
            	}
            	if($.isFunction(this.options.zTreeSettings.callback.onClick)){
            		this.options.onClick = this.options.zTreeSettings.callback.onClick;
            	}
            	$.extend(this.options.zTreeSettings.view ,settings.view);
            	$.extend(this.options.zTreeSettings.callback,settings.callback);
            	//END---防止覆盖效果JS
                $.extend( true ,settings, this.options.zTreeSettings );
            }
            this.tree = this.element.yhTree( settings, this.nodes ).yhTree("getTree");
            this._trigger("createdTree", null, { tree: this.tree });
            this._context();
            if ( this.options.expandLevel ) {
                $.yhui.expandTreeNode( this.tree.getNodes(), this.tree, this.options.expandLevel );
            }
        },

        _context: function() {
            var that = this,
                cMenu = that.options.contextMenu;
            if ( cMenu && cMenu.menu ) {
                that.element.yhContextMenu( cMenu );
            }
        },

        _getNodes: function() {
            var that = this;
            if($.isFunction(that.options.beforeLoad)){
            	that.options.beforeLoad(that);
            }
            if ( typeof this.options.source === "string" ) {
                $.getJSON( this.options.source )
                    .success(function(nodes) {
                        that.nodes = nodes;
                        that._parseTree();
                        if($.isFunction(that.options.afterLoad)){
                        	that.options.afterLoad(that,nodes);
                        }
                    })
                    .error(function( m1, m2 ) {
                        $.yhui.log( m2 );
                    });
            } else {
                this.nodes = this.options.source;
                this._parseTree();
            }
        },

        getTree: function() {
            return this.tree || null;
        },
        
        setValue:function(v){
        	var that = this;
        	if(!that.tree){
        		if(!that.options.afterLoad){
        			that.options.afterLoad = function(){
        				that._set2Value(v);
        			};
        		}else{
        			$.yhui.log( "数据还没加载完，请在afterLoad事件中设置数据" );
        		}
        	}else{
        		that._set2Value(v);
        	}
        	
        },
        _set2Value:function(v){
        	var node = this.tree.getNodeByParam("id", v, null);
        	this.tree.selectNode(node,false);
    		//this.tree.checkNode(node, true, true);
        }
    });
})( jQuery );
