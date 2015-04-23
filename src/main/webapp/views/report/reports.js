var Report = function() {

	return {
		code : "Report",
		actions : {},
		diractions : {},
		model : [],
		tree : null,
		rptClass : {
			FLAT : 'flat',
			IREPORT : 'ireport',
			OLAP : 'olap',
			ADHOC : 'adhoc'
		},
		rptUrls : {
			flatUrl : '',
			ireportUrl : '',
			adhocUrl : '',
			olapUrl : ''
		},
		tabs : null,
		grid : null,
		selectNode : null,
		/**
		 * 初始化报表路径
		 */
		initUrls : function() {
			var _this = this;

			$.post(ctx + "/report/getReportUrls", {}, function(res) {
				res = eval("(" + res + ")");
				_this.rptUrls.flatUrl = res.report_flat_url;
				_this.rptUrls.ireportUrl = res.report_ireport_url;
				_this.rptUrls.adhocUrl = res.report_adhoc_url;
				_this.rptUrls.olapUrl = res.report_olap_url;
			});
		},
		/**
		 * 初始化tabs
		 */
		initTabs : function() {
			// this.tabs = $('div.ui-layout-center').yhTabs({
			this.tabs = $('#mainContent').yhTabs({
				frame : true,
				// showLoading : true,
				create : function() {
					$.yhui.loadingFadeOut();
					$("div.ui-layout-resizer-north").eq(0).remove();
				}
			});
		},
		/**
		 * 初始化表格
		 */
		initModel : function() {
			this.model = [ {
				name : "name",
				label : "报表名称",
				sortable : false
			}, {
				name : "dataAttr.reportTypeName",
				label : "所属目录",
				sortable : false,
			}, {
				name : "dataAttr.reportType",
				label : "所属目录ID",
				hidden : true,
				sortable : false
			}, {
				name : "dataAttr.rptShow",
				label : "显示方式",
				sortable : false,
				formatter : 'select',
				editoptions : {
					value : '1:PC;2:手机端;3:PC&手机端'
				},
			}, {
				name : 'dataAttr.rptClass',
				label : 'rpt_class',
				hidden : true,
				sortable : false
			}, {
				name : 'dataAttr.url',
				label : '模板路径',
				hidden : true,
				sortable : false

			}, {
				name : "id",
				label : "id",
				hidden : true,
				sortable : false
			}, {
				name : "dataAttr.userName",
				label : "创建用户",
				hidden : false,
				sortable : false
			}, {
				name : "dataAttr.stateDate",
				label : "创建时间",
				sortable : false,
			}, {
				name : "dataAttr.state",
				label : "状态",
				sortable : false,
				formatter : 'select',
				editoptions : {
					value : '1:有效;-1:无效'
				}
			} ];

			this.grid = $("#list").yhGrid({
				url : ctx + '/report/queryReportForPage',
				multiselect : true,
				multiboxonly : true,
				rowNum : 20,
				heightStyle : "fill",
				pager : "#pager",
				viewrecords : true,
				colModel : this.model,
				jsonReader : {
					root : "result", // 对于json中数据列表
					page : "currentPage",
					total : "totalPage",
					records : "totalCount",
					repeatitems : false
				}
			});
		},
		/**
		 * 初始化工具栏
		 */
		initToolBar : function() {
			var _this = this;
			this.actions = {
				"Report.search" : function() {
					var data = {};
					data = $.yhui.mapForm($("#searchForm")[0]);
					data['rows'] = 20;

					_this.grid.yhGrid("setGridParam", {
						url : ctx + '/report/queryReportForPage',
						postData : data,
						search : true
					}).trigger("reloadGrid", [ {
						page : 1
					} ]);// 重新以第一页载入Grid表格
				},
				"Report.edit" : function(e, form, holderDiv, btnObj) {
					var rowId = _this.grid.yhGrid("getGridParam", "selrow");
					var rowAllid = _this.grid.yhGrid("getGridParam", "selarrrow");
					if (rowAllid.length > 1) {
						$.yhDialogTip.alert("请“选择一行”进行修改。");
						return;
					}
					if (!rowId) {
						$.yhDialogTip.alert("请“选择一行”进行修改。");
						return;
					}
					var data = _this.grid.yhGrid("getRowData", rowId);
					_this.dispWindow(data);

				},
				"Report.open" : function(e, form, holderDiv, btnObj) {

					var rowId = _this.grid.yhGrid("getGridParam", "selrow");
					var rowAllid = _this.grid.yhGrid("getGridParam", "selarrrow");
					if (rowAllid.length > 1) {
						$.yhDialogTip.alert("只能选择一个报表");
						return;
					}
					if (!rowId) {
						$.yhDialogTip.alert("请选择一个报表。");
						return;
					}
					var data = _this.grid.yhGrid("getRowData", rowId);
					if (data.state == '-1') {
						$.yhDialogTip.alert("该报表被设置成无效，不能打开");
						return;
					}
					openReport(data.id, data.name, data["dataAttr.rptClass"], data["dataAttr.url"]);

				},
				"Report.delete" : function(e, form, holderDiv, btnObj) {
					var rowId = _this.grid.yhGrid("getGridParam", "selrow");
					var rowAllid = _this.grid.yhGrid("getGridParam", "selarrrow");
					/***********************************************************
					 * if (rowAllid.length>1) {
					 * $.yhDialogTip.alert("请“选择一行”进行删除。"); return; }
					 **********************************************************/
					if (!rowId) {
						$.yhDialogTip.alert("请“选择一行”进行删除。");
						return;
					}
					var data = _this.grid.yhGrid("getRowData", rowId);
					var ids = 'ids=';
					var i = 0;
					var tempdata = "";
					$.each(rowAllid, function(k, v) {
						if (i > 0) {
							ids += ",";
							tempdata += ",";
						}
						ids += v;
						tempdata += v;
						i++;
					});

					$.yhDialogTip.alert({
						title : "删除",
						message : "是否确认删除？<br/>删除后，该用户将无法查看该报表。",
						cancelButton : true,
						ok : function() {
							$.ajax({
								type : "POST",
								dataType : "json",
								url : ctx + "/report/deleteReports",
								data : ids,
								success : function(res, textStatus) {
									$.yhDialogTip.alert("删除成功");
									$.each(rowAllid, function(k, v) {
										v = tempdata.split(",")[k];
										var node = _this.tree.getNodeByParam("id", v, _this.selectNode);
										_this.grid.delRowData(v);
										_this.tree.removeNode(node);
									});

								}
							});
						}
					});
				},

				"Report.deploy" : function() {
					if (_this.selectNode.id == '-1') {
						$.yhDialogTip.alert("请选择一个目录");
						return;
					}
					if (_this.selectNode.dataAttr && _this.selectNode.isParent == false) {

						$.yhDialogTip.alert("只能在目录下新增报表");
						return;
					}
					_this.deployWin();
				}
			};

			CommonUtils.loadToolBar($("#toolbar"), _this.code, _this.actions, "");
		},
		initToolsBar : function() {
			var _this = this;
			this.diractions = {
				"Report.diredit" : function(e, form, holderDiv, btnObj) {
					if (_this.selectNode.id == '-1') {
						$.yhDialogTip.alert("请选择一个目录");
						return;
					}
					if (_this.selectNode.dataAttr && _this.selectNode.isParent == false) {

						$.yhDialogTip.alert("不能选择报表进行修改，请选择目录");
						return;
					}
					_this.editDir('edit', _this.selectNode.id, _this.selectNode.name.substring(0, _this.selectNode.name.indexOf("(")), _this.selectNode.privilege);
				},
				"Report.dirdelete" : function(e, form, holderDiv, btnObj) {
					if (_this.selectNode.id == '-1') {
						$.yhDialogTip.alert("请选择一个目录");
						return;
					}

					if (_this.selectNode.dataAttr && _this.selectNode.isParent == false) {

						$.yhDialogTip.alert("此功能不能删除报表，请选择目录进行操作");
						return;
					}
					if (_this.selectNode.id == 'root') {
						$.yhDialogTip.alert("不能删除根目录");
						return;
					}

					$.yhDialogTip.alert({
						title : "删除",
						message : "是否确认删除？<br/>删除后，将无法使用该目录下的报表。",
						cancelButton : true,
						ok : function() {
							_this.procDir('delete', _this.selectNode.id, _this.selectNode.name);
						}
					});
				},
				"Report.dirnew" : function(e, form, holderDiv, btnObj) {
					if (_this.selectNode.id == '-1') {
						$.yhDialogTip.alert("请选择一个目录");
						return;
					}

					if (_this.selectNode.dataAttr && _this.selectNode.isParent == false) {

						$.yhDialogTip.alert("只能在目录下新增目录");
						return;
					}
					_this.editDir('new', _this.selectNode.id, '', _this.selectNode.privilege);
				}
			};

			CommonUtils.loadToolBar($("#tools"), _this.code, _this.diractions, "");
		},
		/**
		 * 初始化报表树
		 */
		initLoadTree : function() {
			var me = this;
			var setting = {
				async : {
					enable : true,// 异步获取数据
					url : ctx + '/report/getRptTree',
					autoParam : [ "id", "parentId" ]
				},
				callback : {
					onNodeCreated : function(event, treeId, treeNode) {
						// alert(treeNode.tId + ", " + treeNode.name);
					},
					onAsyncSuccess : function(event, treeId, treeNode, msg) {
						var treeObj = $.fn.zTree.getZTreeObj(treeId);
						if (treeId) {
						}

						me.treeNode = treeObj.getNodes();
					},
					onClick : function(event, treeId, treeNode, clickFlag) {
						if (treeNode.isParent == false && treeNode.dataAttr) {// 叶子节点，为报表
							var link = '';
							// 平面报表
							if (treeNode.dataAttr.state == '-1') {
								$.yhDialogTip.alert("该报表被设置成无效，不能打开");
								return;
							}
							if (treeNode.dataAttr.rptClass == me.rptClass.FLAT) {
								link = me.rptUrls.flatUrl + treeNode.id;
							} else if (treeNode.dataAttr.rptClass == me.rptClass.OLAP) {
								link = me.rptUrls.olapUrl + treeNode.dataAttr.url;
							} else if (treeNode.dataAttr.rptClass == me.rptClass.ADHOC) {
								link = me.rptUrls.adhocUrl + treeNode.id;

							} else if (treeNode.dataAttr.rptClass == me.rptClass.IREPORT) {
								link = me.rptUrls.ireportUrl + treeNode.id;
							}
							var $li = $("#" + treeNode.id);
							var newlink = ctx + '/views/report/report.jsp?url=' + link + '&reportId=' + treeNode.id + '&name=' + encodeURIComponent(treeNode.name);
							me.tabs.yhTabs("addTab", $li, newlink, treeNode.name);
						} else {
							me.loadGridData(treeNode.id, treeNode.name);
						}
						me.selectNode = treeNode;
					}
				}
			};
			me.tree = $.fn.zTree.init($("#leftTree"), setting);
		},
		/**
		 * 加载表格数据
		 */
		loadGridData : function(id, parentName) {
			var me = this;
			var data = $.yhui.mapForm($("#searchForm")[0]);
			data['id'] = id;
			data['page'] = 1;
			data['rows'] = 20;
			me.grid.yhGrid("setGridParam", {
				url : ctx + '/report/queryReportForPage',
				postData : data,
				search : true
			}).trigger("reloadGrid");
		},
		/**
		 * 显示修改报表窗口
		 */
		dispWindow : function(data) {
			var _this = this;
			var $wrap = $("<div style=\" overflow:hidden;\"></div>"), $ifr = $("<iframe id='_tempframe' style = 'width:100%;height:100%' frameborder = '0'></iframe>");
			var furl = ctx + "/report/createUpdateForm?name=" + encodeURIComponent(data.name) + "&rpt_show=" + data["dataAttr.rptShow"] + "" + "&rpt_type="
					+ data["dataAttr.reportType"] + "&rpt_type_name=" + encodeURIComponent(data["dataAttr.reportTypeName"]) + "&state=" + data["dataAttr.state"];

			$wrap.appendTo(document.body).yhWindow({
				modal : true,
				title : '修改报表',
				width : 500,
				height : 400,
				position : [ "center", "center-5%" ],
				resizable : false,
				showTaskBar : false,
				open : function(e, ui) {
					$ifr.appendTo($(this)).prop("src", furl);
				},
				close : function() {

					$.yhui.isIE && CollectGarbage();
					$(this).yhWindow("destroy").remove();
				},
				buttons : {
					'保存' : function() {
						var doc = document.getElementById('_tempframe').contentWindow.document;
						var newname = $("#name", doc).val();
						var newRptShow = $(":input[name=rpt_show]", doc).val();
						var newRptType = $("#rpt_type", doc).val();
						var state = $(":input[name=state]", doc).val();
						$.ajax({
							type : "POST",
							dataType : "json",
							url : ctx + "/report/updateReport",
							data : {
								id : data.id,
								name : newname,
								rptShow : newRptShow,
								rptType : newRptType,
								state : state
							},
							success : function(res, textStatus) {
								$.yhDialogTip.alert("修改成功");
								var node = _this.tree.getNodeByParam("id", data.id, _this.selectNode);
								if (node) {
									node.name = newname;
									_this.tree.updateNode(node);
								}
								_this.loadGridData(_this.selectNode.id, _this.selectNode.name);
							}
						});
						$(this).yhWindow("destroy").remove();
						return;
					},
					'取消' : function() {
						$(this).yhWindow("destroy").remove();
					}
				}
			});
		},

		editDir : function(act, id, name, privilege) {
			var title = '修改目录';
			var val = "value=" + name;
			if (act == 'new') {
				title = '新增目录';
				val = '';
			}
			var _this = this;
			var $wr = $("<div id=\"ad\" style=\" overflow:hidden;\"></div>");
			$iframe1 = $("<iframe id='_tmpframe' style = 'width:100%;height:100%' frameborder = '0'></iframe>");
			var url = ctx + "/reportdir/dirForm?id=" + id + "&name=" + encodeURIComponent(name) + "&privilege=" + privilege;

			$wr.appendTo(document.body).yhWindow({
				// modal:true,
				title : title,
				width : 350,
				height : 250,
				position : [ "center", "center-5%" ],
				resizable : false,
				showTaskBar : false,
				open : function(e, ui) {

					// var script=$("<input type=\"text\" name=\"txt_\"
					// id=\"txt_\" />");
					$iframe1.appendTo($(this)).prop("src", url);
					// script.appendTo( $(this) );

				},
				close : function() {

					$.yhui.isIE && CollectGarbage();
					$(this).yhWindow("destroy").remove();
				},
				buttons : {
					'保存' : function() {
						var doc = document.getElementById('_tmpframe').contentWindow.document;
						var id = doc.getElementById("id").value;
						
						var name = $("#name",doc).val();
						if (name == '') {
							$.yhDialogTip.alert('报表名称不能为空');
							return;
						}
						var privilege = $(":radio[name='privilege']:checked", doc).val();
						if (privilege == undefined) {
							$.yhDialogTip.alert('目录类型不能为空');
							return;
						}
						var r = _this.asyncAjax(ctx + "/reportdir/checkDir", {
							id : id,
							name : name,
							act : act
						});
						if (r == true) {
							$.yhDialogTip.alert('”' + name + '“目录已经存在');
							return;
						}
						_this.procDir(act, id, name, privilege);
						$(this).yhWindow("destroy").remove();
						// return;
					},
					'取消' : function() {
						$(this).yhWindow("destroy").remove();
					}
				}
			});
		},

		deployWin : function() {
			var _this = this;
			var $wrr = $("<div id=\"ad1\" style=\" overflow:hidden;\"></div>");
			$tmpiframe = $("<iframe id='_frame' style = 'width:100%;height:100%' frameborder = '0'></iframe>");
			var url = ctx + "/report/toDeployForm?pid=" + _this.selectNode.id + "&pname="
					+ encodeURIComponent(_this.selectNode.name.substring(0, _this.selectNode.name.indexOf("(")));
			$wrr.appendTo(document.body).yhWindow({
				modal : true,
				title : '新增报表',
				width : 500,
				height : 450,
				position : [ "center", "center-5%" ],
				resizable : false,
				showTaskBar : false,
				open : function(e, ui) {
					// var script=$("<input type=\"text\" name=\"txt_\"
					// id=\"txt_\" />");
					$tmpiframe.appendTo($(this)).prop("src", url);
					// script.appendTo( $(this) );

				},
				close : function() {

					$.yhui.isIE && CollectGarbage();
					$(this).yhWindow("destroy").remove();
				},
				buttons : {
					'保存' : function() {
						var doc = document.getElementById('_frame').contentWindow.document;
						var name = doc.getElementById("name").value;
						var report_type = doc.getElementById("report_type").value;
						var rpt_class_name = doc.getElementById("rpt_class_name").value;
						var show_type = doc.getElementById("show_type").value;
						var _url = doc.getElementById("url").value;
						var state = doc.getElementById("state").value;

						if (name == '') {
							$.yhDialogTip.alert('报表名称不能为空');
							return;
						}
						if (_url == '') {
							$.yhDialogTip.alert('URL不能为空');
							return;
						}
						if (rpt_class_name == '' || rpt_class_name == '请选择') {
							$.yhDialogTip.alert('报表类型不能为空');
							return;
						}
						if (show_type == '' || show_type == '请选择') {
							$.yhDialogTip.alert('显示类型不能为空');
							return;
						}
						if (state == '' || state == '请选择') {
							$.yhDialogTip.alert('报表状态不能为空');
							return;
						}

						if (rpt_class_name == '多维报表')
							rpt_class_name = 'olap';
						else if (rpt_class_name == '平面报表')
							rpt_class_name = 'flat';

						if (show_type == 'PC')
							show_type = 1;
						else if (show_type == 'PC&手机端')
							show_type = 3;
						else if (show_type == '手机端')
							show_type = 2;

						if (state == '有效')
							state = '1';
						else if (state == '无效')
							state = '-1';
						$.get(ctx + "/report/getCountByName?name=" + name, function(res, textStatus) {
							if (res.result > 0) {
								$.yhDialogTip.alert('报表名称不能重复.');
								return;
							}
							var data = {
								name : name,
								report_type : report_type,
								rpt_class_name : rpt_class_name,
								show_type : show_type,
								url : _url,
								state : state

							};

							$.ajax({
								type : "POST",
								dataType : "json",
								url : ctx + "/report/addReport",
								data : data,
								success : function(res, textStatus) {
									$.yhDialogTip.alert('添加成功');

									Report.loadGridData(_this.selectNode.id, _this.selectNode.name);
								}
							});
						});

						$(this).yhWindow("destroy").remove();
						return;
					},
					'取消' : function() {
						$(this).yhWindow("destroy").remove();
					}
				}
			});
		},

		procDir : function(act, id, name, privilege) {
			var url = '';
			var data = {};
			var title = '';
			if (act == 'new') {
				url = ctx + "/reportdir/createDir";
				data.id = id;
				data.name = name;
				data.privilege = privilege;
				title = '添加成功';
			} else if (act == 'edit') {
				url = ctx + "/reportdir/editDir";
				data.id = id;
				data.name = name;
				data.privilege = privilege;
				title = '修改成功';
			} else if (act == 'delete') {
				url = ctx + "/reportdir/deleteDir";
				data.id = id;
				title = '删除成功';
			}
			$.ajax({
				type : "POST",
				dataType : "json",
				url : url,
				data : data,
				success : function(res, textStatus) {
					$.yhDialogTip.alert(title);
					Report.initLoadTree();
					Report.selectNode = {
						id : -1,
						name : '报表分类'
					};
					Report.loadGridData('-1', '报表分类');
				}
			});
		},

		asyncAjax : function(url, param) {
			var tmp;
			$.ajax({
				async : false,
				type : "POST",
				url : url,
				data : param,
				dataType : 'json',
				success : function(data) {
					tmp = data;
				}
			});

			return tmp;
		}
	};
}();

