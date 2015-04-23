/*!
 * YHUI yhButton @VERSION
 *
 * Depends:
 *  jquery.ui.core
 *	jquery.ui.widget
 *  jquery.jqGrid
 */
(function( $, undefined ){
    if ( !$.fn.jqGrid ) {
        return $.yhui.log( "没有找到 jqGrid 插件!" );
    }
    //获取缓存的原始数据
	$.jgrid.extend({
		getRawData : function(rowId) {
			return this.rawData[rowId];
		}
	});
    var Grid = function( table, options ) {
        this.element = table;
        this.options = options;
    };
  
    $.extend( Grid.prototype, {

        version: "@VERSION",

        init: function() {
            var opts = this.options;

            if ( !opts.datatype ) {
                opts.datatype = "json";
            }

            if ( opts.heightStyle === "fill" && opts.autowidth ) {
                opts.autowidth = false;
            }

            if ( opts.treeGrid ) {
                opts.treeIcons = {
                    plus: "ui-icon-plus",
                    minus: "ui-icon-minus",
                    leaf: "ui-icon-document"
                };
                opts.ExpandColClick = true;
            }

            this.parent = this.element.parent();
            this.grid = this.element.jqGrid( opts );
           
            if ( opts.heightStyle === "fill" ) {
//            	 this._setHeight(26);
//                 this._setWidth();
            	this.refresh();
            }

            if ( opts.contextmenu ) {
                this._contextmenu();
            }

            /*if ( opts.pager ) {
                this._adjustPager();
            }*/
            return this.grid;
        },

        refresh: function() {
            this._setHeight();
            this._setWidth();
        },

        _setHeight: function() {
        	var opts = this.options;
            //  var $viewBox = this.grid.closest( "div.ui-jqgrid-bdiv" ).siblings().not( ".frozen-div, .frozen-bdiv" ),
                totalHeight = this.parent.height(),
                noNeedHeight = 0;
            
//            this.grid.closest( "div.ui-jqgrid" )
//                .children().not( ".ui-jqgrid-view,.loading" ).add( $viewBox )
//                .each(function() {
//                    if ( $(this).is(":visible") ) {
//                        noNeedHeight += $( this ).outerHeight();                    
//                    }
//                });
//          
            //$.yhui.log(this.parent);
            //this.grid.jqGrid( "setGridHeight", totalHeight - noNeedHeight-60);
            this.grid.jqGrid( "setGridHeight", totalHeight - (opts.fixHeight?opts.fixHeight:58));
        },

        _setWidth: function() {
            this.grid.jqGrid( "setGridWidth", this.parent.width() - 2 );
        },

        _contextmenu: function() {
            var nameMap = {},
                menu = {},
                i = 0, that = this,
                domString = "",
                colName = this.options.colName || [],
                colModel = this.options.colModel,
                len = colModel.length;

            for( ; i < len; i ++ ) {
                var label = colName[i] || colModel[i].label;
                var id = "yhui-grid-ctxitem-" + i;
                nameMap[ label ] = colModel[i].name;
                domString = "<input id='" + id
                    + "' type='checkbox' checked/><label for='" + id
                    + "' style = 'position:relative; cursor: pointer; top:-2px; margin-left:5px;'>"
                    + label
                    + "</label>";
                menu[ domString ] = function() {
                    var check = this.firstChild;
                    that._contextCheck( check.checked, check, nameMap[ this.lastChild.innerHTML ] );
                };
            }

            $( "#gbox_" + this.grid.attr("id") ).yhContextMenu({
                menu: menu,
                createdMenu: function( e, yhui ) {
                    yhui.menu.on( "click", ":checkbox", function(e){
                        e.stopPropagation();
                        that._contextCheck( !this.checked, this, nameMap[this.nextSibling.innerHTML] );

                    });
                }
            });
        },
        
        _contextCheck: function( status, check, name ) {
            if ( status ) {
                check.checked = false;
                this.grid.yhGrid( "hideCol", name );
            } else {
                check.checked = true;
                this.grid.yhGrid( "showCol", name );
            }
            this.refresh();
        }
        /*_adjustPager: function() {
            $( this.options.pager ).find( "td" ).first().width( 100 );
        }*/
    });

    $.extend( $.fn, {
        yhGrid: function( opts ) {
        	var _this = this;
            if ( typeof opts === "string" ) {
                var grid = $.data( this[0], "yhGrid" );
                if ( opts.indexOf("_") !== 0 && $.isFunction(grid[opts]) ) {
                    grid[ opts ].apply( grid, arguments );
                    return this;
                }

                var ret = this.jqGrid.apply( this, arguments );

                if ( opts === "filterToolbar" || opts === "setGroupHeaders" ) {
                    grid.refresh();
                    return this;
                }

                return ret;

            }
            //缓存原始数据
            var func = function(){};
            if($.isFunction(opts.loadCompulate)){
            	func = opts.loadCompulate;
            }
            opts.loadComplete = function(page){
            	var data = {};
            	if(page.result){
            		for(var i in page.result){
            			data[page.result[i].id]=page.result[i];
            		}
            		_this.rawData = data;
            	}
            	func();
            };
            
            var yhGrid = new Grid( this, opts );
            $.data( this[0], "yhGrid", yhGrid );
            return yhGrid.init();
        }
    });

})(jQuery);