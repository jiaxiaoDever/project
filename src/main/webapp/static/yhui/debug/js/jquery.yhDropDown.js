/*!
 * YHUI yhDatePicker @VERSION
 *
 * Depends:
 *  jquery.ui.core
 *	jquery.ui.widget
 *  jquery.zTree
 */
(function( $ ) {
	var num = 1, document = window.document;

	function getSerial() {
		return num++;
	}	

	$.widget( "yhui.yhDropDown", {
        version: "@VERSION",
		options:{
			autocomplete: false,
			checkbox: false,
			chkboxType: null,
			customContent: "请选择",
			dataType: "json",
			disable: false,
			height: false,
			hiddenId: "",
			idKey: "",
			inputWidth: false,
			json: null,
			minLength: 1,
            maxWidth: 300,
            maxHeight: 250,
			noChild: false,
			pIdKey: "",
			post: "",
			postData: null,
            resizable: false,
            selectAllSelected: false,
			selectParent: false,
			showButton: true,
			simpleData: false,
			showPath: false,
			type: "post",
			url: "",
			width: false,
			zTreeSettings: null,
			treeNodes:"",
			store:null,

			//callback
			beforeClick: null,
			beforeCreatedTree: null,
			createdTree: null,
			hide: null,
			onClick: null
		},
		
		_consts: {
			ID: {
				DROPUL: "yhDropTree_",
				DROPDIV:"yhDropDiv_",
				ALLINPUT:"dropDownSeleAll_",
                DROPDOWN: "yhui-dropdown-"
			},
			CLASS: {
				DROPUL: "ztree yhui-dropdown-tree",
				DROPDIV: "yhui-dropdown-drop",
				PARENTDIV: "yhui-dropdown",
				ALLDIV: "dropDownAll"
			},
			BTNSTRING: '<a class = "yhui-btn" href="javascript:void(0)">' + 
							'<span class = "yhui-form-icon classHolder"></span>textHolder</a>'
		},

		_create: function() {
			this._parse();
			this._events();
        },

        _init: function() {
            if ( this.firstFlag ) {
                this.__parseDrop();
            }
        },

		_parse: function() {
			var serial = this.serial = getSerial(),
				self = this,
				opts = this.options,
                id = this.element[0].id || "yhui-dropdown-holder-" + serial;


			this.element.attr( "id", id ).val("").css( "border", "none" ).width( opts.inputWidth ? opts.inputWidth : 150 )
					.wrap('<div id = "' + self._consts.ID.DROPDOWN + serial + '" class = "' + self._consts.CLASS.PARENTDIV + '"></div>');
			this.parent = this.element.parent();
			this.arrow = $( '<a href="#" id="yhui-dropdown-arrow_' + serial + '" class = "yhui-dropdown-arrow"></a>' ).appendTo( this.parent );
			if ( opts.post ) { 
				this.hidden = $( '<input type = "hidden" name = "' + (opts.hiddenId ? opts.hiddenId : 'yhui-dropdown-hide_' + serial)
								+ '" id = "' + ( 'yhui-dropdown-hide_' + serial)
								+ '" />' ).appendTo( this.parent );
			}
			this.disabledDiv = $('<div class = "yhui-dropdown-disabled"></div>').appendTo( this.parent );

            // confused in ie6, may be the dom tree render too slowly
            if ( $.yhui.isIE6 ) {
                setTimeout(function() {
                    self.options.disable && self.disable();
                }, 10);
            } else {
                self.options.disable && self.disable();
            }

            var treeId = this._consts.ID.DROPUL  + serial;
			this.element.data( "treeId", treeId );
			this.element.siblings( "input:hidden" ).data( "treeId", treeId );
		},

        _parseDrop: function() {
            var serial = this.serial,
                opts = this.options;

            this.dropDiv = $('<div id = "' + this._consts.ID.DROPDIV + serial
                + '" class = "' + this._consts.CLASS.DROPDIV + '"></div>')
                .width( this.element.width() ).hide();

            $.data( this.dropDiv[0], this.widgetName, this );
            
            if ( !(opts.noChild && !opts.checkbox) && opts.showButton && !opts.showPath ) {
                this.buttonPanel = $( '<div class = "yhui-dropdown-buttonpanel"></div>' ).appendTo( this.dropDiv );

                var unSelect = this._consts.BTNSTRING.replace( /classHolder/, "yhui-btn-selectall" ),
                    select =  this._consts.BTNSTRING.replace( /classHolder/, "yhui-btn-unselectall" )
                        .replace( /textHolder/, "全选" );
                if ( !opts.checkbox ) {
                    $( unSelect.replace( /textHolder/, "清空" ) ).appendTo( this.buttonPanel );
                }
                if ( opts.checkbox ) {
                    $( select ).add( $( unSelect.replace( /textHolder/, "全不选" ) ) ).appendTo( this.buttonPanel );
                }
            }
            this.dropUl = $( '<ul id = "' + this._consts.ID.DROPUL + serial
                + '" class = "' + this._consts.CLASS.DROPUL + '"></ul>' ).appendTo( this.dropDiv );
       
           this.dropDiv.appendTo( document.body );
           this._bindDropEvent();
        },

        __parseDrop: function() {
        	var that = this;
            if ( !this.firstFlag ) {
                if ( (this.dropUl || this.dropDiv ) && this.options.height && this.options.height > 200 ) {
                    this.dropDiv.css( "maxHeight","none" ).height( this.options.height );
                }
            }

            if ( this.tree ) {
                this.tree.destroy();
            }
            if(this.options.store){
            	var store = $.yhStore.get(that.options.store.name);
				that.store = store;
            	if(that.store.data){
            		that.options.json = that.store.data;
            		that._initTree( that.serial, that.options );
            	}else{
            		var initDataFun = that.store.triger.initData;
            		that.store.triger.initData = function(_store){
            			if(initDataFun&&$.isFunction(initDataFun)){
            				initDataFun(_store);
            			}
            			that.options.json = _store.data;
            			that._initTree( that.serial, that.options );
            			
            		};
            	}
            }else 
            	if ( ( !this.options.json || !!this.options.postData ) && !!this.options.url.length || !!this.options.treeNodes.length) {
                this._getData();
            } else {
                this._initTree( this.serial, this.options );
            }

            this.firstFlag = true;
        },

		_events: function() {
			var that = this,
                parseEvent = function( type ) {
                    return $.yhui.parseEventType( type, that.eventNamespace );
                };

            that._documentClickHide();

            that.parent
                .on( parseEvent( "focusin click" ), "input", function(e) {
                    if ( e.type === "click" ) {
                        e.preventDefault();
                    }
                    if ( e.type === "focusin" ) {
                        that._showDrop();
                    }
                })
                .on( parseEvent("click"), "a", function(e) {
                    e.preventDefault();
                    that.dropDiv && that.dropDiv.is( ":visible" ) ? that._hideDrop() : that.element[0].focus();
                });

			this.window.on( parseEvent( "resize" ), function() {
				that._hideDrop();
                that.notUpdatePosition = false;
			});
		},

        _bindDropEvent: function() {
            var that = this,
                parseEvent = function( type ) {
                    return $.yhui.parseEventType( type, that.eventNamespace );
                };

            that.dropDiv.on( parseEvent( "mouseleave" ), function() {
                that._hideDrop();
            });

            if ( this.buttonPanel ) {
                var btn = this.buttonPanel.find( "a" );
                if ( btn.length === 1 ) {
                    btn.eq( 0 ).on( parseEvent( "click" ), function() {
                        that.element[0].value = "";
                        that.hidden && (that.hidden[0].value = "");
                        var treeObj = $.yhGetTree( "yhDropTree_" + that.serial );
                        treeObj && treeObj.cancelSelectedNode();
                        return false;
                    });
                } else if ( btn.length === 2 ) {
                    this.buttonPanel.on( parseEvent( "click" ), "a", function() {
                        var data = this.lastChild.data,
                            tree = $.yhGetTree( "yhDropTree_" + that.serial );
                        if ( data === "全选" ) {
                            that._selectedAll( tree, true );
                        }
                        if ( data === "全不选" ) {
                            that._selectedAll( tree, false );
                        }
                        return false;
                    });
                }
            }
        },
		_initTree: function( serial, opts, event ) {
			var self = this,
				settings = {
					check:{
						enable:false
					},
					view: {
						dblClickExpand: false
					},
					data:{
						simpleData:{}
					},
					callback: {
						beforeClick: function( treeId, treeNode ) { 
							if ( !opts.checkbox ) {
								return self._defaultBeforeClick( treeId, treeNode, opts.selectParent, opts ); 
							} else {
								return self._checkBeforeClick( treeId, treeNode, opts.selectParent, opts );
							}
						},
						onClick: function( e, treeId, treeNode ) {
							if ( !opts.checkbox ) {
								self._defaultOnClick( e, treeId, treeNode, opts );
							}
						},
						onCheck: function( e, treeId, treeNode ) {
							if ( opts.showPath && !opts.noChild ) {
								self._showPathCheck( e, treeId, treeNode );
							} else {
								self._defaultOnCheck( e, treeId, treeNode, opts );
							}
						}
					}
				};	
			
			 if ( $.yhui.isIE6 || $.yhui.isIE8 ) {
				settings.callback.onExpand = function() {
					var height = self.dropUl.height();
					if ( height > 200 ) {
						self.dropUl.height( 200 );
					}
				};
				settings.callback.onCollapse = function() {
					var $li = self.dropUl.find("li:last"),
						height = $li.offset().top + $li.outerHeight();
					if ( height < 201 ) {
						self.dropUl.css( "height", "auto" );
					}
				};
			 }

			if ( opts.checkbox ) {
				settings.check.enable = true;
			}

			if ( !opts.checkbox ) {
				settings.view.selectedMulti = false;
			}

			if ( opts.chkboxType && ( "Y" in opts.chkboxType || "N" in opts.chkboxType ) ) {
				settings.check.chkboxType = opts.chkboxType;
			}

			if ( opts.noChild ) {
				settings.view.showIcon = false;
				settings.view.showLine = false;
			}

			if ( opts.simpleData ) {
				settings.data.simpleData.enable = true;

				if ( opts.pIdKey ) {
					settings.data.simpleData.pIdKey = opts.pIdKey;
				}

				if ( opts.idKey ) {
					settings.data.simpleData.idKey = opts.idKey;
				}
			}

			
			if ( opts.zTreeSettings ) {
            	if(opts.zTreeSettings.callback){
					$.extend(true,opts.zTreeSettings.callback, settings.callback);
				}
				if(opts.zTreeSettings.view){
					$.extend(true,opts.zTreeSettings.view, settings.view);
				}
            	//END---防止覆盖效果JS
				$.extend( true, settings, opts.zTreeSettings );
			}
			
			opts && opts.json && this._trigger( "beforeCreatedTree", event, { data: opts.json, zTreeSettings: settings } );
			
			var json = $.yhui.clone( opts.json );

            if ( opts.noChild && opts.customContent ) {
				var firstNode = { 
					name: opts.customContent 
				};
				opts.post && (firstNode[ opts.post ] = "");
				!opts.checkbox && $.isArray( json ) && json.unshift( firstNode );
			}

			$( "#yhDropTree_" + serial ).yhTree( settings, json );

			var treeObj = this.tree = $.yhGetTree( "yhDropTree_" + serial );
	
			if ( opts.noChild ) {
				var listNodes = treeObj.getNodes(),
					style = {
						display:"inline-block",
						width: (opts.checkbox ? ($.yhui.isIE67 ? "72%" : "80%") : ($.yhui.isIE67 ? "98%" : "100%")),
						overflow:"hidden",
						"text-overflow":"ellipsis"
					};
				
				for ( var j = 0, len = listNodes.length; j < len; j++ ) {
					$("#" + listNodes[j].tId).children("span:first").hide().end()
						.children("a").css( style );
				}	
			}
			
			if ( this.dropDiv && this.options.width ) {
				var width = this.options.width;
				this.dropDiv.width( width );
				if ( this.options.noChild ) {
					this.dropUl.find("a").width( 
						this.options.checkbox 
							? ( $.yhui.isIE67 ? (width - 46) : (width - 30) ) 
							: width - 15
					);
				}
			}

            if ( $.yhui.isIE6 ) {
                var width1 = this.dropDiv.width() - 10;
                this.dropUl.css( "width", width1 + "px" );
            }

			if ( opts.linkage ) {
				var node = treeObj.getNodeByParam( "name", "请先选上一级" );
				node && $("#" + node.tId + "_ico").hide();
			}
			if ( opts.selectAllSelected && opts.noChild ) {
                this._selectedAll( treeObj, true );
			}
			
			this._trigger( "createdTree", event, treeObj );

			if ( opts.autocomplete ) {
                var source = treeObj.transformToArray( treeObj.getNodes() );
                this._autocomplete( treeObj, source );	
			}

            if ( opts.resizable ) {
                this._resizable();
            }
		},

		_autocomplete: function( tree, source ) {
			var that = this, opts = that.options;
			$.ui.autocomplete.filter = function( array, term ) {
					var matcher = new RegExp( $.ui.autocomplete.escapeRegex(term), "i" );
					return $.grep( array, function(value) {
						return matcher.test( value.name );
					});
				};
				
			if ( !opts.checkbox && !opts.noChild ) {
                this.element.on( "keydown", function(e) {
					if ( tree.getSelectedNodes().length && (e.keyCode === $.ui.keyCode.BACKSPACE || e.keyCode === $.ui.keyCode.DELETE) ) {
						this.value.length <= 1 && tree.cancelSelectedNode();
					}
				}).autocomplete({
					source: source,
                    messages: null,
					minLength: opts.minLength,
					key: tree.setting.data.key.name,
					open: function() {
						that._hideDrop();
					},
					position: {
                        of: that.parent
                    },
					select: function( e, ui ) {
						this.value = ui.item.name;
						opts.post && ( $(this).siblings("input:hidden")[0].value = ui.item[ opts.post ] );
						if ( ui.item[opts.post] ) {
							var node = tree.getNodeByParam( opts.post, ui.item[opts.post] );
							if ( node ) {
								tree.selectNode( node );
							}
						}
						return false;
					}
				});
			}
		},

        _resizable: function() {
            var maxHeight = false,
                height = this.buttonPanel.outerHeight(),
                that = this;
           
            this.dropDiv.resizable({
                helper: "ui-resizable-helper",
                maxHeight: this.options.maxHeight,
                minHeight: 100,
                maxWidth: this.options.maxWidth,
                minWidth: this.dropDiv.outerWidth(),
                resize: function( e, ui ) {
                    if ( !maxHeight ) {
                        that.dropUl.css( "maxHeight", that.options.maxHeight );
                        maxHeight = true;
                    }
                    //修复拖动后滚动条移出框外
                   that.dropUl.height( ui.size.height - height -32 );
                },
                start: function() {
                    that.preventHide = true;
                },
                stop: function() {
                    delete that.preventHide;
                }
            });
        },

        _updatePosition: function() {
            if ( !this.notUpdatePosition ) {
            	var reset = { top: 0, left: 0 };
                this.dropDiv.css( reset ).position({
                    of: this.parent,
                    my: "left top-1",
                    at: "left bottom",
                    collision: "flipfit"
                });
                this.notUpdatePosition = true;
            }
        },

		_showDrop: function() {
            if ( !this.dropDiv ) {
                this._parseDrop();
                this.__parseDrop();
            }
            this.dropDiv.show();
            this._updatePosition();
            
			if ( $.yhui.isIE6 || $.yhui.isIE8 ) {
				var height = this.dropUl.height();
				if ( height > 200 ) {
					this.dropUl.height( 200 );
				}
			}
		},
		
		_documentClickHide: function() {
			var that = this;
            that.document.on( "click" + that.eventNamespace, function(e) {
                var t = e.target,
                    $t = $(t ),                  
                    drop = that.dropDiv;
               
                if ( drop && drop.is(":visible") ) {
                    if ( !( $t.closest(that.dropDiv).length > 0
                       // || $t.closest("div.ui-dialog").length > 0
                        || $t.closest(that.parent).length > 0 ) ) {
                        that._hideDrop();
                    }
                }
            });
		},

		_hideDrop: function() {
            if ( this.dropDiv ) {
                this.preventHide || this.dropDiv.hide();
                this.element.blur();
                var param = {
                    dropDiv: this.dropDiv,
                    dropDown: this
                };
                this._trigger( "hide", null, param );
            }
		},
		
		_defaultBeforeClick: function( treeId, treeNode, sParent, opts ) {
			var tree = $.yhGetTree(treeId);
			opts.beforeClick && opts.beforeClick.call( this, tree, treeNode );
			if ( !sParent ) {
				treeNode.isParent && tree.expandNode( treeNode, !treeNode.open, null, null, true );
				return !treeNode.isParent;
			}
		},
		
		_checkBeforeClick: function( treeId, treeNode, sParent, opts ) {
			var tree = $.yhGetTree(treeId);
			opts.beforeClick && opts.beforeClick.call( this, tree, treeNode );
			tree.checkNode(treeNode, !treeNode.checked, true, true);
			return false;
		},
		
		_defaultOnClick: function( e, treeId, treeNode, opts ) {
            var zTree = $.yhGetTree(treeId),
                that = this,
                ui = {
                    tree: zTree,
                    node: treeNode,
                    input: that.element,
                    hidden: that.hidden,
                    dropDiv: that.dropDiv
                };

            if ( that._trigger( "onClick", null, ui ) === false ) return;
			var nodes = zTree.getSelectedNodes(),
				v = nodes[0].name,	p = "";
			
			if ( opts.post ) {
				p = nodes[0][opts.post];
			}
			
			that._bindData( null, v, p, treeId, opts );
            that._hideDrop();
		},
		
		_defaultOnCheck: function( e, treeId, treeNode, opts ) {
			var tree = $.fn.zTree.getZTreeObj( treeId ),
				nodes = tree.getCheckedNodes(true),
                that = this,
                yhui = {
                    tree: tree,
                    node: treeNode,
                    nodes: nodes,
                    input: that.element,
                    hidden: that.hidden,
                    dropDiv: that.dropDiv
                };

            if ( that._trigger( "onClick", null, yhui ) === false ) return;

            var v = "",	p = "",
				i = 0, l = nodes.length;

			for ( ; i < l; i++ ) {
				v += nodes[i].name + ",";
				if ( opts.post ) {
					p += nodes[i][opts.post] + ",";
				}
			}
			
			that._bindData( nodes, v, p, treeId, opts );
		},

		_showPathCheck: function( e, treeId, treeNode ) {
			var tree = $.fn.zTree.getZTreeObj( treeId ),
				nodes = tree.getCheckedNodes(true),
				valueArr = [], postArr = [],
				that = this,
				i = 0, l = nodes.length, 
				isParentHalf = function( node ) {
					var status = node.getParentNode().getCheckStatus();
					return status.checked && status.half;
				},
				writePath = function( node ) {
					var nameArr = [], pArr = [];
					while ( node && node.level >= 0 ) {
						nameArr.unshift( node.name ? node.name : "" );
						if ( that.options.post ) {
							pArr.unshift( node[that.options.post] ? node[that.options.post] : "" );
						}
						node = node.getParentNode();
					}
					return {
						name: nameArr.join( "/" ),
						post: pArr.join( "/" )
					};
				},
				getClosestCheckedParent = function( node ) {
					while ( !isParentHalf(node) ) {
						node = node.getParentNode();
						if ( node.level === 0 
								&& node.getCheckStatus().checked 
								&& !node.getCheckStatus().half ) return node;
					}
					return node;
					
				},
				initArray = function( path ) {
					$.inArray( path.name, valueArr ) < 0 && valueArr.push( path.name );
					if ( that.options.post ) {
						$.inArray( path.post, postArr ) < 0 && postArr.push( path.post );
					}
				};
			
			for ( ; i < l; i++ ) {
				if ( !nodes[i].isParent && nodes[i].level !== 0 ) {
					if ( isParentHalf( nodes[i] ) ) {
						initArray( writePath(nodes[i]) );
					} else {
						initArray( writePath( getClosestCheckedParent(nodes[i]) ) );
					}
				}
			}
			that.element.val( valueArr.join(",") );
			that.element.siblings( "input" ).eq(0).val( postArr.join(";") );
			
			var yhui = {
				tree: tree,
				node: treeNode,
				dropDiv: tree.setting.treeObj.parent()
			};
			that._trigger( "onClick", null, yhui );
		},
		
		_bindData: function( nodes, v, p, treeId, opts ) {
			var $textNeed = this.element,
				$postNeed = this.element.siblings( "input:hidden" ).eq(0);
			
			if ( opts.checkbox && !nodes.length ) {
				$textNeed.val( "" );
				$postNeed.val( "" );
				return;
			}
			
			if ( v.indexOf( "," ) < 0 ) {
				$textNeed.val( v );
				p != null && $postNeed.val( p );
			} else {
				if ( v.length > 0 ) {
					v = v.substring( 0, v.length - 1 );
					$textNeed.val( v );
				}
				if ( p.length > 0 ) {
					p = p.substring( 0, p.length - 1 );
					$postNeed.val( p );
				}
			}
		},
		
		_selectedAll: function( treeObj, flag ) {
			var nodes = treeObj.transformToArray( treeObj.getNodes() ),
				i = 0, l = nodes.length;
			for ( ; i < l; i ++) {
				treeObj.checkNode( nodes[i], flag, null ,true );
			}
		},
		
		_getData: function() {
			var that = this;

            if ( $.yhui.yhLoading ) {
                this.parent.yhLoading({
                    size: "small",
                    duration: 200
                });
            }
            
            if(that.options.treeNodes.length>0 ){
            	that.options.json = that.options.treeNodes;
            	that._initTree( that.serial, that.options );
            }else {
				$.ajax({
					url: that.options.url,
					dataType: that.options.dataType,
					data: that.options.postData,
					type: that.options.type,
					success: function( backData ) {	
						that.options.json = backData;
						that._initTree( that.serial, that.options );
						if ( $.yhui.yhLoading )	 {
	                        that.parent.yhLoading("destroy");
	                    }
					},
					error: function( s1, s2 ) {
						$.yhui.log( s2 );
					}
				});
            }
		},
		
		enable: function() {
			this.option( "disable", false );
			this.disabledDiv.eq(0).hide().end().parent("div").removeClass( "yhui-dropdown-wrapdisabled" );
		},
		
		disable: function() {
			this.option( "disable", true );
			if ( $.yhui.isIE6 ) {
                var style = {
                    width: this.parent.width(),
                    height: this.parent.height(),
                    zoom: 1
                };
                this.disabledDiv.eq(0).css( style );
			}
			this.disabledDiv.eq(0).show();
            this.parent.addClass( "yhui-dropdown-wrapdisabled" );
		},
		
		getTree: function() {
			return $.yhGetTree( this.element.data( "treeId" ) );
		},

        parseDrop: function() {
            this._parseDrop();
            this.__parseDrop();
        },
        setText:function(text){
        	this.element.val(text);
        },
        setValue:function(v){
        	this.tree.cancelSelectedNode();
        	this._selectedAll( this.tree, false );
        	if($.type(v)=='undefined'||v===''){
        		this.element.val("--请选择--");
        		if(this.hidden){this.hidden.val("");}	
        	}else if($.isArray(v)){//数组
        		var kvns = "";
        		var vids = "";
				for(var i=0 ;i<v.length ;i++){
					var kv = v[i];
					if($.type(kv)=='object' && kv["id"]){
						vids += ","+kv["id"];
						var node = this.tree.getNodeByParam("id", kv["id"], null);
						if(node && node.name){
							// 设置选定
							this.tree.selectNode(node,true);
							this.tree.checkNode(node, true, true);
							kvns += node.name + " ";
						}
					}else
					if($.type(kv) == 'string' && kv){
						vids += ","+kv;
						var node = this.tree.getNodeByParam("id", kv, null);
						if(node && node.name){
							// 设置选定
							this.tree.selectNode(node,true);
							this.tree.checkNode(node, true, true);
							kvns += node.name + " ";
						}
					}
				}
				if(this.hidden&&vids){
					//设置值
					this.hidden.val(vids);
				}
				// 设置提交的文本
				this.element.val(kvns != "" ? kvns : "--请选择--");
        	}else if($.type(v)=='string' && v.indexOf(',') > 0){//带逗号分隔的字符串
					// 设置ID
		    		if(this.hidden){
		    			if(v.substring(v.length-1,v.length) == ','){								
		    				this.hidden.val(v.substring(0,v.length-1));
		    			}else{								
		    				this.hidden.val(v);
		    			}
		    		}
					var kvs = v.split(',');
					var kvns = "";
					for(var i=0 ;i<kvs.length ;i++){
						var kv = kvs[i];
						if(kv != ''){
							var node = this.tree.getNodeByParam("id", kv, null);
							if(node && node.name){
								// 设置选定
								this.tree.selectNode(node,true);
								this.tree.checkNode(node, true, true);
								kvns += node.name + " ";
							}
						}
					}
					// 设置提交的文本
					this.element.val(kvns != "" ? kvns : "--请选择--");
        	}else{//设置单个值
        		var node = this.tree.getNodeByParam("id", v, null);
        		if(this.hidden){this.hidden.val(v);}	
            	if(node && node.name){
            		this.element.val(node.name);
            		this.tree.selectNode(node,false);
            		this.tree.checkNode(node, true, true);
            	}else{
            		this.element.val("--请选择--");
            		//$.yhui.log("yhDropDown的setValue不存在值" + v + "对应的树节点");
            	}
        	}
        },
        getValue:function(){
        	return this.hidden.val();
        },
        getText:function(){
        	return this.element.prev().prev().val();
        },
        widget: function() {
            return this.parent;
        }
	});

})(jQuery);