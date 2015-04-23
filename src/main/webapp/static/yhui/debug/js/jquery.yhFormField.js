/*!
 * YHUI yhPortlet @VERSION
 *
 * Depends:
 *  jquery.ui.core
 *	jquery.ui.widget
 */
(function( $ ) {

	$.widget( "yhui.yhFormField", {
        version: "@VERSION",
		options: {
			hoverable: false,
			haveTitle: false,
			onlyTable: false,
            submit: true
		},

		_create: function() {
            var isForm = this.element[0].nodeName.toLowerCase() === "form";
			if ( !isForm && !this.options.onlyTable ) {
				return $.yhui.log( "yhFormField作用于表单(form)元素" );
			}
            if ( !this.element.children( "table" ).length && !this.options.onlyTable  ) {
                return $.yhui.log( "找不到表格，无法渲染样式。" );
            }
			var opts = this.options;
			this.table = opts.onlyTable ? this.element.addClass("yhui-formfield") : this.element.addClass("yhui-formfield").children( "table" ).eq( 0 );
			this._parse();
			this._events();
			this.element.is( ":hidden" ) && this.element.fadeIn( 300 );
            if ( isForm && !this.element.find( ":submit" ).length && this.options.submit ) {
                $( "<input type='submit' role='formfield' />" ).hide().appendTo( this.element );
            }
		},
		
		_parse: function() {
			var that = this, l = 0;
			this.table.addClass( "yhui-formfield-table" )
					.find( "tr" )
					.each(function() {
						if ( $(this).children("td").length > l ) {
							l = $(this).children("td").length;
						}
					})
					.each(function() {
						var $td = $(this).children( "td" );
						if ( l === 2 || l === 4 || l === 6 ) {
							that._renderTd( $td, l );
						} else if ( !that.options.haveTitle ) {
							//$.yhui.log( "yhFormField暂时只支持2、4、6列！" );
						}
					});

			if ( this.options.haveTitle ) {
				this.table.find("td[colspan=4]").css({"text-align":"left","font-weight":"bold","text-indent":"4em"});
			}	
		},
		
		_renderTd: function( $td, l ) {
			$td.filter("td:even").addClass("column" + l + "Even").end()
				.filter("td:odd").addClass("column" + l + "Odd").end()
				.find("select").addClass("yhui-form-select").end()
				.find("input[type=text], input[type=password], input[type=date], input[type=number]")
                .not("[disabled]").addClass("yhui-form-text");
		},

		_events: function() {
			if ( this.options.hoverable ) {
				this.element.find("tr").hover( function() {
					$(this).children( "td" ).toggleClass( "hover" );
				});
			}
		}
	});
})(jQuery);