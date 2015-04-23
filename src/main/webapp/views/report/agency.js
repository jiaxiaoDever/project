var Agency = function() {

	return {
		model : [],
		grid : null,
		ybgrid : null,
		url : ctx + '/report/',
		formDiv : null,
		model_tmp : null,
		gridSelectData : null,
		btns : null,

		initLayout : function() {

			var _this = this;
			$(document.body).yhLayout({
				center__onresize : function() {
					_this.grid.yhGrid("refresh");
					_this.ybgrid.yhGrid("refresh");
				}
			});

		},
		initModel : function() {
			var _this = this;
			_this.model = [ {
				name : "id",
				index : "id",
				label : "编号",
				sortable : false,
				hidden : true
			}, {
				name : "name",
				index : "name",
				label : "报表名称",
				sortable : false,
				formatter : function(cellvalue, options, rowObject) {
					var surl = rowObject.url;
					var tmp = "<a href=\"javascript:void(0)\" onclick=\"Agency.show('" + cellvalue + "','" + surl + "');\" >" + cellvalue + "</a>";
					return tmp;
				}
			}, {
				name : "senderName",
				index : "senderName",
				label : "发送人",
				sortable : false
			}, {
				name : "senderId",
				index : "senderId",
				label : "发送人ID",
				hidden : true,
				sortable : false
			}, {
				name : "content",
				index : "content",
				label : "描述信息",
				sortable : false
			}, {
				name : "stateDate",
				index : "stateDate",
				label : "发送时间",
				sortable : false

			}, {
				name : 'stateName',
				index : 'stateName',
				label : '状态',
				sortable : false,
				formatter : function(cellvalue, options, rowObject) {
					var m = cellvalue;
					if (cellvalue == 'SOA') {
						m = '待签收';
					} else if (cellvalue == 'SOS') {
						m = '已签收,待回写';
					} else if (cellvalue == 'SOW') {
						m = '已回写,待确认';
					} else if (cellvalue == 'SOF') {
						m = '已确认';
					}
					return m;
				}
			}, {
				name : 'url',
				index : 'url',
				label : '报表路径',
				sortable : false,
				hidden : true
			}, {
				name : 'state',
				index : 'state',
				label : 'state',
				sortable : false,
				hidden : true
			} ];
		},
		initTabs : function() {
			var _this = this;
			var tabs = $("#mainContent").tabs({
				showLoading : true,
				heightStyle : "fill",
				create : function() {
					$.yhui.loadingFadeOut();
				},
				activate : function(event, ui) {
					var title = event.currentTarget.text;
					if (title == '我的待办') {
						var data = {};
						data['page'] = 1;
						data['rows'] = 20;

						_this.grid.yhGrid("setGridParam", {
							url : ctx + '/report/' + 'getMyAgencyInfos?flag=SOA',
							postData : data,
							search : true
						}).trigger("reloadGrid").yhGrid("refresh");
					} else if (title == '我的已办') {
						var data = {};
						data['page'] = 1;
						data['rows'] = 20;

						_this.ybgrid.yhGrid("setGridParam", {
							url : ctx + '/report/' + 'getMyAgencyInfos?flag=SOF',
							postData : data,
							search : true
						}).trigger("reloadGrid").yhGrid("refresh");
					}

				}
			});
			$("#toolbar").yhToolbar({
				items : [ {
					type : 'button',
					text : "批阅",
					bodyStyle : 'edit',
					useable : 'T',
					listeners : {
						'click' : function() {
							var rowId = _this.grid.yhGrid("getGridParam", "selrow");
							var rowAllid = _this.grid.yhGrid("getGridParam", "selarrrow");
							if (rowAllid.length > 1) {
								$.yhDialogTip.alert("请“选择一行”进行批阅。");
								return;
							}
							if (!rowId) {
								$.yhDialogTip.alert("请“选择一行”进行批阅。");
								return;
							}
							var data = _this.grid.yhGrid("getRowData", rowId);

							_this.gridSelectData = data;

							$(_this.formDiv).parent().find(".ui-dialog-title").html("批阅待办");
							WinUtils.fillFrom(_this.formDiv, [], _this.model_tmp);
							_this.formDiv.yhWindow("open");

							var state = data.state;
							if (state == 'SOA') {
								_this.btns.yhButton('enableBtn', 'btn-qs');
								_this.btns.yhButton('disableBtn', 'btn-hx');
								_this.btns.yhButton('disableBtn', 'btn-qr');
							} else if (state == 'SOS') {
								_this.btns.yhButton('disableBtn', 'btn-qs');
								_this.btns.yhButton('enableBtn', 'btn-hx');
								_this.btns.yhButton('disableBtn', 'btn-qr');
							} else if (state == 'SOW') {
								_this.btns.yhButton('disableBtn', 'btn-qs');
								_this.btns.yhButton('disableBtn', 'btn-hx');
								_this.btns.yhButton('enableBtn', 'btn-qr');
							}

						}
					}

				} ]
			});
			_this.formDiv = $("<div/>").appendTo("body");
			_this.model_tmp = [ {
				name : "msg",
				index : "msg",
				label : "信息",
				hidden : true,
				field : {
					editor : "textarea",
					hidden : false
				},
				sortable : false
			} ];

			// 创建批阅表单
			WinUtils.createEditWin(_this.formDiv, _this.model_tmp, null, {height:300});
			_this.formDiv.buttonDiv = $('<div>').insertAfter(_this.formDiv[0]);
			// 初始化发表评论的按钮
			_this.btns = _this.formDiv.buttonDiv.yhButton({
				align : "right",
				form : _this.formDiv,
				align : "right",
				items : [ {
					type : "confirm",
					text : '签收',
					id : 'btn-qs',
					onClick : function(e, form) {
						var data = {};
						data = $.yhui.mapForm(form);
						if (data.msg == '') {
							$.yhDialogTip.alert("请输入批阅信息");
							return;
						}

						_this.submitAgen('签收成功', 'SOS', data.msg);

					}
				}, {
					type : 'confirm',
					text : '回写',
					id : 'btn-hx',
					onClick : function(e, form) {
						var data = {};
						data = $.yhui.mapForm(form);
						if (data.msg == '') {
							$.yhDialogTip.alert("请输入批阅信息");
							return;
						}
						_this.submitAgen('回写成功', 'SOW', data.msg);
					}

				}, {
					type : 'confirm',
					text : '确认',
					id : 'btn-qr',
					onClick : function(e, form) {
						var data = {};
						data = $.yhui.mapForm(form);
						if (data.msg == '') {
							data.msg = '已确认';
						}
						_this.submitAgen('确认成功', 'SOF', data.msg);
					}

				}, {
					type : "cancel",
					onClick : function() {

						_this.formDiv.yhWindow("close");

					}
				} ]
			});
		},
		initLoadData : function() {
			var _this = this;
			_this.grid = $("#list").yhGrid({
				url : ctx + '/report/' + 'getMyAgencyInfos?flag=SOA',
				heightStyle : "fill",
				multiselect : true,
				multiboxonly : true,
				rowNum : 20,
				fixHeight:87,
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
			_this.ybgrid = $("#list1").yhGrid({
				url : ctx + '/report/' + 'getMyAgencyInfos?flag=SOF',
				heightStyle : "fill",
				multiselect : true,
				multiboxonly : true,
				rowNum : 20,
				pager : "#pager1",
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
		},

		submitAgen : function(title, type, msg) {
			var _this = this;
			$.ajax({
				async : true,
				type : "POST",
				url : ctx + '/' + 'report/submitAgen',
				data : {
					id : _this.gridSelectData.id,
					type : type,
					msg : msg,
					senderId : _this.gridSelectData.senderId,
					senderName : _this.gridSelectData.senderName
				},
				dataType : 'json',
				success : function(data) {
					var data = {};
					data['page'] = 1;
					data['rows'] = 20;

					Agency.grid.yhGrid("setGridParam", {
						url : ctx + '/report/' + 'getMyAgencyInfos?flag=SOA',
						postData : data,
						search : true
					}).trigger("reloadGrid");
					$.yhDialogTip.alert(title);
					_this.formDiv.yhWindow("close");
				}
			});
		},
		show : function(name, url) {
			if (url)
				window.open(url, name);
		}

	};
}();

YHUI.use("yhFormField yhLayout  yhGrid yhToolbar yhButton yhDialogTip yhWindow", function() {
	Agency.initLayout();
	Agency.initModel();
	Agency.initTabs();
	Agency.initLoadData();
});