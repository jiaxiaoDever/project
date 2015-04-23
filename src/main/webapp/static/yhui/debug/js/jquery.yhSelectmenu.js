/*!
 * YHUI yhSelectmenu @VERSION
 *
 * Depends:
 *  jquery.ui.core
 *  jquery.ui.widget
 *  jquery.ui.selectmenu
 *  yhCore
 */
(function( $, undefined ) {
    $.widget("yhui.yhSelectmenu", $.ui.selectmenu, {
        version: "@VERSION",
        options: {
            firstItem: "请选择",
            type: null,
            maxHeight: 200,
            width: 154,
            renderItem: null,
            month: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", 
                "八月", "九月", "十月", "十一月", "十二月"],
            zIndex: 0
        },

        _create: function() {
            this.element.addClass("yhui-form-select");
            var width = this.options.width;
            if ( width > 0 ) {
                this.element.width( width );
            }
            this._checkType();
            this._super();
        },

        _checkType: function() {
            var type = {},
                t = this.options.type;

            if ( typeof t === "string" ) {
                type.type = t;
            } else if ( t ) {
                type = t;
            }
            if ( t && !type.type ) $.yhui.log( "type 值出错" );
            
            switch ( type.type ) {
                case "month":
                    type.selected = type.selected || 0;
                    this._month( type.selected );
                    break;
                case "year":
                    type.range = type.range || 5;
                    type.selected = type.selected || 0;
                    this._year( type );
                    break;
            }
        },

        _month: function( def ) {
            this.element.empty();
            var option = "<option value='{val}'>{text}</option>",
                rVal = /\{val\}/,
                rText = /\{text\}/,
                opts = [];
            if ( this.options.firstItem ) {
                opts = [ option.replace( rVal, "" ).replace( rText, this.options.firstItem ) ];
            }
            $.each( this.options.month, function( index, month ) {
                opts.push( option.replace( rVal, index + 1 ).replace( rText, month) );
            });
            this.element.append( opts )[0].options[def].selected = true;
        },

        _year: function( info ) {
            this.element.empty();
            var year = new Date().getFullYear(),
                option = "<option value='{val}'>{text}</option>",
                rVal = /\{val\}/,
                rText = /\{text\}/,
                opts = [],
                range = typeof info.range === "number" ? [] : info.range;
            if ( this.options.firstItem ) {
                opts = [ option.replace( rVal, "" ).replace( rText, this.options.firstItem ) ];
            }
            if ( typeof info.range === "number" ) {
                range[0] = year - info.range;
                range[1] = year + info.range;
            }
            range[1] += 1;
            for ( var i = range[0]; i < range[1]; i++ ) {
                opts.push( option.replace( rVal, i ).replace( rText, i ) );
            }

            this.element.append( opts );

            if ( info.selected === 0 ) {
                this.element[0].options[0].selected = true;
            }
            if ( info.selected === "now" ) {
                this.element.find("option[value=" + year + "]" )[0].selected = true;
            }
            if ( typeof info.selected === "number" && info.selected >= range[0] && info.selected <= range[1] ) {
                this.element.find("option[value=" + info.selected + "]" )[0].selected = true;
            }
        },
        /**
         * overwrite super method
         * @private
         */
        _drawMenu: function() {
            this._super();
            var zIndex = this.options.zIndex;
            if ( zIndex ) {
                this.menuWrap.zIndex( zIndex );
            }

        },
        /**
         * overwrite super method
         * @private
         */
        _drawButton: function() {
            this._super();
            this.button.on( "click" + this.eventNamespace, "span.ui-icon-triangle-1-s", function() {
                $(this.parentNode).trigger("focus");
            });
        },
        /**
         * overwrite super method
         * @private
         */
        _toggleAttr: function() {
            this._super();
            if ( !this.calHeight ) {
                if ( this.menu.outerHeight() > this.options.maxHeight ) {
                    this.menu.css({
                        "overflow-y": "auto",
                        "overflow-x": "hidden",
                        height: 200
                    });
                }
                this.calHeight = true;
            }
        },
        /**
         * overwrite super method
         * @private
         */
        _renderItem: function( ul, item ) {
            var render = this.options.renderItem;
            if ( render && $.isFunction(render) ) {
                return render.call( this, ul, item );
            }
            var li = $( "<li>" ).data( "ui-selectmenu-item", item ),
                a = $( "<a>", { href: "#" });

            if ( item.disabled ) {
                li.addClass( "ui-state-disabled" );
            }
            this._setText( a, item.label );

            return li.append( a ).appendTo( ul );
        },
        setValue:function(v){
        	if($.type(v)=='undefined'||v===''){
        		this.element[0].value = this.element[0].options[0].value;
        		this.buttonText.text( this.element[0].options[0].text );
        		return;
        	}
        	this.element[0].value=v;
        	var index = this.element[0].selectedIndex;
        	this.buttonText.text( this.element[0].options[index].text );
        },
        setText:function(text){
        	this.buttonText.text( text );
        }
    });
})( jQuery );
