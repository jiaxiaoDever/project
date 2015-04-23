/*!
 * YHUI yhScrollTab @VERSION
 *
 * Depends:
 *  jquery.ui.core
 *	jquery.ui.widget
 */

(function( $ ){
	$.widget("yhui.yhScrollTab", {
        version: "@VERSION",
		options: {
			duration: 500,
			selected: 0,
			fillSpace: false,
			height: 300,
			select: null
		},
		_create: function() {
			var self = this;
				
			this.ul = this.element.children("ul").eq(0);	
			this.li = $(">li:has(a[href])", this.ul);
			this.titles = {};
			this.tops = {};
			this.anchors = this.li.map(function() {
				var $a = $("a", this),
					name = $a[0].href.match(/#([\w-]+)$/i)[1];
                self.titles[name] = $a.text();
				return $a[0];
			});
			this.panelContainer = this.element.children("div");
			this.panel = this.panelContainer.children("div");
			
			this._parse( self );
			this._events( self );
			this.select( this.panel[0].id );
		},
		_init: function() {
			this.element.children("div").height( this.options.height );
		},
		_parse: function( self ) {
			this.element.addClass("ui-tabs ui-widget ui-widget-content ui-corner-all yhui-scrolltabs");
			this.ul.addClass("ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all");
			this.li.addClass("ui-state-default ui-corner-top");
			this.panelContainer.addClass("ui-widget-content yhui-scrolltabs-panelContainer");
			this.panel.addClass("ui-tabs-panel ui-widget-content ui-corner-bottom yhui-scrolltabs-panel").each(function() {
				var $titleDom = $("<h3></h3>", { 
					id: this.id + "_title", 
					text: self.titles[ this.id ],
					"class": "ui-widget-header ui-corner-all yhui-scrolltabs-title"
				});
				$(this).wrap("<div></div>").parent().prepend( $titleDom );
			});
			this.panel.each(function() {
				self.tops[ this.id ] = $(this).parent().position().top;	
			});
		},
		_events: function(self) {
			var addState = function( state, el ) {
					if ( el.is( ":not(.ui-state-disabled)" ) ) {
						el.addClass( "ui-state-" + state );
					}
				},
				removeState = function( state, el ) {
					el.removeClass( "ui-state-" + state );
				};
			
			this.li.on( "mouseover.yhScrollTabs" , function() {
				addState( "hover", $( this ) );
			}).on( "mouseout.yhScrollTabs", function() {
				removeState( "hover", $( this ) );
			});
			this.anchors.on("click.yhScrollTabs", function(e) {
				//$(this).parent("li").addClass("ui-state-active yhui-scrolltabs-actived")
				//			.siblings("li").removeClass("ui-state-active yhui-scrolltabs-actived");
				e.preventDefault();
			});
			this.element.on("click.yhScrollTabs", "a", function() {
				var id = this.href.match(/#([\w-]+)$/i)[1];
				self.panelContainer.off("scroll");
				self.select( id );
			});
			
			this.panelContainer.on("scroll.yhScrollTabs", { self: self }, self._scrollEvent);
		},
		_scrollEvent: function() {
			
		},
		_destroy: this.destroy,
		destroy: function() {
			this._destroy();
		},
		add: function() {},
		select: function( id ) {
			var li = this.anchors.parent("li").removeClass("ui-state-active")
							.filter( function(){
								return $(this).has('a[href$="#' + id + '"]').length && this;
							}).addClass("ui-state-active"),
				self = this;			
							
			this.panel.prev("h3").removeClass("yhui-scrolltabs-actived")
				.filter(function(){return this.id === id + "_title"}).addClass("yhui-scrolltabs-actived");
			this.panelContainer.animate( {"scrollTop": this.tops[ id ]}, function() {
				self.panelContainer.off("scroll").on("scroll.yhScrollTabs", self._scrollEvent);//因为避免事件冲突被解绑的函数得重新绑定
			} );
		}
	});
})(jQuery);