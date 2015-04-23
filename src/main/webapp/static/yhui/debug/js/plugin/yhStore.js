/**
 * yhStore数据仓库，优化数据重用的中间层
 * 
 * @author zhangy
 */
(function($) {
	$.yhStore = {
		init : function() {
		},
		storeMap : {},
		create : function(option, data) {
			var _this = this;
			var name = option.name;
			if (!name) {
				alert("yhStore.create的参数中必须有name");
			}
			var store = {
				name : name,
				isAutoLoad : option.isAutoLoad === false ? false : true,
				isLoaded : false,
				option : option,// 参数
				data : data || null,// 数据缓存
				triger : {
					beforeLoad : option.beforeLoad || null,
					afterLoad : option.afterLoad || null,
					initData : null
				},
				/**
				 * 执行数据加载，默认true,false为同步加载
				 */
				load : function(options) {
					var _this = this;
					var opt = _this.option;
					$.extend(true, opt, options);
					if (options && options.beforeLoad) {
						_this.triger.beforeLoad = option.beforeLoad;
					}
					if (options && options.afterLoad) {
						_this.triger.afterLoad = option.afterLoad;
					}

					var beforeLoadFun = _this.triger.beforeLoad;
					if ($.isFunction(beforeLoadFun) && beforeLoadFun(_this) === false) {
						return false;
					}

					$.ajax({
						url : opt.url,
						dataType : opt.dataType || "json",
						data : opt.postData || null,
						type : opt.type || "post",
						async : opt.async || true,
						success : function(backData) {
							_this.data = backData;
							var initDataFun = _this.triger.initData;
							if ($.isFunction(initDataFun) && initDataFun(_this) === false) {
								return false;
							}

							var afterLoadFun = _this.triger.afterLoad;
							if ($.isFunction(afterLoadFun) && afterLoadFun(_this) === false) {
								return false;
							}
							_this.isLoaded = true;
						},
						error : function(s1, s2) {
							$.yhui.log(s2);
						}
					});
				},
				find : function(field, value) {
					var data = this.data;
					for ( var k in data) {
						if (data[k][field] == value) {
							return data[k];
						} else {
							var r = this.__findChild(data[k].children, field, value);
							if (r) {
								return r;
							}
						}
					}
					return "";
				},
				__findChild : function(data, field, value) {
					for ( var j in data) {
						if (data[j][field] == value) {
							return data[j];
						} else {
							var r = this.__findChild(data[j].children, field, value);
							if (r) {
								return r;
							}
						}
					}
					return "";
				}
			};
			_this.storeMap[name] = store;
			return store;
		},
		/**
		 * 获取store
		 * 
		 * @param name
		 * @returns
		 */
		get : function(name) {
			return this.storeMap[name];
		}
	};
})(jQuery);