/*!
 * YHUI yhButton @VERSION
 *
 * Depends:
 *  jquery.ui.core
 *	jquery.ui.widget
 */

(function( $ ){
	var handleCache = {}, disabledCache = [];

	$.widget( "yhui.yhButton", {
        version: "@VERSION",
		options:{
			form : null
		},
		_consts:{
			DOMSTRING: '<a id = "idHolder" class = "yhui-btn" href="javascript:void(0)">' + 
							'<span class = "yhui-form-icon classHolder"></span>textHolder</a>',
			NAME2CLASS: {
				submit 	: "yhui-btn-submit",
				back 	: "yhui-btn-back",
				confirm	: "yhui-btn-confirm",
				save 	: "yhui-btn-save",
				reset 	: "yhui-btn-reset",
				cancel 	: "yhui-btn-cancel",
				close 	: "yhui-btn-close",
				search 	: "yhui-btn-search",
				next 	: "yhui-btn-next",
				disabled: "yhui-btn-disabled"
			},
			
			NAME2TEXT: {
				submit 	: "提交",
				back 	: "返回",
				confirm	: "确定",
				save 	: "保存",
				reset 	: "重置",
				cancel 	: "取消",
				close 	: "关闭",
				search 	: "查询",
				next 	: "下一步"
			},
			
			ID: "yhButton_"
		},

		_create: function() {
			this._initDom();
			this._events();
		},

		_init: function() {
			if ( this.options.align ) { // btnHolder的align
				this._checkAlign( this.options.align );
			}
			
			if ( this.options.space ) {
				this._checkSpace( this.options.space );
			}
			if ( this.options.form ) {
				this.options.form = this.options.form.find("form")[0]||this.element.closest("form");
			}

			if ( disabledCache.length ) { //禁用的处理
				$( disabledCache.join( "," ) ).addClass( this._consts.NAME2CLASS.disabled )
					.on("click.yhButton", function() { return false; });
			}
		},

		_initDom: function() {
			var that = this,
				items = this.options.items,
				i = 0, l = items.length,
				disabled = false, id = "",
				domOfArr = [], domOfStr = "";
			
			if ( !items || !$.isArray( items ) ) return $.yhui.log( "请检查items属性是否为数组！" );
			
			this.element.addClass( "yhui-button" ).empty();
			this.wrap = $( "<div class = 'yhui-btn-holder yhui-button-inner'></div>" ).appendTo( this.element );
			
			for ( ; i < l; i ++ ) {
				disabled = !!items[i].disabled;
				
				//渲染ID
				id = items[i].id || this._consts.ID + i;
				domOfStr = this._consts.DOMSTRING.replace( /idHolder/, id );
				
				//渲染样式
				if(items[i].css){
					domOfStr=domOfStr.replace( /classHolder/, items[i].css );
				}else{
					domOfStr=domOfStr.replace( /classHolder/, this._consts.NAME2CLASS[ items[i].type ] );
				}
				
				//添加自定义的名称 text为名称属性
				if(!items[i].text){
					domOfStr=domOfStr.replace( /textHolder/, this._consts.NAME2TEXT[ items[i].type ] );
				}else{
					domOfStr=domOfStr.replace( /textHolder/, items[i].text );
				}
				
				if ( disabled ) {
					disabledCache.push( "#" + id );
				}
				domOfArr.push( domOfStr );
				
                if ( items[i].type === "reset" && !items[i].onClick ) {
                    items[i].onClick = function() {
                        var $form = that.options.form;
                        if ( $form.length ) {
							$form[0].reset();
						} else {
							$.yhui.log( "按钮不在表单中！" );
						}
					};
				}else if ( items[i].type ==="submit") {
                    items[i].onClick = function() {
                        var $form = that.options.form;
                        if ( $form.length ) {
                            $form.submit();
                        } else {
                            $.yhui.log( "按钮不在表单中！" );
                        }
                    };
                }else if ( items[i] === "back" && !items[i].onClick ) {
                    items[i].onClick = function() {

                    };
                }
				
				
				
				if ( items[i].onClick ) {
					handleCache[ id ] = items[i].onClick;
				}	
				
			}
			
			this.wrap.append( domOfArr.join("") );
		},

		_events: function() {
			var that = this;
			this.element
				.off( "click.yhButton" )
				.on( "click.yhButton", "a", function( e ) {
					handleCache[ this.id ] && handleCache[ this.id ].call( this, e, that.options.form, that.element, that );
				});
		},

		_checkAlign: function( align ) {
			var match = /^(left|center|right)((?:\+|-)\d+)?/.exec( align );
			
			if ( match[1] && !match[2] ) {
				this.wrap.css( "textAlign", align );
			} else if ( match[1] && match[2] ) {
				this.wrap.css({ 
					textAlign: match[1],
					marginLeft : match[2] + "px"
				});
			} else {
				$.yhui.log( "align的值不正确！" );
			}
		},

		_checkSpace: function( space ) {
			if ( typeof( space ) !== "number" ) return;

			this.wrap.find("a").not(":first").css( "marginLeft", space + "px" );
		},

		_setOption: function( key, value ) {
			if ( key === "align" ) {
				this._checkAlign( value );
			}

			if ( key === "space" ) {
				this._checkSpace( value );
			}

			this._super( key, value );
		},

		enable: function( type ) {
			this.option( "disable", false );
			var selector = "a:has(span." + this._consts.NAME2CLASS[ type ] + "):first";
			this.element.find( selector )
				.removeClass( this._consts.NAME2CLASS.disabled )
				.off("click.yhButton");
		},
		
		disable: function( type ) {
			this.option( "disable", true );
			var selector = "a:has(span." + this._consts.NAME2CLASS[ type ] + "):first";
			this.element.find( selector )
				.addClass( this._consts.NAME2CLASS.disabled )
				.on("click.yhButton", function() { return false; });
		},
		
		//通过id控制按钮可用 add by xxz
		enableBtn:function(id){
				this.option( "disable", false );
				$("#"+id).removeClass( this._consts.NAME2CLASS.disabled )
				.off("click.yhButton");
		},
		//通过id控制按钮禁用 add by xxz
		disableBtn:function(id){
			this.option( "disable", true );
				$("#"+id).addClass( this._consts.NAME2CLASS.disabled )
				.on("click.yhButton", function() { return false; });
		},

		isDisable: function( type ) {
			var selector = "a:has(span." + this._consts.NAME2CLASS[ type ] + "):first";
			return this.element.find( selector ).hasClass( this._consts.NAME2CLASS.disabled );
		}
	});
})(jQuery);