var CommonUtils={
		/**
		 * 加载按钮
		 * @param div jquery对象
		 * @param code 当前功能的code
		 * @param actions 当前功能的按钮事件
		 */
		loadToolBar:function(div,code,actions,str_tags,config){
			var tags = str_tags.split(","); 
			
			// 加载按钮
			$.ajax({
				type : "POST",
				dataType : "json",
				url : ctx + "/common/common/"  + "getButtonsByParentCode",
				data : {
					code : code
				},
				success : function(data, textStatus) {

					if (data.success) {
						var items = new Array();
						for (i in data.result) {
							if(jQuery.inArray(i,tags)!=-1){ 
								items.push("-");
							}
							if(actions[data.result[i].code]){
								items.push({
									type : 'button',
									text : data.result[i].name,
									bodyStyle : data.result[i].iconSkin,
									useable : data.result[i].state < 0 ? 'F' : 'T',
									align : data.result[i].align,
									listeners : {'click':actions[data.result[i].code]}
								});
							}
						}
						if(!config)config={};
						config.items = items;
						div.yhToolbar(config);
					} else {
						$.yhDialogTip.error(data.title, data.reason);
					}
				}
			});
		}
};
/**
 * 增加原生日期方法，用法：timestamp = (new Date(parseFloat(rData[7]))).format("yyyy-MM-dd hh:mm:ss");
 * @param format
 * @returns
 */
Date.prototype.format = function(format) {
	   var o = {
	       "M+": this.getMonth() + 1,
	       // month
	       "d+": this.getDate(),
	       // day
	       "h+": this.getHours(),
	       // hour
	       "m+": this.getMinutes(),
	       // minute
	       "s+": this.getSeconds(),
	       // second
	       "q+": Math.floor((this.getMonth() + 3) / 3),
	       // quarter
	       "S": this.getMilliseconds()
	       // millisecond
	   };
	   if (/(y+)/.test(format) || /(Y+)/.test(format)) {
	       format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	   }
	   for (var k in o) {
	       if (new RegExp("(" + k + ")").test(format)) {
	           format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
	       }
	   }
	   return format;
	};
	/**
	 * 扩展字符串的替换方法
	 */
	String.prototype.replaceAll  = function(s1,s2){   
	    return this.replace(new RegExp(s1,"gm"),s2);   
	} ;