function openReport(id, name, rpt_class, url) {
	var link = '';
	// 平面报表
	if (rpt_class == Report.rptClass.FLAT) {
		link = Report.rptUrls.flatUrl + id;
	} else if (rpt_class == Report.rptClass.OLAP) {
		link = Report.rptUrls.olapUrl + url;
	} else if (rpt_class == Report.rptClass.ADHOC) {
		link = Report.rptUrls.adhocUrl + id;

	} else if (rpt_class == Report.rptClass.IREPORT) {
		link = Report.rptUrls.ireportUrl + id;
	}
	var $li = $("#" + id);
	var newlink = ctx + '/views/report/report.jsp?url=' + link + '&reportId=' + id + '&name=' + encodeURIComponent(name);
	Report.tabs.yhTabs("addTab", $li, newlink, name);

}

YHUI.use("yhLayout yhTabs zTree yhGrid yhToolbar yhButton yhDialogTip yhWindow yhFormField yhSelectmenu yhDropDown", function() {
	$("#rptShow").yhSelectmenu();
	$("#state").yhSelectmenu();
	$(document.body).yhLayout({
		north : {
			size : northAreaHeight,
			spacing_open : 0,
			spacing_closed : 0
		},
		center__onresize : function() {
			Report.tabs.yhTabs("update");

		}
	});
	$("#searchForm").yhFormField({});
	Report.initUrls();
	Report.initTabs();
	Report.initToolBar();
	Report.initToolsBar();
	Report.initLoadTree();
	Report.initModel();
	Report.loadGridData('-1', '报表分类');
	Report.selectNode = {
		id : -1,
		name : '报表分类'
	};
	$("div.ui-jqgrid-bdiv").css("height", ($("div.ui-jqgrid-bdiv").css("height").replace("px", "") - northAreaHeight));
});