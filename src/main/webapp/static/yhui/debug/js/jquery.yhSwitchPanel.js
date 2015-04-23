/*!
 * YHUI yhSearchBox @VERSION
 *
 * Depends:
 *  jquery.ui.core
 *  jquery.ui.widget
 *  yhLoading
 */
(function( $ ){
	var uid = 0;

	$.widget( "yhui.yhSwitchPanel", {
        version: "@VERSION",
		options: {
			active: 0,
			header: ">:even",
			duration: "fast",
			showAllIcons: true,
			icons: {
				activeHeader: "ui-icon-triangle-1-s",
				header: "ui-icon-triangle-1-e"
			},
			iconsAll: {
				activateAll: "ui-icon-plus",
				foldAll:"ui-icon-minus"
			},
			
			// callbacks
			fold: null,
			beforeFold: null,
			activate: null,
			beforeActivate: null,
			load: null,
			iframeLoaded: null,
			beforeAppend: null
		},

		version: "1.2",
		
		_consts: {
			CLASS: {
				CONTAINER: "ui-accordion ui-widget ui-helper-reset yhui-switchpanel",
				HEADER: "ui-accordion-header ui-helper-reset ui-state-default ui-corner-all",
				PANEL: "ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom noPadding yhui-switchpanel-panel",
				ACTIVE: {
					HEADER: "ui-accordion-header-active ui-state-active",
					PANEL: "ui-accordion-content-active"
				},
				CORNER: "ui-corner-all ui-corner-top"
			}
		},

		_create: function() {
			this._initDom();
			this._events();
			(this.headers.last().attr( "aria-actived" ) === "false") && this._fixBottomBorder( true );
		},

		_initDom: function() {
			var opts = this.options,
				switchPanleId = "yhui-yhSwitchPanle-" + ( this.element.attr( "id" ) || ++uid ),
				that = this;
			
			this.element.addClass( this._consts.CLASS.CONTAINER );
			this.headers = 
				this.element.find( opts.header )
				.addClass( this._consts.CLASS.HEADER ).disableSelection();
			this.panles = 
				this.headers.next().addClass( this._consts.CLASS.PANEL )
				.css("borderBottom","none").hide();
			
			if ( opts.active !== null ) {
				this.actives = this._findActive( opts.active )
							.addClass( this._consts.CLASS.ACTIVE.HEADER )
							.toggleClass( this._consts.CLASS.CORNER );
				
				this.actives.each(function() {
					var contentType;
					if ( contentType = this.getAttribute( "data-type" ) ) {
						that._checkContentType( $(this).next(), contentType );
					} else {
						$(this).next().addClass( that._consts.CLASS.ACTIVE.PANEL ).show();
					}
				});
			}	

			//aria
			this.headers
				.attr( "role", "tab" )
				.each( function( i ) {
					var header = $( this ),
						headerId = header.attr( "id" ),
						panel = header.next(),
						panelId = panel.attr( "id" );
					if ( !headerId ) {
						headerId = switchPanleId + "-header-" + i;
						header.attr( "id", headerId );
					}
					if ( !panelId ) {
						panelId = switchPanleId + "-panel-" + i;
						panel.attr( "id", panelId );
					}
					header.attr( "aria-controls", panelId );
					panel.attr( "aria-labelledby", headerId );
					
				})
				.next().attr( "role", "tabpanel" );

			this.headers
				.not( this.actives )
				.attr( "aria-actived", false )
				.next().attr( "aria-hidden", true ).hide();
			
			this.actives.attr( "aria-actived", true )
					.next().attr( "aria-hidden", false );

			//icons
			this._createIcons();	
			this.options.showAllIcons && this._createAllIcons();
		},

		_getCreateEventData: function() {
			return {
				header: this.actives,
				panel: !this.actives.length ? $() : this.actives.next()
			};
		},

		_createIcons: function() {
			var icons = this.options.icons;
			if ( icons ) {
				$( "<span>" )
					.addClass( "ui-accordion-header-icon ui-icon " + icons.header )
					.prependTo( this.headers );
				this.actives.children( ".ui-accordion-header-icon" )
					.removeClass( icons.header )
					.addClass( icons.activeHeader );
				this.headers.addClass( "ui-accordion-icons" );
			}
		},
		_createAllIcons: function() {
			var obj = { 
				activateAll : "打开全部面部",
				foldAll : "折叠全部面板"
			},
			icons = this.options.iconsAll,
			that = this;
			$.each( obj, function( i, value ) {
				that[ i + "Icon" ] = 
					$( "<span>" )
						.addClass( "yhui-switchpanel-" + i.toLowerCase() + " ui-icon " + icons[i] )
						.attr( "title", value )
						.appendTo( that.headers.first() )
						.tooltip();
			});
		},

		_findActive: function( index ) {
			var $ret = $(),
				that = this;
			
			if ( typeof index === "number" ) {
				$ret = $ret.add( this.headers.eq( index ) );
			} else {
				$.each( index, function( i, value ) {
					$ret = $ret.add( that.headers.eq( value ) );
				});
			}
			
			return $ret;
		},

		_events: function() {
			var that = this;
			//title的hover事件
			this._hoverable( this.headers );
			
			//title的点击事件
			this.headers.on( "click" + this.eventNamespace, function() {
				if ( this.getAttribute("aria-actived") === "false" ) {	
					that._activate( $(this), that._isLastHeader( this ) );
				} else {
					that._fold( $(this), that._isLastHeader( this ) );
				}
			}).find("a").on("click" + this.eventNamespace, function(e) {
				e.preventDefault();
			});

			
			//closeAll和foldAll
			this.activateAllIcon && this.activateAllIcon.on( "click" + this.eventNamespace, function() {
				$(this).tooltip( "close" );
				that.activateAll();
				return false;
			});
            this.foldAllIcon && this.foldAllIcon.on( "click" + this.eventNamespace, function() {
				$(this).tooltip( "close" );
				that.foldAll();
				return false;
			});

		},

		_getEventDate: function( header ) {
			return {
				header: $(header),
				panel: $(header).next(),
				obj: this
			}
		},

		_activate: function( header, lastFlag, fun ) {
			var that = this,
				exeIframe = function() {
					var ifr = header.next().find("iframe");
					if ( ifr.length && fun && $.isFunction( fun ) ) {
						fun.apply( ifr[0], arguments );
					}	
				};
			if ( header.attr( "aria-load" ) === "true" && header.attr("aria-actived") === "true" ) {
				exeIframe();
				return;
			}
			if ( header.jquery ) {
				if ( that._trigger( "beforeActivate", null, that._getEventDate( header ) ) === false ) return;
				
				if ( that._isLastHeader( header[0] ) ) {
					that._fixBottomBorder( true );
				}

				that._toggerIcons( $(header) );
				header.addClass( that._consts.CLASS.ACTIVE.HEADER )
					.toggleClass( that._consts.CLASS.CORNER + (lastFlag ? " bottomBorder" : "") )
					.attr( "aria-actived", true )
					.next()
						.attr( "aria-hidden",false )
						.slideDown( that.options.duration, function() {
							that._trigger( "activate", null, that._getEventDate( header ) );

							var loaded = header.attr( "aria-load" ) && header.attr( "aria-load" ) === "true",
								contentType = header[0].getAttribute( "data-type" );
							
							if ( contentType && !loaded ) {
								that._checkContentType( $(this), contentType, fun );
							}
							
							if ( loaded ) {
								exeIframe();
							}
						});
				
			}
		},

		_fold: function( header, lastFlag, hideHeaderFun ) {
			var that = this;
			if ( header.jquery ) {
				if ( that._trigger( "beforeFold", null, that._getEventDate( header ) ) === false ) return;
				
				if ( header.attr( "aria-actived" ) === "false" ) return;

				if ( that._isLastHeader( header[0] ) ) {
					that._fixBottomBorder( false );
				}

				that._toggerIcons( $(header) );
				header.removeClass( that._consts.CLASS.ACTIVE.HEADER )
					.toggleClass( that._consts.CLASS.CORNER + (lastFlag ? " bottomBorder" : "") )
					.attr( "aria-actived", false )
					.next()
						.attr( "aria-hidden", true )
						.slideUp( that.options.duration, function() {
							that._trigger( "fold", null, that._getEventDate( header ) );
							hideHeaderFun && $.isFunction( hideHeaderFun ) && hideHeaderFun.apply( that, arguments );
						});
			}	
		},

		_fixBottomBorder: function( flag ) {
			this.headers.last()[ flag ? "addClass" : "removeClass" ]( "bottomBorder" );
		},

		_isLastHeader: function( header ) {
			return header === this.headers.last()[0];
		},

		_toggerIcons: function( $header ) {
			$header.find( "span.ui-accordion-header-icon:first" )
				.toggleClass( this.options.icons.activeHeader + " " + this.options.icons.header );
		},
		
		_checkContentType: function( $panel, contentType, fun ) {
			if ( contentType.indexOf( "[" ) === -1  ) {
				var $iframe = $( "<iframe style = 'width:100%; height:100%' frameborder = 'no'></iframe>"),
					that = this;
				
				$panel.empty().show()
                    .append( $iframe )
                    .yhLoading();
				$iframe.attr( "src" , contentType )
					.on( "load", function(e) {
						var fixedHeight = function() {
							$panel.animate( {"height" : $.yhui.getDocHeight($iframe[0].contentWindow.document) }, 300 );
						};
						that._delay( fixedHeight, 600 );
                        $panel.prev().attr( "aria-load", "true" );
						
						if ( fun && $.isFunction( fun ) ) {
							if ( fun.apply( this, arguments ) === false ) return;
						}

						if ( that._trigger( "iframeLoaded", null, { header: $panel.prev(), panel: $panel } ) === false ) return;

						$panel.yhLoading("destroy");
					});
			} else {
				this._ajaxContent( $panel, contentType );
			}
		},

		_ajaxContent: function( $panel, contentType ) {
			var rContent = /^\[(\w+)\](.+)/,
				aContent = rContent.exec( contentType ),
				type = aContent[1],
				path = aContent[2],
				that = this;
			if ( type === "html" ) {
				$panel.prev().attr( "aria-load", "true" );
				$panel.load( path, function( data ) {
					that._trigger( "load", null, data );
				});
				$panel.is(":hidden") && $panel.slideDown( "fast" );
			} else if ( type === "json" ) {
				$panel.prev().attr( "aria-load", "true" );
				$.getJSON( path, function( data ) {
					var yhui = {
						panel: $panel,
						data: data 
					};
					if ( that._trigger( "beforeAppend", null, yhui  ) !== false ) {
						$panel.append( JSON.stringify( data ) );
					}
					$panel.is(":hidden") && $panel.slideDown( "fast" );
				});		
			}

		},

		activateAll: function() {
			var that = this;
			this.headers.each(function( i ) {
				this.getAttribute( "aria-actived" ) === "false" && that._activate( $(this),  ( i === (that.headers.length - 1) ) );
			});
		},
		
		foldAll: function() {
			var that = this;
			this.headers.each(function( i ) {
				this.getAttribute( "aria-actived" ) === "true" && that._fold( $(this),  ( i === that.headers.length - 1 ) );
			});
		},

		_showHeader: function( index, showPanelFlag, fun ) {
			var that = this;
			setTimeout( function() {
				that.headers.eq( index ).show();
				if ( showPanelFlag ) {
					that._activate( that.headers.eq(index), that._isLastHeader( that.headers[index]), fun );
				}
			}, 2 );
		},

		showHeader: function( index, showPanelFlag, fun ) {
			var that = this;
			if ( typeof index === "number" ) {
				this._showHeader( index, showPanelFlag, fun );
			} else if ( $.isArray( index ) ) {
				$.each( index, function( i, value ) {
					that._showHeader( value, showPanelFlag );
				});
			}
		},

		_hideHeader: function( index, removeFlag ) {
			var header = this.headers.eq( index );
			this._fold( header, this._isLastHeader( header[0] ), function() {
				header.hide().next().hide();
				if ( removeFlag ) {
					header.off().find("a").off().end().remove().next().remove();
				}
			});
		},

		hideHeader: function( index, removeFlag ) {
			var that = this;
			if ( typeof index === "number" ) {
				this._hideHeader( index, removeFlag );
			} else if ( $.isArray( index ) ) {
				$.each( index, function( i, value ) {
					that._hideHeader( value, removeFlag );
				});
			}
		},

		activate: function( index, fun ) {
			var header, that = this;
			if ( typeof index === "number" ) {
				that._activate( that.headers.eq( index ), that._isLastHeader( that.headers[index] ), fun ); 
			} else if ( $.isArray(index) ) {
				$.each( index, function( i, value ) {
					header = that.headers.eq( value );
					that._activate( header, that._isLastHeader(header[0]), fun );
				});
			}
		},

		fold: function( index ) {
			var header, that = this;
			if ( typeof index === "number" ) {
				that._fold( that.headers.eq( index ), that._isLastHeader( that.headers[index] ) ); 
			} else if ( $.isArray(index) ) {
				$.each( index, function( i, value ) {
					header = that.headers.eq( value );
					that._fold( header, that._isLastHeader(header[0]) );
				});
			}
		},

		removeLoading: function( ifr ) {
			$(ifr).siblings("div.yhui-switch-contentloading").fadeOut( "fast", function() {
				$(this).remove();
			});
		}
		
	});
})(jQuery);