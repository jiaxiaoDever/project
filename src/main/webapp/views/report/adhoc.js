var AdhocReport =function(){

	return{
		model:null,
		grid:null,
		initHeader:function(){
			var jsonStr =json;
			var obj = eval("("+jsonStr+")"); 
			var columns= obj.columns||[];
			var model=[];
			for(var i=0,len=columns.length;i<len;i++){
				var column = columns[i];
				model.push({
				    name:column['dataIndex'],
				    index:column['dataIndex'],
				    label:column['header'],
				    sortable:column['sortable']||false,
				    hidden:column['hidden']||false
				});
			}
			
			this.model= model;
			
		},
		/**
		 * 先初始化，后加载数据
		 */
		initGrid:function(){
			var _this =this ;
			
			var  data ={};
			data['page']=1;
			data['rows']=20;
			data['sql'] =sql;
		

			_this.grid = $("#list").yhGrid({
			url : ctx+'/report/executeSql',
			heightStyle : "fill",
			multiselect : true,
			multiboxonly : true,
			postData:data,
			rowNum : 20,
			pager : "#pager",
			viewrecords : true,
			colModel : _this.model,
			jsonReader : {
				root : "result", // 对于json中数据列表
				page : "currentPage",
				total : "totalPage",
				records : "totalCount",
				repeatitems : false
			}
		});
		}
	
	};
}();