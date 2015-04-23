/*!
 * YHUI yhLoading @VERSION
 *
 * Depends:
 *  jquery.ui.core
 *  jquery.ui.widget
 *  jquery.ui.position
 *  yhCore
 */
(function( $, undefined ){
    var guid = 0;
    $.widget( "yhui.yhLoading", {
        options: {
            opacity: 0.5,
            backgroundColor: "#FFF",
            duration: 500,
            size: "middle",
            autoOpen: true
        },
        
        _create: function() {
            this.id = "yhui-loaing-" + (this.element.attr( "id" ) || (guid++));
            if ( this.options.autoOpen ) {
                this.open();
            }
        },

        _parseData: function() {
            this.info = {
                width: this.element.outerWidth(),
                height: this.element.outerHeight()
            };
        },
        
        open: function() {
            this._parseData();
            var size = this.options.size;
            if ( size !== "middle" && $.inArray( size, ["small","big"] ) === -1 ) {
                size = "middle";
            }

            var loader = "<div class='yhui-loading-loader yhui-loading-{size}'></div>".replace(/\{size\}/, size );
            this.cover =
                $("<div></div>", {
                    "class": "yhui-loading"
                })
                .css({
                    "opacity": this.options.opacity,
                    backgroundColor: this.options.backgroundColor
                })
                .append( loader )
                .hide();

            this.element.attr( "hasloaing", this.id );
            this.cover
                .attr( "id", this.id )
                .css( this.info )
                .appendTo( this.document[0].body )
                .position({
                    my: "top left",
                    at: "top left",
                    of: this.element
                })
                .show();
            this.openFlag = true;
        },
        
        close: function() {
            this.element.removeAttr( "hasloaing" );
            this.cover
                .fadeOut( this.options.duration, function() {
                    $(this).remove();
                });
            this.openFlag = false;
        },

        isOpen: function() {
            return this.openFlag;
        },

        _destroy: function() {
            if ( this.openFlag ) {
                this.close();
            }
        }
        
    });
})( jQuery );
