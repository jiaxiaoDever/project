/*!
 * YHUI yhDialogTip @VERSION
 *
 * Depends:
 *  jquery.ui.core
 *  jquery.ui.widget
 *  jquery.ui.dialog
 *  yhCore
 */
(function( $, doc, undefined ){
    if ( $.yhDialogTip && $.yhDialogTip.alert ) return;
    var Dialog = function() {};
    $.extend( Dialog.prototype, {
        _defaults: {
            draggable: false,
            resizable: false,
            position: [ "center", "center-15%" ],
            show: { effect: "drop", direction: "up", duration: 300 },
            hide: { effect: "drop", direction: "up", duration: 300 },
            create: function() {
                $( this )
                    .dialog( "widget" )
                    .addClass( "yhui-dialogtip" )
                    .find( "a.ui-dialog-titlebar-close" ).hide();
            },
            close: function() {
                $(this).dialog( "destroy" ).remove();
            },
            open: function() {
                $.yhui.isIE67 && $( this ).dialog( "widget" ).find( "button" ).blur();
            }
        },
        _map: {
            alert: "警告",
            confirm: "确认",
            error: "错误"
        },
        _config: {
            showLogo: true,
            cancel: function() {
                $( this ).dialog( "close" );
            },
            cancelButton: false,
            cancelText: "取消",
            okText: "确定",
            modal: true
        },
        _parse: function( type, config ) {
            config = $.extend( {}, this._config, config );
            var buttons = [];

            buttons.push({
                text: config.okText,
                click: function() {
                    if ( config.ok.apply( this, arguments ) === false ) return;
                    $( this ).dialog( "close" );
                }
            });

            if ( config.cancelButton ) {
                buttons.push({
                    text: config.cancelText,
                    click: config.cancel
                });
            }

            var dialogOptions = {
                buttons: buttons,
                modal: config.modal,
                title: config.title
            };

            var tipContent = "<td class = 'yhui-dialogtip-message'>" + config.message + "</td>";
            if ( config.showLogo ) {
                tipContent = "<td class = 'yhui-dialogtip-logo " + "yhui-dialogtip-" + type + "'></td>" + tipContent;
            }
            $( "<div class='yhui-dialogtip-content'></div>" )
                .prepend( "<table><tr>" + tipContent + "</tr></table>" )
                .appendTo( doc.body )
                .dialog( $.extend(true, {},this._defaults, dialogOptions) );
        },
        del:function(grid,url,params){
        	config = {
					title : "删除",
					message : "是否确认删除？<br/>删除用户后，该用户将不能登陆本系统。",
					cancelButton : true,
					ok : function() {
						$.ajax({
							type : "POST",
							dataType : "json",
							url : url,
							data : params,
							success : function(data, textStatus) {
								if (data.success) {
									grid.trigger("reloadGrid");
									$.yhDialogTip.confirm(data.title, data.reason); // 嵌套使用
								} else {
									$.yhDialogTip.error(data.title, data.reason);
								}
							}
						});
					}
				};
        	this._parse( "alert", config );
        }
    });

    $.each( "alert confirm error".split(" "), function( index, item ) {
        Dialog.prototype[ item ] = function( message, title, callback ) {
            if ( !message ) return;
            var config;
            if ( typeof message === "string" ) {
                if ( !title ) {
                    title = this._map[ item ];
                    callback = $.noop;
                }
                if ( title && $.isFunction(title) ) {
                    callback = title;
                    title = this._map[ item ];
                }
                if ( !callback ) {
                    callback = $.noop;
                }

                config = {
                    title: title,
                    message: message,
                    ok: callback
                };
            } else {
                if( !message.ok ) {
                    message.ok = $.noop;
                }
                if ( !message.title ) {
                    message.title = this._map[ item ];
                }
                config = message;
            }

            this._parse( item, config );
        };
    });

    $.yhDialogTip = new Dialog();
})(jQuery, window.document);