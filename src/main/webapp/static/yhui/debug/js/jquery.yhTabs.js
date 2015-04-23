/*!
 * YHUI yhTabs @VERSION
 *
 * Depends:
 *  jquery.ui.core
 *	jquery.ui.widget
 *	jquery.ui.position
 *  jquery.ui.tabs
 *	jquery.ui.tooltip
 */
(function( $ ) {
    $.widget( "yhui.yhTabs", $.ui.tabs, {
        version: "@VERSION",
        options: {
            frame: false,
            showLoading: false,
            standTimeout: 0,
            timeOut: 10000,
            tooltip: true,
            
            // callback
            add: null
        },

        _consts: {
            LISTACTIVED: "yhui-tabs-list-actived",
            TABID: "data-yhui-tabid",
            TAB: "<li title='{title}'><a href='#{href}'>{title}</a></li>",
            CTAB: "<li title='{title}'><a href='#{href}'>{title}</a><span title = '关闭' class='ui-icon ui-icon-close yhui-tabs-close'>Remove Tab</span></li>"
        },

        _create: function() {
            this._super();
            this.element.addClass( "yhui-tabs" );
            if ( this.options.frame ) {
                if ( !this.element.find( "div.yhui-tabs-header-inner" ).length ) return $.yhui.log( "bad structure!" );
                this._parse();
            }

            this._events();
        },

        addTab: function( $dom, src, title ) {
            if ( !this.options.frame ) return $.yhui.log( "use add ?" );

            var id, addObj;
            if($dom && $dom  != null && $dom[0]){
            	//此处修改让不满足该条件的也能够继续执行下去  2013.11.14   肖长江
            	id = $dom[0].getAttribute( this._consts.TABID );
            }
            if ( !id ) {
                id = "yhtabs-" + $.now();
                if($dom && $dom  != null && $dom[0]){  
                	//此处修改让不满足该条件的也能够继续执行下去  2013.11.14   肖长江
                	$dom[0].setAttribute( this._consts.TABID, id );
                }
            }

            if ( !$( "#" + id ).length ) {
                title = title || $.trim( $dom.text() ) || "选项卡";
                addObj = {
                    title: title,
                    id: id,
                    src: src,
                    close: true,
                    capture: true
                };

                this.options.showLoading && this._timeOutStart();
                this.add( addObj );
                this._addTabCheck();
                this._addItemToRightList( title, id );
            } else {
                this._itemClick( id );
            }
        },

        _removeTab: function( $li, allFlag ) {
            var panelId = $li.remove().attr( "aria-controls" ),
                $panel = $( "#" + panelId ),
                $iframe = $panel.find( "iframe" );

            // src > about:blank  trigger the iframe unload and beforeunload in ie
            $iframe.length && $iframe.attr( "src", "about:blank" ).remove();
            $panel.remove();
            if ( !allFlag ) {
                this.refresh();
                this._removeTabCheck();
            }
            if ( this.options.frame ) {
                this._removeItemFromRightList( panelId );
                this.options.showLoading && this.loading.off( "dialogbeforeclose" );
            }
            $.yhui.isIE && CollectGarbage();
        },

        _parse: function() {
            this.header = this.element.find( "div" ).first()
                .addClass( "ui-widget-header" )
                .append( '<div class = "yhui-tabs-arrow-w ui-icon ui-icon-triangle-1-w" role = "data-yhui-tabs-btn"></div>'
                    + '<div class = "yhui-tabs-arrow-e ui-icon ui-icon-triangle-1-e" role = "data-yhui-tabs-btn"></div>'
                    + '<div class = "yhui-tabs-arrow-s ui-icon ui-icon-circle-triangle-s" role = "data-yhui-tabs-btn"></div>'
                    + '<div class = "yhui-tabs-refresh ui-icon ui-icon-refresh" role = "data-yhui-tabs-btn"></div>' );
            this.container = this.element.find( "div.ui-layout-content" ).eq( 0 ).addClass("yhui-tabs-panels");
            this.headerInner = this.header.find( "div.yhui-tabs-header-inner" ).eq( 0 );
            this.wArrow = this.header.find( "div.yhui-tabs-arrow-w" ).eq( 0 );
            this.sArrow = this.header.find( "div.yhui-tabs-arrow-s" ).eq( 0 );
            this.animated = false;
            this._parseRightList();
            this.options.showLoading && this._parseTimeOut();

            this.tabs[0].title = $.trim( this.tabs.eq( 0 ).text() );
            this.usualValue = this.tabs.eq( 0 ).outerWidth()
                + parseInt( this.tabs.eq( 0 ).css( "marginRight" ), 10 )
                + parseInt( this.tabs.eq( 0 ).css( "marginLeft" ), 10 );

            if ( this.options.tooltip ) {
                this.tablist.tooltip({
                    items: "li[title]",
                    position: {
                        at: "left top-52"
                    }
                });
            }
        },

        _parseRightList: function() {
            var id = this.tabs[0].getAttribute( "aria-controls" );
            this.rightListUp = $( '<ul class = "yhui-tabs-list-up" ><li role = "data-yhui-tabs-rightlist" data-yhui-tabid = "'
                + id + '" class = "yhui-tabs-list-actived">'
                + $.trim( this.tabs.first().text() ) + '</li></ul>' );
            this.rightListDown = $( '<ul class = "yhui-tabs-list-menu">' +
                '<li role = "data-yhui-tabs-rightcontrol">关闭当前选项卡</li>' +
                '<li role = "data-yhui-tabs-rightcontrol">关闭其他选项卡</li>' +
                '<li role = "data-yhui-tabs-rightcontrol">关闭全部选项卡</li></ul>' );
            this.rightList =
                $( '<div class = "yhui-tabs-list"></div>' )
                    .append( this.rightListUp, this.rightListDown )
                    .appendTo( this.element.find( "div.yhui-tabs-header" ) );
        },

        _parseTimeOut: function() {
            this.loading =
                $( '<div class = "yhui-tabs-loading" title = "加载中……"></div>' )
                    .appendTo( this.document[0].body )
                    .dialog( {
                        modal: true,
                        autoOpen: false,
                        draggable: false,
                        resizable: false,
                        buttons: {
                            "取消加载": function() {
                                $( this ).dialog( "close" );
                            }
                        },
                        create: function() {
                            $( this ).dialog( "widget" ).find( "a.ui-dialog-titlebar-close" ).hide();
                        },
                        height: 180,
                        position: ["center", "top+15%"],
                        open: function() {
                            $.yhui.isIE67 && $( this ).dialog( "widget" ).find( "button" ).blur();
                        }
                    } );
        },

        _events: function() {
            var that = this,
                c = this._parseEventType( "click" ),
                mmc = this._parseEventType( "mouseenter mouseleave click" );
            
            this.document.on( that._parseEventType( "click" ), function( e ) {
                 if ( !$( e.target ).closest( "div.yhui-tabs-list" ).length && e.target.className.indexOf("yhui-tabs-arrow-s") === -1 ) {
                    that._rightListHide();
                 }
             });

            that._contextMenu();
            that.element
                .on( c, '.yhui-tabs-close', function() {
                    that._removeTab( $( this.parentNode ) );
                } )
                .on( that._parseEventType( "mouseleave" ), ".yhui-tabs-list", function() {
                    that._rightListHide();
                } )
                .on( mmc, "[role=data-yhui-tabs-btn]", function( e ) {
                    if ( e.type === "mouseenter" ) {
                        $( this ).addClass( "yhui-tabs-arrow-hover" );
                    }
                    if ( e.type === "mouseleave" ) {
                        $( this ).removeClass( "yhui-tabs-arrow-hover" );
                    }
                    if ( e.type === "click" ) {
                        var c = this.className;

                        if ( c.indexOf( "refresh" ) !== -1 ) {
                            that.refreshActive();
                        }

                        if ( c.indexOf( "arrow-w" ) !== -1 || c.indexOf( "arrow-e" ) !== -1 ) {
                            that._fixedPosition( c );
                        }

                        if ( c.indexOf( "arrow-s" ) !== -1 ) {
                            that.rightList.is(":hidden") ? that._rightListShow() : that._rightListHide();
                        }
                    }
                } )
                .on( mmc, "[role=data-yhui-tabs-rightlist],[role=data-yhui-tabs-rightcontrol]", function( e ) {
                    var role = this.getAttribute( "role" );
                    switch ( e.type ) {
                        case "mouseleave":
                            $( this ).removeClass( "yhui-tabs-list-hover" );
                            break;
                        case "mouseenter":
                            !$( this ).hasClass( "yhui-tabs-list-disable" ) && $( this ).addClass( "yhui-tabs-list-hover" );
                            break;
                        case "click":
                            role === "data-yhui-tabs-rightlist"
                                ? ( that._itemClick( this.getAttribute( that._consts.TABID ), this ) )
                                : ( that._rightContol( this ) );
                            break;
                    }
                });

            if ( that.options.frame ) {
                var $firstIframe = this.container.find( "div" ).first().find( "iframe" );
                if ( $firstIframe.length ) {
                    $firstIframe.on( that._parseEventType( "load" ), function() {
                        try {
                            $( $firstIframe[0].contentWindow.document ).on( "click", function() {
                                that._rightListHide();
                            } );
                        } catch ( err ) {
                        }
                    } );
                }
            }
        },

        _parseEventType: function( type ) {
            var ret, space = this.eventNamespace;
            if ( type.indexOf( " " ) === -1 ) {
                ret = type + space;
            } else {
                var a = [];
                $.each( type.split( " " ), function( i, value ) {
                    a.push( value + space );
                } );
                ret = a.join( " " );
            }
            return ret;
        },

        _fixedPosition: function( c ) {
            var that = this,
                $ul = that.tablist.eq( 0 ),
                left = $ul.position().left,
                dValue = that.usualValue * 2;

            if ( c.indexOf( "arrow-w" ) !== -1 ) {
                if ( left < 0 ) {
                    $ul.animate( {"left": "+=" + dValue + "px"}, function() {
                        $( this ).position().left > 0 && $( this ).animate( {"left": "0px"} );
                    } );
                } else {
                    $ul.animate( {"left": "+=" + dValue + "px"} ).animate( {"left": "0px"} );
                }
            }

            if ( c.indexOf( "arrow-e" ) !== -1 ) {
                left = Math.abs( left );
                if ( that.maxValue > left ) {
                    $ul.animate( {"left": "-=" + dValue + "px"}, function() {
                        Math.abs( $( this ).position().left ) > that.maxValue
                        && $( this ).animate( {"left": -that.maxValue + "px"} );
                    } );
                } else {
                    $ul.animate( {"left": "-=" + dValue + "px"} )
                        .animate( {"left": "+=" + dValue + "px"} );
                }
            }
        },

        _fixedLeftDistance: function() {
            var $ul = this.tablist.eq( 0 ),
                ulLeft = Math.abs( $ul.position().left ),
                liLeft = this.active.eq( 0 ).position().left,
                dLeft = ulLeft - liLeft,
                ddLeft = liLeft - ( ulLeft + this.headerInner.width() ),
                usual = ddLeft + this.usualValue;

            if ( dLeft >= 0 ) {
                $ul.animate( {"left": "+=" + dLeft + "px"} );
            }
            if ( ddLeft >= 0 ) {
                $ul.animate( {"left": "-=" + usual + "px"} );
            }
        },

        _addTabCheck: function() {
            var $ul = this.tablist.eq( 0 );
            this.maxValue = this.tabs.length * this.usualValue - this.headerInner.width();
            if ( this.maxValue > 0 ) {
                this._arrowFadeIn();
                if ( !this.animated ) {
                    this.maxValue += this.updateOffset;
                    this.animated = true;
                }
                $ul.animate( {"left": "-" + this.maxValue + "px"} );
            }
        },

        _removeTabCheck: function( updateFlag ) {
            var that = this, $ul = that.tablist.eq( 0 );
            
            if ( updateFlag ) {
                var maxValue = this.tabs.length * this.usualValue - this.headerInner.width();
                if ( maxValue <= 0 ) {
                    this._arrowFadeOut();
                    $ul.css( "left", "0px" );
                }
                return;
            }

            this.maxValue -= this.usualValue;
            if ( $ul.position().left < 0 ) {
                $ul.animate( {"left": "+=" + this.usualValue + "px"}, function() {
                    if ( $( this ).position().left >= 0 ) {
                        $( this ).animate( { "left": "0px" } );
                        that.animated = false;
                        that._arrowFadeOut();
                    }
                } );
            }
        },

        _itemClick: function( id, rightList ) {
            this.option( "active", this._getIndex( id ) );
            this._fixedLeftDistance();
            if ( rightList ) {
                $( rightList ).addClass( this._consts.LISTACTIVED )
                    .siblings().removeClass( this._consts.LISTACTIVED );
            }
        },

        _rightContol: function( li ) {
            if ( li.className === "yhui-tabs-list-disable" ) return;
            switch ( li.innerHTML ) {
                case "关闭当前选项卡":
                    var $span = this.active.find( "span.yhui-tabs-close" );
                    if ( $span.length ) {
                        $span.trigger( "click" );
                    }
                    break;
                case "关闭其他选项卡":
                    this._closeOthers( this.active );
                    break;
                case "关闭全部选项卡":
                    this._closeAll();
                    break;
            }
            this._rightListHide();
        },

        _arrowFadeIn: function() {
            this._arrowVisible()
            || this.headerInner.css( "margin", "0 54px 0 18px" )
                .siblings( ".yhui-tabs-arrow-w,.yhui-tabs-arrow-e" ).show();
            this.updateOffset = parseInt( this.headerInner.css( "marginLeft" ), 10 ) * 2;
        },

        _arrowFadeOut: function() {
            this.headerInner.css( "margin", "0 36px 0 0" )
                .siblings( ".yhui-tabs-arrow-w,.yhui-tabs-arrow-e" ).hide();
        },

        _arrowVisible: function() {
            return this.wArrow.is( ":visible" );
        },

        _rightListShow: function() {
            var that = this;
            if ( this.tabs.length === 1 ) {
                this.rightListDown.find( "li" ).addClass( "yhui-tabs-list-disable" );
            } else if ( this.tabs.length === 2 ) {
                this.rightListDown.find( "li" ).removeClass( "yhui-tabs-list-disable" ).eq( 1 ).addClass( "yhui-tabs-list-disable" );
            } else {
                this.rightListDown.find( "li" ).removeClass( "yhui-tabs-list-disable" );
            }
            this.sArrow.addClass( "ui-icon-circle-triangle-n" );
            this.rightList.slideDown( 300, "easeInQuad", function() {
                if ( $.yhui.isIE6 ) {
                    var $list = that.rightListUp;
                    $list.innerHeight() > 350 ? $list.height( 350 ) : $list.css( "height", "auto" );
                }
            } );
        },

        _rightListHide: function() {
            this.sArrow && this.sArrow.removeClass( "ui-icon-circle-triangle-n" );
            this.rightList && this.rightList.slideUp( 100 );
        },

        _addItemToRightList: function( title, id ) {
            $( "<li>" + title + "</li>" )
                .attr( {
                    "title": title,
                    "data-yhui-tabId": id,
                    "role": "data-yhui-tabs-rightlist"
                } )
                .addClass( "yhui-tabs-list-actived " )
                .prependTo( this.rightListUp )
                .siblings( "li" ).removeClass( "yhui-tabs-list-actived" );
        },

        _removeItemFromRightList: function( id ) {
            var activeId = this.active[0].getAttribute( "aria-controls" );
            this.rightListUp.find( "li[data-yhui-tabId='" + id + "']" ).eq( 0 ).remove();
            this.rightListUp.find( "li[data-yhui-tabId='" + activeId + "']" ).eq( 0 ).addClass( "yhui-tabs-list-actived" )
                .siblings( "li" ).removeClass( "yhui-tabs-list-actived" );
        },

        _contextMenu: function() {
            var that = this,
                contextMenu = {
                    "刷新当前": function( e, target ) {
                        var $li = that._getContextMenuTab( target );
                        if ( $li[0] !== that.active[0] ) return;

                        that.refreshActive();
                    },

                    "关闭当前": function( e, target ) {
                        var $li = that._getContextMenuTab( target );
                        $li.find( "span.yhui-tabs-close" ).eq( 0 ).trigger( "click" )
                        && $( document.body ).trigger( "click" );
                    },

                    "关闭其他": function( e, target ) {
                        that._closeOthers( target );
                    },

                    "关闭全部": function() {
                        that._closeAll();
                    }
                };

            that.tabs.eq( 0 ).on( "contextmenu", function( e ) {
                e.stopPropagation();
            });
            that.tablist.eq( 0 ).yhContextMenu( {
                menu: contextMenu,
                width: 100,
                beforeShow: function( e, yhui ) {
                    var $li = that._getContextMenuTab( yhui.target ),
                        panelID = $li[0].getAttribute( "aria-controls" );

                    if ( yhui.target.nodeName.toLowerCase() === "ul" ) {
                        return false;
                    }

                    if ( that.tabs.length === 2 ) {
                        $( this ).yhContextMenu( "disableItem", 2 );
                    } else {
                        $( this ).yhContextMenu( "isItemDisable", 2 ) && $( this ).yhContextMenu( "enableItem", 2 );
                    }

                    $( "#" + panelID ).is( ":hidden" )
                        ? $( this ).yhContextMenu( "disableItem", 0 )
                        : $( this ).yhContextMenu( "isItemDisable", 0 ) && $( this ).yhContextMenu( "enableItem", 0 );
                }
            } );
        },

        _getContextMenuTab: function( target ) {
            return $( target ).closest( "li" );
        },

        _closeAll: function() {
            var that = this;
            this._beforeCloseCheck();
            this.tabs.not( ":first" ).each( function() {
                that._removeTab( $( this ), true );
            });
            this.refresh();
        },

        _closeOthers: function( target ) {
            var $li, that = this;
            this._beforeCloseCheck();

            $li = this._getContextMenuTab( target );

            if ( this.tablist.find( "li:first" )[0] !== this.active[0] ) {
                $li.siblings( "li" ).not( ":first" ).each( function() {
                    that._removeTab( $( this ), true );
                } );
                that.refresh();
                var index = that._getIndex( $li[0].getAttribute( "aria-controls" ) );
                that.option( "active", index );
            } else {
                this._closeAll();
            }
        },

        _beforeCloseCheck: function() {
            if ( this._arrowVisible() && parseInt( this.tablist.eq( 0 ).css( "left" ), 10 ) <= 0 ) {
                this.tablist.css( "left", 0 ).animate( {"left": "100px"} ).animate( {"left": 0} );
                this.animated = false;
                this._arrowFadeOut();
            }
        },

        _eventHandler: function( event ) {
            this._super( event );
            this.rightListUp &&
            this.rightListUp
                    .find( "li[data-yhui-tabid = '" + this.active[0].getAttribute( "aria-controls" ) + "']" )
                    .addClass( this._consts.LISTACTIVED )
                    .siblings().removeClass( this._consts.LISTACTIVED );
        },

        _timeOutIframeLoaded: function( $iframe, capture ) {
            var that = this;
           if ( $iframe.length ) {
                $iframe.on( that._parseEventType("load") , function() {
                    if ( that.options.showLoading ) {
                        clearTimeout( that.standTimer );
                        clearTimeout( that.timer );
                        that._timeOutEnd();
                    }

                    if ( capture ) {
                        try {
                            $( this.contentWindow.document ).on( that._parseEventType( "click" ), function() {
                                that._rightListHide();
                            });
                        } catch ( err ) {}
                    }
                });
            }
        },

        _timeOutStart: function() {
            var that = this;
            that.loading.on( "dialogbeforeclose", function() {
                if ( confirm( "确定要取消加载吗？" ) ) {
                    clearTimeout( that.standTimer );
                    clearTimeout( that.timer );
                    that._removeTab( that.active );
                } else {
                    return false;
                }
            } );
            that.standTimer = setTimeout( function() {
                that.loading.dialog( "open" );
                that.timer = setTimeout( function() {
                    var $loading = that.loading;
                    if ( $loading.length ) {
                        $loading.off( "dialogbeforeclose" );
                        $loading.dialog( "isOpen" ) && $loading.dialog( "close" );
                    }
                    that._removeTab( that.active );
                    alert( "抱歉，页面加载超时，请尝试重新打开！" );
                }, that.options.timeOut );

            }, this.options.standTimeout );

            
        },

        _timeOutEnd: function() {
            this.loading.off( "dialogbeforeclose" );
            this.loading.dialog( "isOpen" ) && this.loading.dialog( "close" );
        },

        update: function() {
            this._addTabCheck();
            this._removeTabCheck( true );
        },

        refreshActive: function() {
            var $iframe = this._getPanelForTab( this.active ).find( "iframe" );
            if ( $iframe.length ) {
                //$iframe[0].contentWindow.location.reload( true );
            	var src =$iframe[0].src;
            	$iframe[0].contentWindow.location =src;
            } else {
                if ( $.yhDialogTip && $.yhDialogTip.alert ) {
                    $.yhDialogTip.alert( "当前选项卡没有需要刷新的内容。", "温馨提示" );
                } else {
                    alert( "当前选项卡没有需要刷新的内容！" );
                }
            }
        },

        activeDefault: function() {
            this.rightListUp.find("li").last().trigger("click");
        },

        add: function( options ) {
            if ( !options ) return;
            var title = options.title || "选项卡",
                id = options.id || this._consts.TABID + $.now(),
                src = options.src || "",
                close = options.close || false,
                callback = options.callback || null,
                $tab = $( this._consts[ close ? "CTAB" : "TAB" ].replace( /\{href\}/, id ).replace( /\{title\}/g, title ) ),
                $panel = $( "<div id = '" + id + "'></div>" );

            this.tablist.append( $tab );
            ( this.container ? this.container : this.element).append( $panel );
            if ( src ) {
            	var ifHeight = "99%";
            	if($.yhui.isIE678){
            		ifHeight = "100%";
            	}
                var $iframe = $( "<iframe frameborder='0' style = 'width: 100%; height: "+ifHeight+"'></iframe>" ).appendTo( $panel );
                $iframe[0].src = src;
                this._timeOutIframeLoaded( $iframe, options.capture );
            }
            this.refresh();
            this.option( "active", this._getIndex( id ) );

            var yhui = {
                tab: $tab,
                panel: $panel
            };
            callback && callback.call( this.element, yhui );
            this._trigger( "add", null, yhui );
        }
    } );
})( jQuery );