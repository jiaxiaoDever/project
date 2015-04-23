/*!
 * YHUI yhMenu @VERSION
 * imitate zTree and salute zTree
 * Depends:
 *  jquery.ui.core
 *	jquery.ui.widget
 */

(function( $ ){
    $.widget( "yhui.yhPlaceholder", {
        version: "@VERSION",
        defaultElement: "<input>",
        options: {
            placeholder: ""
        },
        _create: function() {
            this._holderParse();
        },
        _holderParse: function() {
            if ( !this._checkPlaceholder() ) {
                this.holderText = this.options.placeholder 
                                    ? this.options.placeholder 
                                    : this.element.attr( "placeholder" );
                                    
                if ( this.holderText ) {
                    this._addHolder();
                    this._holderBindEvent();
                }
            }
        },
        _holderBindEvent: function() {
            var that = this;
            this.element
                .on( "focusin" + this.eventNamespace, function() {
                    that._removeHolder();
                })
                .on( "focusout" + this.eventNamespace, function() {
                    that._addHolder();
                })
                .on( "keyup" + this.eventNamespace, function( e ) {
                    if ( e.keyCode === $.ui.keyCode.DELETE || e.keyCode === $.ui.keyCode.BACKSPACE ) {
                        that._addHolder( true );
                    }
                })
                .on( "keydown" + this.eventNamespace, function() {
                    if ( that.element.hasClass("yhui-placeholder") ) {
                        that._removeHolder();
                    }
                });
        },
        _addHolder: function( caretFlag ) {
            if ( this.element.val() === "" ) {
                this.element.addClass("yhui-placeholder").val( this.holderText );
                if ( caretFlag ) {
                    this._fixCaret();
                }
            }
        },
        _removeHolder: function() {
            this.element.val() === this.holderText && this.element.removeClass("yhui-placeholder").val( "" );
        },
        _checkPlaceholder: function() {
            var input = this.document[0].createElement("input");
            var ret = "placeholder" in input;
            input = null;
            return ret;
        },
        _fixCaret: function() {
            if ( this.element[0].selectionStart ) {
                this.element[0].selectionStart = 0;
                this.element[0].selectionEnd = 0;
            } else {
                var selRange = this.element[0].createTextRange();
                selRange.collapse( true );
                selRange.moveStart( "character", 0 );
                selRange.moveEnd( "character", 0 );
                selRange.select();
            }
        }
    });
})(jQuery);