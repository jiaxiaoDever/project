/*!
 * YHUI yhSearchBox @VERSION
 *
 * Depends:
 *  jquery.ui.core
 *  jquery.ui.widget
 *  jquery.ui.select
 */

(function( $ ){
	
	$.widget( "yhui.yhSelector", {
        version: "@VERSION",
		options: {
			width: 400,
			height: 120,
			middleWidth: 40,
			type: "list",
			leftDataUrl: "",
			leftData: [],//存放左边列表数据
			rightDataUrl: "",
			rightData: [],//存放右边已选数据
			key: "name",
			idKey:"id",//作为左右列表项的id，用name判断会有重名情况
			dbClick:false,
			rightKeyHashMap:new Object()//已选的数据hashMap,作为重复数据判断用
			
		},
		
		_create: function() {
			this._createDoms();
			this._setupEvent();
		},

		_init: function() {
			var opts = this.options,
				that = this;
				
			//初始化过程的时候，顺便给Aarry增加删除项功能
			Array.prototype.del=function(dx) {　//n表示第几项，从0开始算起。
				if(isNaN(dx)||dx>this.length){return false;}
			　　for(var i=0,n=0;i<this.length;i++)
			　　{
			　　　　if(this[i]!=this[dx])
			　　　　{
			　　　　　　this[n++]=this[i]
			　　　　}
			　　}
			　　this.length-=1
				　　
			};
			
			if ( opts.leftDataUrl && ( !$.isArray( opts.leftData ) || !opts.leftData.length ) ) {
				if ( opts.type === "list" ) {
					$.getJSON( opts.leftDataUrl, function( data ) {
						if(opts.rightDataUrl!=""){
							$.getJSON( opts.rightDataUrl, function( rData ) {
								for(var j=0; j<rData.length; j++){					
									for (var i=0 ; i < data.length; i ++ ) {		
											if(rData[j][opts.key]==data[i][opts.key]) {	
												data.splice(i,1);							
											}
										}
								}
							
							
							that._initLeftList( data );
							that._initRightList( rData );
						});
							}else{//console.log(data);
						var   rd=opts.rightData;
						if(rd){
							for(var j=0; j<rd.length; j++){					
								for (var i=0 ; i < data.length; i ++ ) {		
										if(rd[j][opts.key]==data[i][opts.key]) {
										
											data.splice(i,1);
										
										}
									}
							}
						
							//console.log(rd);
						that._initLeftList( data );
						that._initRightList( opts.rightData );
						}else{that._initLeftList( data );};
						
					}});
				}
			} else {
				this._initLeftList( opts.leftData );
			}
		},

		_getCreateOptions: function() {
			return {
				obj: this
			};
		},

		_createDoms: function() {
			var that = this;
			this.element.empty()
				.addClass("yhui-selector ui-widget-content ui-helper-clearfix")
				.width( this.options.width < 150 ? 150 : this.options.width ).height( this.options.height < 120 ? 120 : this.options.height );

			this.leftPanel = $("<div class = 'yhui-selector-panel yhui-selector-leftpanel' ></div>").appendTo( this.element );
			this.rightPanel = $("<div class = 'yhui-selector-panel yhui-selector-rightpanel'></div>").appendTo( this.element );
			this._setPanelWH();
			//初始化按钮
			this.btnContainer = $( "<div class = 'yhui-selector-btncontainer'></div>" ).appendTo( this.element );
			$.each( "triangle-1-e triangle-1-w seek-next seek-prev".split(" "), function( i, value ) {
				$( "<div class = 'yhui-selector-btn' role = 'btn_" + i + "' ><span class = 'ui-icon ui-icon-" 
						+ value + "' ></span></div>" ).appendTo( that.btnContainer );
			});
			this.btn = this.btnContainer.find( "div.yhui-selector-btn" );

		},

		_calPanelWH: function() {
			return {
				width: ( this.element.width() - this.options.middleWidth )/2
			,	height: this.element.height()
			};
		},

		_setPanelWH: function() {
			var panelWH = this._calPanelWH();
			this.leftPanel.add( this.rightPanel ).width( panelWH.width ).height( panelWH.height );
		},

		_setupEvent: function() {
			var that = this, opts = this.options;
			//hover状态
			this._hoverable( this.btn );
			if ( opts.type === "list" ) {
				this.leftPanel.add( this.rightPanel ).on( "mouseenter." + this.eventNamespace, "div", function() {
					$(this).addClass( "yhui-state-hover" );
				}).on( "mouseleave." + this.eventNamespace, "div", function() {
					$(this).removeClass( "yhui-state-hover" );
				});
			}

			//按钮事件
			this.btnContainer.on( "click", "div", function() {
				switch ( this.getAttribute("role") ) {
					case "btn_0": that._leftToRight();
						break;
					case "btn_1": that._rightToLeft();
						break;
					case "btn_2": that._allLeftToRight();
						break;
					case "btn_3": that._allRightToLeft();
						break;		
				}
			});
		},

		_initLeftList: function( data ) {
			this._cancelLoading();
			var listHtml;
			//清除掉左边数据,并且重新赋值
			 this.options.leftData =[] ;
			//$.isArray ( data ) && ( listHtml = this._createList( data ) );
			if($.isArray ( data )){
				this.options.leftData = data;
				listHtml = this._createList( data );
			}else if(data && data.constructor==Object){
				if(data.result && data.result.constructor == Array){
					this.options.leftData = data.result;
					listHtml = this._createList( data.result );
				}
			}
			
			listHtml !== "" && this.leftPanel.append( listHtml ).selectable();
			this.leftPanel.find( "div.selectli" ).each(function( i ) {
				$(this).data(  "yhSelectorData", data[i] );
			});
		},
		_initRightList: function( data ) {
			this._cancelLoading();
			var listHtml;
			//清除掉右边数据
			this.options.rightData = [] ;
			if($.isArray ( data )){
				this.options.rightData = data;
				listHtml = this._createList( data );
			}
			//$.isArray ( data ) && ( listHtml = this._createList( data ) );
			listHtml !== "" && this.rightPanel.append( listHtml ).selectable();
			this.rightPanel.find( "div.selectli" ).each(function( i ) {
				$.data( this, "yhSelectorData", data[i] );
			});
		},

		_createList: function( data ) {
			var aHtml = [], i = 0,j = 0, l = data.length, rd=this.options.rightData;
			this.listData = data;	
			for ( ; i < l; i ++ ) {
					if ( data[i][this.options.key] ) {
						//每项div必须有ID，否则获取数据时名称如果重复则数据获取时对不上
						aHtml.push( "<div class='selectli' id=\""+data[i][this.options.idKey]+"\">", data[i][this.options.key], "</div>" );
					}
			}
			return aHtml.join( "" );
		},

		_cancelLoading: function() {
			this.leftPanel.add( this.rightPanel ).css( "background", "none");
		},

		_leftToRight: function() {
			var $moveList = this.leftPanel.find( "div.ui-selected" ),
				that = this;
			if ( $moveList.length ) {
				$moveList.each(function(i) {//添加 i参数做为下标
					
					//将数据添加到已选列表中
					var id =$moveList[i][that.options.idKey];
					var value = $moveList[i].innerText;
					//判断右边数据区是否已经添加了该项数据
					if(that.options.rightKeyHashMap && that.options.rightKeyHashMap[id]){//数据已经存在了
					}else{//已选区数据没存该项
						that.options.rightKeyHashMap[id] =value;
						//循环左边取数据，因为左边的数据不会太多。
						for(var x =0,len = that.options.leftData.length;x<len;x++){
							var o =that.options.leftData[x];
							if(o[that.options.idKey] == id ){
								that.options.rightData.push(o);
								break;
							}
						}
					}
					
					$(this).removeClass( "ui-selected" ).removeData( "selectableItem" )
						.appendTo( that.rightPanel );
						
					
				});	
			
				if ( !!this.rightPanel.data( "selectable" ) ) {
					this.rightPanel.selectable( "refresh" );
				} else {
					this.rightPanel.selectable();
				}
			} else {
				this._noItemAlert( "没有选中项" );
			}
		},

		_rightToLeft: function() {
			var $moveList = this.rightPanel.find( "div.ui-selected" ),
				that = this;

			if ( $moveList.length ) {
				$moveList.each(function(i) {//添加 i参数做为下标
					
					//将数据添加到已选列表中
					var id =$moveList[i][that.options.idKey];
					//var value = $moveList[i][this.options.key];
					//从右边数据区一出该数据
					delete that.options.rightKeyHashMap[id];//hashMap中删除
					for(var x = 0 ,len = that.options.rightData.length;x<len;x++){
						if(that.options.rightData[x][that.options.idKey] == id){
							that.options.rightData.del(x);
							break;
						}
					}
					
					$(this).removeClass( "ui-selected" ).removeData( "selectableItem" )
						.appendTo( that.leftPanel );
					
						
				});
			}

			this.leftPanel.selectable( "refresh" );
		},

		_allLeftToRight: function() {
			var $moveList = this.leftPanel.find( "div" );
			if ( $moveList ) {
				
				//将左边的值赋给右边
				
				for(var i = 0,len = this.options.leftData.length;i<len ;i++){
					//存在该记录，跳过
					if(this.options.rightKeyHashMap[this.options.leftData[i][this.options.idKey]])
					{
						continue;
					}
					//不存在，则添加到右边数据区
					this.options.rightKeyHashMap[this.options.leftData[i][this.options.idKey]]=
						this.options.leftData[i][this.options.key];
					this.options.rightData.push(this.options.leftData[i]);
				}
				
				$moveList.removeClass( "ui-selected" ).removeData( "selectableItem" ).appendTo( this.rightPanel );

				if ( !!this.rightPanel.data( "selectable" ) ) {
					this.rightPanel.selectable( "refresh" );
				} else {
					this.rightPanel.selectable();
				}
				
				
				
			}
		},

		_allRightToLeft: function() {
			var $moveList = this.rightPanel.find( "div" );
			if ( $moveList ) {
				$moveList.removeClass( "ui-selected" ).removeData( "selectableItem" ).appendTo( this.leftPanel );
				this.leftPanel.selectable( "refresh" );
				
				//清空右边数据
				this.options.rightData = [];
				this.options.rightKeyHashMap = new Object();
			}
		},

		_noItemAlert: function( mess ) {
			if ( $.yhDialogTip && $.yhDialogTip.alert ) {
				$.yhDialogTip.alert( mess )
			} else {
				alert( mess );
			}
		},

		getSelected: function() {
//			var ret = [],
//				$seleted = this.rightPanel.find( "div.ui-selectee" );
//			
//			if ( $seleted.length ) {
//				$seleted.each(function() {
//					ret.push( $.data( this, "yhSelectorData") );
//				});
//			} else {
//				$.yhui.log( "没有选中项" );
//				//alert( "没有选中项" );
//			}
//			return ret;
			if(this.options.rightData.length == 0){
				$.yhui.log( "没有选中项" );
			}
			return this.options.rightData;
			
		},

		addList: function( data, flag ) {
			var listHtml = "", that = this;
			
			if ( $.isArray( data ) ) {
				listHtml = this._createList( data );
			}else {
				$.getJSON( data, function( data ) {
					that._initLeftList( data );
				});
			}

			if ( listHtml ) {
				$( listHtml ).each(function( i ) {
					$(this)[ flag ? "prependTo" : "appendTo" ]( that.leftPanel ).data( "yhSelectorData", data[i] );
				});
				this.leftPanel.selectable( "refresh" );
			}
		},
		replaceList:function(data, flag){
			var $moveList = this.leftPanel.find( "div" );
			var listHtml = "", that = this;
			
			if ( $moveList ) {
				$moveList.removeClass( "ui-selectee" ).removeData( "selectableItem" ).remove();
				
				if ( $.isArray( data ) ) {
					listHtml = this._createList( data );
				}
				else {
					$.getJSON( data, function( data ) {
						that._initLeftList( data );
					});
				}
				
				if ( listHtml ) {
					$( listHtml ).each(function( i ) {
						$(this).appendTo( that.leftPanel ).data( "yhSelectorData", data[i] );
					});
					this.leftPanel.selectable( "refresh" );
				}	
				
			}
		}
	});
})(jQuery);
