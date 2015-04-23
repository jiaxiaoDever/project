/*!
 * YHUI yhCore @VERSION
 *
 * Depends:
 *  jquery
 */

(function( $ ) {
    $.yhui = $.yhui || {};
    if ( $.yhui.version ) return;
    $.extend( $.yhui, {
        version: "@VERSION",
        isIE: !!( document.all && window.ActiveXObject ),
        isIE6: !!( $.browser.msie && $.browser.version == 6 ),
        isIE67: !( $.support.getSetAttribute ),
        isIE678: !( $.support.opacity ),
        isIE8: !!( $.browser.msie && $.browser.version == 8 ),
        isIE9: !!( $.browser.msie && $.browser.version == 9 ),
        chrome: $.browser.chrome,
        ff: $.browser.mozilla,

        getHeight: function() {
            var i, len = arguments.length, height = 0;
            for ( i = 0; i < len; i++ ) {
                arguments[i].length && ( height += arguments[i].outerHeight() );
            }
            return height;
        },

        createTable: function( $dom, row, col ) {
            var table = [];
            if ( $.isArray( row ) ) {
                col = null;
                table.push( "<table>" );
                for ( var i = 0, l = row.length; i < l; i++ ) {
                    table.push( "<tr>" );
                    for ( var j = 0, len = row[i].length; j < len; j++ ) {
                        table.push( "<td>", row[i][j], "</td>" );
                    }
                    table.push( "</tr>" );
                }
                table.push( "</table>" );
                $dom.html( table.join( "" ) );
                return $dom.children( "table" );

            } else {
                table.push( "<table>" );
                for ( var i = 0; i < row; i++ ) {
                    table.push( "<tr>" );
                    for ( var j = 0; j < col; j++ ) {
                        table.push( "<td>", i + "行" + j + "列", "</td>" );
                    }
                    table.push( "</tr>" );
                }
                table.push( "</table>" );
                $dom.html( table.join( "" ) );
                return $dom.children( "table" );
            }
        },

        clone: function( obj ) {
            if ( obj === null ) return null;
            var o = obj.constructor === Array ? [] : {};
            for ( var i in obj ){
                o[i] = (obj[i] instanceof Date)
                            ? new Date(obj[i].getTime())
                            : (typeof obj[i] === "object"
                                ? arguments.callee(obj[i])
                                : obj[i]);
            }
            return o;
        },

        log: function( mess ) {
            window.console ? console.log( mess ) : alert( mess );
        },

        setDay: function( date, day ) {
            if ( typeof date === "string" ) {
                day = date;
                date = new Date();
            }
            var newDay,
                changeType = day.substring( 0, 1 ),
                numOfDay = parseInt( day.substring( 1 ) );

            if ( changeType === "+" ) {
                newDay = new Date( date.getTime() + numOfDay * 24 * 60 * 60 * 1000 );
            }

            if ( changeType === "-" ) {
                newDay = new Date( date.getTime() - numOfDay * 24 * 60 * 60 * 1000 );
            }

            return newDay ? newDay : null;
        },

        daysInMonth: function( year, month, date ) {
            date = date || new Date();
            year = year || date.getFullYear();
            month = month || date.getMonth();
            return 32 - new Date( year, month, 32 ).getDate();
        },

        adjust: function( period, offset, date ) {
            date = date || new Date();
            var day = period == "D" ? date.getDate() + offset : date.getDate(),
                month = period == "M" ? date.getMonth() + offset : date.getMonth(),
                year = period == "Y" ? date.getFullYear() + offset : date.getFullYear();
            if ( period != "D" ) {
                day = Math.max( 1, Math.min( day, this.daysInMonth( year, month, date ) ) );
            }
            return new Date( year, month, day, date.getHours(), date.getMinutes(), date.getSeconds() );
        },

        isLeapYear: function( year ) {
            year = year || new Date().getFullYear();
            return new Date( year, 1, 29 ).getMonth() == 1;
        },

        stringToDate: function( value, format ) {
            if ( !value ) return;
            format = format || "yyyy-MM-dd";
            return Globalize.parseDate( value, format );
        },

        getDocHeight: function( D ) {
            return Math.max(
                Math.max( D.body.scrollHeight, D.documentElement.scrollHeight ),
                Math.max( D.body.offsetHeight, D.documentElement.offsetHeight ),
                Math.max( D.body.clientHeight, D.documentElement.clientHeight )
            );
        },

        byId: function( id ) {
            return document.getElementById( id );
        },

        byTag: function( node, tag ) {
            var ret;
            if ( typeof node === "string" ) {
                ret = document.getElementsByTagName( node );
            }
            if ( node.nodeName ) {
                ret = node.getElementsByTagName( tag );
            }
            return ret;
        },

        objectLength: function( obj ) {
            if ( !$.isPlainObject( obj ) ) return;
            var count = 0;
            for ( var i in obj ) {
                count++;
            }
            return count;
        },

        getUserInfo: function() {
            var ua = navigator.userAgent,
                ret = $.uaMatch( navigator.userAgent );
            if ( ret.browser === "webkit" && !/1\.8/.test( $.fn.jquery ) ) {
                var r = /chrome\/([\d\.]+)/i, v;
                if ( v = r.exec( ua )[1] ) {
                    ret.browser = "chrome";
                    ret.version = v;
                }
            }

            if ( !ret.browser ) {
                ret.browser = "unknow";
                ret.version = "";
            }
            ret.ratio = screen.width + " x " + screen.height;
            return ret;
        },

        windowResize: function( fun, namespace, win ) {
            if ( !fun ) return;
            $( win || window ).on( "resize" + (namespace||""), function() {
                if ( !fun.yhuiTimer ) {
                    fun.yhuiTimer = setTimeout( function() {
                        fun.apply( window, arguments );
                        clearTimeout( fun.yhuiTimer );
                        fun.yhuiTimer = undefined;
                    }, 300 );
                }
            });
        },

        cookie: function( key, value, options ) {
            if ( arguments.length > 1 && (value === null || typeof value !== "object") ) {
                options = jQuery.extend( {}, options );

                if ( value === null ) {
                    options.expires = -1;
                }

                if ( typeof options.expires === 'number' ) {
                    var days = options.expires, t = options.expires = new Date();
                    t.setDate( t.getDate() + days );
                }

                return (document.cookie = [
                    encodeURIComponent( key ), '=',
                    options.raw ? String( value ) : encodeURIComponent( String( value ) ),
                    options.expires ? '; expires=' + options.expires.toUTCString() : '', // use expires attribute, max-age is not supported by IE
                    options.path ? '; path=' + options.path : '',
                    options.domain ? '; domain=' + options.domain : '',
                    options.secure ? '; secure' : ''
                ].join( '' ));
            }

            // key and possibly options given, get cookie...
            options = value || {};
            var result, decode = options.raw ? function( s ) {
                return s;
            } : decodeURIComponent;
            return (result = new RegExp( '(?:^|; )' + encodeURIComponent( key ) + '=([^;]*)' ).exec( document.cookie )) ? decode( result[1] ) : null;
        },

        expandTreeNode: function( nodes, tree, level ) {
            var n;
            level = level || 1000;
            for ( var i = 0, l = nodes.length; i < l; i++ ) {
                if ( nodes[i].level < level ) {
                    tree.expandNode( nodes[i], true, null, null, true );
                    if ( n = nodes[i].children ) {
                        arguments.callee( n, tree, level );
                    }
                }
            }
        },

        loadingFadeOut: function(fun) {
            $( "div.yhui-cover" ).fadeOut( 400, function() {
                $(this).remove();
                if ( fun ) {
                    fun.apply(null);
                }
            });
        },

        parseEventType: function( type, space ) {
            var ret;
            if ( type.indexOf( " " ) === -1 ) {
                ret = type + space;
            } else {
                var a = [];
                $.each( type.split( " " ), function( i, value ) {
                    a.push( value + space );
                });
                ret = a.join( " " );
            }
            return ret;
        },

        print: function( source, params ) {
            if ( !params ) return source;

            if ( arguments.length > 2 && params.constructor !== Array  ) {
                params = $.makeArray(arguments).slice(1);
            }
            if ( params.constructor !== Array ) {
                params = [ params ];
            }
            $.each(params, function( i, n ) {
                source = source.replace( new RegExp("\\{" + i + "\\}", "g"), function() {
                    return n;
                });
            });
            return source;
        },

        mapForm: function( form ) {
            var ret = {},
                fields = form.elements,
                len = fields.length,
                i = 0,
                flag;
            
            for ( ; i < len; i ++ ) {
                if ( flag = (fields[i].name || fields[i].id) ) {
                    ret[ flag ] =  fields[i].value;
                }
            }

            return ret;
        }
    });
})( jQuery );