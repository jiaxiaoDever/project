/*!
 * YHUI yhLayout @VERSION
 *
 * Depends:
 *  jquery.layout
 */
 (function( $ ){
 	if ( !$.layout ) return $.yhui.log( "no layout plugin!" );
	$.fn.yhLayout = function( options ) {
		if ( typeof options === "string" ) {
			var lt = $.data( this[0], "layout" ),
				args = Array.prototype.slice.call( arguments, 1 );
			if ( lt ) {
				if ( $.isFunction( lt[ options ] ) ) {
					lt[options].apply( lt, args );
				} else {
					$.yhui.log( "没有" + options + "方法！" );
				}
			}
			return;
		}	
		var dfts = {
			defaults: {
				togglerTip_open:		"隐藏",
				togglerTip_closed:		"展开",
				fxName:					"none",
				togglerLength_open:		53,
				togglerLength_closed:	53,
				maskContents: true
			},
			north: {
				size: 					64,
				spacing_open: 			8,
				spacing_closed:  		8,
				showOverflowOnHover: 	true,
				resizerTip:				"上下拖动"
			},
			west: {
				size: 					240,
				togglerLength_open:		54,
				togglerLength_closed:	54,
				resizerTip:				"左右拖动"
			},
			south: {
				size: 					64,
				spacing_open: 			8,
				spacing_closed:  		8,
				resizerTip:				"上下拖动"
			}
		},
		opts = $.extend( true, dfts, options );
		if ( opts.addBorder ) {
			$( document.body ).addClass( "yhui-layout-border" )
				.find("div.yhui-header").addClass( "yhui-layout-border-bottom" );
		}
		this.layout( opts );
		return this;
	};
 })(jQuery);