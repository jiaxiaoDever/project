/**
 * 内容管理
 * 
 * @author zhangy
 */
var ContentList = {
	code : "ContentList",
	baseUrl : ctx + "/content/content/",
	formDivWidth : 770,
	treeAccessName : "contentTypeId",
	treeUrl : ctx + "/content/contentType/getTree",
	initModel : function() {
		var _this = this;
		_this.gridModel = [ {
			name : "id",
			label : "编号",
			hidden : true
		}, {
			name : "contentTypeId",
			label : "内容分类",
			valiRule : {
				required : true
			},
			formatter : _this.treeStoreFormatter,
			field : {
				editor : 'dropdown',
				config : {
					hiddenId : "contentTypeId",
					resizable : true,
					selectParent : true,
					store : _this.treeStore,
					post : "id"
				}
			},
			sortable : false
		}, {
			name : "title",
			label : "标题"
		}, {
			name : "intro",
			label : "简介"
		}, {
			name : "userId",
			label : "发布人ID",
			hidden : true
		}, {
			name : "userName",
			label : "发布人名称",
			field : {
				editor : 'hidden'
			}
		}, {
			name : "pic",
			label : "图片",
			hidden : true,
			field : {
				editor : 'file'
			},

		}, {
			name : "sort",
			label : "排序"
		}

		// , {
		// name : "createDate",
		// label : "发布日期",
		// formatter : function(value, options, rData) {
		// var timestamp = "";
		// if (!isNaN(rData.createDate) && rData.createDate) {
		// timestamp = (new
		// Date(parseFloat(rData.createDate))).format("yyyy-MM-dd hh:mm:ss");
		// }
		// return timestamp;
		// },
		// sortable : false
		// }, {
		// name : "stateDate",
		// label : "更新日期",
		// formatter : function(value, options, rData) {
		// var timestamp = "";
		// if (!isNaN(rData.stateDate) && rData.stateDate) {// rData[7]表示日期列
		// timestamp = (new
		// Date(parseFloat(rData.stateDate))).format("yyyy-MM-dd hh:mm:ss");
		// }
		// return timestamp;
		// },
		// sortable : false
		// }
		, {
			name : "state",
			label : "状态",
			hidden : true
		}, {
			name : "content",
			label : "内容",
			field : {
				editor : 'editor'
			},
			hidden : true
		} ];
	},
	initListeners : function() {
		var _this = this;
		_this.listeners.beforeSave = function(e, form) {
			KindEditor.sync("textarea[name=content]");
		};
	}
};

/**
 * 初始化时layout要放在form/toolbar/button之后，loaddata之前
 */
YHUI.use("yhStore yhSelectmenu yhTreemenu yhFormField yhLayout yhDropDown yhGrid yhToolbar yhButton yhDialogTip zTree  yhValidate  yhWindow yhSearchBox yhEditor", function() {
	var view = $.extend(true, DefaultView, ContentList);
	view.start();

});
